// agoraya/AGORA/src/componentes/juegos/Trivia.jsx
import { useState } from "react";
import { motion, AnimatePresence } from "framer-motion";
import { ArrowLeft, Sparkles, Trophy } from "lucide-react";
import "./Trivia.css";

const preguntas = [
  {
    pregunta: "¿Qué es la democracia?",
    opciones: [
      "El gobierno de una sola persona",
      "Un sistema donde participan los ciudadanos",
      "Eliminar las elecciones",
      "No tener leyes",
    ],
    correcta: 1,
  },
  {
    pregunta: "¿Qué permite el voto?",
    opciones: [
      "Participar en decisiones políticas",
      "Eliminar derechos",
      "Evitar elecciones",
      "Quitar leyes",
    ],
    correcta: 0,
  },
  {
    pregunta: "¿Qué es un ciudadano?",
    opciones: [
      "Una persona sin derechos",
      "Un partido político",
      "Una institución",
      "Una persona con derechos y responsabilidades",
    ],
    correcta: 3,
  },
  {
    pregunta: "¿Cuál es una responsabilidad ciudadana?",
    opciones: [
      "No participar en la sociedad",
      "Eliminar derechos",
      "Respetar las leyes",
      "Evitar elecciones",
    ],
    correcta: 2,
  },
  {
    pregunta: "¿Qué institución representa al Estado?",
    opciones: [
      "Una institución pública",
      "Un videojuego",
      "Una empresa privada",
      "Un grupo sin reglas",
    ],
    correcta: 0,
  },
];

