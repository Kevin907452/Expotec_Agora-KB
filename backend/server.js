// agoraya/backend/server.js
const express = require("express");
const cors = require("cors");
const dotenv = require("dotenv");
const bcrypt = require("bcrypt");
const crypto = require("crypto");
const { OAuth2Client } = require("google-auth-library");
const db = require("./db");

dotenv.config();

const app = express();

// ═══════════════════════════════════════════════════════════
// MIDDLEWARES
// ═══════════════════════════════════════════════════════════
app.use(cors());
app.use(express.json({ limit: "10mb" }));
app.use(express.urlencoded({ limit: "10mb", extended: true }));

// ═══════════════════════════════════════════════════════════
// HEALTH CHECK
// ═══════════════════════════════════════════════════════════
app.get("/", (req, res) => {
    res.send("Servidor funcionando correctamente");
});

// ═══════════════════════════════════════════════════════════
// TOKENS DE SESIÓN (HMAC)
// ═══════════════════════════════════════════════════════════
const sessionSecret = process.env.SESSION_SECRET;

function crearToken(usuario) {
    if (!sessionSecret) throw new Error("Falta SESSION_SECRET en backend/.env");
    const payload = Buffer.from(
        JSON.stringify({
            id: usuario.id_usuario,
            rol: usuario.rol,
            exp: Date.now() + 8 * 60 * 60 * 1000,
        })
    ).toString("base64url");
    const firma = crypto
        .createHmac("sha256", sessionSecret)
        .update(payload)
        .digest("base64url");
    return `${payload}.${firma}`;
}

function leerToken(req) {
    if (!sessionSecret) return null;
    const token = (req.get("Authorization") || "").replace(/^Bearer /i, "");
    const [payload, firma, ...rest] = token.split(".");
    if (!payload || !firma || rest.length) return null;
    const esperado = crypto
        .createHmac("sha256", sessionSecret)
        .update(payload)
        .digest("base64url");
    const a = Buffer.from(firma);
    const b = Buffer.from(esperado);
    if (a.length !== b.length || !crypto.timingSafeEqual(a, b)) return null;
    try {
        const data = JSON.parse(Buffer.from(payload, "base64url").toString());
        return data.exp > Date.now() ? data : null;
    } catch {
        return null;
    }
}

// ═══════════════════════════════════════════════════════════
// LOGIN Y REGISTRO
// ═══════════════════════════════════════════════════════════
app.post("/api/login", async (req, res) => {
    try {
        const { correo, contrasena } = req.body || {};
        if (!correo || !contrasena) {
            return res.status(400).json({ mensaje: "Ingresa correo y contraseña." });
        }

        const x = await db.query(
            "SELECT id_usuario, nombre, apellido, correo, contrasena, rol, activo, avatar_url FROM usuario WHERE LOWER(correo)=LOWER($1) LIMIT 1",
            [correo.trim()]
        );
        const usuario = x.rows[0];

        if (
            !usuario ||
            usuario.activo === false ||
            !usuario.contrasena ||
            !(await bcrypt.compare(contrasena, usuario.contrasena))
        ) {
            return res.status(401).json({ mensaje: "Correo o contraseña incorrectos." });
        }

        const { contrasena: _, ...seguro } = usuario;
        res.json({ usuario: seguro, token: crearToken(seguro) });
    } catch (err) {
        console.error("Error login:", err);
        res.status(500).json({
            mensaje: "No se pudo iniciar sesión. Revisa la conexión y SESSION_SECRET.",
        });
    }
});

app.post("/api/usuarios", async (req, res) => {
    try {
        const { nombre, apellido, correo, contrasena, rol } = req.body;

        if (!nombre || !apellido || !correo || !contrasena || !rol) {
            return res.status(400).json({ mensaje: "Todos los campos son obligatorios." });
        }

        if (rol !== "estudiante" && rol !== "profesor") {
            return res.status(400).json({ mensaje: "El rol seleccionado no es válido." });
        }

        const usuarioExistente = await db.query(
            "SELECT id_usuario FROM usuario WHERE correo = $1",
            [correo]
        );

        if (usuarioExistente.rows.length > 0) {
            return res.status(409).json({ mensaje: "Ya existe un usuario con ese correo." });
        }

        const contrasenaEncriptada = await bcrypt.hash(contrasena, 10);

        const resultado = await db.query(
            `INSERT INTO usuario (nombre, apellido, correo, contrasena, proveedor, rol)
             VALUES ($1, $2, $3, $4, 'local', $5)
             RETURNING id_usuario, nombre, apellido, correo, rol, avatar_id, activo, fecha_registro`,
            [nombre, apellido, correo, contrasenaEncriptada, rol]
        );

        res.status(201).json({
            mensaje: "Usuario registrado correctamente.",
            usuario: resultado.rows[0],
        });
    } catch (error) {
        console.error("Error registrando usuario:", error);
        res.status(500).json({
            mensaje: "Error al registrar el usuario.",
            detalle: error.message,
        });
    }
});

// ═══════════════════════════════════════════════════════════
// GOOGLE LOGIN
// ═══════════════════════════════════════════════════════════
const googleClient = new OAuth2Client(process.env.GOOGLE_CLIENT_ID);

app.post("/api/google-login", async (req, res) => {
    try {
        const { credential } = req.body;
        if (!credential) {
            return res.status(400).json({ mensaje: "Falta el token de Google" });
        }

        const ticket = await googleClient.verifyIdToken({
            idToken: credential,
            audience: process.env.GOOGLE_CLIENT_ID,
        });

        const payload = ticket.getPayload();
        const { email, given_name, family_name, sub: googleId } = payload;

        let usuarioRes = await db.query(
            "SELECT * FROM usuario WHERE LOWER(correo) = LOWER($1) LIMIT 1",
            [email]
        );

        let usuario = usuarioRes.rows[0];

        if (!usuario) {
            const insertado = await db.query(
                `INSERT INTO usuario (nombre, apellido, correo, google_id, proveedor, rol)
                 VALUES ($1, $2, $3, $4, 'google', 'estudiante')
                 RETURNING id_usuario, nombre, apellido, correo, rol, avatar_url`,
                [given_name || "Usuario", family_name || "", email, googleId]
            );
            usuario = insertado.rows[0];
        } else if (!usuario.google_id) {
            await db.query(
                "UPDATE usuario SET google_id = $1, proveedor = 'google' WHERE id_usuario = $2",
                [googleId, usuario.id_usuario]
            );
        }

        const token = crearToken(usuario);
        const { contrasena, ...usuarioSeguro } = usuario;

        res.json({ usuario: usuarioSeguro, token });
    } catch (error) {
        console.error("Error en Google login:", error);
        res.status(401).json({ mensaje: "No se pudo verificar la cuenta de Google" });
    }
});

