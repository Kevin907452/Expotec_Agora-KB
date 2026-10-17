// agoraya/AGORA/src/componentes/Perfil.jsx
import { useState, useEffect } from "react";
import { Link, useNavigate } from "react-router-dom";
import { motion, AnimatePresence } from "framer-motion";
import {
  ArrowLeft, Edit3, Lock, Camera, Save, X,
  Trophy, Flame, TrendingUp, BookOpen, Award, Eye, EyeOff, Check
} from "lucide-react";
import Swal from "sweetalert2";
import "./Perfil.css";
import UploadDropzone from "./UploadDropzone.jsx";
import InlineConfirm from "./InlineConfirm.jsx";
import NavbarProfesor from "./NavbarProfesor.jsx";
import { NavbarEstudiante } from "./indexestudiante.jsx";

const API = "http://localhost:3000/api";

export default function Perfil() {
  const navigate = useNavigate();
  const usuarioLocal = (() => {
    try {
      return JSON.parse(localStorage.getItem("usuario") || "null");
    } catch {
      return null;
    }
  })();

  const esProfesor = usuarioLocal?.rol === "profesor";

  // Estados
  const [cargando, setCargando] = useState(true);
  const [error, setError] = useState("");
  const [perfil, setPerfil] = useState(null);

  // Modales
  const [modalEditar, setModalEditar] = useState(false);
  const [modalPassword, setModalPassword] = useState(false);
  const [modalAvatar, setModalAvatar] = useState(false);

  // ═══ Cargar perfil ═══
  const cargarPerfil = async () => {
    setCargando(true);
    setError("");

    try {
      const token = localStorage.getItem("agora_token") || "";
      const res = await fetch(`${API}/perfil`, {
        headers: { Authorization: `Bearer ${token}` },
      });

      const data = await res.json();
      if (!res.ok) throw new Error(data.error || "Error al cargar perfil");

      setPerfil(data);
    } catch (err) {
      console.error(err);
      setError(err.message);
    } finally {
      setCargando(false);
    }
  };

  useEffect(() => {
    cargarPerfil();
  }, []);

  // ═══ Guardar cambios de avatar ═══
  const guardarAvatar = async (nuevaImagen) => {
    try {
      const token = localStorage.getItem("agora_token") || "";
      const res = await fetch(`${API}/perfil/avatar`, {
        method: "PUT",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`,
        },
        body: JSON.stringify({ avatar_url: nuevaImagen }),
      });

      const data = await res.json();
      if (!res.ok) throw new Error(data.error);

      // Actualizar localStorage
      const u = JSON.parse(localStorage.getItem("usuario") || "{}");
      u.avatar_url = nuevaImagen;
      localStorage.setItem("usuario", JSON.stringify(u));

      setModalAvatar(false);
      cargarPerfil();

      Swal.fire({
        title: "¡Listo!",
        text: "Tu foto de perfil se actualizó",
        icon: "success",
        timer: 2000,
        showConfirmButton: false,
        background: "#fef8ed",
        color: "#4a386d",
      });
    } catch (err) {
      Swal.fire({
        title: "Error",
        text: err.message,
        icon: "error",
        confirmButtonColor: "#9571dd",
        background: "#fef8ed",
        color: "#4a386d",
      });
    }
  };

  // ═══ Eliminar avatar ═══
  const eliminarAvatar = async () => {
    try {
      const token = localStorage.getItem("agora_token") || "";
      const res = await fetch(`${API}/perfil/avatar`, {
        method: "DELETE",
        headers: { Authorization: `Bearer ${token}` },
      });

      if (!res.ok) throw new Error("Error al eliminar");

      const u = JSON.parse(localStorage.getItem("usuario") || "{}");
      delete u.avatar_url;
      localStorage.setItem("usuario", JSON.stringify(u));

      cargarPerfil();

      Swal.fire({
        title: "Eliminado",
        text: "Tu foto de perfil se eliminó",
        icon: "success",
        timer: 2000,
        showConfirmButton: false,
        background: "#fef8ed",
        color: "#4a386d",
      });
    } catch (err) {
      Swal.fire({
        title: "Error",
        text: err.message,
        icon: "error",
        confirmButtonColor: "#9571dd",
        background: "#fef8ed",
        color: "#4a386d",
      });
    }
  };

  // ═══ Render ═══
  if (cargando) {
    return (
      <>
        {esProfesor ? <NavbarProfesor /> : <NavbarEstudiante />}
        <div className="pf-page">
          <div className="pf-loading">Cargando perfil...</div>
        </div>
      </>
    );
  }

  if (error || !perfil) {
    return (
      <>
        {esProfesor ? <NavbarProfesor /> : <NavbarEstudiante />}
        <div className="pf-page">
          <div className="pf-error">{error || "No se pudo cargar el perfil"}</div>
        </div>
      </>
    );
  }

  const { usuario, estadisticas, ultimas_notas, recompensas } = perfil;
  const iniciales = `${usuario.nombre?.[0] || ""}${usuario.apellido?.[0] || ""}`.toUpperCase();

  return (
    <>
      {esProfesor ? <NavbarProfesor /> : <NavbarEstudiante />}

      <main className="pf-page">
        {/* Blobs decorativos */}
        <div className="pf-blob pf-blob-1" />
        <div className="pf-blob pf-blob-2" />

        <div className="pf-container">
          {/* Botón volver */}
          <Link
            to={esProfesor ? "/indexprofesor" : "/indexestudiante"}
            className="pf-back"
          >
            <ArrowLeft size={16} />
            Volver al inicio
          </Link>

          {/* ═══ Header del perfil ═══ */}
          <motion.header
            className="pf-header"
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.5 }}
          >
            {/* Avatar */}
            <div className="pf-avatar-wrap">
              <div className="pf-avatar">
                {usuario.avatar_url ? (
                  <img src={usuario.avatar_url} alt="Avatar" />
                ) : (
                  <span>{iniciales}</span>
                )}
              </div>
              <button
                className="pf-avatar-btn"
                onClick={() => setModalAvatar(true)}
                aria-label="Cambiar foto"
              >
                <Camera size={16} />
              </button>
            </div>

            {/* Info */}
            <div className="pf-header-info">
              <h1 className="pf-nombre">
                {usuario.nombre} {usuario.apellido}
              </h1>
              <p className="pf-correo">{usuario.correo}</p>
              <span className={`pf-rol pf-rol-${usuario.rol}`}>
                {usuario.rol}
              </span>
            </div>

            {/* Acciones */}
            <div className="pf-header-actions">
              <button
                className="pf-btn pf-btn-secondary"
                onClick={() => setModalEditar(true)}
              >
                <Edit3 size={16} />
                Editar perfil
              </button>
              <button
                className="pf-btn pf-btn-secondary"
                onClick={() => setModalPassword(true)}
              >
                <Lock size={16} />
                Cambiar contraseña
              </button>
            </div>
          </motion.header>

          {/* ═══ Stats ═══ */}
          <motion.section
            className="pf-stats"
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.5, delay: 0.15 }}
          >
            <div className="pf-stat">
              <div className="pf-stat-icon pf-stat-icon-promedio">
                <TrendingUp size={22} />
              </div>
              <div className="pf-stat-info">
                <span className="pf-stat-valor">
                  {estadisticas.promedio ? `${Math.round(estadisticas.promedio)}%` : "—"}
                </span>
                <span className="pf-stat-label">Promedio</span>
              </div>
            </div>

            <div className="pf-stat">
              <div className="pf-stat-icon pf-stat-icon-quizzes">
                <BookOpen size={22} />
              </div>
              <div className="pf-stat-info">
                <span className="pf-stat-valor">{estadisticas.total_quizzes}</span>
                <span className="pf-stat-label">Quizzes</span>
              </div>
            </div>

            <div className="pf-stat">
              <div className="pf-stat-icon pf-stat-icon-racha">
                <Flame size={22} />
              </div>
              <div className="pf-stat-info">
                <span className="pf-stat-valor">{estadisticas.racha_actual}</span>
                <span className="pf-stat-label">Racha actual</span>
              </div>
            </div>

            <div className="pf-stat">
              <div className="pf-stat-icon pf-stat-icon-logros">
                <Trophy size={22} />
              </div>
              <div className="pf-stat-info">
                <span className="pf-stat-valor">{estadisticas.total_logros}</span>
                <span className="pf-stat-label">Logros</span>
              </div>
            </div>
          </motion.section>

          {/* ═══ Últimas notas ═══ */}
          <motion.section
            className="pf-section"
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.5, delay: 0.3 }}
          >
            <div className="pf-section-header">
              <h2 className="pf-section-titulo">
                <BookOpen size={20} />
                Mis últimas notas
              </h2>
              <Link to="/notas" className="pf-section-link">
                Ver todas →
              </Link>
            </div>

            {ultimas_notas.length === 0 ? (
              <div className="pf-empty">
                <BookOpen size={32} />
                <p>Aún no tenés notas registradas</p>
              </div>
            ) : (
              <div className="pf-notas">
                {ultimas_notas.map((nota) => (
                  <div key={nota.id_intento} className="pf-nota">
                    <div className="pf-nota-info">
                      <p className="pf-nota-nombre">{nota.quiz}</p>
                      <p className="pf-nota-fecha">
                        {new Date(nota.fecha).toLocaleDateString("es-CR")}
                      </p>
                    </div>
                    <div className="pf-nota-badge">
                      <span className="pf-nota-porcentaje">{nota.porcentaje}%</span>
                    </div>
                  </div>
                ))}
              </div>
            )}
          </motion.section>

          {/* ═══ Logros ═══ */}
          <motion.section
            className="pf-section"
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.5, delay: 0.45 }}
          >
            <div className="pf-section-header">
              <h2 className="pf-section-titulo">
                <Award size={20} />
                Mis logros
              </h2>
            </div>

            {recompensas.length === 0 ? (
              <div className="pf-empty">
                <Trophy size={32} />
                <p>Aún no tenés logros. ¡Seguí aprendiendo!</p>
              </div>
            ) : (
              <div className="pf-logros">
                {recompensas.map((logro) => (
                  <div key={logro.id_recompensa} className="pf-logro">
                    <div className="pf-logro-icon">
                      {logro.imagen_url ? (
                        <img src={logro.imagen_url} alt={logro.nombre} />
                      ) : (
                        <Trophy size={24} />
                      )}
                    </div>
                    <div className="pf-logro-info">
                      <p className="pf-logro-nombre">{logro.nombre}</p>
                      <p className="pf-logro-desc">{logro.descripcion}</p>
                    </div>
                  </div>
                ))}
              </div>
            )}
          </motion.section>
        </div>

        {/* ═══ Modal: Editar perfil ═══ */}
        <AnimatePresence>
          {modalEditar && (
            <ModalEditar
              usuario={usuario}
              onClose={() => setModalEditar(false)}
              onGuardar={() => {
                setModalEditar(false);
                cargarPerfil();
              }}
            />
          )}
        </AnimatePresence>

        {/* ═══ Modal: Cambiar contraseña ═══ */}
        <AnimatePresence>
          {modalPassword && (
            <ModalPassword
              onClose={() => setModalPassword(false)}
            />
          )}
        </AnimatePresence>

        {/* ═══ Modal: Cambiar avatar ═══ */}
        <AnimatePresence>
          {modalAvatar && (
            <ModalAvatar
              usuario={usuario}
              onClose={() => setModalAvatar(false)}
              onGuardar={guardarAvatar}
              onEliminar={eliminarAvatar}
            />
          )}
        </AnimatePresence>
      </main>
    </>
  );
}

// ═══════════════════════════════════════════════════════════
// MODAL: Editar perfil
// ═══════════════════════════════════════════════════════════
function ModalEditar({ usuario, onClose, onGuardar }) {
  const [nombre, setNombre] = useState(usuario.nombre);
  const [apellido, setApellido] = useState(usuario.apellido);
  const [guardando, setGuardando] = useState(false);

  const handleSubmit = async (e) => {
    e.preventDefault();
    setGuardando(true);

    try {
      const token = localStorage.getItem("agora_token") || "";
      const res = await fetch(`${API}/perfil`, {
        method: "PUT",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`,
        },
        body: JSON.stringify({ nombre, apellido }),
      });

      const data = await res.json();
      if (!res.ok) throw new Error(data.error);

      // Actualizar localStorage
      const u = JSON.parse(localStorage.getItem("usuario") || "{}");
      u.nombre = nombre;
      u.apellido = apellido;
      localStorage.setItem("usuario", JSON.stringify(u));

      Swal.fire({
        title: "¡Listo!",
        text: "Perfil actualizado correctamente",
        icon: "success",
        timer: 2000,
        showConfirmButton: false,
        background: "#fef8ed",
        color: "#4a386d",
      });

      onGuardar();
    } catch (err) {
      Swal.fire({
        title: "Error",
        text: err.message,
        icon: "error",
        confirmButtonColor: "#9571dd",
        background: "#fef8ed",
        color: "#4a386d",
      });
    } finally {
      setGuardando(false);
    }
  };

  return (
    <motion.div
      className="pf-modal-overlay"
      initial={{ opacity: 0 }}
      animate={{ opacity: 1 }}
      exit={{ opacity: 0 }}
      onClick={onClose}
    >
      <motion.div
        className="pf-modal"
        initial={{ opacity: 0, y: 30, scale: 0.95 }}
        animate={{ opacity: 1, y: 0, scale: 1 }}
        exit={{ opacity: 0, y: 30, scale: 0.95 }}
        transition={{ type: "spring", stiffness: 300, damping: 25 }}
        onClick={(e) => e.stopPropagation()}
      >
        <div className="pf-modal-header">
          <h3>Editar perfil</h3>
          <button className="pf-modal-close" onClick={onClose}>
            <X size={20} />
          </button>
        </div>

        <form onSubmit={handleSubmit} className="pf-modal-body">
          <div className="pf-field">
            <label>Nombre</label>
            <input
              type="text"
              value={nombre}
              onChange={(e) => setNombre(e.target.value)}
              required
            />
          </div>

          <div className="pf-field">
            <label>Apellido</label>
            <input
              type="text"
              value={apellido}
              onChange={(e) => setApellido(e.target.value)}
              required
            />
          </div>

          <div className="pf-field">
            <label>Correo electrónico</label>
            <input
              type="email"
              value={usuario.correo}
              disabled
              title="El correo no se puede cambiar"
            />
            <span className="pf-field-hint">
              El correo no se puede modificar
            </span>
          </div>

          <div className="pf-modal-actions">
            <button
              type="button"
              className="pf-btn pf-btn-secondary"
              onClick={onClose}
            >
              Cancelar
            </button>
            <button
              type="submit"
              className="pf-btn pf-btn-primary"
              disabled={guardando}
            >
              <Save size={16} />
              {guardando ? "Guardando..." : "Guardar"}
            </button>
          </div>
        </form>
      </motion.div>
    </motion.div>
  );
}