function Trivia({ volver }) {
  const [actual, setActual] = useState(0);
  const [resultado, setResultado] = useState(null);
  const [puntos, setPuntos] = useState(0);
  const [terminado, setTerminado] = useState(false);

  const pregunta = preguntas[actual];
  const progreso = ((actual + 1) / preguntas.length) * 100;

  // ═══════════════════════════════════════════════════════════
  // PANTALLA FINAL
  // ═══════════════════════════════════════════════════════════
  if (terminado) {
    const porcentaje = (puntos / 50) * 100;
    const mensaje =
      puntos === 50
        ? { emoji: "🏆", texto: "¡Perfecto! Dominaste el tema", color: "excelente" }
        : puntos === 40
        ? { emoji: "🌟", texto: "¡Muy bien! Tienes buenos conocimientos", color: "muy-bien" }
        : puntos === 30
        ? { emoji: "👍", texto: "Bien, pero puedes seguir practicando", color: "bien" }
        : { emoji: "📚", texto: "Debes repasar un poco más", color: "mejorar" };

    return (
      <div className="tj-pantalla-final">
        <div className="tj-blob tj-blob-1" />
        <div className="tj-blob tj-blob-2" />

        <motion.div
          className="tj-final-card"
          initial={{ opacity: 0, scale: 0.9, y: 20 }}
          animate={{ opacity: 1, scale: 1, y: 0 }}
          transition={{ type: "spring", stiffness: 200, damping: 20 }}
        >
          <motion.div
            className="tj-final-trofeo"
            initial={{ scale: 0, rotate: -180 }}
            animate={{ scale: 1, rotate: 0 }}
            transition={{ delay: 0.3, type: "spring", stiffness: 200 }}
          >
            <Trophy size={56} />
          </motion.div>

          <motion.h1
            className="tj-final-titulo"
            initial={{ opacity: 0, y: 10 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: 0.4 }}
          >
            ¡Juego terminado!
          </motion.h1>

          <motion.div
            className="tj-final-puntaje-wrap"
            initial={{ opacity: 0, scale: 0.8 }}
            animate={{ opacity: 1, scale: 1 }}
            transition={{ delay: 0.5 }}
          >
            <span className="tj-final-puntaje-num">{puntos}</span>
            <span className="tj-final-puntaje-de">/50</span>
          </motion.div>

          <motion.p
            className={`tj-final-mensaje tj-final-mensaje-${mensaje.color}`}
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            transition={{ delay: 0.6 }}
          >
            <span className="tj-final-emoji">{mensaje.emoji}</span>
            {mensaje.texto}
          </motion.p>

          <div className="tj-final-progreso-wrap">
            <div className="tj-final-progreso">
              <motion.div
                className="tj-final-progreso-bar"
                initial={{ width: 0 }}
                animate={{ width: `${porcentaje}%` }}
                transition={{ delay: 0.7, duration: 1, ease: "easeOut" }}
              />
            </div>
          </div>

          <div className="tj-final-actions">
            <motion.button
              onClick={() => {
                setActual(0);
                setPuntos(0);
                setResultado(null);
                setTerminado(false);
              }}
              className="tj-btn-reintentar"
              whileHover={{ scale: 1.05 }}
              whileTap={{ scale: 0.95 }}
            >
              <Sparkles size={16} />
              Volver a jugar
            </motion.button>

            <motion.button
              onClick={volver}
              className="tj-btn-volver"
              whileHover={{ scale: 1.05 }}
              whileTap={{ scale: 0.95 }}
            >
              <ArrowLeft size={16} />
              Volver a Juegos
            </motion.button>
          </div>
        </motion.div>
      </div>
    );
  }

  // ═══════════════════════════════════════════════════════════
  // FUNCIONES
  // ═══════════════════════════════════════════════════════════
  function siguiente() {
    if (actual < preguntas.length - 1) {
      setActual(actual + 1);
      setResultado(null);
    } else {
      setTerminado(true);
    }
  }

  function responder(index) {
    if (resultado !== null) return;
    setResultado(index);
    if (index === pregunta.correcta) {
      setPuntos(puntos + 10);
    }
  }

  // ═══════════════════════════════════════════════════════════
  // PANTALLA DE JUEGO
  // ═══════════════════════════════════════════════════════════
  return (
    <div className="tj-pagina">
      <div className="tj-blob tj-blob-1" />
      <div className="tj-blob tj-blob-2" />

      <div className="tj-container">
        <motion.button
          onClick={volver}
          className="tj-btn-salir"
          initial={{ opacity: 0, x: -20 }}
          animate={{ opacity: 1, x: 0 }}
          whileHover={{ scale: 1.05 }}
          whileTap={{ scale: 0.95 }}
        >
          <ArrowLeft size={16} />
          Volver
        </motion.button>

        <motion.div
          className="tj-card"
          initial={{ opacity: 0, y: 30 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.5 }}
        >
          {/* Header del card */}
          <div className="tj-card-header">
            <h1 className="tj-titulo">Trivia Política</h1>

            <div className="tj-header-info">
              <div className="tj-puntaje-badge">
                <Sparkles size={14} />
                <span>Puntaje: {puntos}</span>
              </div>
              <span className="tj-progreso-texto">
                Pregunta {actual + 1} de {preguntas.length}
              </span>
            </div>

            {/* Barra de progreso */}
            <div className="tj-progreso-wrap">
              <motion.div
                className="tj-progreso-bar"
                initial={false}
                animate={{ width: `${progreso}%` }}
                transition={{ duration: 0.5, ease: "easeOut" }}
              />
            </div>
          </div>

          {/* Pregunta */}
          <AnimatePresence mode="wait">
            <motion.div
              key={actual}
              initial={{ opacity: 0, x: 30 }}
              animate={{ opacity: 1, x: 0 }}
              exit={{ opacity: 0, x: -30 }}
              transition={{ duration: 0.3 }}
            >
              <h2 className="tj-pregunta">{pregunta.pregunta}</h2>

              <div className="tj-opciones">
                {pregunta.opciones.map((opcion, index) => {
                  let claseEstado = "";
                  if (resultado === index) {
                    claseEstado =
                      index === pregunta.correcta ? "correcta" : "incorrecta";
                  }
                  if (
                    resultado !== null &&
                    index === pregunta.correcta &&
                    index !== resultado
                  ) {
                    claseEstado = "revelada";
                  }

                  return (
                    <motion.button
                      key={index}
                      onClick={() => responder(index)}
                      className={`tj-opcion ${claseEstado}`}
                      whileHover={resultado === null ? { scale: 1.02, x: 6 } : {}}
                      whileTap={resultado === null ? { scale: 0.98 } : {}}
                      disabled={resultado !== null}
                    >
                      <span className="tj-opcion-letra">
                        {String.fromCharCode(65 + index)}
                      </span>
                      <span className="tj-opcion-texto">{opcion}</span>
                      {claseEstado === "correcta" && (
                        <span className="tj-opcion-icon">✓</span>
                      )}
                      {claseEstado === "incorrecta" && (
                        <span className="tj-opcion-icon">✗</span>
                      )}
                    </motion.button>
                  );
                })}
              </div>
            </motion.div>
          </AnimatePresence>

          {/* Botón siguiente */}
          <motion.button
            onClick={siguiente}
            disabled={resultado === null}
            className="tj-btn-siguiente"
            whileHover={resultado !== null ? { scale: 1.02 } : {}}
            whileTap={resultado !== null ? { scale: 0.98 } : {}}
          >
            {actual === preguntas.length - 1 ? "Ver resultados" : "Siguiente"}
            <span className="tj-btn-arrow">→</span>
          </motion.button>
        </motion.div>
      </div>
    </div>
  );
}

export default Trivia;