// ═══════════════════════════════════════════════════════════
// ESTUDIANTES (CRUD)
// ═══════════════════════════════════════════════════════════
app.get("/api/estudiantes", async (req, res) => {
    try {
        const resultado = await db.query(
            `SELECT id_usuario, nombre, apellido, correo, rol, avatar_id, activo, fecha_registro, ultimo_acceso
             FROM usuario
             WHERE rol = 'estudiante'
             ORDER BY id_usuario ASC`
        );
        res.json(resultado.rows);
    } catch (error) {
        console.error("Error obteniendo estudiantes:", error);
        res.status(500).json({ error: "Error al obtener los estudiantes", detalle: error.message });
    }
});

app.get("/api/estudiantes/:id", async (req, res) => {
    try {
        const { id } = req.params;
        const estudiante = await db.query(
            `SELECT id_usuario, nombre, apellido, correo, rol, avatar_id, activo, fecha_registro
             FROM usuario WHERE id_usuario = $1 AND rol = 'estudiante'`,
            [id]
        );
        if (estudiante.rows.length === 0) {
            return res.status(404).json({ error: "Estudiante no encontrado" });
        }
        res.json(estudiante.rows[0]);
    } catch (error) {
        console.error("Error al obtener estudiante por ID:", error);
        res.status(500).json({ error: "Error del servidor", detalle: error.message });
    }
});

app.put("/api/estudiantes/:id", async (req, res) => {
    const { id } = req.params;
    const { nombre, apellido, correo } = req.body;
    try {
        const resultado = await db.query(
            `UPDATE usuario SET nombre = $1, apellido = $2, correo = $3
             WHERE id_usuario = $4 AND rol = 'estudiante'
             RETURNING id_usuario, nombre, apellido, correo`,
            [nombre, apellido, correo, id]
        );
        if (resultado.rows.length === 0) {
            return res.status(404).json({ error: "Estudiante no encontrado." });
        }
        res.json({ mensaje: "Estudiante actualizado correctamente.", estudiante: resultado.rows[0] });
    } catch (error) {
        console.error("Error al actualizar estudiante:", error);
        res.status(500).json({ error: "Error al actualizar estudiante.", detalle: error.message });
    }
});

app.delete("/api/estudiantes/:id", async (req, res) => {
    const { id } = req.params;
    const client = await db.getClient ? await db.getClient() : null;

    try {
        if (client) await client.query("BEGIN");
        const queryRunner = client || db;

        await queryRunner.query("DELETE FROM sesion WHERE id_usuario = $1", [id]);
        await queryRunner.query("DELETE FROM usuario_curso WHERE usuario_id = $1", [id]);
        await queryRunner.query("DELETE FROM resultado_quiz WHERE id_estudiante = $1", [id]);
        await queryRunner.query("DELETE FROM usuario_recompensa WHERE id_usuario = $1", [id]);
        await queryRunner.query("DELETE FROM racha WHERE id_usuario = $1", [id]);
        await queryRunner.query("DELETE FROM caja_ideas WHERE id_usuario = $1", [id]);
        await queryRunner.query("DELETE FROM miembro_partido WHERE id_estudiante = $1", [id]);
        await queryRunner.query("DELETE FROM voto WHERE id_estudiante = $1", [id]);
        await queryRunner.query(
            "DELETE FROM mensaje_chat WHERE conversacion_id IN (SELECT id_conversacion FROM conversacion_chat WHERE usuario = $1)",
            [id]
        );
        await queryRunner.query("DELETE FROM conversacion_chat WHERE usuario = $1", [id]);

        const resultado = await queryRunner.query(
            "DELETE FROM usuario WHERE id_usuario = $1 AND rol = 'estudiante' RETURNING id_usuario",
            [id]
        );

        if (resultado.rows.length === 0) {
            if (client) await client.query("ROLLBACK");
            return res.status(404).json({
                error: "Estudiante no encontrado o no corresponde al rol de estudiante.",
            });
        }

        if (client) await client.query("COMMIT");
        res.json({ mensaje: "Estudiante eliminado con éxito", id_usuario: id });
    } catch (error) {
        if (client) await client.query("ROLLBACK");
        console.error("Error al eliminar estudiante:", error);
        res.status(500).json({
            error: "Error al eliminar el estudiante.",
            detalle: error.message,
        });
    } finally {
        if (client) client.release();
    }
});

// ═══════════════════════════════════════════════════════════
// MÓDULO DE CREACIÓN DE PARTIDOS
// ═══════════════════════════════════════════════════════════
app.get("/api/formulario", async (req, res) => {
    try {
        const gobiernosRes = await db.query(
            "SELECT id_gobierno, nombre, estado FROM gobierno_estudiantil ORDER BY id_gobierno DESC"
        );
        const profesoresRes = await db.query(
            "SELECT id_usuario, nombre, apellido FROM usuario WHERE rol = 'profesor' ORDER BY apellido ASC"
        );
        const estudiantesRes = await db.query(
            "SELECT id_usuario, nombre, apellido FROM usuario WHERE rol = 'estudiante' ORDER BY apellido ASC"
        );
        const membresiasRes = await db.query(
            `SELECT m.id_estudiante, m.id_partido, p.gobierno_id, p.nombre AS partido
             FROM miembro_partido m
             JOIN partido_politico p ON m.id_partido = p.id_partido`
        );
        const partidosRes = await db.query(
            `SELECT p.id_partido, p.nombre, p.descripcion, p.bandera_url, g.nombre AS gobierno,
                (SELECT COUNT(*) FROM miembro_partido m WHERE m.id_partido = p.id_partido) AS integrantes,
                (SELECT COUNT(*) FROM propuesta pr WHERE pr.id_partido = p.id_partido) AS propuestas
             FROM partido_politico p
             LEFT JOIN gobierno_estudiantil g ON p.gobierno_id = g.id_gobierno
             ORDER BY p.id_partido DESC`
        );

        res.json({
            baseDeDatos: process.env.DB_NAME || "agora",
            gobiernos: gobiernosRes.rows,
            profesores: profesoresRes.rows,
            estudiantes: estudiantesRes.rows,
            membresias: membresiasRes.rows,
            partidos: partidosRes.rows,
            sinProfesores: profesoresRes.rows.length === 0,
        });
    } catch (error) {
        console.error("Error al obtener datos del formulario:", error);
        res.status(500).json({ error: "Error al obtener datos.", detalle: error.message });
    }
});

