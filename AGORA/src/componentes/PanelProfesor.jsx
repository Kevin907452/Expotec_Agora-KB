// agoraya/AGORA/src/componentes/PanelProfesor.jsx
import { useState, useEffect } from "react";
import { useNavigate } from "react-router-dom";
import { motion, AnimatePresence } from "framer-motion";
import {
  ArrowLeft, Loader, MessageSquare, CheckCircle2, XCircle,
  Clock, Users, Lightbulb, Send, X, User,
} from "lucide-react";
import Swal from "sweetalert2";
import "./PanelProfesor.css";
import NavbarProfesor from "./NavbarProfesor.jsx";

const API = "http://localhost:3000/api";

const CARGOS = {
  presidente: "Presidente",
  vicepresidente: "Vicepresidente",
  secretario: "Secretario",
  tesorero: "Tesorero",
  vocal: "Vocal",
  vocal1: "Vocal 1",
  vocal2: "Vocal 2",
  vocal_2: "Vocal 2",
  fiscal: "Fiscal",
};

function PanelProfesor() {
  const navigate = useNavigate();
  const [partidos, setPartidos] = useState([]);
  const [cargando, setCargando] = useState(true);
  const [seleccionado, setSeleccionado] = useState(null);
  const [feedback, setFeedback] = useState("");
  const [enviando, setEnviando] = useState(false);
  const [detalle, setDetalle] = useState(null);
  const [cargandoDetalle, setCargandoDetalle] = useState(false);

  useEffect(() => {
    cargarPartidos();
  }, []);

  const cargarPartidos = async () => {
    try {
      setCargando(true);
      const token = localStorage.getItem("agora_token");
      const res = await fetch(`${API}/partidos/pendientes`, {
        headers: { Authorization: `Bearer ${token}` },
      });
      const data = await res.json();
      if (!res.ok) throw new Error(data.error);
      setPartidos(data.partidos || []);
    } catch (err) {
      console.error(err);
      Swal.fire({
        title: "Error",
        text: err.message,
        icon: "error",
        confirmButtonColor: "#9571dd",
        background: "#fef8ed",
        color: "#4a386d",
      });
    } finally {
      setCargando(false);
    }
  };

  const abrirDetalle = async (partido) => {
    setSeleccionado(partido);
    setDetalle(null);
    setFeedback("");
    setCargandoDetalle(true);

    try {
      const token = localStorage.getItem("agora_token");
      const res = await fetch(`${API}/partidos/pendientes/${partido.id_partido}`, {
        headers: { Authorization: `Bearer ${token}` },
      });
      const data = await res.json();
      if (!res.ok) throw new Error(data.error);
      setDetalle(data);
    } catch (err) {
      console.error(err);
    } finally {
      setCargandoDetalle(false);
    }
  };

  const handleAprobar = async (id) => {
    setEnviando(true);
    try {
      const token = localStorage.getItem("agora_token");
      const res = await fetch(`${API}/partidos/${id}/aprobar`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`,
        },
        body: JSON.stringify({ feedback }),
      });
      const data = await res.json();
      if (!res.ok) throw new Error(data.error);

      Swal.fire({
        title: "¡Aprobado!",
        text: "El partido ya es visible para los estudiantes",
        icon: "success",
        timer: 2000,
        showConfirmButton: false,
        background: "#fef8ed",
        color: "#4a386d",
      });

      setSeleccionado(null);
      setDetalle(null);
      setFeedback("");
      cargarPartidos();
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
      setEnviando(false);
    }
  };

  const handleRechazar = async (id) => {
    if (!feedback.trim()) {
      Swal.fire({
        title: "Falta el motivo",
        text: "Escribí por qué rechazás el partido",
        icon: "warning",
        confirmButtonColor: "#9571dd",
        background: "#fef8ed",
        color: "#4a386d",
      });
      return;
    }

    setEnviando(true);
    try {
      const token = localStorage.getItem("agora_token");
      const res = await fetch(`${API}/partidos/${id}/rechazar`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`,
        },
        body: JSON.stringify({ feedback }),
      });
      const data = await res.json();
      if (!res.ok) throw new Error(data.error);

      Swal.fire({
        title: "Rechazado",
        text: "El estudiante verá el feedback",
        icon: "info",
        confirmButtonColor: "#9571dd",
        background: "#fef8ed",
        color: "#4a386d",
      });

      setSeleccionado(null);
      setDetalle(null);
      setFeedback("");
      cargarPartidos();
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
      setEnviando(false);
    }
  };

  return (
    <div className="pp-page">
      <NavbarProfesor />

      <main className="pp-main">
        <header className="pp-header">
          <button className="pp-back" onClick={() => navigate("/indexprofesor")}>
            <ArrowLeft size={18} />
            Volver
          </button>
          <span className="pp-eyebrow">Panel de profesor</span>
          <h1>Partidos pendientes</h1>
          <p>Revisá, aprobá o rechazá los partidos enviados por los estudiantes</p>
        </header>

        {cargando ? (
          <div className="pp-loading">
            <Loader size={28} className="spin" />
            <p>Cargando partidos...</p>
          </div>
        ) : partidos.length === 0 ? (
          <div className="pp-empty">
            <CheckCircle2 size={48} />
            <h3>¡Todo al día!</h3>
            <p>No hay partidos pendientes de revisión</p>
          </div>
        ) : (
          <div className="pp-grid">
            {partidos.map((p) => (
              <motion.article
                key={p.id_partido}
                className="pp-card"
                initial={{ opacity: 0, y: 20 }}
                animate={{ opacity: 1, y: 0 }}
                whileHover={{ y: -4 }}
              >
                <div className="pp-card-header">
                  <div className="pp-card-flag">
                    {p.bandera_url ? (
                      <img src={p.bandera_url} alt={p.nombre} />
                    ) : (
                      <div className="pp-card-flag-placeholder">
                        {p.nombre[0]}
                      </div>
                    )}
                  </div>
                  <div className="pp-card-info">
                    <h3>{p.nombre}</h3>
                    <p className="pp-card-creator">
                      Enviado por {p.creador_nombre} {p.creador_apellido}
                    </p>
                    <span className="pp-card-estado">
                      <Clock size={12} />
                      Pendiente
                    </span>
                  </div>
                </div>

                <p className="pp-card-desc">{p.descripcion}</p>

                <div className="pp-card-meta">
                  <span>
                    <Users size={14} /> {p.total_miembros} integrantes
                  </span>
                  <span>
                    <Lightbulb size={14} /> {p.total_propuestas} propuestas
                  </span>
                </div>

                <button
                  className="pp-card-btn"
                  onClick={() => abrirDetalle(p)}
                >
                  <MessageSquare size={16} />
                  Revisar y decidir
                </button>
              </motion.article>
            ))}
          </div>
        )}
      </main>

      {/* Modal de decisión */}
      <AnimatePresence>
        {seleccionado && (
          <motion.div
            className="pp-modal-overlay"
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            exit={{ opacity: 0 }}
            onClick={() => setSeleccionado(null)}
          >
            <motion.div
              className="pp-modal"
              initial={{ opacity: 0, y: 30, scale: 0.95 }}
              animate={{ opacity: 1, y: 0, scale: 1 }}
              exit={{ opacity: 0, y: 30, scale: 0.95 }}
              onClick={(e) => e.stopPropagation()}
            >
              <header className="pp-modal-header">
                <h2>{seleccionado.nombre}</h2>
                <button
                  className="pp-modal-close"
                  onClick={() => setSeleccionado(null)}
                >
                  <X size={20} />
                </button>
              </header>

              <div className="pp-modal-body">
                {cargandoDetalle ? (
                  <div className="pp-modal-loading">
                    <Loader size={24} className="spin" />
                    <p>Cargando detalles...</p>
                  </div>
                ) : detalle ? (
                  <>
                    <p className="pp-modal-desc">{detalle.partido.descripcion}</p>

                    {detalle.miembros?.length > 0 && (
                      <section className="pp-modal-section">
                        <h3>
                          <Users size={16} />
                          Integrantes ({detalle.miembros.length})
                        </h3>
                        <div className="pp-modal-miembros">
                          {detalle.miembros.map((m) => (
                            <div key={m.id_miembro} className="pp-modal-miembro">
                              <span className="pp-modal-miembro-cargo">
                                {CARGOS[m.cargo] || m.cargo}
                              </span>
                              <span className="pp-modal-miembro-nombre">
                                {m.nombre} {m.apellido}
                              </span>
                              {m.seccion && (
                                <span className="pp-modal-miembro-sec">
                                  {m.seccion}
                                </span>
                              )}
                            </div>
                          ))}
                        </div>
                      </section>
                    )}

                    {detalle.propuestas?.length > 0 && (
                      <section className="pp-modal-section">
                        <h3>
                          <Lightbulb size={16} />
                          Propuestas ({detalle.propuestas.length})
                        </h3>
                        <div className="pp-modal-propuestas">
                          {detalle.propuestas.map((p, i) => (
                            <div key={p.id_propuesta} className="pp-modal-propuesta">
                              <span className="pp-modal-propuesta-num">
                                {i + 1}
                              </span>
                              <div>
                                <p className="pp-modal-propuesta-titulo">
                                  {p.titulo}
                                </p>
                                {p.descripcion && (
                                  <p className="pp-modal-propuesta-desc">
                                    {p.descripcion}
                                  </p>
                                )}
                              </div>
                            </div>
                          ))}
                        </div>
                      </section>
                    )}

                    <section className="pp-modal-feedback">
                      <label>
                        <MessageSquare size={14} />
                        Feedback para el estudiante
                      </label>
                      <textarea
                        placeholder="Escribí tus comentarios sobre el partido..."
                        value={feedback}
                        onChange={(e) => setFeedback(e.target.value)}
                        rows={4}
                      />
                    </section>

                    <div className="pp-modal-actions">
                      <button
                        className="pp-modal-btn pp-modal-reject"
                        onClick={() => handleRechazar(seleccionado.id_partido)}
                        disabled={enviando}
                      >
                        <XCircle size={16} />
                        Rechazar
                      </button>
                      <button
                        className="pp-modal-btn pp-modal-approve"
                        onClick={() => handleAprobar(seleccionado.id_partido)}
                        disabled={enviando}
                      >
                        <CheckCircle2 size={16} />
                        {enviando ? "Procesando..." : "Aprobar"}
                      </button>
                    </div>
                  </>
                ) : null}
              </div>
            </motion.div>
          </motion.div>
        )}
      </AnimatePresence>
    </div>
  );
}

export default PanelProfesor;