// ═══════════════════════════════════════════════════════════
// MODAL: Cambiar contraseña
// ═══════════════════════════════════════════════════════════
function ModalPassword({ onClose }) {
  const [actual, setActual] = useState("");
  const [nueva, setNueva] = useState("");
  const [confirmar, setConfirmar] = useState("");
  const [verActual, setVerActual] = useState(false);
  const [verNueva, setVerNueva] = useState(false);
  const [guardando, setGuardando] = useState(false);

  const handleSubmit = async (e) => {
    e.preventDefault();

    if (nueva !== confirmar) {
      Swal.fire({
        title: "Error",
        text: "Las contraseñas no coinciden",
        icon: "error",
        confirmButtonColor: "#9571dd",
        background: "#fef8ed",
        color: "#4a386d",
      });
      return;
    }

    if (nueva.length < 6) {
      Swal.fire({
        title: "Error",
        text: "La contraseña debe tener al menos 6 caracteres",
        icon: "error",
        confirmButtonColor: "#9571dd",
        background: "#fef8ed",
        color: "#4a386d",
      });
      return;
    }

    setGuardando(true);

    try {
      const token = localStorage.getItem("agora_token") || "";
      const res = await fetch(`${API}/perfil/password`, {
        method: "PUT",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`,
        },
        body: JSON.stringify({
          contrasena_actual: actual,
          contrasena_nueva: nueva,
        }),
      });

      const data = await res.json();
      if (!res.ok) throw new Error(data.error);

      Swal.fire({
        title: "¡Listo!",
        text: "Contraseña cambiada correctamente",
        icon: "success",
        timer: 2000,
        showConfirmButton: false,
        background: "#fef8ed",
        color: "#4a386d",
      });

      onClose();
    } catch (err) {
      Swal.fire({
        title: "Error",
        text: err.message,
        icon: "error",
        confirmButtonColor: "#9571dd",
        background: "#fef8ed",
        color: "#4a386d",
      });
    } finally {
      setGuardando(false);
    }
  };

  return (
    <motion.div
      className="pf-modal-overlay"
      initial={{ opacity: 0 }}
      animate={{ opacity: 1 }}
      exit={{ opacity: 0 }}
      onClick={onClose}
    >
      <motion.div
        className="pf-modal"
        initial={{ opacity: 0, y: 30, scale: 0.95 }}
        animate={{ opacity: 1, y: 0, scale: 1 }}
        exit={{ opacity: 0, y: 30, scale: 0.95 }}
        transition={{ type: "spring", stiffness: 300, damping: 25 }}
        onClick={(e) => e.stopPropagation()}
      >
        <div className="pf-modal-header">
          <h3>Cambiar contraseña</h3>
          <button className="pf-modal-close" onClick={onClose}>
            <X size={20} />
          </button>
        </div>

        <form onSubmit={handleSubmit} className="pf-modal-body">
          <div className="pf-field">
            <label>Contraseña actual</label>
            <div className="pf-field-password">
              <input
                type={verActual ? "text" : "password"}
                value={actual}
                onChange={(e) => setActual(e.target.value)}
                required
              />
              <button
                type="button"
                className="pf-field-eye"
                onClick={() => setVerActual(!verActual)}
              >
                {verActual ? <EyeOff size={18} /> : <Eye size={18} />}
              </button>
            </div>
          </div>

          <div className="pf-field">
            <label>Nueva contraseña</label>
            <div className="pf-field-password">
              <input
                type={verNueva ? "text" : "password"}
                value={nueva}
                onChange={(e) => setNueva(e.target.value)}
                required
                minLength={6}
              />
              <button
                type="button"
                className="pf-field-eye"
                onClick={() => setVerNueva(!verNueva)}
              >
                {verNueva ? <EyeOff size={18} /> : <Eye size={18} />}
              </button>
            </div>
          </div>

          <div className="pf-field">
            <label>Confirmar nueva contraseña</label>
            <input
              type="password"
              value={confirmar}
              onChange={(e) => setConfirmar(e.target.value)}
              required
            />
          </div>

          <div className="pf-modal-actions">
            <button
              type="button"
              className="pf-btn pf-btn-secondary"
              onClick={onClose}
            >
              Cancelar
            </button>
            <button
              type="submit"
              className="pf-btn pf-btn-primary"
              disabled={guardando}
            >
              <Check size={16} />
              {guardando ? "Cambiando..." : "Cambiar"}
            </button>
          </div>
        </form>
      </motion.div>
    </motion.div>
  );
}

// ═══════════════════════════════════════════════════════════
// MODAL: Cambiar avatar
// ═══════════════════════════════════════════════════════════
function ModalAvatar({ usuario, onClose, onGuardar, onEliminar }) {
  const [imagen, setImagen] = useState(usuario.avatar_url || null);
  const [mostrarConfirm, setMostrarConfirm] = useState(false);

  const handleGuardar = () => {
    if (imagen) {
      onGuardar(imagen);
    }
  };

  const handleEliminar = () => {
    onEliminar();
    onClose();
  };

  return (
    <motion.div
      className="pf-modal-overlay"
      initial={{ opacity: 0 }}
      animate={{ opacity: 1 }}
      exit={{ opacity: 0 }}
      onClick={onClose}
    >
      <motion.div
        className="pf-modal pf-modal-avatar"
        initial={{ opacity: 0, y: 30, scale: 0.95 }}
        animate={{ opacity: 1, y: 0, scale: 1 }}
        exit={{ opacity: 0, y: 30, scale: 0.95 }}
        transition={{ type: "spring", stiffness: 300, damping: 25 }}
        onClick={(e) => e.stopPropagation()}
      >
        <div className="pf-modal-header">
          <h3>Foto de perfil</h3>
          <button className="pf-modal-close" onClick={onClose}>
            <X size={20} />
          </button>
        </div>

        <div className="pf-modal-body pf-modal-body-avatar">
          <UploadDropzone
            imagen={imagen}
            onImagenSeleccionada={setImagen}
            circular
            tamaño={200}
          />

          {mostrarConfirm ? (
            <div className="pf-avatar-confirm">
              <p>¿Estás seguro de eliminar tu foto?</p>
              <InlineConfirm
                onConfirm={handleEliminar}
                confirmText="Sí, eliminar"
                mensajeExito="Eliminado"
              />
              <button
                className="pf-btn pf-btn-secondary"
                onClick={() => setMostrarConfirm(false)}
              >
                Cancelar
              </button>
            </div>
          ) : (
            <div className="pf-modal-actions">
              {usuario.avatar_url && (
                <button
                  type="button"
                  className="pf-btn pf-btn-danger"
                  onClick={() => setMostrarConfirm(true)}
                >
                  Quitar foto
                </button>
              )}
              <button
                type="button"
                className="pf-btn pf-btn-primary"
                onClick={handleGuardar}
                disabled={!imagen || imagen === usuario.avatar_url}
              >
                <Save size={16} />
                Guardar
              </button>
            </div>
          )}
        </div>
      </motion.div>
    </motion.div>
  );
}