// ── GOBIERNO ACTIVO ──
app.get("/api/gobiernos/activo", async (req, res) => {
    try {
        const resultado = await db.query(
            `SELECT id_gobierno, nombre FROM gobierno_estudiantil 
             WHERE estado = 'activo' OR estado = 'en_curso'
             ORDER BY id_gobierno DESC LIMIT 1`
        );
        if (resultado.rows.length === 0) {
            const fallback = await db.query(
                "SELECT id_gobierno, nombre FROM gobierno_estudiantil ORDER BY id_gobierno ASC LIMIT 1"
            );
            return res.json(fallback.rows[0] || { id_gobierno: 1 });
        }
        res.json(resultado.rows[0]);
    } catch (error) {
        console.error("Error al obtener gobierno:", error);
        res.json({ id_gobierno: 1 });
    }
});

// ── POST: Crear partido (con slogan, meta, frase, colores) ──
app.post("/api/partidos", async (req, res) => {
    const { 
        nombre, descripcion, slogan, meta, frase, 
        color_principal, color_secundario,
        gobierno_id, creador_id, bandera, miembros, propuestas 
    } = req.body;

    if (!nombre || !gobierno_id || !creador_id) {
        return res.status(400).json({ error: "Faltan campos obligatorios." });
    }

    const client = await db.getClient ? await db.getClient() : null;
    const queryRunner = client || db;

    try {
        if (client) await client.query("BEGIN");
        const banderaUrl = bandera ? bandera.datos : null;

        const partidoRes = await queryRunner.query(
            `INSERT INTO partido_politico 
             (nombre, descripcion, slogan, meta, frase, color_principal, color_secundario, gobierno_id, creador_id, bandera_url, estado)
             VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, 'pendiente')
             RETURNING id_partido, nombre, descripcion, bandera_url`,
            [
                nombre, 
                descripcion, 
                slogan || null,
                meta || null,
                frase || null,
                color_principal || "#A3D9BD",
                color_secundario || "#E6A8D7",
                gobierno_id, 
                creador_id, 
                banderaUrl
            ]
        );
        const nuevoPartido = partidoRes.rows[0];

        // Miembros
        if (Array.isArray(miembros)) {
            for (const m of miembros) {
                if (m.id_estudiante) {
                    await queryRunner.query(
                        `INSERT INTO miembro_partido (id_partido, id_estudiante, cargo)
                         VALUES ($1, $2, $3)`,
                        [nuevoPartido.id_partido, m.id_estudiante, m.cargo]
                    );
                }
            }
        }

        // Propuestas
        if (Array.isArray(propuestas)) {
            for (const p of propuestas) {
                if (p.titulo && p.titulo.trim()) {
                    await queryRunner.query(
                        `INSERT INTO propuesta (id_partido, titulo, descripcion)
                         VALUES ($1, $2, $3)`,
                        [nuevoPartido.id_partido, p.titulo, p.descripcion]
                    );
                }
            }
        }

        if (client) await client.query("COMMIT");

        res.status(201).json({
            mensaje: "Partido registrado con éxito.",
            partido: nuevoPartido,
        });
    } catch (error) {
        if (client) await client.query("ROLLBACK");
        console.error("Error al guardar partido político:", error);
        res.status(500).json({ error: "Error al registrar el partido.", detalle: error.message });
    } finally {
        if (client) client.release();
    }
});

// ── GET: Todos los partidos ──
app.get("/api/partidos", async (req, res) => {
    try {
        const resultado = await db.query(
            "SELECT id_partido, nombre, descripcion, bandera_url FROM partido_politico ORDER BY id_partido ASC"
        );
        res.json(resultado.rows);
    } catch (error) {
        console.error("Error obteniendo partidos políticos:", error);
        res.status(500).json({ error: "Error al obtener partidos.", detalle: error.message });
    }
});

/// ── GET: Detalle de partido (miembros + propuestas) ──
app.get("/api/partidos/detalle/:id", async (req, res) => {
    const { id } = req.params;
    try {
        // Info básica del partido
        const partidoRes = await db.query(
            `SELECT 
                p.id_partido, p.nombre, p.descripcion, p.slogan, p.meta, p.frase,
                p.color_principal, p.color_secundario, p.bandera_url,
                p.estado, p.fecha_registro,
                u.nombre AS creador_nombre, u.apellido AS creador_apellido
             FROM partido_politico p
             LEFT JOIN usuario u ON p.creador_id = u.id_usuario
             WHERE p.id_partido = $1`,
            [id]
        );

        if (partidoRes.rows.length === 0) {
            return res.status(404).json({ error: "Partido no encontrado" });
        }

        // Miembros (con todos los cargos ordenados)
        const miembrosRes = await db.query(
            `SELECT m.id_miembro, m.cargo, m.seccion,
                    u.nombre, u.apellido, u.correo, u.avatar_url
             FROM miembro_partido m
             LEFT JOIN usuario u ON m.id_estudiante = u.id_usuario
             WHERE m.id_partido = $1
             ORDER BY CASE m.cargo
                 WHEN 'presidente' THEN 1
                 WHEN 'vicepresidente' THEN 2
                 WHEN 'secretario' THEN 3
                 WHEN 'tesorero' THEN 4
                 WHEN 'vocal' THEN 5
                 WHEN 'vocal1' THEN 5
                 WHEN 'vocal2' THEN 6
                 WHEN 'vocal_2' THEN 6
                 WHEN 'fiscal' THEN 7
                 ELSE 8 END`,
            [id]
        );

        // Propuestas
        const propuestasRes = await db.query(
            `SELECT id_propuesta, titulo, descripcion 
             FROM propuesta WHERE id_partido = $1 
             ORDER BY id_propuesta ASC`,
            [id]
        );

        res.json({
            partido: partidoRes.rows[0],
            miembros: miembrosRes.rows,
            propuestas: propuestasRes.rows,
        });
    } catch (error) {
        console.error("Error obteniendo detalles del partido:", error);
        res.status(500).json({ error: "Error al obtener detalles.", detalle: error.message });
    }
});

