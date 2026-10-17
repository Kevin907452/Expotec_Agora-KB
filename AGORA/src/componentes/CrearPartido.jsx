// agoraya/AGORA/src/componentes/CrearPartido.jsx
import { useState, useEffect } from "react";
import { useNavigate } from "react-router-dom";
import {
  ArrowLeft,
  ArrowRight,
  Check,
  Sparkles,
  Users,
  Lightbulb,
  Palette,
  Image as ImageIcon,
  UserPlus,
  X,
  Plus,
  Quote,
} from "lucide-react";
import Swal from "sweetalert2";
import NavbarProfesor from "./NavbarProfesor.jsx";
import { NavbarEstudiante } from "./indexestudiante.jsx";
import UploadDropzone from "./UploadDropzone.jsx";
import "./CrearPartido.css";

const API = "http://localhost:3000/api";

const CARGOS = [
  { value: "presidente", label: "Presidente" },
  { value: "vicepresidente", label: "Vicepresidente" },
  { value: "secretario", label: "Secretario" },
  { value: "tesorero", label: "Tesorero" },
  { value: "vocal1", label: "Vocal 1" },
  { value: "vocal2", label: "Vocal 2" },
  { value: "fiscal", label: "Fiscal" },
];

const PALETA = [
  { c1: "#A3D9BD", c2: "#E6A8D7", nombre: "Menta & Rosa" },
  { c1: "#F0C15C", c2: "#9EA8D7", nombre: "Oro & Lavanda" },
  { c1: "#E6A8D7", c2: "#F0C15C", nombre: "Rosa & Oro" },
  { c1: "#9EA8D7", c2: "#A7EFEA", nombre: "Lavanda & Menta" },
  { c1: "#8D7BE8", c2: "#C1FFF4", nombre: "Violeta & Turquesa" },
  { c1: "#F5A524", c2: "#E5484D", nombre: "Naranja & Rojo" },
];

const PASOS = [
  { id: 1, titulo: "Identidad", icon: Sparkles },
  { id: 2, titulo: "Colores e imagen", icon: Palette },
  { id: 3, titulo: "Directiva", icon: Users },
  { id: 4, titulo: "Propuestas", icon: Lightbulb },
  { id: 5, titulo: "Revisión", icon: Check },
];

