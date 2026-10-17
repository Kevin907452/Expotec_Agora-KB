// agoraya/AGORA/src/componentes/Like.jsx
import { useState } from "react";
import { AnimatePresence, motion } from "framer-motion";
import { Heart } from "lucide-react";
import "./Like.css";

const H = 40;
const RED = "#e5484d";
const CONFETTI = ["#e3b3ed", "#c1fff4", "#b3bbde", "#f0c15c", "#9571dd"];

const fmt = (n) => n.toLocaleString("es-CR");

function Roll({ value, up }) {
  const chars = String(value).split("");
  return (
    <span className="lk-count">
      {chars.map((c, i) => {
        const place = chars.length - 1 - i;
        return (
          <span key={`p${place}`} className="lk-wheel">
            <AnimatePresence initial={false} mode="popLayout">
              <motion.span
                key={c}
                className="lk-digit"
                initial={{ y: up ? "100%" : "-100%", opacity: 0 }}
                animate={{ y: "0%", opacity: 1 }}
                exit={{ y: up ? "-100%" : "100%", opacity: 0 }}
                transition={{ duration: 0.4, ease: [0.22, 1, 0.36, 1], delay: place * 0.04 }}
              >
                {c}
              </motion.span>
            </AnimatePresence>
          </span>
        );
      })}
    </span>
  );
}

function Burst({ beat }) {
  return (
    <>
      <span className="lk-bloom" key={`bloom-${beat}`} />
      {Array.from({ length: 7 }, (_, k) => (
        <span
          key={`spoke-${beat}-${k}`}
          className="lk-spoke"
          style={{ "--a": `${k * (360 / 7) - 90}deg` }}
        >
          <i style={{ "--c": CONFETTI[k % CONFETTI.length] }} />
          <i style={{ "--c": CONFETTI[(k + 2) % CONFETTI.length] }} />
        </span>
      ))}
    </>
  );
}

export function Like({ start = 0, initialLiked = false, onChange }) {
  const [liked, setLiked] = useState(initialLiked);
  const [beat, setBeat] = useState(0);
  const count = start + (liked && !initialLiked ? 1 : 0) - (!liked && initialLiked ? 1 : 0);

  const press = async () => {
    const next = !liked;
    setLiked(next);
    if (next) setBeat((b) => b + 1);

    if (onChange) {
      try {
        await onChange(next);
      } catch {
        setLiked(!next);
      }
    }
  };

  return (
    <div className="lk-frame">
      <button
        type="button"
        className="lk"
        data-liked={liked || undefined}
        aria-pressed={liked}
        aria-label={`Me gusta. ${fmt(count)} likes`}
        style={{ height: H, "--lk-on": RED }}
        onClick={press}
      >
        <span className="lk-heart">
          <span key={liked ? `on${beat}` : "off"} className="lk-glyph" data-on={liked || undefined}>
            <Heart size={18} strokeWidth={2.3} fill={liked ? "currentColor" : "none"} />
          </span>
          {liked && (
            <span key={beat} className="lk-burst" aria-hidden="true">
              <Burst beat={beat} />
            </span>
          )}
        </span>
        <Roll value={count} up={liked} />
      </button>
    </div>
  );
}

export default Like;