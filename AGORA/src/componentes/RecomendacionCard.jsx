// agoraya/AGORA/src/componentes/RecomendacionCard.jsx
import { useState, useEffect, useRef } from "react";
import {
  MoreHorizontal,
  Trash2,
  MessageCircle,
  Pencil,
  Check,
  X,
  Send,
  Loader,
  Bookmark,
  BookmarkCheck,
} from "lucide-react";
import { Like } from "./Like";
import InlineConfirm from "./InlineConfirm";
import "./RecomendacionCard.css";

const API = "http://localhost:3000/api";

function RecomendacionCard({
  recomendacion,
  onLike,
  onDelete,
  onGuardar,
  onEditar,
  usuarioActual,
}) {
  const [menuAbierto, setMenuAbierto] = useState(false);
  const [editando, setEditando] = useState(false);
  const [textoEditado, setTextoEditado] = useState(recomendacion.comentario);
  const [guardando, setGuardando] = useState(false);
  const [mostrarConfirm, setMostrarConfirm] = useState(false);
  const [mostrarComentarios, setMostrarComentarios] = useState(false);
  const [comentarios, setComentarios] = useState([]);
  const [nuevoComentario, setNuevoComentario] = useState("");
  const [cargandoComentarios, setCargandoComentarios] = useState(false);
  const [enviandoComentario, setEnviandoComentario] = useState(false);
  const [guardado, setGuardado] = useState(recomendacion.usuario_guardo || false);
  const menuRef = useRef(null);
  const comentariosEndRef = useRef(null);
  const inputRef = useRef(null);

  const esPropia = usuarioActual?.id_usuario === recomendacion.id_usuario;

  useEffect(() => {
    const handleClick = (e) => {
      if (menuRef.current && !menuRef.current.contains(e.target)) {
        setMenuAbierto(false);
      }
    };
    if (menuAbierto) document.addEventListener("mousedown", handleClick);
    return () => document.removeEventListener("mousedown", handleClick);
  }, [menuAbierto]);

  useEffect(() => {
    if (mostrarComentarios && comentariosEndRef.current) {
      comentariosEndRef.current.scrollIntoView({
        behavior: "smooth",
        block: "nearest",
      });
    }
  }, [comentarios, mostrarComentarios]);

  const formatearFecha = (fecha) => {
    const date = new Date(fecha);
    const ahora = new Date();
    const diffMs = ahora - date;
    const diffMin = Math.floor(diffMs / 60000);
    const diffHoras = Math.floor(diffMin / 60);
    const diffDias = Math.floor(diffHoras / 24);

    if (diffMin < 1) return "hace un momento";
    if (diffMin < 60) return `hace ${diffMin}m`;
    if (diffHoras < 24) return `hace ${diffHoras}h`;
    if (diffDias < 7) return `hace ${diffDias}d`;
    return date.toLocaleDateString("es-CR", { day: "numeric", month: "short" });
  };

  const formatearHora = (fecha) => {
    const date = new Date(fecha);
    return date.toLocaleTimeString("es-CR", { hour: "2-digit", minute: "2-digit" });
  };

  const iniciales = `${recomendacion.nombre?.[0] || ""}${recomendacion.apellido?.[0] || ""}`.toUpperCase();

  const handleGuardar = async () => {
    setGuardando(true);
    try {
      const res = await onGuardar(recomendacion.id_idea);
      setGuardado(res.usuario_guardo);
    } finally {
      setGuardando(false);
    }
  };

  const handleEditar = async () => {
    if (textoEditado.trim().length < 10) return;
    await onEditar(recomendacion.id_idea, textoEditado);
    setEditando(false);
  };

  const toggleComentarios = async () => {
    const next = !mostrarComentarios;
    setMostrarComentarios(next);

    if (next && comentarios.length === 0) {
      setCargandoComentarios(true);
      try {
        const token = localStorage.getItem("agora_token");
        const res = await fetch(
          `${API}/recomendaciones/${recomendacion.id_idea}/comentarios`,
          { headers: { Authorization: `Bearer ${token}` } }
        );
        const data = await res.json();
        setComentarios(data.comentarios || []);
      } catch (err) {
        console.error(err);
      } finally {
        setCargandoComentarios(false);
      }
    }

    if (next) {
      setTimeout(() => inputRef.current?.focus(), 300);
    }
  };

  const enviarComentario = async (e) => {
    e.preventDefault();
    if (nuevoComentario.trim().length < 2) return;

    setEnviandoComentario(true);
    try {
      const token = localStorage.getItem("agora_token");
      const res = await fetch(
        `${API}/recomendaciones/${recomendacion.id_idea}/comentarios`,
        {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
            Authorization: `Bearer ${token}`,
          },
          body: JSON.stringify({ comentario: nuevoComentario }),
        }
      );
      const data = await res.json();
      if (!res.ok) throw new Error(data.error);

      setComentarios([...comentarios, data.comentario]);
      setNuevoComentario("");
    } catch (err) {
      console.error(err);
    } finally {
      setEnviandoComentario(false);
    }
  };

  return (
    <article className="rc-card">
      <header className="rc-header">
        <div className="rc-user">
          <div className="rc-avatar">
            {recomendacion.avatar_url ? (
              <img src={recomendacion.avatar_url} alt={recomendacion.nombre} />
            ) : (
              <span>{iniciales}</span>
            )}
            <span className="rc-badge">✓</span>
          </div>
          <div className="rc-user-info">
            <p className="rc-nombre">
              {recomendacion.nombre} {recomendacion.apellido}
            </p>
            <p className="rc-meta">
              {formatearFecha(recomendacion.fecha)}
              {recomendacion.editado && " · editado"}
              {" · Estudiante"}
            </p>
          </div>
        </div>

        <button
          className={`rc-save-btn ${guardado ? "saved" : ""}`}
          onClick={handleGuardar}
          disabled={guardando}
          aria-label={guardado ? "Quitar de guardados" : "Guardar"}
          title={guardado ? "Quitar de guardados" : "Guardar"}
        >
          {guardado ? <BookmarkCheck size={18} /> : <Bookmark size={18} />}
        </button>

        {esPropia && (
          <div className="rc-menu-wrapper" ref={menuRef}>
            <button
              className="rc-menu-btn"
              onClick={() => setMenuAbierto(!menuAbierto)}
              aria-label="Opciones"
            >
              <MoreHorizontal size={18} />
            </button>
            {menuAbierto && (
              <div className="rc-menu-dropdown">
                <button
                  className="rc-menu-item"
                  onClick={() => {
                    setMenuAbierto(false);
                    setEditando(true);
                  }}
                >
                  <Pencil size={14} />
                  Editar
                </button>
                <button
                  className="rc-menu-item rc-menu-danger"
                  onClick={() => {
                    setMenuAbierto(false);
                    setMostrarConfirm(true);
                  }}
                >
                  <Trash2 size={14} />
                  Eliminar
                </button>
              </div>
            )}
          </div>
        )}
      </header>

      <div className="rc-content">
        {editando ? (
          <div className="rc-edit">
            <textarea
              value={textoEditado}
              onChange={(e) => setTextoEditado(e.target.value)}
              rows={3}
              maxLength={500}
            />
            <div className="rc-edit-actions">
              <button
                className="rc-edit-cancel"
                onClick={() => {
                  setEditando(false);
                  setTextoEditado(recomendacion.comentario);
                }}
              >
                <X size={14} />
                Cancelar
              </button>
              <button className="rc-edit-save" onClick={handleEditar}>
                <Check size={14} />
                Guardar
              </button>
            </div>
          </div>
        ) : (
          <p className="rc-comentario">{recomendacion.comentario}</p>
        )}
      </div>

      {mostrarConfirm && (
        <div className="rc-confirm-wrapper">
          <InlineConfirm
            onConfirm={() => {
              onDelete(recomendacion.id_idea);
              setMostrarConfirm(false);
            }}
            confirmText="Eliminar"
          />
          <button
            className="rc-confirm-cancel"
            onClick={() => setMostrarConfirm(false)}
          >
            Cancelar
          </button>
        </div>
      )}

      <footer className="rc-footer">
        <div className="rc-actions-left">
          <Like
            start={recomendacion.total_likes || 0}
            initialLiked={recomendacion.usuario_dio_like || false}
            onChange={async () => await onLike(recomendacion.id_idea)}
          />

          <button
            className={`rc-action-btn ${mostrarComentarios ? "active" : ""}`}
            onClick={toggleComentarios}
            aria-label="Comentarios"
          >
            <MessageCircle size={18} />
            <span>{recomendacion.total_comentarios || 0}</span>
          </button>
        </div>
      </footer>

      {mostrarComentarios && (
        <div className="rc-comments">
          <div className="rc-comments-header">
            <div className="rc-comments-title">
              <MessageCircle size={16} />
              <span>Comentarios</span>
              <span className="rc-comments-count">{comentarios.length}</span>
            </div>
          </div>

          <div className="rc-comments-body">
            {cargandoComentarios ? (
              <div className="rc-comments-loading">
                <Loader size={16} className="spin" />
                <span>Cargando comentarios...</span>
              </div>
            ) : comentarios.length === 0 ? (
              <div className="rc-comments-empty">
                <p>Sé el primero en comentar</p>
                <span>Compartí tu opinión sobre esta idea</span>
              </div>
            ) : (
              <div className="rc-comments-list">
                {comentarios.map((c) => {
                  const esMio = c.id_usuario === usuarioActual?.id_usuario;
                  const inicialesC = `${c.nombre?.[0] || ""}${c.apellido?.[0] || ""}`.toUpperCase();

                  return (
                    <div
                      key={c.id_comentario}
                      className={`rc-comment ${esMio ? "rc-comment-mine" : "rc-comment-other"}`}
                    >
                      {!esMio && (
                        <div className="rc-comment-avatar">
                          {c.avatar_url ? (
                            <img src={c.avatar_url} alt={c.nombre} />
                          ) : (
                            <span>{inicialesC}</span>
                          )}
                        </div>
                      )}

                      <div className="rc-comment-bubble">
                        {!esMio && (
                          <span className="rc-comment-name">
                            {c.nombre} {c.apellido}
                          </span>
                        )}
                        <p className="rc-comment-text">{c.comentario}</p>
                        <span className="rc-comment-time">
                          {formatearHora(c.fecha)}
                        </span>
                      </div>

                      {esMio && (
                        <div className="rc-comment-avatar rc-comment-avatar-mine">
                          {c.avatar_url ? (
                            <img src={c.avatar_url} alt={c.nombre} />
                          ) : (
                            <span>{inicialesC}</span>
                          )}
                        </div>
                      )}
                    </div>
                  );
                })}
                <div ref={comentariosEndRef} />
              </div>
            )}
          </div>

          <form className="rc-comment-form" onSubmit={enviarComentario}>
            <div className="rc-comment-form-avatar">
              {usuarioActual?.avatar_url ? (
                <img src={usuarioActual.avatar_url} alt="Yo" />
              ) : (
                <span>
                  {usuarioActual?.nombre?.[0]}
                  {usuarioActual?.apellido?.[0]}
                </span>
              )}
            </div>
            <input
              ref={inputRef}
              type="text"
              value={nuevoComentario}
              onChange={(e) => setNuevoComentario(e.target.value)}
              placeholder="Escribí un comentario..."
              maxLength={300}
            />
            <button
              type="submit"
              disabled={enviandoComentario || nuevoComentario.trim().length < 2}
              aria-label="Enviar comentario"
            >
              {enviandoComentario ? (
                <Loader size={14} className="spin" />
              ) : (
                <Send size={14} />
              )}
            </button>
          </form>
        </div>
      )}
    </article>
  );
}

export default RecomendacionCard;