// ── GET: Partidos APROBADOS con info completa ──
app.get("/api/partidos/aprobados", async (req, res) => {
    try {
        const partidosRes = await db.query(
            `SELECT 
                p.id_partido, p.nombre, p.descripcion, p.slogan, p.meta, p.frase,
                p.color_principal, p.color_secundario, p.bandera_url,
                p.estado, p.fecha_registro,
                g.nombre AS gobierno_nombre
             FROM partido_politico p
             LEFT JOIN gobierno_estudiantil g ON p.gobierno_id = g.id_gobierno
             WHERE p.activo = TRUE AND p.estado = 'aprobado'
             ORDER BY p.fecha_registro ASC`
        );

        const partidosCompletos = await Promise.all(
            partidosRes.rows.map(async (partido) => {
                const [miembros, propuestas] = await Promise.all([
                    db.query(
                        `SELECT m.id_miembro, m.cargo, m.seccion,
                                u.id_usuario, u.nombre, u.apellido, u.avatar_url
                         FROM miembro_partido m
                         INNER JOIN usuario u ON m.id_estudiante = u.id_usuario
                         WHERE m.id_partido = $1`,
                        [partido.id_partido]
                    ),
                    db.query(
                        `SELECT id_propuesta, titulo, descripcion FROM propuesta
                         WHERE id_partido = $1 ORDER BY id_propuesta ASC`,
                        [partido.id_partido]
                    ),
                ]);

                return {
                    ...partido,
                    miembros: miembros.rows,
                    propuestas: propuestas.rows,
                };
            })
        );

        res.json({ total: partidosCompletos.length, partidos: partidosCompletos });
    } catch (error) {
        console.error("Error al obtener partidos:", error);
        res.status(500).json({ error: "Error del servidor", detalle: error.message });
    }
});

// ═══════════════════════════════════════════════════════════
// PROPUESTAS
// ═══════════════════════════════════════════════════════════
app.get("/api/propuestas", async (req, res) => {
    try {
        const resultado = await db.query(
            "SELECT id_propuesta, id_partido, titulo, descripcion FROM propuesta ORDER BY id_propuesta ASC"
        );
        res.json(resultado.rows);
    } catch (error) {
        console.error("Error al obtener propuestas:", error);
        res.status(500).json({ error: "Error al obtener propuestas.", detalle: error.message });
    }
});

// ── PROPUESTAS CON EJE INFERIDO ──
const PALABRAS_CLAVE = {
  ecologico: ["reciclaje", "reciclar", "ambiente", "verde", "sostenible",
    "sostenibilidad", "planeta", "naturaleza", "árboles", "jardín",
    "contaminación", "eco", "residuos", "basura", "limpieza", "orgánico",
    "compost", "agua", "huerta"],
  social: ["convivencia", "respeto", "comunidad", "compañerismo", "unión",
    "inclusión", "ayuda", "apoyo", "emocional", "bienestar", "amistad",
    "igualdad", "diversidad", "tolerancia", "solidaridad", "integración",
    "juntos", "acompañamiento", "empatía"],
  academico: ["académico", "estudio", "talleres", "aprendizaje", "tutorías",
    "biblioteca", "exámenes", "clases", "educación", "formación",
    "conocimiento", "investigación", "refuerzo", "orientación",
    "preparación", "estudiar", "ciencia"],
  cultural: ["cultura", "arte", "deporte", "deportivo", "música", "teatro",
    "festival", "baile", "pintura", "recreación", "recreativo", "torneo",
    "competencias", "actividades", "evento", "celebración", "tradición",
    "identidad", "danzas", "folclor", "juegos"],
  tecnologico: ["tecnología", "innovación", "digital", "moderno",
    "computadora", "internet", "app", "software", "robótica", "ciencia",
    "científico", "datos", "virtual", "pantalla", "online",
    "digitalización", "automatización", "smart", "electrónica"],
};

function normalizarTexto(texto) {
  return texto
    .toLowerCase()
    .normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "")
    .replace(/[^\w\s]/g, " ")
    .replace(/\s+/g, " ")
    .trim();
}

function contarOcurrencias(textoNormalizado, palabras) {
  let contador = 0;
  for (const palabra of palabras) {
    const p = normalizarTexto(palabra);
    const regex = new RegExp(`\\b${p}\\b`, "g");
    const matches = textoNormalizado.match(regex);
    if (matches) contador += matches.length;
  }
  return contador;
}

function inferirEjePropuesta(propuesta) {
  const texto = normalizarTexto(
    `${propuesta.titulo || ""} ${propuesta.descripcion || ""}`
  );
  let mejorEje = "social";
  let mayorConteo = 0;
  for (const [eje, palabras] of Object.entries(PALABRAS_CLAVE)) {
    const conteo = contarOcurrencias(texto, palabras);
    if (conteo > mayorConteo) {
      mayorConteo = conteo;
      mejorEje = eje;
    }
  }
  return mejorEje;
}

app.get("/api/propuestas/con-ejes", async (req, res) => {
    try {
        const resultado = await db.query(
            `SELECT p.id_propuesta, p.id_partido, p.titulo, p.descripcion,
                    pp.nombre AS partido_nombre, pp.color_principal
             FROM propuesta p
             INNER JOIN partido_politico pp ON p.id_partido = pp.id_partido
             WHERE pp.activo = TRUE AND pp.estado = 'aprobado'
             ORDER BY p.id_propuesta ASC`
        );

        const propuestasConEje = resultado.rows.map((p) => ({
            ...p,
            eje: inferirEjePropuesta(p),
        }));

        res.json({ total: propuestasConEje.length, propuestas: propuestasConEje });
    } catch (error) {
        console.error("Error al obtener propuestas con ejes:", error);
        res.status(500).json({ error: "Error del servidor" });
    }
});

// ═══════════════════════════════════════════════════════════
// VOTACIÓN
// ═══════════════════════════════════════════════════════════
app.post("/api/votar", async (req, res) => {
    const { id_estudiante, id_partido } = req.body;
    if (!id_estudiante || !id_partido) {
        return res.status(400).json({ error: "Faltan datos." });
    }
    try {
        const votoPrevio = await db.query(
            "SELECT id_voto FROM voto WHERE id_estudiante = $1",
            [id_estudiante]
        );
        if (votoPrevio.rows.length > 0) {
            return res.status(400).json({ error: "Ya has emitido tu voto anteriormente." });
        }
        await db.query(
            "INSERT INTO voto (id_estudiante, id_partido) VALUES ($1, $2)",
            [id_estudiante, id_partido]
        );
        res.status(201).json({ mensaje: "Voto registrado exitosamente." });
    } catch (error) {
        console.error("Error al registrar voto:", error);
        res.status(500).json({ error: "Error al guardar el voto.", detalle: error.message });
    }
});

// ═══════════════════════════════════════════════════════════
// EVENTOS / CALENDARIO
// ═══════════════════════════════════════════════════════════
app.get("/api/eventos", async (req, res) => {
    try {
        const resultado = await db.query(
            "SELECT id_evento, titulo, descripcion, fecha_inicio, fecha_fin, id_modulo FROM evento ORDER BY fecha_inicio ASC"
        );
        res.json(resultado.rows);
    } catch (error) {
        console.error("Error al obtener eventos:", error);
        res.status(500).json({ error: "Error al obtener los eventos.", detalle: error.message });
    }
});

