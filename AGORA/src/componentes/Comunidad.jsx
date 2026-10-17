// agoraya/AGORA/src/componentes/Comunidad.jsx
import { useState, useEffect, useRef } from "react";
import { motion, AnimatePresence } from "framer-motion";
import {
  Send,
  Sparkles,
  TrendingUp,
  Loader,
  Clock,
  Flame,
} from "lucide-react";
import Swal from "sweetalert2";
import "./Comunidad.css";
import RecomendacionCard from "./RecomendacionCard";
import NavbarProfesor from "./NavbarProfesor.jsx";
import { NavbarEstudiante } from "./indexestudiante.jsx";

const API = "http://localhost:3000/api";

function Comunidad() {
  const usuarioLocal = (() => {
    try {
      return JSON.parse(localStorage.getItem("usuario") || "null");
    } catch {
      return null;
    }
  })();

  const esProfesor = usuarioLocal?.rol === "profesor" || usuarioLocal?.rol === "administrador";

  const [recomendaciones, setRecomendaciones] = useState([]);
  const [comentario, setComentario] = useState("");
  const [cargando, setCargando] = useState(true);
  const [enviando, setEnviando] = useState(false);
  const [filtro, setFiltro] = useState("recientes");
  const [focused, setFocused] = useState(false);
  const textareaRef = useRef(null);

  const iniciales = `${usuarioLocal?.nombre?.[0] || ""}${usuarioLocal?.apellido?.[0] || ""}`.toUpperCase();

  // Cargar recomendaciones
  useEffect(() => {
    cargarRecomendaciones();
  }, []);

  const cargarRecomendaciones = async () => {
    try {
      setCargando(true);
      const token = localStorage.getItem("agora_token") || "";
      const res = await fetch(`${API}/recomendaciones`, {
        headers: { Authorization: `Bearer ${token}` },
      });
      const data = await res.json();
      if (!res.ok) throw new Error(data.error);
      setRecomendaciones(data.recomendaciones || []);
    } catch (error) {
      Swal.fire({
        title: "Error",
        text: error.message,
        icon: "error",
        confirmButtonColor: "#9571dd",
        background: "#fef8ed",
        color: "#4a386d",
      });
    } finally {
      setCargando(false);
    }
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    const texto = comentario.trim();

    if (texto.length < 10) {
      Swal.fire({
        title: "Muy corta",
        text: "La recomendación debe tener al menos 10 caracteres",
        icon: "warning",
        confirmButtonColor: "#9571dd",
        background: "#fef8ed",
        color: "#4a386d",
      });
      return;
    }

    try {
      setEnviando(true);
      const token = localStorage.getItem("agora_token") || "";
      const res = await fetch(`${API}/recomendaciones`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`,
        },
        body: JSON.stringify({ comentario: texto }),
      });
      const data = await res.json();
      if (!res.ok) throw new Error(data.error);

      setRecomendaciones((prev) => [data.recomendacion, ...prev]);
      setComentario("");
      textareaRef.current?.blur();
      setFocused(false);

      Swal.fire({
        title: "¡Gracias!",
        text: "Tu recomendación fue publicada",
        icon: "success",
        timer: 1800,
        showConfirmButton: false,
        background: "#fef8ed",
        color: "#4a386d",
      });
    } catch (error) {
      Swal.fire({
        title: "Error",
        text: error.message,
        icon: "error",
        confirmButtonColor: "#9571dd",
        background: "#fef8ed",
        color: "#4a386d",
      });
    } finally {
      setEnviando(false);
    }
  };

  const handleLike = async (id_idea) => {
    const token = localStorage.getItem("agora_token") || "";
    const res = await fetch(`${API}/recomendaciones/${id_idea}/like`, {
      method: "POST",
      headers: { Authorization: `Bearer ${token}` },
    });
    const resultado = await res.json();
    if (!res.ok) throw new Error(resultado.error);

    setRecomendaciones((prev) =>
      prev.map((r) =>
        r.id_idea === id_idea
          ? {
              ...r,
              total_likes: resultado.total_likes,
              usuario_dio_like: resultado.usuario_dio_like,
            }
          : r
      )
    );
    return resultado;
  };

  const handleGuardar = async (id_idea) => {
    const token = localStorage.getItem("agora_token") || "";
    const res = await fetch(`${API}/recomendaciones/${id_idea}/guardar`, {
      method: "POST",
      headers: { Authorization: `Bearer ${token}` },
    });
    const resultado = await res.json();
    if (!res.ok) throw new Error(resultado.error);

    setRecomendaciones((prev) =>
      prev.map((r) =>
        r.id_idea === id_idea ? { ...r, usuario_guardo: resultado.usuario_guardo } : r
      )
    );
    return resultado;
  };

  const handleEditar = async (id_idea, comentario) => {
    const token = localStorage.getItem("agora_token") || "";
    const res = await fetch(`${API}/recomendaciones/${id_idea}`, {
      method: "PUT",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${token}`,
      },
      body: JSON.stringify({ comentario }),
    });
    const data = await res.json();
    if (!res.ok) throw new Error(data.error);

    setRecomendaciones((prev) =>
      prev.map((r) =>
        r.id_idea === id_idea
          ? { ...r, comentario: data.recomendacion.comentario, editado: true }
          : r
      )
    );

    Swal.fire({
      title: "Editada",
      icon: "success",
      timer: 1200,
      showConfirmButton: false,
      background: "#fef8ed",
      color: "#4a386d",
    });
    return data;
  };

  const handleDelete = async (id_idea) => {
    const token = localStorage.getItem("agora_token") || "";
    const res = await fetch(`${API}/recomendaciones/${id_idea}`, {
      method: "DELETE",
      headers: { Authorization: `Bearer ${token}` },
    });
    const data = await res.json();
    if (!res.ok) throw new Error(data.error);

    setRecomendaciones((prev) => prev.filter((r) => r.id_idea !== id_idea));

    Swal.fire({
      title: "Eliminada",
      icon: "success",
      timer: 1200,
      showConfirmButton: false,
      background: "#fef8ed",
      color: "#4a386d",
    });
  };

  const recomendacionesOrdenadas = [...recomendaciones].sort((a, b) => {
    if (filtro === "populares") return b.total_likes - a.total_likes;
    return new Date(b.fecha) - new Date(a.fecha);
  });

  const totalLikes = recomendaciones.reduce(
    (sum, r) => sum + Number(r.total_likes || 0),
    0
  );

  return (
    <div className="cm-page">
      {esProfesor ? <NavbarProfesor /> : <NavbarEstudiante />}

      <main className="cm-main">
        {/* Hero */}
        <motion.header
          className="cm-hero"
          initial={{ opacity: 0, y: -20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.5 }}
        >
          <div className="cm-hero-bg" />

          <div className="cm-hero-top">
            <div className="cm-hero-icon">
              <Sparkles size={24} />
            </div>
            <div className="cm-hero-text">
              <h1>Comunidad Ágora</h1>
              <p>Compartí tu experiencia. Inspirá a otros estudiantes.</p>
            </div>
          </div>

          <div className="cm-stats">
            <div className="cm-stat">
              <span className="cm-stat-num">{recomendaciones.length}</span>
              <span className="cm-stat-label">Ideas</span>
            </div>
            <div className="cm-stat-divider" />
            <div className="cm-stat">
              <span className="cm-stat-num">{totalLikes}</span>
              <span className="cm-stat-label">Apoyos</span>
            </div>
          </div>
        </motion.header>

        {/* Composer */}
        <motion.form
          className="cm-composer"
          onSubmit={handleSubmit}
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.5, delay: 0.1 }}
        >
          <div className="cm-composer-avatar">
            {usuarioLocal?.avatar_url ? (
              <img src={usuarioLocal.avatar_url} alt="Avatar" />
            ) : (
              <span>{iniciales}</span>
            )}
          </div>

          <div className="cm-composer-body">
            <textarea
              ref={textareaRef}
              value={comentario}
              onChange={(e) => setComentario(e.target.value)}
              onFocus={() => setFocused(true)}
              onBlur={() => !comentario && setFocused(false)}
              placeholder="Compartí una idea para mejorar el cole..."
              maxLength={500}
              rows={1}
              disabled={enviando}
            />

            <div className="cm-composer-actions">
              <span className="cm-counter">{comentario.length}/500</span>
              <button
                type="submit"
                className="cm-publish"
                disabled={enviando || comentario.trim().length < 10}
              >
                {enviando ? (
                  <>
                    <Loader size={14} className="spin" />
                    Publicando
                  </>
                ) : (
                  <>
                    <Send size={14} />
                    Publicar
                  </>
                )}
              </button>
            </div>
          </div>
        </motion.form>

        {/* Filtros */}
        <motion.div
          className="cm-tabs-bar"
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          transition={{ duration: 0.5, delay: 0.2 }}
        >
          <div className="cm-tabs">
            <button
              className={`cm-tab ${filtro === "recientes" ? "active" : ""}`}
              onClick={() => setFiltro("recientes")}
            >
              <Clock size={15} />
              Recientes
            </button>
            <button
              className={`cm-tab ${filtro === "populares" ? "active" : ""}`}
              onClick={() => setFiltro("populares")}
            >
              <Flame size={15} />
              Populares
            </button>
          </div>
        </motion.div>

        {/* Feed */}
        {cargando ? (
          <div className="cm-loading">
            <Loader size={28} className="spin" />
            <p>Cargando comunidad...</p>
          </div>
        ) : recomendaciones.length === 0 ? (
          <motion.div
            className="cm-empty"
            initial={{ opacity: 0, scale: 0.9 }}
            animate={{ opacity: 1, scale: 1 }}
            transition={{ duration: 0.5 }}
          >
            <div className="cm-empty-icon">
              <Sparkles size={32} />
            </div>
            <h3>Todavía no hay ideas</h3>
            <p>Sé el primero en compartir una recomendación con la comunidad</p>
          </motion.div>
        ) : (
          <div className="cm-feed">
            <AnimatePresence>
              {recomendacionesOrdenadas.map((r, i) => (
                <motion.div
                  key={r.id_idea}
                  initial={{ opacity: 0, y: 20 }}
                  animate={{ opacity: 1, y: 0 }}
                  exit={{ opacity: 0, scale: 0.95 }}
                  transition={{ duration: 0.4, delay: i * 0.05 }}
                >
                  <RecomendacionCard
                    recomendacion={r}
                    onLike={handleLike}
                    onGuardar={handleGuardar}
                    onEditar={handleEditar}
                    onDelete={handleDelete}
                    usuarioActual={usuarioLocal}
                  />
                </motion.div>
              ))}
            </AnimatePresence>
          </div>
        )}
      </main>
    </div>
  );
}

export default Comunidad;