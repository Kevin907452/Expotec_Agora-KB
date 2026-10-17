// agoraya/AGORA/src/componentes/juegos/Juegos.jsx
import { useState } from "react";
import { motion, AnimatePresence } from "framer-motion";
import { Puzzle, Sparkles, ArrowLeft } from "lucide-react";
import "./Juegos.css";

import Trivia from "./Trivia";
import Memoria from "./Memoria";
import VerdaderoFalso from "./VerdaderoFalso";

// ═══════════════════════════════════════════════════════════
// ÍCONOS SVG
// ═══════════════════════════════════════════════════════════
function RuletaIcon({ size = 90 }) {
  return (
    <svg
      width={size}
      height={size}
      viewBox="0 0 100 100"
      fill="none"
      stroke="currentColor"
      strokeWidth="4.5"
      strokeLinecap="round"
      strokeLinejoin="round"
    >
      <circle cx="50" cy="45" r="35" />
      <line x1="50" y1="10" x2="50" y2="80" />
      <line x1="15" y1="45" x2="85" y2="45" />
      <line x1="25" y1="20" x2="75" y2="70" />
      <line x1="75" y1="20" x2="25" y2="70" />
      <circle cx="50" cy="45" r="8" fill="currentColor" />
      <path d="M35 80 L35 90" />
      <path d="M65 80 L65 90" />
      <rect x="25" y="90" width="50" height="5" rx="2" />
    </svg>
  );
}

function VerdaderoFalsoIcon({ size = 90 }) {
  return (
    <svg
      width={size}
      height={size}
      viewBox="0 0 140 140"
      fill="none"
      stroke="currentColor"
      strokeWidth="4.5"
      strokeLinecap="round"
      strokeLinejoin="round"
    >
      {/* Círculo X */}
      <circle cx="35" cy="25" r="18" />
      <line x1="27" y1="17" x2="43" y2="33" />
      <line x1="43" y1="17" x2="27" y2="33" />
      {/* Círculo Check */}
      <circle cx="105" cy="25" r="18" />
      <polyline points="95,25 102,32 115,17" />
      {/* Persona */}
      <circle cx="65" cy="55" r="12" />
      <path d="M65 67 L65 105" />
      <path d="M65 75 L95 55 L82 42" />
      <path d="M65 80 L45 95 L55 110" />
      <path d="M65 105 L65 130" />
    </svg>
  );
}

// ═══════════════════════════════════════════════════════════
// ANIMACIONES
// ═══════════════════════════════════════════════════════════
const containerVariants = {
  hidden: { opacity: 0 },
  visible: {
    opacity: 1,
    transition: {
      staggerChildren: 0.15,
      delayChildren: 0.1,
    },
  },
  exit: {
    opacity: 0,
    transition: { duration: 0.3 },
  },
};

const cardVariants = {
  hidden: {
    opacity: 0,
    y: 40,
    scale: 0.9,
  },
  visible: {
    opacity: 1,
    y: 0,
    scale: 1,
    transition: {
      type: "spring",
      stiffness: 200,
      damping: 20,
    },
  },
};

const iconVariants = {
  rest: { y: 0, rotate: 0 },
  hover: {
    y: -8,
    rotate: [0, -8, 8, -4, 0],
    transition: {
      y: { type: "spring", stiffness: 300, damping: 15 },
      rotate: { duration: 0.6, ease: "easeInOut" },
    },
  },
};

const buttonVariants = {
  rest: { scale: 1 },
  hover: {
    scale: 1.05,
    transition: { type: "spring", stiffness: 400, damping: 15 },
  },
  tap: { scale: 0.95 },
};