app.post("/api/eventos", async (req, res) => {
    const { titulo, descripcion, fecha_inicio, fecha_fin, id_modulo } = req.body;
    if (!titulo || !fecha_inicio) {
        return res.status(400).json({ error: "El título y la fecha de inicio son requeridos." });
    }
    try {
        const resultado = await db.query(
            `INSERT INTO evento (titulo, descripcion, fecha_inicio, fecha_fin, id_modulo)
             VALUES ($1, $2, $3, $4, $5) RETURNING *`,
            [titulo, descripcion || "", fecha_inicio, fecha_fin || fecha_inicio, id_modulo || null]
        );
        res.status(201).json(resultado.rows[0]);
    } catch (error) {
        console.error("Error al crear evento:", error);
        res.status(500).json({ error: "Error al registrar el evento.", detalle: error.message });
    }
});

app.put("/api/eventos/:id", async (req, res) => {
    const { id } = req.params;
    const { titulo, descripcion, fecha_inicio, fecha_fin, id_modulo } = req.body;
    try {
        const resultado = await db.query(
            `UPDATE evento SET titulo = $1, descripcion = $2, fecha_inicio = $3, fecha_fin = $4, id_modulo = $5
             WHERE id_evento = $6 RETURNING *`,
            [titulo, descripcion || "", fecha_inicio, fecha_fin || fecha_inicio, id_modulo || null, id]
        );
        if (resultado.rows.length === 0) {
            return res.status(404).json({ error: "Evento no encontrado." });
        }
        res.json(resultado.rows[0]);
    } catch (error) {
        console.error("Error al actualizar evento:", error);
        res.status(500).json({ error: "Error al actualizar el evento.", detalle: error.message });
    }
});

app.delete("/api/eventos/:id", async (req, res) => {
    const { id } = req.params;
    try {
        const resultado = await db.query(
            "DELETE FROM evento WHERE id_evento = $1 RETURNING *",
            [id]
        );
        if (resultado.rows.length === 0) {
            return res.status(404).json({ error: "Evento no encontrado." });
        }
        res.json({ mensaje: "Evento eliminado correctamente.", evento: resultado.rows[0] });
    } catch (error) {
        console.error("Error al eliminar evento:", error);
        res.status(500).json({ error: "Error al eliminar el evento.", detalle: error.message });
    }
});

// ═══════════════════════════════════════════════════════════
// CUESTIONARIOS EDUCATIVOS + NOTAS
// ═══════════════════════════════════════════════════════════
const catalogoCuestionarios = require("./quiz-catalog.json");

async function asegurarIntentosEducativos() {
    await db.query(`CREATE TABLE IF NOT EXISTS public.agora_intentos_educativos (
        id_intento BIGSERIAL PRIMARY KEY,
        id_estudiante INTEGER NOT NULL REFERENCES public.usuario(id_usuario),
        id_tema VARCHAR(120) NOT NULL,
        nombre_quiz TEXT NOT NULL,
        aciertos INTEGER NOT NULL,
        total INTEGER NOT NULL,
        porcentaje INTEGER NOT NULL,
        fecha TIMESTAMPTZ NOT NULL DEFAULT NOW()
    )`);
}

app.post("/api/cuestionarios-educativos/entregar", async (req, res) => {
    try {
        const sesion = leerToken(req);
        if (!sesion) return res.status(401).json({ mensaje: "Inicia sesión para guardar tu calificación." });

        const usuario = await db.query(
            "SELECT id_usuario, rol, activo FROM public.usuario WHERE id_usuario=$1",
            [sesion.id]
        );
        if (!usuario.rows.length || !usuario.rows[0].activo || usuario.rows[0].rol !== "estudiante") {
            return res.status(403).json({ mensaje: "Solo estudiantes pueden registrar estos cuestionarios." });
        }

        const { temaId, respuestas } = req.body || {};
        const tema = catalogoCuestionarios
            .flatMap((m) => m.topics.map((t) => ({ ...t, modulo: m.title })))
            .find((t) => t.id === temaId);

        if (!tema || !tema.answers.length) {
            return res.status(404).json({ mensaje: "Cuestionario no disponible." });
        }
        if (
            !Array.isArray(respuestas) ||
            respuestas.length !== tema.answers.length ||
            respuestas.some((x) => !Number.isInteger(x) || x < 0)
        ) {
            return res.status(400).json({ mensaje: "Responde todas las preguntas antes de entregar." });
        }

        const aciertos = tema.answers.filter((correcta, i) => correcta === respuestas[i]).length;
        const porcentaje = Math.round((100 * aciertos) / tema.answers.length);

        await asegurarIntentosEducativos();
        const guardado = await db.query(
            `INSERT INTO public.agora_intentos_educativos
             (id_estudiante, id_tema, nombre_quiz, aciertos, total, porcentaje)
             VALUES ($1, $2, $3, $4, $5, $6) RETURNING id_intento, fecha`,
            [sesion.id, temaId, `${tema.modulo} · ${tema.title}`, aciertos, tema.answers.length, porcentaje]
        );

        res.status(201).json({
            aciertos,
            total: tema.answers.length,
            porcentaje,
            fecha: guardado.rows[0].fecha,
        });
    } catch (err) {
        console.error("Error al guardar cuestionario educativo:", err);
        res.status(500).json({ mensaje: "No se pudo guardar la nota." });
    }
});

app.get("/api/notas", async (req, res) => {
    try {
        const sesion = leerToken(req);
        if (!sesion) return res.status(401).json({ mensaje: "Tu sesión ha vencido." });

        const id = Number(sesion.id);
        if (!Number.isInteger(id) || id <= 0) {
            return res.status(401).json({ mensaje: "Sesión inválida." });
        }

        const u = await db.query("SELECT id_usuario, rol FROM usuario WHERE id_usuario=$1 AND activo=true", [id]);
        if (!u.rows.length) return res.status(403).json({ mensaje: "Usuario no autorizado." });

        const profesor = u.rows[0].rol === "profesor";

        await asegurarIntentosEducativos();
        const nuevos = (
            await db.query(
                `SELECT a.id_intento, a.id_estudiante, a.nombre_quiz AS quiz,
                    a.porcentaje, a.porcentaje AS nota, a.fecha, u.nombre, u.apellido, u.correo,
                    (SELECT COUNT(*)::int FROM public.agora_intentos_educativos b
                     WHERE b.id_estudiante=a.id_estudiante AND b.id_tema=a.id_tema AND b.fecha<=a.fecha) AS intentos
                 FROM public.agora_intentos_educativos a
                 JOIN public.usuario u ON u.id_usuario=a.id_estudiante
                 ${profesor ? "" : "WHERE a.id_estudiante=$1"}
                 ORDER BY a.fecha DESC`,
                profesor ? [] : [id]
            )
        ).rows;

        res.json(nuevos);
    } catch (err) {
        console.error("Error al consultar notas:", err);
        res.status(500).json({ mensaje: "No se pudieron consultar las calificaciones." });
    }
});

