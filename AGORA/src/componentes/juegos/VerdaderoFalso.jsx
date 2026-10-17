// agoraya/AGORA/src/componentes/juegos/VerdaderoFalso.jsx
import { useState } from "react";
import { motion, AnimatePresence } from "framer-motion";
import { ArrowLeft, Sparkles, Trophy, Check, X } from "lucide-react";
import "./VerdaderoFalso.css";

const preguntas = [
  {
    caso: "Carlos vota en las elecciones para elegir a sus representantes.",
    pregunta: "¿El voto es una forma de participación ciudadana?",
    respuesta: true,
  },
  {
    caso: "Una persona decide no respetar las leyes porque piensa que solo algunas personas deben cumplirlas.",
    pregunta: "¿Esta actitud representa una responsabilidad ciudadana?",
    respuesta: false,
  },
  {
    caso: "Un grupo de estudiantes organiza una campaña para ayudar a su comunidad.",
    pregunta: "¿Los estudiantes están ejerciendo participación ciudadana?",
    respuesta: true,
  },
  {
    caso: "Un gobierno elimina las elecciones y permite que una sola persona tome todas las decisiones.",
    pregunta: "¿Este sistema representa una democracia?",
    respuesta: false,
  },
  {
    caso: "Ana conoce sus derechos y también cumple con sus responsabilidades como ciudadana.",
    pregunta: "¿Una ciudadanía responsable incluye derechos y deberes?",
    respuesta: true,
  },
  {
    caso: "Un ciudadano piensa que no puede opinar sobre los problemas de su país porque solo los políticos pueden hacerlo.",
    pregunta: "¿Esta idea es correcta?",
    respuesta: false,
  },
];