function CrearPartido() {
  const navigate = useNavigate();
  const usuario = (() => {
    try {
      return JSON.parse(localStorage.getItem("usuario") || "null");
    } catch {
      return null;
    }
  })();

  const esProfesor =
    usuario?.rol === "profesor" || usuario?.rol === "administrador";

  const [paso, setPaso] = useState(1);
  const [cargando, setCargando] = useState(false);
  const [gobiernoId, setGobiernoId] = useState(1);

  const [form, setForm] = useState({
    nombre: "",
    descripcion: "",
    slogan: "",
    meta: "",
    frase: "",
    color_principal: "#A3D9BD",
    color_secundario: "#E6A8D7",
    bandera_url: null,
    miembros: [],
    propuestas: [],
  });

  // Cargar el gobierno activo (el primero)
  useEffect(() => {
    const cargarGobierno = async () => {
      try {
        const res = await fetch(`${API}/gobiernos/activo`);
        const data = await res.json();
        if (data?.id_gobierno) setGobiernoId(data.id_gobierno);
      } catch (err) {
        // Si falla, usamos 1 por defecto
        console.warn("Usando gobierno_id = 1 por defecto");
      }
    };
    cargarGobierno();
  }, []);

  const actualizar = (campo, valor) => setForm({ ...form, [campo]: valor });

  const puedeAvanzar = () => {
    if (paso === 1)
      return form.nombre.length >= 3 && form.descripcion.length >= 20;
    if (paso === 2) return form.bandera_url && form.color_principal;
    if (paso === 3) return form.miembros.length >= 5;
    if (paso === 4) return form.propuestas.length >= 2;
    return true;
  };

  const siguiente = () => puedeAvanzar() && setPaso(paso + 1);
  const anterior = () => paso > 1 && setPaso(paso - 1);

  const enviar = async () => {
    setCargando(true);
    try {
      const token = localStorage.getItem("agora_token") || "";
      const creador_id = usuario?.id_usuario;

      if (!creador_id) {
        throw new Error("No se encontró tu usuario. Cerrá sesión y volvé a entrar.");
      }

      const res = await fetch(`${API}/partidos`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`,
        },
        body: JSON.stringify({
          nombre: form.nombre,
          descripcion: form.descripcion,
          slogan: form.slogan,
          meta: form.meta,
          frase: form.frase,
          color_principal: form.color_principal,
          color_secundario: form.color_secundario,
          bandera: { datos: form.bandera_url },
          gobierno_id: gobiernoId,
          creador_id,
          miembros: form.miembros.map((m) => ({
            cargo: m.cargo,
            id_estudiante: null,
            nombre: m.nombre,
            apellido: m.apellido,
            seccion: m.seccion,
          })),
          propuestas: form.propuestas.map((p) => ({
            titulo: p.titulo,
            descripcion: p.descripcion,
          })),
        }),
      });

      const data = await res.json();
      if (!res.ok) throw new Error(data.error || data.mensaje);

      Swal.fire({
        title: "¡Partido enviado!",
        html: `Tu partido <b>${form.nombre}</b> fue enviado para revisión.<br/>Un profesor lo aprobará pronto.`,
        icon: "success",
        confirmButtonText: "Ver partidos",
        confirmButtonColor: "#8D7BE8",
        background: "#fef8ed",
        color: "#4a386d",
      }).then(() => navigate("/partidos"));
    } catch (err) {
      Swal.fire({
        title: "Error",
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
    <div className="crear-page">
      {esProfesor ? <NavbarProfesor /> : <NavbarEstudiante />}

      <main className="crear-main">
        <header className="crear-header">
          <button className="crear-back" onClick={() => navigate("/partidos")}>
            <ArrowLeft size={18} />
            Volver a partidos
          </button>
          <div className="crear-title">
            <span className="crear-eyebrow">INSCRIPCIÓN DE PARTIDO</span>
            <h1>Creá tu partido político</h1>
            <p>Completá los 5 pasos y enviá tu partido para revisión</p>
          </div>
        </header>

        <div className="crear-stepper">
          {PASOS.map((p) => {
            const Icon = p.icon;
            const activo = paso === p.id;
            const completado = paso > p.id;
            return (
              <div
                key={p.id}
                className={`crear-step ${activo ? "active" : ""} ${
                  completado ? "done" : ""
                }`}
              >
                <div className="crear-step-icon">
                  {completado ? <Check size={16} /> : <Icon size={16} />}
                </div>
                <span className="crear-step-label">{p.titulo}</span>
              </div>
            );
          })}
        </div>

        <div className="crear-content">
          <PreviewLateral form={form} />

          <div className="crear-form">
            {paso === 1 && <PasoIdentidad form={form} actualizar={actualizar} />}
            {paso === 2 && <PasoColores form={form} actualizar={actualizar} />}
            {paso === 3 && <PasoDirectiva form={form} actualizar={actualizar} />}
            {paso === 4 && <PasoPropuestas form={form} actualizar={actualizar} />}
            {paso === 5 && <PasoRevision form={form} />}

            <div className="crear-nav">
              <button
                className="crear-btn-secondary"
                onClick={anterior}
                disabled={paso === 1}
              >
                <ArrowLeft size={16} />
                Anterior
              </button>

              {paso < 5 ? (
                <button
                  className="crear-btn-primary"
                  onClick={siguiente}
                  disabled={!puedeAvanzar()}
                >
                  Siguiente
                  <ArrowRight size={16} />
                </button>
              ) : (
                <button
                  className="crear-btn-primary"
                  onClick={enviar}
                  disabled={cargando}
                >
                  {cargando ? "Enviando..." : "Enviar para revisión"}
                  <Check size={16} />
                </button>
              )}
            </div>
          </div>
        </div>
      </main>
    </div>
  );
}

// ═══════════════════════════════════════════════════════
// VISTA PREVIA (extraída como componente)
// ═══════════════════════════════════════════════════════
function PreviewLateral({ form }) {
  const iniciales = `${form.nombre?.[0] || "P"}`.toUpperCase();

  return (
    <aside className="crear-preview">
      <div
        className="preview-card"
        style={{
          "--c1": form.color_principal,
          "--c2": form.color_secundario,
        }}
      >
        {/* Bandera */}
        <div className="preview-flag">
          {form.bandera_url ? (
            <img src={form.bandera_url} alt="Bandera" />
          ) : (
            <div className="preview-flag-placeholder">
              <ImageIcon size={28} />
            </div>
          )}
        </div>

        {/* Contenido */}
        <div className="preview-body">
          <h3>{form.nombre || "Nombre del partido"}</h3>
          {form.slogan && <p className="preview-slogan">"{form.slogan}"</p>}
          <p className="preview-desc">
            {form.descripcion ||
              "Descripción del partido aparecerá aquí..."}
          </p>

          <div className="preview-meta">
            <span>
              <Users size={12} strokeWidth={2.5} />
              {form.miembros.length} integrantes
            </span>
            <span>
              <Lightbulb size={12} strokeWidth={2.5} />
              {form.propuestas.length} propuestas
            </span>
          </div>
        </div>
      </div>
      <p className="preview-label">VISTA PREVIA EN VIVO</p>
    </aside>
  );
}

// ═══════════════════════════════════════════════════════
// PASO 1 — IDENTIDAD
// ═══════════════════════════════════════════════════════
function PasoIdentidad({ form, actualizar }) {
  return (
    <div className="paso-content">
      <div className="paso-header">
        <h2>Identidad del partido</h2>
        <p>¿Cómo se llamará tu partido y qué los representa?</p>
      </div>

      <div className="paso-grid">
        <div className="campo">
          <label>Nombre del partido *</label>
          <input
            type="text"
            placeholder="Ej: Acción Común"
            value={form.nombre}
            onChange={(e) => actualizar("nombre", e.target.value)}
            maxLength={80}
          />
          <span className="campo-hint">{form.nombre.length}/80</span>
        </div>

        <div className="campo">
          <label>Slogan</label>
          <input
            type="text"
            placeholder="Ej: Juntos por un CEDES más verde"
            value={form.slogan}
            onChange={(e) => actualizar("slogan", e.target.value)}
            maxLength={200}
          />
        </div>

        <div className="campo full">
          <label>
            Descripción * <small>(mínimo 20 caracteres)</small>
          </label>
          <textarea
            placeholder="Contá de qué trata tu partido, cuáles son sus valores, qué los diferencia..."
            value={form.descripcion}
            onChange={(e) => actualizar("descripcion", e.target.value)}
            rows={4}
            maxLength={500}
          />
          <span className="campo-hint">{form.descripcion.length}/500</span>
        </div>

        <div className="campo full">
          <label>Meta principal</label>
          <textarea
            placeholder="¿Cuál es el objetivo más importante que quieren lograr?"
            value={form.meta}
            onChange={(e) => actualizar("meta", e.target.value)}
            rows={2}
            maxLength={300}
          />
        </div>

        <div className="campo full">
          <label>Frase que los representa</label>
          <div className="campo-with-icon">
            <Quote size={18} />
            <input
              type="text"
              placeholder="Ej: El futuro no se espera, se construye hoy."
              value={form.frase}
              onChange={(e) => actualizar("frase", e.target.value)}
              maxLength={200}
            />
          </div>
        </div>
      </div>
    </div>
  );
}

// ═══════════════════════════════════════════════════════
// PASO 2 — COLORES E IMAGEN
// ═══════════════════════════════════════════════════════
function PasoColores({ form, actualizar }) {
  return (
    <div className="paso-content">
      <div className="paso-header">
        <h2>Identidad visual</h2>
        <p>Elegí los colores y subí la bandera del partido</p>
      </div>

      <div className="paso-grid">
        <div className="campo full">
          <label>Imagen del partido *</label>
          <UploadDropzone
            initialImage={form.bandera_url}
            onImageSelected={(img) => actualizar("bandera_url", img)}
          />
        </div>

        <div className="campo full">
          <label>Paleta de colores</label>
          <div className="paleta-grid">
            {PALETA.map((p, i) => {
              const seleccionado =
                form.color_principal === p.c1 &&
                form.color_secundario === p.c2;
              return (
                <button
                  key={i}
                  type="button"
                  className={`paleta-item ${seleccionado ? "active" : ""}`}
                  onClick={() => {
                    actualizar("color_principal", p.c1);
                    actualizar("color_secundario", p.c2);
                  }}
                >
                  <div
                    className="paleta-preview"
                    style={{
                      background: `linear-gradient(135deg, ${p.c1}, ${p.c2})`,
                    }}
                  />
                  <span>{p.nombre}</span>
                  {seleccionado && (
                    <span className="paleta-check">
                      <Check size={14} />
                    </span>
                  )}
                </button>
              );
            })}
          </div>
        </div>

        <div className="campo">
          <label>Color principal</label>
          <div className="color-picker">
            <input
              type="color"
              value={form.color_principal}
              onChange={(e) => actualizar("color_principal", e.target.value)}
            />
            <input
              type="text"
              value={form.color_principal}
              onChange={(e) => actualizar("color_principal", e.target.value)}
            />
          </div>
        </div>

        <div className="campo">
          <label>Color secundario</label>
          <div className="color-picker">
            <input
              type="color"
              value={form.color_secundario}
              onChange={(e) => actualizar("color_secundario", e.target.value)}
            />
            <input
              type="text"
              value={form.color_secundario}
              onChange={(e) => actualizar("color_secundario", e.target.value)}
            />
          </div>
        </div>
      </div>
    </div>
  );
}

// ═══════════════════════════════════════════════════════
// PASO 3 — DIRECTIVA
// ═══════════════════════════════════════════════════════
function PasoDirectiva({ form, actualizar }) {
  const [nuevo, setNuevo] = useState({
    nombre: "",
    apellido: "",
    cargo: "presidente",
    seccion: "10-A",
  });

  const agregar = () => {
    if (!nuevo.nombre || !nuevo.apellido) return;
    if (form.miembros.some((m) => m.cargo === nuevo.cargo)) {
      Swal.fire({
        title: "Cargo ya asignado",
        text: `Ya hay alguien en el cargo de ${nuevo.cargo}`,
        icon: "warning",
        confirmButtonColor: "#8D7BE8",
        background: "#fef8ed",
        color: "#4a386d",
      });
      return;
    }
    actualizar("miembros", [...form.miembros, { ...nuevo }]);
    setNuevo({ nombre: "", apellido: "", cargo: "presidente", seccion: "10-A" });
  };

  const eliminar = (i) => {
    actualizar(
      "miembros",
      form.miembros.filter((_, idx) => idx !== i)
    );
  };

  const cargosDisponibles = CARGOS.filter(
    (c) => !form.miembros.some((m) => m.cargo === c.value)
  );

  return (
    <div className="paso-content">
      <div className="paso-header">
        <h2>Directiva del partido</h2>
        <p>Agregá los 7 candidatos con sus cargos y secciones</p>
      </div>

      <div className="miembros-form">
        <div className="miembros-inputs">
          <input
            type="text"
            placeholder="Nombre"
            value={nuevo.nombre}
            onChange={(e) => setNuevo({ ...nuevo, nombre: e.target.value })}
          />
          <input
            type="text"
            placeholder="Apellido"
            value={nuevo.apellido}
            onChange={(e) => setNuevo({ ...nuevo, apellido: e.target.value })}
          />
          <select
            value={nuevo.cargo}
            onChange={(e) => setNuevo({ ...nuevo, cargo: e.target.value })}
          >
            {cargosDisponibles.map((c) => (
              <option key={c.value} value={c.value}>
                {c.label}
              </option>
            ))}
          </select>
          <select
            value={nuevo.seccion}
            onChange={(e) => setNuevo({ ...nuevo, seccion: e.target.value })}
          >
            {[7, 8, 9, 10, 11, 12].flatMap((n) =>
              ["A", "B", "C", "D", "E", "F"].map((l) => (
                <option key={`${n}-${l}`} value={`${n}-${l}`}>
                  {n}-{l}
                </option>
              ))
            )}
          </select>
          <button
            type="button"
            className="btn-add"
            onClick={agregar}
            disabled={!nuevo.nombre || !nuevo.apellido}
          >
            <Plus size={16} />
            Agregar
          </button>
        </div>

        <div className="miembros-list">
          {form.miembros.length === 0 && (
            <div className="miembros-empty">
              <UserPlus size={32} />
              <p>Agregá los 7 candidatos de tu partido</p>
            </div>
          )}
          {form.miembros.map((m, i) => {
            const cargoLabel = CARGOS.find((c) => c.value === m.cargo)?.label;
            return (
              <div key={i} className="miembro-item">
                <div className="miembro-avatar">
                  {m.nombre[0]}
                  {m.apellido[0]}
                </div>
                <div className="miembro-info">
                  <span className="miembro-cargo">{cargoLabel}</span>
                  <span className="miembro-nombre">
                    {m.nombre} {m.apellido}
                  </span>
                  <span className="miembro-seccion">{m.seccion}</span>
                </div>
                <button
                  type="button"
                  className="miembro-remove"
                  onClick={() => eliminar(i)}
                >
                  <X size={16} />
                </button>
              </div>
            );
          })}
        </div>
      </div>

      <p className="paso-hint">
        {form.miembros.length}/7 integrantes · mínimo 5 para avanzar
      </p>
    </div>
  );
}

// ═══════════════════════════════════════════════════════
// PASO 4 — PROPUESTAS
// ═══════════════════════════════════════════════════════
function PasoPropuestas({ form, actualizar }) {
  const [nueva, setNueva] = useState({ titulo: "", descripcion: "" });

  const agregar = () => {
    if (!nueva.titulo.trim()) return;
    actualizar("propuestas", [...form.propuestas, { ...nueva }]);
    setNueva({ titulo: "", descripcion: "" });
  };

  const eliminar = (i) => {
    actualizar(
      "propuestas",
      form.propuestas.filter((_, idx) => idx !== i)
    );
  };

  return (
    <div className="paso-content">
      <div className="paso-header">
        <h2>Propuestas del partido</h2>
        <p>¿Qué van a cambiar? Mínimo 2 propuestas concretas</p>
      </div>

      <div className="propuestas-form">
        <div className="propuesta-input">
          <input
            type="text"
            placeholder="Título de la propuesta (ej: Campaña de reciclaje)"
            value={nueva.titulo}
            onChange={(e) => setNueva({ ...nueva, titulo: e.target.value })}
            maxLength={100}
          />
          <textarea
            placeholder="Descripción breve: ¿en qué consiste? ¿cómo lo van a hacer?"
            value={nueva.descripcion}
            onChange={(e) =>
              setNueva({ ...nueva, descripcion: e.target.value })
            }
            rows={2}
            maxLength={300}
          />
          <button
            type="button"
            className="btn-add"
            onClick={agregar}
            disabled={!nueva.titulo.trim()}
          >
            <Plus size={16} />
            Agregar propuesta
          </button>
        </div>

        <div className="propuestas-list">
          {form.propuestas.length === 0 && (
            <div className="propuestas-empty">
              <Lightbulb size={32} />
              <p>Agregá al menos 2 propuestas</p>
            </div>
          )}
          {form.propuestas.map((p, i) => (
            <div key={i} className="propuesta-item">
              <span className="propuesta-num">{i + 1}</span>
              <div className="propuesta-content">
                <p className="propuesta-titulo">{p.titulo}</p>
                {p.descripcion && (
                  <p className="propuesta-desc">{p.descripcion}</p>
                )}
              </div>
              <button
                type="button"
                className="propuesta-remove"
                onClick={() => eliminar(i)}
              >
                <X size={16} />
              </button>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
}

// ═══════════════════════════════════════════════════════
// PASO 5 — REVISIÓN
// ═══════════════════════════════════════════════════════
function PasoRevision({ form }) {
  return (
    <div className="paso-content">
      <div className="paso-header">
        <h2>Revisión final</h2>
        <p>Revisá toda la información antes de enviar</p>
      </div>

      <div className="revision-grid">
        <div className="revision-card">
          <h4>IDENTIDAD</h4>
          <p>
            <b>Nombre:</b> {form.nombre}
          </p>
          <p>
            <b>Slogan:</b> {form.slogan || "—"}
          </p>
          <p>
            <b>Descripción:</b> {form.descripcion}
          </p>
          <p>
            <b>Meta:</b> {form.meta || "—"}
          </p>
          <p>
            <b>Frase:</b> {form.frase || "—"}
          </p>
        </div>

        <div className="revision-card">
          <h4>DIRECTIVA ({form.miembros.length})</h4>
          {form.miembros.map((m, i) => (
            <p key={i}>
              <b>{CARGOS.find((c) => c.value === m.cargo)?.label}:</b>{" "}
              {m.nombre} {m.apellido} ({m.seccion})
            </p>
          ))}
        </div>

        <div className="revision-card full">
          <h4>PROPUESTAS ({form.propuestas.length})</h4>
          {form.propuestas.map((p, i) => (
            <div key={i} className="revision-propuesta">
              <b>
                {i + 1}. {p.titulo}
              </b>
              {p.descripcion && <span>{p.descripcion}</span>}
            </div>
          ))}
        </div>
      </div>
    </div>
  );
}

export default CrearPartido;