// ═══════════════════════════════════════════════════════════
// PERFIL DE USUARIO
// ═══════════════════════════════════════════════════════════
app.get("/api/perfil", async (req, res) => {
    try {
        const sesion = leerToken(req);
        if (!sesion) return res.status(401).json({ error: "No autenticado" });

        const id = Number(sesion.id);

        const usuarioRes = await db.query(
            `SELECT id_usuario, nombre, apellido, correo, rol,
                avatar_id, avatar_url, activo, fecha_registro, ultimo_acceso
             FROM usuario WHERE id_usuario = $1 AND activo = true`,
            [id]
        );
        if (usuarioRes.rows.length === 0) {
            return res.status(404).json({ error: "Usuario no encontrado" });
        }

        const usuario = usuarioRes.rows[0];

        await asegurarIntentosEducativos();
        const notasRes = await db.query(
            `SELECT COUNT(*)::int AS total,
                ROUND(AVG(porcentaje)::numeric, 2) AS promedio,
                MAX(porcentaje) AS mejor
             FROM public.agora_intentos_educativos WHERE id_estudiante = $1`,
            [id]
        );

        const ultimasNotasRes = await db.query(
            `SELECT id_intento, nombre_quiz AS quiz, porcentaje, fecha, id_tema
             FROM public.agora_intentos_educativos
             WHERE id_estudiante = $1
             ORDER BY fecha DESC LIMIT 5`,
            [id]
        );

        const rachaRes = await db.query(
            "SELECT racha_actual, mejor_racha FROM racha WHERE id_usuario = $1",
            [id]
        );

        const recompensasRes = await db.query(
            `SELECT r.id_recompensa, r.nombre, r.descripcion, r.imagen_url, ur.fecha_obtenida
             FROM usuario_recompensa ur
             INNER JOIN recompensa r ON ur.id_recompensa = r.id_recompensa
             WHERE ur.id_usuario = $1
             ORDER BY ur.fecha_obtenida DESC`,
            [id]
        );

        res.json({
            usuario,
            estadisticas: {
                total_quizzes: notasRes.rows[0]?.total || 0,
                promedio: notasRes.rows[0]?.promedio || null,
                mejor: notasRes.rows[0]?.mejor || null,
                racha_actual: rachaRes.rows[0]?.racha_actual || 0,
                mejor_racha: rachaRes.rows[0]?.mejor_racha || 0,
                total_logros: recompensasRes.rows.length,
            },
            ultimas_notas: ultimasNotasRes.rows,
            recompensas: recompensasRes.rows,
        });
    } catch (error) {
        console.error("Error al obtener perfil:", error);
        res.status(500).json({ error: "Error del servidor" });
    }
});

app.put("/api/perfil", async (req, res) => {
    try {
        const sesion = leerToken(req);
        if (!sesion) return res.status(401).json({ error: "No autenticado" });

        const id = Number(sesion.id);
        const { nombre, apellido } = req.body;

        if (!nombre || !apellido) {
            return res.status(400).json({ error: "Nombre y apellido son obligatorios" });
        }

        await db.query(
            "UPDATE usuario SET nombre = $1, apellido = $2 WHERE id_usuario = $3",
            [nombre.trim(), apellido.trim(), id]
        );

        res.json({ mensaje: "Perfil actualizado correctamente" });
    } catch (error) {
        console.error("Error al actualizar perfil:", error);
        res.status(500).json({ error: "Error del servidor" });
    }
});

app.put("/api/perfil/avatar", async (req, res) => {
    try {
        const sesion = leerToken(req);
        if (!sesion) return res.status(401).json({ error: "No autenticado" });

        const id = Number(sesion.id);
        const { avatar_url } = req.body;

        if (!avatar_url) return res.status(400).json({ error: "Falta la imagen" });
        if (!avatar_url.startsWith("data:image/")) {
            return res.status(400).json({ error: "Formato de imagen no válido" });
        }

        const tamaño = avatar_url.length * 0.75;
        if (tamaño > 2 * 1024 * 1024) {
            return res.status(400).json({ error: "La imagen no puede pesar más de 2MB" });
        }

        await db.query("UPDATE usuario SET avatar_url = $1 WHERE id_usuario = $2", [avatar_url, id]);

        res.json({ mensaje: "Avatar actualizado correctamente", avatar_url });
    } catch (error) {
        console.error("Error al actualizar avatar:", error);
        res.status(500).json({ error: "Error del servidor" });
    }
});

app.delete("/api/perfil/avatar", async (req, res) => {
    try {
        const sesion = leerToken(req);
        if (!sesion) return res.status(401).json({ error: "No autenticado" });

        const id = Number(sesion.id);
        await db.query("UPDATE usuario SET avatar_url = NULL WHERE id_usuario = $1", [id]);
        res.json({ mensaje: "Avatar eliminado" });
    } catch (error) {
        console.error("Error al eliminar avatar:", error);
        res.status(500).json({ error: "Error del servidor" });
    }
});

app.put("/api/perfil/password", async (req, res) => {
    try {
        const sesion = leerToken(req);
        if (!sesion) return res.status(401).json({ error: "No autenticado" });

        const id = Number(sesion.id);
        const { contrasena_actual, contrasena_nueva } = req.body;

        if (!contrasena_actual || !contrasena_nueva) {
            return res.status(400).json({ error: "Faltan datos" });
        }
        if (contrasena_nueva.length < 6) {
            return res.status(400).json({ error: "La nueva contraseña debe tener al menos 6 caracteres" });
        }

        const usuarioRes = await db.query("SELECT contrasena FROM usuario WHERE id_usuario = $1", [id]);
        if (usuarioRes.rows.length === 0) {
            return res.status(404).json({ error: "Usuario no encontrado" });
        }

        const coincide = await bcrypt.compare(contrasena_actual, usuarioRes.rows[0].contrasena);
        if (!coincide) {
            return res.status(401).json({ error: "La contraseña actual es incorrecta" });
        }

        const hash = await bcrypt.hash(contrasena_nueva, 10);
        await db.query("UPDATE usuario SET contrasena = $1 WHERE id_usuario = $2", [hash, id]);

        res.json({ mensaje: "Contraseña cambiada correctamente" });
    } catch (error) {
        console.error("Error al cambiar contraseña:", error);
        res.status(500).json({ error: "Error del servidor" });
    }
});

