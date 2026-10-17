// agoraya/AGORA/src/componentes/Partidos.jsx
import { useState, useEffect, useRef } from "react";
import { useNavigate } from "react-router-dom";
import { motion, AnimatePresence } from "framer-motion";
import {
  Users, Vote, Heart, Sparkles, ArrowRight,
  Trophy, X, Loader, Target, Lightbulb, Plus,
  ChevronLeft, ChevronRight, RefreshCw,
} from "lucide-react";
import Swal from "sweetalert2";
import "./Partidos.css";
import NavbarProfesor from "./NavbarProfesor.jsx";
import { NavbarEstudiante } from "./indexestudiante.jsx";

const API = "http://localhost:3000/api";

// ═══════════════════════════════════════════════════════════
// HELPER: Resolver la URL de la imagen del partido
// Maneja base64, rutas absolutas y rutas relativas
// ═══════════════════════════════════════════════════════════
function resolverImagen(bandera_url) {
  if (!bandera_url) return null;
  const url = String(bandera_url).trim();
  if (!url) return null;

  // base64
  if (url.startsWith("data:image/")) return url;

  // URL absoluta
  if (/^https?:\/\//i.test(url)) return url;

  // path relativo
  if (url.startsWith("/")) return url;

  return `/${url}`;
}

const OPCIONES_ESCALA = [
  { valor: 3, texto: "Totalmente de acuerdo", lado: "acuerdo", tamano: "grande" },
  { valor: 2, texto: "De acuerdo", lado: "acuerdo", tamano: "mediano" },
  { valor: 1, texto: "Algo de acuerdo", lado: "acuerdo", tamano: "pequeno" },
  { valor: 0, texto: "Neutral / Indiferente", lado: "neutral", tamano: "neutro" },
  { valor: -1, texto: "Algo en desacuerdo", lado: "desacuerdo", tamano: "pequeno" },
  { valor: -2, texto: "En desacuerdo", lado: "desacuerdo", tamano: "mediano" },
  { valor: -3, texto: "Totalmente en desacuerdo", lado: "desacuerdo", tamano: "grande" },
];

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

const SLIDES = [
  {
    url: "https://images.unsplash.com/photo-1518709268805-4e9042af9f23?w=1920&q=80",
    titulo: "La voz de los estudiantes",
    subtitulo: "Tu participación construye el futuro del colegio",
  },
  {
    url: "https://images.unsplash.com/photo-1541872703-74c5e44368f9?w=1920&q=80",
    titulo: "Democracia estudiantil",
    subtitulo: "Elegí con conciencia, elegí con responsabilidad",
  },
  {
    url: "https://images.unsplash.com/photo-1523240795612-9a054b0db644?w=1920&q=80",
    titulo: "Juntos hacemos la diferencia",
    subtitulo: "Cada voto cuenta, cada idea suma",
  },
];

const STICKER_COLORES = [
  { bg: "#E8D9F5", acento: "#D4B8E8" },
  { bg: "#D9F5F0", acento: "#B8E8DC" },
  { bg: "#F5D9E8", acento: "#E8B8D4" },
  { bg: "#E0D9F5", acento: "#C4B8E8" },
  { bg: "#F5E8D9", acento: "#E8D4B8" },
  { bg: "#D9E8F5", acento: "#B8D4E8" },
];

function Partidos() {
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

  const [partidos, setPartidos] = useState([]);
  const [cargandoPartidos, setCargandoPartidos] = useState(true);
  const [partidoSeleccionado, setPartidoSeleccionado] = useState(null);

  const [vista, setVista] = useState("partidos");
  const [propuestas, setPropuestas] = useState([]);
  const [cargandoPropuestas, setCargandoPropuestas] = useState(false);
  const [indicePropuesta, setIndicePropuesta] = useState(0);
  const [respuestas, setRespuestas] = useState({});
  const [resultado, setResultado] = useState(null);

  const [slideActual, setSlideActual] = useState(0);
  const intervaloRef = useRef(null);

  useEffect(() => {
    cargarPartidos();
  }, []);

  useEffect(() => {
    intervaloRef.current = setInterval(() => {
      setSlideActual((prev) => (prev + 1) % SLIDES.length);
    }, 5000);
    return () => {
      if (intervaloRef.current) clearInterval(intervaloRef.current);
    };
  }, []);

  const cargarPartidos = async () => {
    try {
      setCargandoPartidos(true);
      const res = await fetch(`${API}/partidos/aprobados`);
      const data = await res.json();
      setPartidos(data.partidos || []);
    } catch (error) {
      console.error(error);
    } finally {
      setCargandoPartidos(false);
    }
  };

  const empezarQuiz = async () => {
    setVista("quiz");
    setIndicePropuesta(0);
    setRespuestas({});

    setCargandoPropuestas(true);
    try {
      const res = await fetch(`${API}/propuestas/con-ejes`);
      const data = await res.json();
      setPropuestas(data.propuestas || []);
    } catch (error) {
      console.error(error);
      Swal.fire({
        title: "Error",
        text: "No se pudieron cargar las propuestas",
        icon: "error",
        confirmButtonColor: "#9571dd",
        background: "#fef8ed",
        color: "#4a386d",
      });
      setVista("partidos");
    } finally {
      setCargandoPropuestas(false);
    }
  };

  const responder = (valor) => {
    const propuesta = propuestas[indicePropuesta];
    setRespuestas((prev) => ({ ...prev, [propuesta.id_propuesta]: valor }));

    setTimeout(() => {
      if (indicePropuesta < propuestas.length - 1) {
        setIndicePropuesta(indicePropuesta + 1);
      } else {
        finalizarQuiz({ ...respuestas, [propuesta.id_propuesta]: valor });
      }
    }, 350);
  };

  const anterior = () => {
    if (indicePropuesta > 0) setIndicePropuesta(indicePropuesta - 1);
  };

  const finalizarQuiz = (respuestasFinales) => {
    const resultadosPartidos = partidos.map((partido) => {
      const propuestasPartido = propuestas.filter(
        (p) => p.id_partido === partido.id_partido
      );

      if (propuestasPartido.length === 0) {
        return { ...partido, afinidad: 50, perfil: {}, propuestas: [] };
      }

      let puntosObtenidos = 0;
      let puntosMaximos = propuestasPartido.length * 3;

      const perfilPartido = {
        ecologico: 0, social: 0, academico: 0, cultural: 0, tecnologico: 0,
      };
      const perfilUsuario = {
        ecologico: 0, social: 0, academico: 0, cultural: 0, tecnologico: 0,
      };

      propuestasPartido.forEach((p) => {
        const resp = respuestasFinales[p.id_propuesta] ?? 0;
        puntosObtenidos += Math.max(0, resp);
        perfilUsuario[p.eje] = (perfilUsuario[p.eje] || 0) + Math.max(0, resp);
        perfilPartido[p.eje] = (perfilPartido[p.eje] || 0) + 3;
      });

      const afinidad = Math.round((puntosObtenidos / puntosMaximos) * 100);

      return {
        ...partido,
        afinidad,
        propuestas: propuestasPartido,
        perfil: perfilPartido,
        perfil_usuario: perfilUsuario,
      };
    });

    resultadosPartidos.sort((a, b) => b.afinidad - a.afinidad);
    const ganador = resultadosPartidos[0];

    setResultado({
      ganador,
      todos: resultadosPartidos,
      perfil_usuario: ganador.perfil_usuario || {},
    });
    setVista("resultado");
  };

  const resetQuiz = () => {
    setVista("partidos");
    setIndicePropuesta(0);
    setRespuestas({});
    setResultado(null);
    cargarPartidos();
  };

  const siguienteSlide = () => setSlideActual((prev) => (prev + 1) % SLIDES.length);
  const anteriorSlide = () => setSlideActual((prev) => (prev - 1 + SLIDES.length) % SLIDES.length);

  const rutaImagenPartido = (p) => resolverImagen(p.bandera_url);

  return (
    <div className="pt-page">
      {esProfesor ? <NavbarProfesor /> : <NavbarEstudiante />}

      <AnimatePresence mode="wait">
        {vista === "quiz" && (
          <motion.main
            key="quiz"
            className="pt-quiz-container"
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            exit={{ opacity: 0 }}
          >
            {cargandoPropuestas ? (
              <div className="pt-loading">
                <Loader size={32} className="spin" />
                <p>Cargando propuestas...</p>
              </div>
            ) : propuestas.length > 0 ? (
              <QuizPregunta
                propuesta={propuestas[indicePropuesta]}
                indice={indicePropuesta}
                total={propuestas.length}
                seleccion={respuestas[propuestas[indicePropuesta]?.id_propuesta]}
                onResponder={responder}
                onAnterior={anterior}
                onCancelar={resetQuiz}
              />
            ) : null}
          </motion.main>
        )}

        {vista === "resultado" && resultado && (
          <motion.main
            key="resultado"
            className="pt-resultado-container"
            initial={{ opacity: 0, y: 30 }}
            animate={{ opacity: 1, y: 0 }}
            exit={{ opacity: 0 }}
          >
            <ResultadoAfinidad
              resultado={resultado}
              usuario={usuario}
              onRepetir={empezarQuiz}
              onVolver={resetQuiz}
              onVerPartido={setPartidoSeleccionado}
            />
          </motion.main>
        )}

        {vista === "partidos" && (
          <motion.main
            key="partidos"
            className="pt-main"
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            exit={{ opacity: 0 }}
          >
            {/* CARRUSEL */}
            <section className="pt-carrusel-section">
              <div className="pt-carrusel">
                <AnimatePresence mode="wait">
                  <motion.div
                    key={slideActual}
                    className="pt-carrusel-slide"
                    style={{ backgroundImage: `url("${SLIDES[slideActual].url}")` }}
                    initial={{ opacity: 0, scale: 1.05 }}
                    animate={{ opacity: 1, scale: 1 }}
                    exit={{ opacity: 0, scale: 0.98 }}
                    transition={{ duration: 0.8, ease: [0.22, 1, 0.36, 1] }}
                  >
                    <div className="pt-carrusel-overlay" />
                    <div className="pt-carrusel-content">
                      <motion.h1
                        initial={{ opacity: 0, y: 20 }}
                        animate={{ opacity: 1, y: 0 }}
                        transition={{ delay: 0.3, duration: 0.6 }}
                      >
                        {SLIDES[slideActual].titulo}
                      </motion.h1>
                      <motion.p
                        initial={{ opacity: 0, y: 20 }}
                        animate={{ opacity: 1, y: 0 }}
                        transition={{ delay: 0.5, duration: 0.6 }}
                      >
                        {SLIDES[slideActual].subtitulo}
                      </motion.p>
                    </div>
                  </motion.div>
                </AnimatePresence>

                <button className="pt-carrusel-btn pt-carrusel-btn-prev" onClick={anteriorSlide}>
                  <ChevronLeft size={24} />
                </button>
                <button className="pt-carrusel-btn pt-carrusel-btn-next" onClick={siguienteSlide}>
                  <ChevronRight size={24} />
                </button>

                <div className="pt-carrusel-dots">
                  {SLIDES.map((_, i) => (
                    <button
                      key={i}
                      className={`pt-carrusel-dot ${i === slideActual ? "active" : ""}`}
                      onClick={() => setSlideActual(i)}
                    />
                  ))}
                </div>
              </div>
            </section>

            {/* INFO */}
            <section className="pt-info-section">
              <div className="pt-info-card-lg">
                <div className="pt-info-card-lg-img">
                  <img
                    src="https://images.unsplash.com/photo-1523240795612-9a054b0db644?w=800&q=80"
                    alt="Estudiantes participando"
                  />
                </div>
                <div className="pt-info-card-lg-text">
                  <span className="pt-info-eyebrow">Sobre los partidos</span>
                  <h3>¿Qué son los partidos estudiantiles?</h3>
                  <p>
                    Los partidos estudiantiles son organizaciones formadas por
                    estudiantes que comparten ideas, valores y propuestas para
                    mejorar el colegio. Son el primer espacio donde tu voz se
                    convierte en acción.
                  </p>
                  <p>
                    En Costa Rica, la participación estudiantil es fundamental
                    para formar ciudadanos conscientes. Cada partido presenta
                    candidatos y propuestas que vos podés apoyar con tu voto.
                  </p>
                </div>
              </div>
            </section>

            {/* GRID DE PARTIDOS */}
            <section id="partidos-lista" className="pt-partidos-section">
              <div className="pt-section-header">
                <h2>Conocé los partidos</h2>
                <p>Tocá cualquier tarjeta para ver la info completa</p>
              </div>

              {cargandoPartidos ? (
                <div className="pt-loading">
                  <Loader size={28} className="spin" />
                  <p>Cargando partidos...</p>
                </div>
              ) : partidos.length === 0 ? (
                <div className="pt-empty">
                  <Vote size={48} />
                  <h3>No hay partidos registrados</h3>
                  <p>Los partidos aparecerán cuando sean aprobados</p>
                </div>
              ) : (
                <div className="pt-partidos-grid">
                  {partidos.map((p, i) => (
                    <PartidoCard
                      key={p.id_partido}
                      partido={p}
                      onClick={() => setPartidoSeleccionado(p)}
                      delay={i * 0.1}
                    />
                  ))}
                </div>
              )}
            </section>

            {/* QUIZ - STICKERS */}
            <section className="pt-quiz-cta-section">
              <div className="pt-quiz-cta-inner">
                <div className="pt-quiz-cta-text">
                  <h2>¿Con cuál partido coincides más?</h2>
                  <p>
                    Vas a leer 8 propuestas sin saber qué partido las presentó.
                    Marcá qué tan de acuerdo estás con cada una y al final verás
                    con cuál partido tienes más afinidad.
                  </p>
                  <button className="pt-btn-primary" onClick={empezarQuiz}>
                    <Sparkles size={18} />
                    Comenzar el quiz
                  </button>
                </div>

                <div className="pt-quiz-cta-stickers">
                  {partidos.length > 0
                    ? partidos.slice(0, 4).map((p, i) => {
                        const c = STICKER_COLORES[i % STICKER_COLORES.length];
                        const rutaImg = rutaImagenPartido(p);
                        return (
                          <motion.div
                            key={p.id_partido}
                            className="pt-sticker-card"
                            style={{ background: c.bg }}
                            animate={{ y: [0, -10, 0] }}
                            transition={{
                              duration: 3 + i * 0.4,
                              repeat: Infinity,
                              ease: "easeInOut",
                              delay: i * 0.4,
                            }}
                          >
                            <div className="pt-sticker-img-wrap" style={{ background: c.acento }}>
                              {rutaImg ? (
                                <img src={rutaImg} alt={p.nombre} className="pt-sticker-img" />
                              ) : (
                                <span className="pt-sticker-letra">
                                  {p.nombre?.[0]?.toUpperCase()}
                                </span>
                              )}
                            </div>
                            <div className="pt-sticker-nombre">{p.nombre}</div>
                          </motion.div>
                        );
                      })
                    : [0, 1, 2, 3].map((i) => {
                        const c = STICKER_COLORES[i % STICKER_COLORES.length];
                        const emojis = ["🦋", "⭐", "🎀", "🌸"];
                        return (
                          <motion.div
                            key={i}
                            className="pt-sticker-card"
                            style={{ background: c.bg }}
                            animate={{ y: [0, -10, 0] }}
                            transition={{
                              duration: 3 + i * 0.4,
                              repeat: Infinity,
                              ease: "easeInOut",
                              delay: i * 0.4,
                            }}
                          >
                            <div className="pt-sticker-img-wrap" style={{ background: c.acento }}>
                              <span className="pt-sticker-emoji">{emojis[i]}</span>
                            </div>
                          </motion.div>
                        );
                      })}
                </div>
              </div>
            </section>

            {/* CREAR PARTIDO (solo estudiante) */}
            {!esProfesor && (
              <section className="pt-crear-cta-section">
                <div className="pt-crear-cta-inner">
                  <div className="pt-crear-cta-icon">
                    <Plus size={32} />
                  </div>
                  <div className="pt-crear-cta-text">
                    <span className="pt-crear-cta-eyebrow">¿Tenés una idea?</span>
                    <h2>Creá tu partido político</h2>
                    <p>
                      Presentá tu propuesta al colegio. Vas a poder elegir el
                      nombre, la bandera, los integrantes de la directiva y las
                      propuestas que defenderá tu partido. Un profesor lo
                      revisará y, si es aprobado, aparecerá aquí para que todos
                      lo conozcan y puedan votar por él.
                    </p>
                    <button
                      className="pt-btn-primary"
                      onClick={() => navigate("/crearpartido")}
                    >
                      <Plus size={18} />
                      Crear mi partido político
                      <ArrowRight size={18} />
                    </button>
                  </div>
                </div>
              </section>
            )}
          </motion.main>
        )}
      </AnimatePresence>

      <AnimatePresence>
        {partidoSeleccionado && (
          <PartidoModal
            partido={partidoSeleccionado}
            onClose={() => setPartidoSeleccionado(null)}
          />
        )}
      </AnimatePresence>
    </div>
  );
}

// ═══════════════════════════════════════════════════════════
// TARJETA DE PARTIDO
// ═══════════════════════════════════════════════════════════
function PartidoCard({ partido, onClick, delay }) {
  const rutaImagen = resolverImagen(partido.bandera_url);

  return (
    <motion.div
      className="pt-card-original"
      onClick={onClick}
      initial={{ opacity: 0, y: 30 }}
      whileInView={{ opacity: 1, y: 0 }}
      viewport={{ once: true }}
      transition={{ duration: 0.5, delay }}
      whileHover={{ y: -5 }}
      style={{
        backgroundImage: rutaImagen ? `url("${rutaImagen}")` : "none",
        backgroundColor: rutaImagen ? "transparent" : "#9571dd",
      }}
    >
      <div className="pt-card-contenido">
        <h2 className="pt-card-titulo">{partido.nombre}</h2>
        <h4 className="pt-card-sub">Partido Político</h4>
        <p className="pt-card-descrip">{partido.descripcion}</p>
      </div>
    </motion.div>
  );
}

// ═══════════════════════════════════════════════════════════
// QUIZ PREGUNTA
// ═══════════════════════════════════════════════════════════
function QuizPregunta({
  propuesta, indice, total, seleccion,
  onResponder, onAnterior, onCancelar,
}) {
  const progreso = ((indice + 1) / total) * 100;

  return (
    <div className="pt-quiz">
      <div className="pt-quiz-progress">
        <motion.div
          className="pt-quiz-progress-fill"
          initial={false}
          animate={{ width: `${progreso}%` }}
          transition={{ duration: 0.5, ease: "easeOut" }}
        />
      </div>

      <div className="pt-quiz-header">
        <button className="pt-quiz-back" onClick={onCancelar}>
          ← Cancelar
        </button>
        <span className="pt-quiz-counter">
          Propuesta {indice + 1} de {total}
        </span>
      </div>

      <AnimatePresence mode="wait">
        <motion.div
          key={propuesta.id_propuesta}
          className="pt-quiz-question-wrap"
          initial={{ opacity: 0, x: 30 }}
          animate={{ opacity: 1, x: 0 }}
          exit={{ opacity: 0, x: -30 }}
          transition={{ duration: 0.3 }}
        >
          <h2 className="pt-quiz-question">{propuesta.titulo}</h2>
          {propuesta.descripcion && (
            <p className="pt-quiz-question-desc">{propuesta.descripcion}</p>
          )}

          <div className="pt-escala">
            <span className="pt-escala-extremo pt-escala-acuerdo">De acuerdo</span>
            <div className="pt-escala-opciones">
              {OPCIONES_ESCALA.map((op) => {
                const sel = seleccion === op.valor;
                return (
                  <button
                    key={op.valor}
                    type="button"
                    className={`pt-opcion pt-opcion-${op.lado} pt-opcion-${op.tamano} ${sel ? "selected" : ""}`}
                    onClick={() => onResponder(op.valor)}
                    title={op.texto}
                    aria-label={op.texto}
                  >
                    <span className="pt-opcion-circulo" />
                  </button>
                );
              })}
            </div>
            <span className="pt-escala-extremo pt-escala-desacuerdo">En desacuerdo</span>
          </div>

          <p className="pt-quiz-seleccion-texto">
            {seleccion !== undefined
              ? OPCIONES_ESCALA.find((o) => o.valor === seleccion)?.texto
              : "Tocá una pelotita para responder"}
          </p>
        </motion.div>
      </AnimatePresence>

      <div className="pt-quiz-nav">
        <button
          className="pt-quiz-nav-btn pt-quiz-nav-prev"
          onClick={onAnterior}
          disabled={indice === 0}
        >
          ← Anterior
        </button>
      </div>
    </div>
  );
}

// ═══════════════════════════════════════════════════════════
// RESULTADO
// ═══════════════════════════════════════════════════════════
function ResultadoAfinidad({ resultado, usuario, onRepetir, onVolver, onVerPartido }) {
  const { ganador, todos, perfil_usuario } = resultado;

  const ejes = ["ecologico", "social", "academico", "cultural", "tecnologico"];
  const nombresEjes = {
    ecologico: "Medio Ambiente",
    social: "Convivencia",
    academico: "Académico",
    cultural: "Cultura y Deporte",
    tecnologico: "Tecnología",
  };
  const iconosEjes = {
    ecologico: "🌱", social: "🤝", academico: "📚", cultural: "🎭", tecnologico: "💻",
  };

  const totalUsuario = Object.values(perfil_usuario).reduce((a, b) => a + b, 0) || 1;
  const totalPartido = Object.values(ganador.perfil).reduce((a, b) => a + b, 0) || 1;
  const maxValor = Math.max(totalUsuario, totalPartido, 1);

  const radarData = ejes.map((eje) => ({
    eje: nombresEjes[eje],
    icono: iconosEjes[eje],
    usuario: Math.round(((perfil_usuario[eje] || 0) / maxValor) * 100),
    partido: Math.round(((ganador.perfil[eje] || 0) / maxValor) * 100),
  }));

  const size = 500;
  const center = size / 2;
  const radius = size * 0.33;
  const numEjes = ejes.length;
  const anguloEntre = (Math.PI * 2) / numEjes;
  const anguloInicio = -Math.PI / 2;

  const getPunto = (idx, valor, max = 100) => {
    const ang = anguloInicio + idx * anguloEntre;
    const r = (valor / max) * radius;
    return [center + Math.cos(ang) * r, center + Math.sin(ang) * r];
  };

  const polygonUsuario = radarData.map((d, i) => getPunto(i, d.usuario).join(",")).join(" ");
  const polygonPartido = radarData.map((d, i) => getPunto(i, d.partido).join(",")).join(" ");

  const colorPartido = ganador.color_principal || "#F4B860";
  const imagenGanador = resolverImagen(ganador.bandera_url);

  return (
    <div className="pt-result">
      <div className="pt-result-header-card">
        <motion.div
          className="pt-result-trophy"
          initial={{ scale: 0, rotate: -180 }}
          animate={{ scale: 1, rotate: 0 }}
          transition={{ delay: 0.2, type: "spring", stiffness: 200 }}
        >
          <Trophy size={44} />
        </motion.div>
        <span className="pt-result-eyebrow">TU AFINIDAD POLÍTICA</span>
        <h1 className="pt-result-title">¡{usuario?.nombre || "Estudiante"}!</h1>
        <p className="pt-result-sub">Según tus respuestas, perteneces al partido:</p>
      </div>

      <motion.div
        className="pt-result-ganador"
        style={{ "--c1": colorPartido, "--c2": ganador.color_secundario || "#E8D9F5" }}
        initial={{ opacity: 0, scale: 0.9 }}
        animate={{ opacity: 1, scale: 1 }}
        transition={{ delay: 0.3, type: "spring", stiffness: 200 }}
      >
        <div className="pt-result-ganador-img">
          {imagenGanador ? (
            <img src={imagenGanador} alt={ganador.nombre} />
          ) : (
            <div className="pt-result-ganador-placeholder">{ganador.nombre?.[0]}</div>
          )}
        </div>
        <div className="pt-result-ganador-info">
          <h2>{ganador.nombre}</h2>
          {ganador.slogan && <p>"{ganador.slogan}"</p>}
          <div className="pt-result-match">
            <span className="pt-result-match-num">{ganador.afinidad}%</span>
            <span className="pt-result-match-label">de afinidad</span>
          </div>
        </div>
      </motion.div>

      <div className="pt-result-buttons">
        <button className="pt-result-btn pt-result-btn-light" onClick={onRepetir}>
          <RefreshCw size={16} />
          Rehacer el test
        </button>
        <button className="pt-result-btn pt-result-btn-primary" onClick={() => onVerPartido(ganador)}>
          Ver mi partido completo
          <ArrowRight size={16} />
        </button>
      </div>

      <div className="pt-result-chart">
        <h3 className="pt-result-chart-title">COMPARACIÓN DE PERFILES</h3>
        <div className="pt-result-chart-svg">
          <svg viewBox={`0 0 ${size} ${size}`} width="100%" height="auto">
            {[0.25, 0.5, 0.75, 1].map((p, i) => {
              const puntos = ejes.map((_, idx) => getPunto(idx, p * 100).join(",")).join(" ");
              return (
                <polygon key={i} points={puntos} fill="none"
                  stroke={i === 3 ? "rgba(141, 123, 232, 0.5)" : "rgba(141, 123, 232, 0.2)"}
                  strokeWidth={i === 3 ? "1.5" : "1"} />
              );
            })}

            {radarData.map((_, i) => {
              const [x, y] = getPunto(i, 100);
              return <line key={i} x1={center} y1={center} x2={x} y2={y}
                stroke="rgba(141, 123, 232, 0.25)" strokeWidth="1" />;
            })}

            <polygon points={polygonPartido} fill={`${colorPartido}40`}
              stroke={colorPartido} strokeWidth="2.5" strokeLinejoin="round" />

            <polygon points={polygonUsuario} fill="rgba(141, 123, 232, 0.35)"
              stroke="#7d67ec" strokeWidth="2.5" strokeLinejoin="round" />

            {radarData.map((d, i) => {
              const [x, y] = getPunto(i, d.partido);
              return <circle key={`p-${i}`} cx={x} cy={y} r="5" fill={colorPartido}
                stroke="white" strokeWidth="2" />;
            })}

            {radarData.map((d, i) => {
              const [x, y] = getPunto(i, d.usuario);
              return <circle key={`u-${i}`} cx={x} cy={y} r="5" fill="#7d67ec"
                stroke="white" strokeWidth="2" />;
            })}

            {radarData.map((d, i) => {
              const [x, y] = getPunto(i, 128);
              const esIzquierda = x < center - 20;
              const esDerecha = x > center + 20;
              const textAnchor = esIzquierda ? "end" : esDerecha ? "start" : "middle";
              const offsetX = esIzquierda ? -8 : esDerecha ? 8 : 0;
              return (
                <g key={i}>
                  <text x={x + offsetX} y={y - 6} textAnchor={textAnchor}
                    dominantBaseline="middle" fontSize="20">{d.icono}</text>
                  <text x={x + offsetX} y={y + 12} textAnchor={textAnchor}
                    dominantBaseline="middle" fontSize="12" fontWeight="700"
                    fill="#4a386d">{d.eje}</text>
                </g>
              );
            })}
          </svg>

          <div className="pt-result-chart-legend">
            <div>
              <span className="pt-result-chart-dot" style={{ background: colorPartido }} />
              {ganador.nombre}
            </div>
            <div>
              <span className="pt-result-chart-dot" style={{ background: "#7d67ec" }} />
              Tu perfil
            </div>
          </div>
        </div>
      </div>

      <div className="pt-result-ranking">
        <h3 className="pt-result-chart-title">TU AFINIDAD CON CADA PARTIDO</h3>
        <div className="pt-result-ranking-list">
          {todos.map((p, i) => {
            const rutaImg = resolverImagen(p.bandera_url);
            return (
              <div key={p.id_partido} className={`pt-result-ranking-item ${i === 0 ? "top" : ""}`}>
                <span className="pt-result-ranking-pos">{i + 1}</span>
                <div className="pt-result-ranking-flag">
                  {rutaImg ? (
                    <img src={rutaImg} alt={p.nombre} />
                  ) : (
                    <span>{p.nombre?.[0]}</span>
                  )}
                </div>
                <span className="pt-result-ranking-nombre">{p.nombre}</span>
                <div className="pt-result-ranking-bar-wrap">
                  <motion.div
                    className="pt-result-ranking-bar"
                    style={{
                      background: `linear-gradient(90deg, ${p.color_principal || "#A3D9BD"}, ${p.color_secundario || "#E6A8D7"})`,
                    }}
                    initial={{ width: 0 }}
                    animate={{ width: `${p.afinidad}%` }}
                    transition={{ delay: 0.5 + i * 0.1, duration: 0.6 }}
                  />
                </div>
                <span className="pt-result-ranking-pct">{p.afinidad}%</span>
              </div>
            );
          })}
        </div>
      </div>
    </div>
  );
}

// ═══════════════════════════════════════════════════════════
// MODAL DE PARTIDO (con carga de detalle completo)
// ═══════════════════════════════════════════════════════════
function PartidoModal({ partido, onClose }) {
  const [detalle, setDetalle] = useState(null);
  const [cargando, setCargando] = useState(true);

  useEffect(() => {
    const onEsc = (e) => e.key === "Escape" && onClose();
    document.addEventListener("keydown", onEsc);
    document.body.style.overflow = "hidden";

    // Cargar detalle completo desde el backend
    const cargarDetalle = async () => {
      try {
        const res = await fetch(`${API}/partidos/detalle/${partido.id_partido}`);
        const data = await res.json();
        if (res.ok) {
          setDetalle(data);
        } else {
          // Fallback: usar lo que ya viene en el partido
          setDetalle({
            partido,
            miembros: partido.miembros || [],
            propuestas: partido.propuestas || [],
          });
        }
      } catch (err) {
        console.error("Error cargando detalle:", err);
        // Fallback: usar lo que ya viene en el partido
        setDetalle({
          partido,
          miembros: partido.miembros || [],
          propuestas: partido.propuestas || [],
        });
      } finally {
        setCargando(false);
      }
    };
    cargarDetalle();

    return () => {
      document.removeEventListener("keydown", onEsc);
      document.body.style.overflow = "";
    };
  }, [partido.id_partido, onClose]);

  // Datos combinados (del detalle o del partido pasado por prop)
  const datos = detalle?.partido || partido;
  const miembros = detalle?.miembros || partido.miembros || [];
  const propuestas = detalle?.propuestas || partido.propuestas || [];

  const coloresDefault = [
    { c1: "#A3D9BD", c2: "#E6A8D7" },
    { c1: "#FFB347", c2: "#FFCC33" },
    { c1: "#8D7BE8", c2: "#B3BBDE" },
    { c1: "#F4A261", c2: "#E76F51" },
    { c1: "#2A9D8F", c2: "#A8DADC" },
    { c1: "#E9C46A", c2: "#F4A261" },
  ];
  const idx = (datos.id_partido || 0) % coloresDefault.length;
  const color1 = datos.color_principal || coloresDefault[idx].c1;
  const color2 = datos.color_secundario || coloresDefault[idx].c2;
  const rutaImagen = resolverImagen(datos.bandera_url);

  return (
    <motion.div
      className="pt-modal-overlay"
      initial={{ opacity: 0 }}
      animate={{ opacity: 1 }}
      exit={{ opacity: 0 }}
      onClick={onClose}
    >
      <motion.div
        className="pt-modal"
        style={{ "--c1": color1, "--c2": color2 }}
        initial={{ opacity: 0, y: 30, scale: 0.95 }}
        animate={{ opacity: 1, y: 0, scale: 1 }}
        exit={{ opacity: 0, y: 30, scale: 0.95 }}
        transition={{ type: "spring", stiffness: 300, damping: 25 }}
        onClick={(e) => e.stopPropagation()}
      >
        {/* Header con la bandera */}
        <div className="pt-modal-header">
          <div className="pt-modal-header-bg" />
          <button className="pt-modal-close" onClick={onClose}>
            <X size={20} />
          </button>

          <div className="pt-modal-header-content">
            <div className="pt-modal-image">
              {rutaImagen ? (
                <img src={rutaImagen} alt={datos.nombre} />
              ) : (
                <div className="pt-modal-image-placeholder">
                  {datos.nombre?.[0]}
                </div>
              )}
            </div>
            <div className="pt-modal-header-text">
              <h2>{datos.nombre}</h2>
              {datos.slogan && (
                <p className="pt-modal-slogan">"{datos.slogan}"</p>
              )}
              <p className="pt-modal-desc">{datos.descripcion}</p>
              {datos.estado && datos.estado !== "aprobado" && (
                <span
                  style={{
                    display: "inline-block",
                    marginTop: "8px",
                    padding: "4px 12px",
                    borderRadius: "999px",
                    background:
                      datos.estado === "pendiente"
                        ? "rgba(240, 193, 92, 0.25)"
                        : "rgba(229, 72, 77, 0.15)",
                    color: datos.estado === "pendiente" ? "#b8801e" : "#e5484d",
                    fontSize: "10.5px",
                    fontWeight: 800,
                    textTransform: "uppercase",
                    letterSpacing: "0.5px",
                  }}
                >
                  {datos.estado === "pendiente" ? "⏳ Pendiente de aprobación" : "❌ Rechazado"}
                </span>
              )}
            </div>
          </div>
        </div>

        {/* Body con toda la info */}
        <div className="pt-modal-body">
          {cargando ? (
            <div style={{ textAlign: "center", padding: "40px", color: "#8b7ba8" }}>
              <Loader size={24} className="spin" />
              <p style={{ marginTop: "12px" }}>Cargando detalles...</p>
            </div>
          ) : (
            <>
              {/* Meta */}
              {datos.meta && (
                <section className="pt-modal-section">
                  <h3 className="pt-modal-section-title">
                    <Target size={18} />
                    Nuestra meta
                  </h3>
                  <div className="pt-modal-meta-box">
                    <p>{datos.meta}</p>
                  </div>
                </section>
              )}

              {/* Miembros */}
              <section className="pt-modal-section">
                <h3 className="pt-modal-section-title">
                  <Users size={18} />
                  Candidatos a la directiva ({miembros.length})
                </h3>
                {miembros.length === 0 ? (
                  <div className="pt-modal-empty">
                    Sin integrantes registrados todavía
                  </div>
                ) : (
                  <div className="pt-modal-miembros">
                    {miembros.map((m, i) => (
                      <div key={m.id_miembro || i} className="pt-modal-miembro">
                        <span className="pt-modal-miembro-cargo">
                          {CARGOS[m.cargo] || m.cargo}
                        </span>
                        <span className="pt-modal-miembro-nombre">
                          {m.nombre} {m.apellido}
                        </span>
                        {m.seccion && (
                          <span className="pt-modal-miembro-seccion">
                            {m.seccion}
                          </span>
                        )}
                      </div>
                    ))}
                  </div>
                )}
              </section>

              {/* Propuestas */}
              <section className="pt-modal-section">
                <h3 className="pt-modal-section-title">
                  <Lightbulb size={18} />
                  Propuestas ({propuestas.length})
                </h3>
                {propuestas.length === 0 ? (
                  <div className="pt-modal-empty">
                    Sin propuestas registradas todavía
                  </div>
                ) : (
                  <div className="pt-modal-propuestas">
                    {propuestas.map((p, i) => (
                      <div
                        key={p.id_propuesta || i}
                        className="pt-modal-propuesta"
                      >
                        <span className="pt-modal-propuesta-num">{i + 1}</span>
                        <div>
                          <p className="pt-modal-propuesta-titulo">{p.titulo}</p>
                          {p.descripcion && (
                            <p className="pt-modal-propuesta-desc">
                              {p.descripcion}
                            </p>
                          )}
                        </div>
                      </div>
                    ))}
                  </div>
                )}
              </section>

              {/* Frase */}
              {datos.frase && (
                <section className="pt-modal-frase">
                  <Sparkles size={16} />
                  <p>{datos.frase}</p>
                </section>
              )}
            </>
          )}
        </div>
      </motion.div>
    </motion.div>
  );
}

export default Partidos;