// ═══════════════════════════════════════════════════════════
// COMPONENTE PRINCIPAL
// ═══════════════════════════════════════════════════════════
function Juegos({ volver }) {
  const [juegoActual, setJuegoActual] = useState("menu");

  // ═══ Juegos ═══
  if (juegoActual === "trivia") {
    return <Trivia volver={() => setJuegoActual("menu")} />;
  }
  if (juegoActual === "memoria") {
    return <Memoria volver={() => setJuegoActual("menu")} />;
  }
  if (juegoActual === "verdadero") {
    return <VerdaderoFalso volver={() => setJuegoActual("menu")} />;
  }

  // ═══ Lista de juegos ═══
  const juegos = [
    {
      id: "trivia",
      nombre: "Trivia Política",
      descripcion: "Responde preguntas sobre democracia y ciudadanía.",
      icono: RuletaIcon,
      color: "rosa", // color de acento para el card
      emoji: "🎯",
    },
    {
      id: "memoria",
      nombre: "Memoria Ciudadana",
      descripcion: "Encuentra las parejas correctas.",
      icono: Puzzle,
      color: "menta",
      emoji: "🧩",
    },
    {
      id: "verdadero",
      nombre: "Verdadero o Falso",
      descripcion: "Demuestra cuánto sabes.",
      icono: VerdaderoFalsoIcon,
      color: "celeste",
      emoji: "✨",
    },
  ];

  return (
    <div className="jg-pagina">
      {/* ═══ Blobs decorativos de fondo ═══ */}
      <div className="jg-blob jg-blob-1" />
      <div className="jg-blob jg-blob-2" />
      <div className="jg-blob jg-blob-3" />

      {/* ═══ Header ═══ */}
      <motion.header
        className="jg-header"
        initial={{ opacity: 0, y: -30 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ duration: 0.6, ease: "easeOut" }}
      >
        <div className="jg-header-left">
          <motion.button
            onClick={volver}
            className="jg-btn-back"
            variants={buttonVariants}
            initial="rest"
            whileHover="hover"
            whileTap="tap"
          >
            <ArrowLeft size={18} />
            <span>Volver al Quiz</span>
          </motion.button>

          <div className="jg-header-title">
            <motion.h1
              className="jg-titulo"
              initial={{ opacity: 0, x: -20 }}
              animate={{ opacity: 1, x: 0 }}
              transition={{ delay: 0.2, duration: 0.5 }}
            >
              Juegos
            </motion.h1>
            <motion.p
              className="jg-subtitulo"
              initial={{ opacity: 0 }}
              animate={{ opacity: 1 }}
              transition={{ delay: 0.35, duration: 0.5 }}
            >
              Aprende jugando · Elige uno y empieza
            </motion.p>
          </div>
        </div>

        <motion.div
          className="jg-header-badge"
          initial={{ opacity: 0, scale: 0.8 }}
          animate={{ opacity: 1, scale: 1 }}
          transition={{ delay: 0.4, duration: 0.5, type: "spring" }}
        >
          <Sparkles size={20} />
          <span>3 juegos disponibles</span>
        </motion.div>
      </motion.header>

      {/* ═══ Grid de juegos ═══ */}
      <motion.main
        className="jg-grid"
        variants={containerVariants}
        initial="hidden"
        animate="visible"
      >
        {juegos.map((juego, index) => {
          const Icono = juego.icono;
          return (
            <motion.div
              key={index}
              className={`jg-card jg-card-${juego.color}`}
              variants={cardVariants}
              whileHover="hover"
              initial="rest"
              animate="rest"
            >
              {/* Decoración del card */}
              <div className="jg-card-decoration" />

              {/* Ícono animado */}
              <motion.div
                className="jg-icono"
                variants={iconVariants}
              >
                <Icono size={80} />
              </motion.div>

              {/* Contenido */}
              <div className="jg-card-contenido">
                <h2 className="jg-card-titulo">
                  <span className="jg-card-emoji">{juego.emoji}</span>
                  {juego.nombre}
                </h2>
                <p className="jg-card-descripcion">{juego.descripcion}</p>
              </div>

              {/* Botón */}
              <motion.button
                onClick={() => setJuegoActual(juego.id)}
                className="jg-jugar"
                variants={buttonVariants}
                whileTap="tap"
              >
                <span>Jugar</span>
                <span className="jg-jugar-arrow">→</span>
              </motion.button>
            </motion.div>
          );
        })}
      </motion.main>

      {/* ═══ Footer informativo ═══ */}
      <motion.p
        className="jg-footer"
        initial={{ opacity: 0 }}
        animate={{ opacity: 1 }}
        transition={{ delay: 0.8, duration: 0.6 }}
      >
        💡 Tip: cada juego suma puntos para tu progreso
      </motion.p>
    </div>
  );
}

export default Juegos;