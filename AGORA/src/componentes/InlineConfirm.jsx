// agoraya/AGORA/src/componentes/InlineConfirm.jsx
// Basado en el InlineConfirm de Bencho (bencho.dev/licence — MIT)
// Adaptado a la paleta y tipografía de Ágora
import { useEffect, useRef, useState } from "react";
import { AnimatePresence, motion } from "framer-motion";
import { Check, Trash2, Undo2 } from "lucide-react";
import "./InlineConfirm.css";

const clamp = (v, a, b) => Math.min(b, Math.max(a, v));
const hold = (e) => e.stopPropagation();

/* ══ Confirm in place ═══════════════════════════════════
   El botón se vuelve su propio diálogo. No se abre nada
   encima de la página, no se mueve nada alrededor, y la
   decisión queda bajo el cursor que la pidió — un modal
   mueve tu atención a otro lado para responder una
   pregunta que acabás de hacer acá.

   Undo vive en el mismo espacio, en un timer, así que el
   camino destructivo nunca necesita un toast tampoco. */

const GRACE = 4000;
const SAY_CORNER = 22;
const SAY_W = 260;
const SAY_IDLE = 112;
const SAY_DONE = 206;

export function InlineConfirm({ corner = SAY_CORNER, onConfirm } = {}) {
  const [phase, setPhase] = useState("idle");
  const timer = useRef(undefined);

  useEffect(() => () => window.clearTimeout(timer.current), []);

  const commit = () => {
    setPhase("done");
    timer.current = window.setTimeout(() => {
      setPhase("idle");
      if (onConfirm) onConfirm();
    }, GRACE);
  };

  const undo = () => {
    window.clearTimeout(timer.current);
    setPhase("idle");
  };

  const done = phase === "done";
  const w = done ? SAY_DONE : SAY_IDLE;
  const left = (SAY_W - w) / 2;
  const spring = done
    ? { type: "spring", stiffness: 420, damping: 20, mass: 0.9 }
    : { type: "spring", stiffness: 460, damping: 30, mass: 0.9 };
  const r = clamp(corner, 0, SAY_CORNER);

  return (
    <div
      className="say-well"
      data-phase={phase}
      style={{ "--say-r": `${r}px` }}
    >
      <motion.span
        className="say-body"
        initial={false}
        animate={{ left, width: w }}
        transition={spring}
      />

      <AnimatePresence initial={false}>
        {!done && (
          <motion.button
            key="idle"
            className="say-face"
            style={{ left, width: w }}
            initial={{ opacity: 0 }}
            animate={{ opacity: 1, transition: { duration: 0.18, delay: 0.08 } }}
            exit={{ opacity: 0, transition: { duration: 0.08 } }}
            onClick={commit}
            onPointerDown={hold}
          >
            <Trash2 size={15} strokeWidth={2} />
            Eliminar
          </motion.button>
        )}

        {done && (
          <motion.div
            key="done"
            className="say-merged"
            style={{ left, width: w }}
            initial={{ opacity: 0 }}
            animate={{ opacity: 1, transition: { duration: 0.2, delay: 0.1 } }}
            exit={{ opacity: 0, transition: { duration: 0.08 } }}
          >
            <span className="say-done">
              <Check size={14} strokeWidth={2} />
              Eliminado
            </span>
            <button className="say-undo" onClick={undo} onPointerDown={hold}>
              <Undo2 size={13} strokeWidth={2} />
              Deshacer
            </button>
            <i
              className="say-fuse"
              style={{ animationDuration: `${GRACE}ms` }}
            />
          </motion.div>
        )}
      </AnimatePresence>
    </div>
  );
}

export default InlineConfirm;