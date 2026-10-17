// agoraya/AGORA/src/componentes/juegos/Memoria.jsx
import { useState } from "react";
import { motion, AnimatePresence } from "framer-motion";
import { ArrowLeft, Sparkles, Trophy } from "lucide-react";
import "./Memoria.css";

import democracia from "./iconos/democracia.png";
import voto from "./iconos/voto.png";
import justicia from "./iconos/justicia.png";
import ley from "./iconos/ley.png";
import ciudadano from "./iconos/ciudadano.png";
import gobierno from "./iconos/gobierno.png";
import participacion from "./iconos/participacion.png";
import constitucion from "./iconos/constitucion.png";

const cartasIniciales = [
  { id: 1, nombre: "Democracia", icono: democracia },
  { id: 2, nombre: "Democracia", icono: democracia },
  { id: 3, nombre: "Voto", icono: voto },
  { id: 4, nombre: "Voto", icono: voto },
  { id: 5, nombre: "Justicia", icono: justicia },
  { id: 6, nombre: "Justicia", icono: justicia },
  { id: 7, nombre: "Ley", icono: ley },
  { id: 8, nombre: "Ley", icono: ley },
  { id: 9, nombre: "Ciudadano", icono: ciudadano },
  { id: 10, nombre: "Ciudadano", icono: ciudadano },
  { id: 11, nombre: "Gobierno", icono: gobierno },
  { id: 12, nombre: "Gobierno", icono: gobierno },
  { id: 13, nombre: "Participación", icono: participacion },
  { id: 14, nombre: "Participación", icono: participacion },
  { id: 15, nombre: "Constitución", icono: constitucion },
  { id: 16, nombre: "Constitución", icono: constitucion },
];