// ═══════════════════════════════════════════════════════════
// COMUNIDAD — RECOMENDACIONES, LIKES Y COMENTARIOS
// ═══════════════════════════════════════════════════════════

app.get("/api/recomendaciones", async (req, res) => {
    try {
        const sesion = leerToken(req);
        const idUsuario = sesion ? Number(sesion.id) : 0;

        const resultado = await db.query(
            `SELECT 
                ci.id_idea, ci.comentario, ci.fecha, ci.editado, ci.fecha_edicion,
                u.id_usuario, u.nombre, u.apellido, u.avatar_url,
                COUNT(DISTINCT li.id_like)::int AS total_likes,
                COUNT(DISTINCT com.id_comentario)::int AS total_comentarios,
                COALESCE(BOOL_OR(li.id_usuario = $1), false) AS usuario_dio_like,
                EXISTS(SELECT 1 FROM idea_guardada ig WHERE ig.id_idea = ci.id_idea AND ig.id_usuario = $1) AS usuario_guardo
            FROM caja_ideas ci
            INNER JOIN usuario u ON ci.id_usuario = u.id_usuario
            LEFT JOIN like_idea li ON ci.id_idea = li.id_idea
            LEFT JOIN comentario_idea com ON ci.id_idea = com.id_idea
            GROUP BY ci.id_idea, u.id_usuario, u.nombre, u.apellido, u.avatar_url
            ORDER BY total_likes DESC, ci.fecha DESC`,
            [idUsuario]
        );

        res.json({
            total: resultado.rows.length,
            recomendaciones: resultado.rows,
        });
    } catch (error) {
        console.error("Error al obtener recomendaciones:", error);
        res.status(500).json({ error: "Error del servidor" });
    }
});

app.post("/api/recomendaciones", async (req, res) => {
    try {
        const sesion = leerToken(req);
        if (!sesion) return res.status(401).json({ error: "No autenticado" });

        const idUsuario = Number(sesion.id);
        const { comentario } = req.body;

        if (!comentario || comentario.trim().length < 10) {
            return res.status(400).json({ error: "La recomendación debe tener al menos 10 caracteres" });
        }

        const resultado = await db.query(
            `INSERT INTO caja_ideas (id_usuario, comentario)
             VALUES ($1, $2)
             RETURNING id_idea, comentario, fecha, editado`,
            [idUsuario, comentario.trim()]
        );

        const usuarioRes = await db.query(
            "SELECT nombre, apellido, avatar_url FROM usuario WHERE id_usuario = $1",
            [idUsuario]
        );

        res.status(201).json({
            mensaje: "¡Recomendación publicada!",
            recomendacion: {
                ...resultado.rows[0],
                ...usuarioRes.rows[0],
                id_usuario: idUsuario,
                total_likes: 0,
                total_comentarios: 0,
                usuario_dio_like: false,
                usuario_guardo: false,
            },
        });
    } catch (error) {
        console.error("Error al crear recomendación:", error);
        res.status(500).json({ error: "Error del servidor" });
    }
});

app.post("/api/recomendaciones/:id/like", async (req, res) => {
    try {
        const sesion = leerToken(req);
        if (!sesion) return res.status(401).json({ error: "No autenticado" });

        const idUsuario = Number(sesion.id);
        const { id } = req.params;

        const verificar = await db.query(
            "SELECT id_like FROM like_idea WHERE id_idea = $1 AND id_usuario = $2",
            [id, idUsuario]
        );

        let accion;
        if (verificar.rows.length > 0) {
            await db.query("DELETE FROM like_idea WHERE id_idea = $1 AND id_usuario = $2", [id, idUsuario]);
            accion = "like_removido";
        } else {
            await db.query("INSERT INTO like_idea (id_idea, id_usuario) VALUES ($1, $2)", [id, idUsuario]);
            accion = "like_agregado";
        }

        const count = await db.query("SELECT COUNT(*)::int AS total FROM like_idea WHERE id_idea = $1", [id]);

        res.json({
            accion,
            total_likes: count.rows[0].total,
            usuario_dio_like: accion === "like_agregado",
        });
    } catch (error) {
        console.error("Error al dar like:", error);
        res.status(500).json({ error: "Error del servidor" });
    }
});

app.get("/api/recomendaciones/:id/comentarios", async (req, res) => {
    try {
        const { id } = req.params;
        const resultado = await db.query(
            `SELECT c.id_comentario, c.comentario, c.fecha,
                u.id_usuario, u.nombre, u.apellido, u.avatar_url
             FROM comentario_idea c
             INNER JOIN usuario u ON c.id_usuario = u.id_usuario
             WHERE c.id_idea = $1
             ORDER BY c.fecha ASC`,
            [id]
        );
        res.json({ comentarios: resultado.rows });
    } catch (error) {
        console.error("Error al obtener comentarios:", error);
        res.status(500).json({ error: "Error del servidor" });
    }
});

app.post("/api/recomendaciones/:id/comentarios", async (req, res) => {
    try {
        const sesion = leerToken(req);
        if (!sesion) return res.status(401).json({ error: "No autenticado" });

        const idUsuario = Number(sesion.id);
        const { id } = req.params;
        const { comentario } = req.body;

        if (!comentario || comentario.trim().length < 2) {
            return res.status(400).json({ error: "El comentario es muy corto" });
        }

        const resultado = await db.query(
            `INSERT INTO comentario_idea (id_idea, id_usuario, comentario)
             VALUES ($1, $2, $3)
             RETURNING id_comentario, comentario, fecha`,
            [id, idUsuario, comentario.trim()]
        );

        const usuarioRes = await db.query(
            "SELECT nombre, apellido, avatar_url FROM usuario WHERE id_usuario = $1",
            [idUsuario]
        );

        res.status(201).json({
            comentario: {
                ...resultado.rows[0],
                ...usuarioRes.rows[0],
                id_usuario: idUsuario,
            },
        });
    } catch (error) {
        console.error("Error al crear comentario:", error);
        res.status(500).json({ error: "Error del servidor" });
    }
});

