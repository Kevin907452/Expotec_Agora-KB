// agoraya/AGORA/src/componentes/indexestudiante.jsx
import { useEffect, useCallback, useState } from "react";
import { Link, useNavigate } from "react-router-dom";
import "./estudiante.css";
import logoA from "../assets/logoA.png";
import MenuPerfil from "./MenuPerfil.jsx";
import { motion, AnimatePresence } from "framer-motion";
import Swal from "sweetalert2";
import { X, KeyRound } from "lucide-react";

import Hero from "./hero";
import Votacion from "./votacion";

const API = "http://localhost:3000/api";

// ═══════════════════════════════════════════════════════════
// HELPER: resolver imagen (base64 / path)
// ═══════════════════════════════════════════════════════════
function resolverImagenPreview(bandera_url) {
  if (!bandera_url) return null;
  const url = String(bandera_url).trim();
  if (!url) return null;
  if (url.startsWith("data:image/")) return url;
  if (/^https?:\/\//i.test(url)) return url;
  if (url.startsWith("/")) return url;
  return `/${url}`;
}

// ═══════════════════════════════════════════════════════════
// TRES COLUMNAS
// ═══════════════════════════════════════════════════════════
function TresColumnas() {
  const attrStringCol =
    '{"variationThumbColour":"#8D7BE8","variationName":"Two Tone","variationNumber":2,"numberOfGroups":2,"backgroundIsGroup":false,"strokeWidth":1,"defaultColours":{"group-1":"#8D7BE8","group-2":"#000000","background":"#FFFFFF00"}}';

  const setColIconAttrs = useCallback((node) => {
    if (node) node.setAttribute("attributes", attrStringCol);
  }, []);

  return (
    <section className="seccion-tres-columnas">
      <div className="columna-item">
        <animated-icons
          ref={setColIconAttrs}
          src="https://animatedicons.co/get-icon?name=Review&style=minimalistic&token=e271fbe7-23f4-4470-9cc9-ac62bdc729f1"
          trigger="loop"
          height="70"
          width="70"
        ></animated-icons>
        <h2>Poder Estudiantil</h2>
        <p>
          Al organizarnos y expresar ideas, la comunidad estudiantil asume un
          rol activo en la construcción de nuestro entorno, permitiendo así que
          tengamos poder de decidir sobre los temas que nos afectan.
        </p>
      </div>

      <div className="columna-item">
        <animated-icons
          ref={setColIconAttrs}
          src="https://animatedicons.co/get-icon?name=Firecracker&style=minimalistic&token=0e6f2ecc-a2ca-45ba-9eab-0926e9b25a78"
          trigger="loop"
          height="70"
          width="70"
        ></animated-icons>
        <h2>Tu Voto Importa</h2>
        <p>
          Cada voto representa tu postura frente al futuro de la institución. Es
          la herramienta clave para respaldar las propuestas que mejor se
          alinean con las necesidades de la comunidad estudiantil.
        </p>
      </div>

      <div className="columna-item">
        <animated-icons
          ref={setColIconAttrs}
          src="https://animatedicons.co/get-icon?name=Dynamic%20Role&style=minimalistic&token=deb3f3dc-7e65-4d2a-a47e-e6447f4bab30"
          trigger="loop"
          height="70"
          width="70"
        ></animated-icons>
        <h2>Importancia de la Participación</h2>
        <p>
          Involucrarse en los procesos democráticos fortalece la convivencia, la
          transparencia y el pensamiento crítico. La participación activa
          fomenta una ciudadanía responsable desde la etapa escolar.
        </p>
      </div>
    </section>
  );
}

// ═══════════════════════════════════════════════════════════
// VISTA PREVIA DE PARTIDOS (REDISEÑADA)
// ═══════════════════════════════════════════════════════════
function PreviewPartidos() {
  const [partidos, setPartidos] = useState([]);
  const [cargando, setCargando] = useState(true);

  useEffect(() => {
    const cargar = async () => {
      try {
        const res = await fetch(`${API}/partidos/aprobados`);
        const data = await res.json();
        setPartidos((data.partidos || []).slice(0, 4));
      } catch (error) {
        console.error(error);
      } finally {
        setCargando(false);
      }
    };
    cargar();
  }, []);

  if (cargando) {
    return (
      <section className="pv-section">
        <div className="pv-header">
          <h2>Conocé los partidos</h2>
          <p>Los partidos que compiten este año</p>
        </div>
        <div className="pv-loading">Cargando partidos...</div>
      </section>
    );
  }

  if (partidos.length === 0) return null;

  return (
    <section className="pv-section">
      <div className="pv-header">
        <span className="pv-eyebrow">ELECCIÓN ESTUDIANTIL</span>
        <h2>Conocé los partidos</h2>
        <p>Los partidos que compiten este año</p>
      </div>

      <div className="pv-grid">
        {partidos.map((p, i) => {
          const rutaImagen = resolverImagenPreview(p.bandera_url);
          const color1 = p.color_principal || "#A3D9BD";
          const color2 = p.color_secundario || "#E6A8D7";

          return (
            <motion.div
              key={p.id_partido}
              className="pv-card"
              initial={{ opacity: 0, y: 40, rotateX: -10 }}
              whileInView={{ opacity: 1, y: 0, rotateX: 0 }}
              viewport={{ once: true }}
              transition={{ duration: 0.6, delay: i * 0.12, type: "spring", stiffness: 100 }}
              whileHover={{ y: -8, scale: 1.02 }}
            >
              {/* Franja de colores del partido */}
              <div
                className="pv-color-bar"
                style={{ background: `linear-gradient(90deg, ${color1}, ${color2})` }}
              />

              {/* Imagen de la bandera */}
              <div className="pv-image-wrap">
                {rutaImagen ? (
                  <img src={rutaImagen} alt={p.nombre} className="pv-image" />
                ) : (
                  <div
                    className="pv-image-placeholder"
                    style={{ background: `linear-gradient(135deg, ${color1}, ${color2})` }}
                  >
                    <span>{p.nombre?.[0]?.toUpperCase()}</span>
                  </div>
                )}

                {/* Badge flotante */}
                <span className="pv-badge">#{i + 1}</span>
              </div>

              {/* Contenido */}
              <div className="pv-body">
                <h3 className="pv-nombre">{p.nombre}</h3>
                <p className="pv-desc">
                  {p.descripcion?.substring(0, 90)}
                  {p.descripcion?.length > 90 ? "…" : ""}
                </p>

                {/* Mini stats */}
                <div className="pv-stats">
                  <span className="pv-stat">
                    <strong>{p.miembros?.length || 0}</strong> integrantes
                  </span>
                  <span className="pv-dot" />
                  <span className="pv-stat">
                    <strong>{p.propuestas?.length || 0}</strong> propuestas
                  </span>
                </div>
              </div>
            </motion.div>
          );
        })}
      </div>

      <Link to="/partidos" className="pv-ver-todos">
        Ver todos los partidos
        <span>→</span>
      </Link>
    </section>
  );
}

// ═══════════════════════════════════════════════════════════
// MODAL: Tengo código
// ═══════════════════════════════════════════════════════════
function ModalTengoCodigo({ onClose }) {
  const navigate = useNavigate();
  const [codigo, setCodigo] = useState("");
  const [cargando, setCargando] = useState(false);

  const handleSubmit = async (e) => {
    e.preventDefault();
    if (!codigo.trim()) return;

    setCargando(true);
    try {
      const token = localStorage.getItem("agora_token") || "";
      const res = await fetch(`${API}/perfil/ascender-profesor`, {
        method: "PUT",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`,
        },
        body: JSON.stringify({ codigo: codigo.trim() }),
      });

      // Manejar el caso en que el backend devuelva HTML
      const text = await res.text();
      let data;
      try {
        data = JSON.parse(text);
      } catch {
        throw new Error(
          "El servidor no respondió correctamente. Verificá que el backend tenga el endpoint /api/perfil/ascender-profesor."
        );
      }

      if (!res.ok) throw new Error(data.error || data.mensaje);

      // Actualizar localStorage
      const u = JSON.parse(localStorage.getItem("usuario") || "{}");
      u.rol = "profesor";
      localStorage.setItem("usuario", JSON.stringify(u));

      await Swal.fire({
        title: "¡Ahora sos profesor!",
        text: "Vas a poder revisar partidos de los estudiantes.",
        icon: "success",
        confirmButtonText: "Ir al panel",
        confirmButtonColor: "#8D7BE8",
        background: "#fef8ed",
        color: "#4a386d",
      });

      onClose();
      navigate("/indexprofesor");
    } catch (err) {
      Swal.fire({
        title: "Código inválido",
        text: err.message,
        icon: "error",
        confirmButtonColor: "#8D7BE8",
        background: "#fef8ed",
        color: "#4a386d",
      });
    } finally {
      setCargando(false);
    }
  };

  return (
    <motion.div
      className="modal-codigo-overlay"
      initial={{ opacity: 0 }}
      animate={{ opacity: 1 }}
      exit={{ opacity: 0 }}
      onClick={onClose}
    >
      <motion.div
        className="modal-codigo"
        initial={{ opacity: 0, y: 30, scale: 0.95 }}
        animate={{ opacity: 1, y: 0, scale: 1 }}
        exit={{ opacity: 0, y: 30, scale: 0.95 }}
        transition={{ type: "spring", stiffness: 300, damping: 25 }}
        onClick={(e) => e.stopPropagation()}
      >
        <button className="modal-codigo-close" onClick={onClose}>
          <X size={20} />
        </button>

        <div className="modal-codigo-icon">
          <KeyRound size={32} />
        </div>

        <h2>¿Tenés un código?</h2>
        <p>
          Ingresá el código que te dio tu profesor para cambiar tu rol a
          docente y poder revisar partidos.
        </p>

        <form onSubmit={handleSubmit} className="modal-codigo-form">
          <input
            type="text"
            placeholder="Ej: PROF-2026-AGORA"
            value={codigo}
            onChange={(e) => setCodigo(e.target.value.toUpperCase())}
            maxLength={30}
            autoFocus
            required
          />
          <button type="submit" disabled={cargando || !codigo.trim()}>
            {cargando ? "Verificando..." : "Canjear código"}
          </button>
        </form>
      </motion.div>
    </motion.div>
  );
}

// ═══════════════════════════════════════════════════════════
// NAVBAR ESTUDIANTE
// ═══════════════════════════════════════════════════════════
function Navbar() {
  const [isOpen, setIsOpen] = useState(false);
  const [modalCodigo, setModalCodigo] = useState(false);

  const toggleMenu = () => setIsOpen(!isOpen);
  const closeMenu = () => setIsOpen(false);

  useEffect(() => {
    const scriptId = "animated-icons-script";
    if (!document.getElementById(scriptId)) {
      const script = document.createElement("script");
      script.id = scriptId;
      script.src = "https://animatedicons.co/scripts/embed-animated-icons.js";
      script.async = true;
      document.body.appendChild(script);
    }
  }, []);

  const attrString =
    '{"variationThumbColour":"#8D7BE8","variationName":"Two Tone","variationNumber":2,"numberOfGroups":2,"backgroundIsGroup":false,"strokeWidth":1,"defaultColours":{"group-1":"#8D7BE8","group-2":"#000000","background":"#FFFFFF00"}}';

  const setIconAttrs = useCallback((node) => {
    if (node) node.setAttribute("attributes", attrString);
  }, []);

  return (
    <>
      <nav className="navbar-estudiante">
        <div className="navbar-logo">
          <img src={logoA} alt="Logo de Ágora" />
          <span>Ágora</span>
        </div>

        <button
          className={`hamburger-btn ${isOpen ? "active" : ""}`}
          onClick={toggleMenu}
          aria-label="Abrir menú"
        >
          <span></span>
          <span></span>
          <span></span>
        </button>

        <div className={`navbar-links ${isOpen ? "active" : ""}`}>
          <Link to="/indexestudiante" className="nav-item" onClick={closeMenu}>
            <animated-icons
              ref={setIconAttrs}
              src="https://animatedicons.co/get-icon?name=Thank%20you&style=minimalistic&token=eb0b9e1a-e71e-4b20-a7dc-7c38f678e237"
              trigger="loop-on-hover"
              height="45"
              width="45"
            ></animated-icons>
            <span>Inicio</span>
          </Link>

          <Link to="/partidos" className="nav-item" onClick={closeMenu}>
            <animated-icons
              ref={setIconAttrs}
              src="https://animatedicons.co/get-icon?name=Register&style=minimalistic&token="
              trigger="loop-on-hover"
              height="45"
              width="45"
            ></animated-icons>
            <span>Partidos</span>
          </Link>

          <Link to="/modulos" className="nav-item" onClick={closeMenu}>
            <animated-icons
              ref={setIconAttrs}
              src="https://animatedicons.co/get-icon?name=checklist&style=minimalistic&token=0d874aa3-6ae4-45c8-9949-aca91ae5739d"
              trigger="loop-on-hover"
              height="45"
              width="45"
            ></animated-icons>
            <span>Módulos</span>
          </Link>

          <Link to="/calendario" className="nav-item" onClick={closeMenu}>
            <animated-icons
              ref={setIconAttrs}
              src="https://animatedicons.co/get-icon?name=calendar%20V3&style=minimalistic&token=4c41ae18-3a92-43bc-b097-59c6f2c21510"
              trigger="loop-on-hover"
              height="45"
              width="45"
            ></animated-icons>
            <span>Calendario</span>
          </Link>

          <Link to="/comunidad" className="nav-item" onClick={closeMenu}>
            <animated-icons
              ref={setIconAttrs}
              src="https://animatedicons.co/get-icon?name=Audience%20Reach&style=minimalistic&token=a566e2c2-ed78-4e8f-9adb-3283a20f035c"
              trigger="loop-on-hover"
              height="45"
              width="45"
            ></animated-icons>
            <span>Comunidad</span>
          </Link>

          <Link to="/notas" className="nav-item" onClick={closeMenu}>
            <animated-icons
              ref={setIconAttrs}
              src="https://animatedicons.co/get-icon?name=Report%20V2&style=minimalistic&token=1869947d-0b96-4314-9dd7-a86ec7a829ff"
              trigger="loop-on-hover"
              height="45"
              width="45"
            ></animated-icons>
            <span>Notas</span>
          </Link>

          <button
            className="nav-item nav-item-codigo"
            onClick={() => {
              closeMenu();
              setModalCodigo(true);
            }}
          >
            <KeyRound size={20} />
            <span>Tengo código</span>
          </button>

          <div className="nav-perfil">
            <MenuPerfil />
          </div>
        </div>
      </nav>

      <AnimatePresence>
        {modalCodigo && <ModalTengoCodigo onClose={() => setModalCodigo(false)} />}
      </AnimatePresence>
    </>
  );
}

// ═══════════════════════════════════════════════════════════
// PÁGINA PRINCIPAL
// ═══════════════════════════════════════════════════════════
export default function IndexEstudiante() {
  return (
    <div>
      <Navbar />
      <main>
        <Hero />
      </main>

      <TresColumnas />

      <PreviewPartidos />

      <Votacion />
    </div>
  );
}

export { Navbar as NavbarEstudiante };