function Memoria({ volver }) {
  const [cartas, setCartas] = useState(() =>
    [...cartasIniciales].sort(() => Math.random() - 0.5)
  );
  const [seleccionadas, setSeleccionadas] = useState([]);
  const [bloqueadas, setBloqueadas] = useState([]);
  const [bloqueo, setBloqueo] = useState(false);
  const [parejasEncontradas, setParejasEncontradas] = useState(0);
  const [ganador, setGanador] = useState(false);

  function volverAJugar() {
    setCartas([...cartasIniciales].sort(() => Math.random() - 0.5));
    setSeleccionadas([]);
    setBloqueadas([]);
    setParejasEncontradas(0);
    setGanador(false);
  }

  function elegirCarta(carta) {
    if (
      bloqueo ||
      seleccionadas.length === 2 ||
      bloqueadas.includes(carta.id)
    ) {
      return;
    }

    const nuevas = [...seleccionadas, carta];
    setSeleccionadas(nuevas);

    if (nuevas.length === 2) {
      if (nuevas[0].nombre === nuevas[1].nombre) {
        const nuevasBloqueadas = [...bloqueadas, nuevas[0].id, nuevas[1].id];
        setBloqueadas(nuevasBloqueadas);
        setParejasEncontradas(parejasEncontradas + 1);
        setSeleccionadas([]);

        if (parejasEncontradas + 1 === 8) {
          setTimeout(() => setGanador(true), 500);
        }
      } else {
        setBloqueo(true);
        setTimeout(() => {
          setSeleccionadas([]);
          setBloqueo(false);
        }, 1000);
      }
    }
  }

  const progreso = (parejasEncontradas / 8) * 100;

  // ═══════════════════════════════════════════════════════════
  // PANTALLA DE GANADOR
  // ═══════════════════════════════════════════════════════════
  if (ganador) {
    return (
      <div className="mj-pantalla-final">
        <div className="mj-blob mj-blob-1" />
        <div className="mj-blob mj-blob-2" />

        <motion.div
          className="mj-final-card"
          initial={{ opacity: 0, scale: 0.9, y: 20 }}
          animate={{ opacity: 1, scale: 1, y: 0 }}
          transition={{ type: "spring", stiffness: 200, damping: 20 }}
        >
          <motion.div
            className="mj-final-trofeo"
            initial={{ scale: 0, rotate: -180 }}
            animate={{ scale: 1, rotate: 0 }}
            transition={{ delay: 0.3, type: "spring", stiffness: 200 }}
          >
            <Trophy size={56} />
          </motion.div>

          <h1 className="mj-final-titulo">¡Felicidades!</h1>
          <p className="mj-final-mensaje">
            Encontraste las <b>8 parejas</b> en tiempo récord
          </p>

          <div className="mj-final-actions">
            <motion.button
              onClick={volverAJugar}
              className="mj-btn-reintentar"
              whileHover={{ scale: 1.05 }}
              whileTap={{ scale: 0.95 }}
            >
              <Sparkles size={16} />
              Volver a jugar
            </motion.button>
            <motion.button
              onClick={volver}
              className="mj-btn-volver"
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
    <div className="mj-pagina">
      <div className="mj-blob mj-blob-1" />
      <div className="mj-blob mj-blob-2" />

      <div className="mj-container">
        <motion.button
          onClick={volver}
          className="mj-btn-salir"
          initial={{ opacity: 0, x: -20 }}
          animate={{ opacity: 1, x: 0 }}
          whileHover={{ scale: 1.05 }}
          whileTap={{ scale: 0.95 }}
        >
          <ArrowLeft size={16} />
          Volver
        </motion.button>

        <motion.div
          className="mj-card"
          initial={{ opacity: 0, y: 30 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.5 }}
        >
          <div className="mj-card-header">
            <h1 className="mj-titulo">Memoria Ciudadana</h1>
            <div className="mj-header-info">
              <div className="mj-contador-badge">
                <Sparkles size={14} />
                <span>
                  Parejas: {parejasEncontradas}/8
                </span>
              </div>
            </div>
            <div className="mj-progreso-wrap">
              <motion.div
                className="mj-progreso-bar"
                initial={false}
                animate={{ width: `${progreso}%` }}
                transition={{ duration: 0.5, ease: "easeOut" }}
              />
            </div>
          </div>

          <div className="mj-grid">
            {cartas.map((carta, index) => {
              const estaSeleccionada = seleccionadas.includes(carta);
              const estaBloqueada = bloqueadas.includes(carta.id);
              const visible = estaSeleccionada || estaBloqueada;

              return (
                <motion.button
                  key={carta.id}
                  onClick={() => elegirCarta(carta)}
                  className={`mj-carta ${
                    estaBloqueada ? "bloqueada" : ""
                  } ${estaSeleccionada ? "seleccionada" : ""}`}
                  initial={{ opacity: 0, scale: 0.5, rotateY: 180 }}
                  animate={{ opacity: 1, scale: 1, rotateY: 0 }}
                  transition={{
                    delay: index * 0.03,
                    type: "spring",
                    stiffness: 200,
                    damping: 20,
                  }}
                  whileHover={!visible ? { scale: 1.08, y: -4 } : {}}
                  whileTap={!visible ? { scale: 0.95 } : {}}
                  disabled={visible}
                >
                  <AnimatePresence mode="wait">
                    {visible ? (
                      <motion.img
                        key="img"
                        src={carta.icono}
                        alt={carta.nombre}
                        className="mj-carta-img"
                        initial={{ opacity: 0, rotateY: 90 }}
                        animate={{ opacity: 1, rotateY: 0 }}
                        transition={{ duration: 0.3 }}
                      />
                    ) : (
                      <motion.span
                        key="question"
                        className="mj-carta-question"
                        initial={{ opacity: 0 }}
                        animate={{ opacity: 1 }}
                        transition={{ duration: 0.2 }}
                      >
                        ?
                      </motion.span>
                    )}
                  </AnimatePresence>
                </motion.button>
              );
            })}
          </div>
        </motion.div>
      </div>
    </div>
  );
}

export default Memoria;