// ═══════════════════════════════════════════════════════════
// PANEL DEL PROFESOR — GESTIÓN DE PARTIDOS
// ═══════════════════════════════════════════════════════════
app.get("/api/partidos/pendientes", async (req, res) => {
    try {
        const sesion = leerToken(req);
        if (!sesion) return res.status(401).json({ error: "No autenticado" });

        const u = await db.query("SELECT rol FROM usuario WHERE id_usuario = $1", [sesion.id]);

        if (!u.rows.length || (u.rows[0].rol !== "profesor" && u.rows[0].rol !== "administrador")) {
            return res.status(403).json({ error: "Solo profesores pueden acceder" });
        }

        const resultado = await db.query(
            `SELECT p.id_partido, p.nombre, p.descripcion, p.slogan, p.meta,
                    p.frase, p.color_principal, p.color_secundario, p.bandera_url,
                    p.estado, p.fecha_registro,
                    u.nombre AS creador_nombre, u.apellido AS creador_apellido,
                    (SELECT COUNT(*)::int FROM miembro_partido WHERE id_partido = p.id_partido) AS total_miembros,
                    (SELECT COUNT(*)::int FROM propuesta WHERE id_partido = p.id_partido) AS total_propuestas
             FROM partido_politico p
             INNER JOIN usuario u ON p.creador_id = u.id_usuario
             WHERE p.estado IN ('pendiente', 'borrador')
             ORDER BY p.fecha_registro DESC`
        );

        res.json({ total: resultado.rows.length, partidos: resultado.rows });
    } catch (error) {
        console.error("Error:", error);
        res.status(500).json({ error: "Error del servidor" });
    }
});

app.get("/api/partidos/pendientes/:id", async (req, res) => {
    try {
        const sesion = leerToken(req);
        if (!sesion) return res.status(401).json({ error: "No autenticado" });

        const { id } = req.params;

        const partidoRes = await db.query(
            `SELECT p.*, u.nombre AS creador_nombre, u.apellido AS creador_apellido
             FROM partido_politico p
             INNER JOIN usuario u ON p.creador_id = u.id_usuario
             WHERE p.id_partido = $1`,
            [id]
        );

        if (partidoRes.rows.length === 0) {
            return res.status(404).json({ error: "Partido no encontrado" });
        }

        const [miembros, propuestas] = await Promise.all([
            db.query(
                `SELECT m.id_miembro, m.cargo, m.seccion,
                        u.nombre, u.apellido, u.correo
                 FROM miembro_partido m
                 INNER JOIN usuario u ON m.id_estudiante = u.id_usuario
                 WHERE m.id_partido = $1`,
                [id]
            ),
            db.query(
                "SELECT id_propuesta, titulo, descripcion FROM propuesta WHERE id_partido = $1",
                [id]
            ),
        ]);

        res.json({
            partido: partidoRes.rows[0],
            miembros: miembros.rows,
            propuestas: propuestas.rows,
        });
    } catch (error) {
        console.error("Error:", error);
        res.status(500).json({ error: "Error del servidor" });
    }
});

app.post("/api/partidos/:id/aprobar", async (req, res) => {
    try {
        const sesion = leerToken(req);
        if (!sesion) return res.status(401).json({ error: "No autenticado" });

        const u = await db.query("SELECT rol FROM usuario WHERE id_usuario = $1", [sesion.id]);

        if (!u.rows.length || (u.rows[0].rol !== "profesor" && u.rows[0].rol !== "administrador")) {
            return res.status(403).json({ error: "Solo profesores pueden aprobar" });
        }

        const { id } = req.params;

        await db.query(
            `UPDATE partido_politico 
             SET estado = 'aprobado', aprobado_por = $1, fecha_aprobacion = NOW()
             WHERE id_partido = $2`,
            [sesion.id, id]
        );

        res.json({ mensaje: "Partido aprobado exitosamente" });
    } catch (error) {
        console.error("Error:", error);
        res.status(500).json({ error: "Error del servidor" });
    }
});

app.post("/api/partidos/:id/rechazar", async (req, res) => {
    try {
        const sesion = leerToken(req);
        if (!sesion) return res.status(401).json({ error: "No autenticado" });

        const u = await db.query("SELECT rol FROM usuario WHERE id_usuario = $1", [sesion.id]);

        if (!u.rows.length || (u.rows[0].rol !== "profesor" && u.rows[0].rol !== "administrador")) {
            return res.status(403).json({ error: "Solo profesores pueden rechazar" });
        }

        const { id } = req.params;
        const { feedback } = req.body;

        if (!feedback || !feedback.trim()) {
            return res.status(400).json({ error: "Necesitás escribir el motivo del rechazo" });
        }

        await db.query(
            `UPDATE partido_politico 
             SET estado = 'rechazado', aprobado_por = $1, fecha_aprobacion = NOW()
             WHERE id_partido = $2`,
            [sesion.id, id]
        );

        res.json({ mensaje: "Partido rechazado" });
    } catch (error) {
        console.error("Error:", error);
        res.status(500).json({ error: "Error del servidor" });
    }
});
// ═══════════════════════════════════════════════════════════
// CANJEAR CÓDIGO DE PROFESOR
// ═══════════════════════════════════════════════════════════
const CODIGO_PROFESOR = process.env.CODIGO_PROFESOR || "PROF-2026-AGORA";

app.put("/api/perfil/ascender-profesor", async (req, res) => {
    console.log("🔑 INTENTO DE CANJE RECIBIDO");
    
    try {
        const sesion = leerToken(req);
        if (!sesion) {
            console.log("❌ No hay sesión");
            return res.status(401).json({ error: "No autenticado" });
        }

        const id = Number(sesion.id);
        const { codigo } = req.body;

        console.log(`📝 Usuario ${id} con código: "${codigo}"`);
        console.log(`🎫 Esperado: "${CODIGO_PROFESOR}"`);

        if (!codigo) {
            return res.status(400).json({ error: "Falta el código" });
        }

        if (codigo.trim() !== CODIGO_PROFESOR) {
            console.log("❌ Código incorrecto");
            return res.status(401).json({ error: "El código no es válido" });
        }

        const usuarioRes = await db.query(
            "SELECT rol FROM usuario WHERE id_usuario = $1",
            [id]
        );

        if (usuarioRes.rows.length === 0) {
            return res.status(404).json({ error: "Usuario no encontrado" });
        }

        if (usuarioRes.rows[0].rol === "profesor") {
            return res.status(400).json({ error: "Ya sos profesor" });
        }

        await db.query(
            "UPDATE usuario SET rol = 'profesor' WHERE id_usuario = $1",
            [id]
        );

        console.log(`✅ Usuario ${id} ahora es profesor`);

        res.json({
            mensaje: "¡Ahora sos profesor!",
            rol: "profesor",
        });
    } catch (error) {
        console.error("❌ Error:", error);
        res.status(500).json({ error: "Error del servidor", detalle: error.message });
    }
});
// ═══════════════════════════════════════════════════════════
// INICIAR SERVIDOR
// ═══════════════════════════════════════════════════════════
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`Servidor funcionando en http://localhost:${PORT}`);
});