function VerdaderoFalso({ volver }) {
  const [actual, setActual] = useState(0);
  const [respuesta, setRespuesta] = useState(null);
  const [puntos, setPuntos] = useState(0);
  const [terminado, setTerminado] = useState(false);

  function responder(valor) {
    if (respuesta !== null) return;
    setRespuesta(valor);
    if (valor === preguntas[actual].respuesta) {
      setPuntos(puntos + 10);
    }
  }

  function siguiente() {
    if (actual < preguntas.length - 1) {
      setActual(actual + 1);
      setRespuesta(null);
    } else {
      setTerminado(true);
    }
  }

  function volverAJugar() {
    setActual(0);
    setRespuesta(null);
    setPuntos(0);
    setTerminado(false);
  }

  const progreso = ((actual + 1) / preguntas.length) * 100;

  // ═══════════════════════════════════════════════════════════
  // PANTALLA FINAL
  // ═══════════════════════════════════════════════════════════
  if (terminado) {
    const porcentaje = (puntos / 60) * 100;
    const mensaje =
      puntos === 60
        ? { emoji: "🏆", texto: "Excelente análisis", color: "excelente" }
        : puntos >= 40
        ? { emoji: "🌟", texto: "Muy bien, tienes buenos conocimientos", color: "muy-bien" }
        : { emoji: "📚", texto: "Debes repasar un poco más", color: "mejorar" };

    return (
      <div className="vf-pantalla-final">
        <div className="vf-blob vf-blob-1" />
        <div className="vf-blob vf-blob-2" />

        <motion.div
          className="vf-final-card"
          initial={{ opacity: 0, scale: 0.9, y: 20 }}
          animate={{ opacity: 1, scale: 1, y: 0 }}
          transition={{ type: "spring", stiffness: 200, damping: 20 }}
        >
          <motion.div
            className="vf-final-trofeo"
            initial={{ scale: 0, rotate: -180 }}
            animate={{ scale: 1, rotate: 0 }}
            transition={{ delay: 0.3, type: "spring", stiffness: 200 }}
          >
            <Trophy size={56} />
          </motion.div>

          <h1 className="vf-final-titulo">¡Juego terminado!</h1>

          <div className="vf-final-puntaje-wrap">
            <span className="vf-final-puntaje-num">{puntos}</span>
            <span className="vf-final-puntaje-de">/60</span>
          </div>

          <p className={`vf-final-mensaje vf-final-mensaje-${mensaje.color}`}>
            <span className="vf-final-emoji">{mensaje.emoji}</span>
            {mensaje.texto}
          </p>

          <div className="vf-final-progreso-wrap">
            <div className="vf-final-progreso">
              <motion.div
                className="vf-final-progreso-bar"
                initial={{ width: 0 }}
                animate={{ width: `${porcentaje}%` }}
                transition={{ delay: 0.7, duration: 1, ease: "easeOut" }}
              />
            </div>
          </div>

          <div className="vf-final-actions">
            <motion.button
              onClick={volverAJugar}
              className="vf-btn-reintentar"
              whileHover={{ scale: 1.05 }}
              whileTap={{ scale: 0.95 }}
            >
              <Sparkles size={16} />
              Volver a jugar
            </motion.button>
            <motion.button
              onClick={volver}
              className="vf-btn-volver"
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
  // PANTALLA DE JUEGO
  // ═══════════════════════════════════════════════════════════
  return (
    <div className="vf-pagina">
      <div className="vf-blob vf-blob-1" />
      <div className="vf-blob vf-blob-2" />

      <div className="vf-container">
        <motion.button
          onClick={volver}
          className="vf-btn-salir"
          initial={{ opacity: 0, x: -20 }}
          animate={{ opacity: 1, x: 0 }}
          whileHover={{ scale: 1.05 }}
          whileTap={{ scale: 0.95 }}
        >
          <ArrowLeft size={16} />
          Volver
        </motion.button>

        <motion.div
          className="vf-card"
          initial={{ opacity: 0, y: 30 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.5 }}
        >
          <div className="vf-card-header">
            <h1 className="vf-titulo">Verdadero o Falso</h1>

            <div className="vf-header-info">
              <div className="vf-puntaje-badge">
                <Sparkles size={14} />
                <span>Puntaje: {puntos}</span>
              </div>
              <span className="vf-progreso-texto">
                Caso {actual + 1} de {preguntas.length}
              </span>
            </div>

            <div className="vf-progreso-wrap">
              <motion.div
                className="vf-progreso-bar"
                initial={false}
                animate={{ width: `${progreso}%` }}
                transition={{ duration: 0.5, ease: "easeOut" }}
              />
            </div>
          </div>

          <AnimatePresence mode="wait">
            <motion.div
              key={actual}
              initial={{ opacity: 0, x: 30 }}
              animate={{ opacity: 1, x: 0 }}
              exit={{ opacity: 0, x: -30 }}
              transition={{ duration: 0.3 }}
            >
              <div className="vf-situacion">
                <h2 className="vf-situacion-titulo">Situación:</h2>
                <p className="vf-situacion-texto">{preguntas[actual].caso}</p>
              </div>

              <h3 className="vf-pregunta">{preguntas[actual].pregunta}</h3>

              <div className="vf-botones">
                <motion.button
                  onClick={() => responder(true)}
                  className={`vf-btn-opcion ${
                    respuesta === true
                      ? preguntas[actual].respuesta === true
                        ? "correcta"
                        : "incorrecta"
                      : "verdadero"
                  }`}
                  whileHover={respuesta === null ? { scale: 1.05, y: -4 } : {}}
                  whileTap={respuesta === null ? { scale: 0.95 } : {}}
                  disabled={respuesta !== null}
                >
                  <Check size={24} strokeWidth={3} />
                  Verdadero
                </motion.button>

                <motion.button
                  onClick={() => responder(false)}
                  className={`vf-btn-opcion ${
                    respuesta === false
                      ? preguntas[actual].respuesta === false
                        ? "correcta"
                        : "incorrecta"
                      : "falso"
                  }`}
                  whileHover={respuesta === null ? { scale: 1.05, y: -4 } : {}}
                  whileTap={respuesta === null ? { scale: 0.95 } : {}}
                  disabled={respuesta !== null}
                >
                  <X size={24} strokeWidth={3} />
                  Falso
                </motion.button>
              </div>

              <AnimatePresence>
                {respuesta !== null && (
                  <motion.div
                    className="vf-resultado"
                    initial={{ opacity: 0, y: 20, height: 0 }}
                    animate={{ opacity: 1, y: 0, height: "auto" }}
                    exit={{ opacity: 0, height: 0 }}
                    transition={{ duration: 0.3 }}
                  >
                    {respuesta === preguntas[actual].respuesta ? (
                      <p className="vf-resultado-ok">
                        <Check size={20} strokeWidth={3} />
                        ¡Correcto!
                      </p>
                    ) : (
                      <p className="vf-resultado-error">
                        <X size={20} strokeWidth={3} />
                        Incorrecto
                      </p>
                    )}

                    <p className="vf-resultado-respuesta">
                      La respuesta correcta es:{" "}
                      <b>
                        {preguntas[actual].respuesta ? "Verdadero" : "Falso"}
                      </b>
                    </p>
                  </motion.div>
                )}
              </AnimatePresence>
            </motion.div>
          </AnimatePresence>

          <motion.button
            onClick={siguiente}
            disabled={respuesta === null}
            className="vf-btn-siguiente"
            whileHover={respuesta !== null ? { scale: 1.02 } : {}}
            whileTap={respuesta !== null ? { scale: 0.98 } : {}}
          >
            {actual === preguntas.length - 1 ? "Ver resultados" : "Siguiente"}
            <span className="vf-btn-arrow">→</span>
          </motion.button>
        </motion.div>
      </div>
    </div>
  );
}

export default VerdaderoFalso;