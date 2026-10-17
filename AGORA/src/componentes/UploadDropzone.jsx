// agoraya/AGORA/src/componentes/UploadDropzone.jsx
// Híbrido: animación RADICAL de Bencho (bencho.dev/licence — MIT)
// + subida real de imagen para Ágora
import { useEffect, useLayoutEffect, useRef, useState } from "react";
import { motion, useAnimationControls } from "framer-motion";
import { Check, Upload as UpIcon, X, Image as ImageIcon } from "lucide-react";
import "./UploadDropzone.css";

const MAX_MB = 5;
const TIPOS = ["image/png", "image/jpeg", "image/webp"];
const MAX_DIM = 1200;

/* ══ Upload dropzone ══════════════════════════════════════
   Con la animación radical de Bencho:
   - El cuadro INHALA cuando arrastrás encima
   - Al soltar, el archivo es SUCCIONADO al centro
   - El cuadro da un GULP cuando termina
   - Aparece un TICK verde al completarse

   Pero SÍ sube imágenes reales: redimensiona, convierte a
   base64 y devuelve al padre con onImageSelected. */

const stillness = () =>
  typeof window !== "undefined" &&
  !!window.matchMedia?.("(prefers-reduced-motion: reduce)").matches;

const clamp = (v, a, b) => Math.min(b, Math.max(a, v));

function Page({ size = 40, tint = "#8d7be8" }) {
  return (
    <svg
      className="upl-page"
      width={size}
      height={size}
      viewBox="0 0 40 40"
      fill="none"
      aria-hidden="true"
    >
      <path
        className="upl-page-line"
        d="M7.75 4A3.25 3.25 0 0 1 11 .75h16c.121 0 .238.048.323.134l10.793 10.793a.46.46 0 0 1 .134.323v24A3.25 3.25 0 0 1 35 39.25H11A3.25 3.25 0 0 1 7.75 36z"
      />
      <path className="upl-page-line" d="M27 .5V8a4 4 0 0 0 4 4h7.5" />
      <rect width="29" height="16" x="1" y="18" rx="8" fill={tint} />
      <text x="15.5" y="29.3" textAnchor="middle" className="upl-page-ext">
        IMG
      </text>
    </svg>
  );
}

function Roll({ value }) {
  const s = String(Math.round(value));
  return (
    <span className="upl-roll" aria-label={`${s}%`}>
      {s.split("").map((d, i) => (
        <span key={s.length - i} className="upl-roll-col">
          <span
            className="upl-roll-strip"
            style={{ transform: `translateY(${-Number(d)}em)` }}
          >
            {"0123456789".split("").map((n) => (
              <span key={n}>{n}</span>
            ))}
          </span>
        </span>
      ))}
      %
    </span>
  );
}

export function UploadDropzone({ initialImage = null, onImageSelected }) {
  const still = stillness();
  const inputRef = useRef(null);
  const zone = useRef(null);
  const now = useRef(null);
  const tiles = useRef({});
  const shake = useAnimationControls();
  const raf = useRef(0);
  const timers = useRef([]);

  const [imagen, setImagen] = useState(initialImage);
  const [dragging, setDragging] = useState(false);
  const [phase, setPhase] = useState({ kind: "idle" });
  const [inBox, setInBox] = useState(false);
  const [held, setHeld] = useState(false);
  const [over, setOver] = useState(false);
  const [refuse, setRefuse] = useState(null);
  const [gulp, setGulp] = useState(false);
  const drag = useRef(null);

  useEffect(
    () => () => {
      cancelAnimationFrame(raf.current);
      timers.current.forEach(clearTimeout);
    },
    []
  );

  const later = (fn, ms) => {
    timers.current.push(window.setTimeout(fn, ms));
  };

  /* ── Subida real (redimensiona, convierte a base64) ── */
  const procesarArchivo = (archivo) => {
    setRefuse(null);

    if (!TIPOS.includes(archivo.type)) {
      setRefuse("Solo PNG, JPG o WebP");
      shake.start({ x: [0, -7, 6, -4, 2, 0], transition: { duration: 0.38 } });
      later(() => setRefuse(null), 2000);
      return;
    }

    if (archivo.size > MAX_MB * 1024 * 1024) {
      setRefuse(`Máx ${MAX_MB} MB`);
      shake.start({ x: [0, -7, 6, -4, 2, 0], transition: { duration: 0.38 } });
      later(() => setRefuse(null), 2000);
      return;
    }

    // Leer archivo y procesar
    const reader = new FileReader();
    reader.onload = (e) => {
      const img = new Image();
      img.onload = () => {
        const canvas = document.createElement("canvas");
        let w = img.width;
        let h = img.height;

        if (w > h && w > MAX_DIM) {
          h = (h * MAX_DIM) / w;
          w = MAX_DIM;
        } else if (h > MAX_DIM) {
          w = (w * MAX_DIM) / h;
          h = MAX_DIM;
        }

        canvas.width = w;
        canvas.height = h;
        canvas.getContext("2d").drawImage(img, 0, 0, w, h);
        const dataUrl = canvas.toDataURL("image/jpeg", 0.85);

        // Iniciar animación de subida
        send(dataUrl);
      };
      img.src = e.target.result;
    };
    reader.readAsDataURL(archivo);
  };

  /* ── Animación de subida ── */
  const send = (dataUrl) => {
    if (still) {
      setImagen(dataUrl);
      setPhase({ kind: "idle" });
      if (onImageSelected) onImageSelected(dataUrl);
      return;
    }

    setInBox(true);
    setPhase({ kind: "up", p: 0 });

    let p = 0;
    let prev = 0;
    const secs = 1.8;
    const tick = (t) => {
      const dt = prev ? Math.min(0.05, (t - prev) / 1000) : 0;
      prev = t;
      p = Math.min(1, p + (dt / secs) * (0.5 + Math.random() * 1));
      if (p >= 1) {
        raf.current = 0;
        finish(dataUrl);
        return;
      }
      setPhase({ kind: "up", p });
      raf.current = requestAnimationFrame(tick);
    };
    raf.current = requestAnimationFrame(tick);
  };

  const finish = (dataUrl) => {
    setPhase({ kind: "done" });
    later(() => {
      setGulp(true);
      later(() => setGulp(false), 460);
    }, 50);
    later(() => {
      setImagen(dataUrl);
      setPhase({ kind: "idle" });
      setInBox(false);
      if (onImageSelected) onImageSelected(dataUrl);
    }, 500);
  };

  /* ── Drag handlers (para el archivo real) ── */
  const handleDrop = (e) => {
    e.preventDefault();
    setDragging(false);
    setOver(false);
    const archivo = e.dataTransfer.files?.[0];
    if (archivo) {
      // Simular la succión
      suckAndProcess(archivo);
    }
  };

  const suckAndProcess = (archivo) => {
    // Animación de gulp antes de procesar
    setGulp(true);
    later(() => setGulp(false), 460);
    later(() => procesarArchivo(archivo), 200);
  };

  const handleFileInput = (e) => {
    const archivo = e.target.files?.[0];
    if (archivo) suckAndProcess(archivo);
    e.target.value = "";
  };

  const eliminarImagen = () => {
    setImagen(null);
    if (onImageSelected) onImageSelected(null);
  };

  /* ── El cuadro se ajusta al contenido ── */
  useLayoutEffect(() => {
    const z = zone.current;
    const n = now.current;
    if (!z) return;
    if (phase.kind === "idle" || !n) {
      z.style.width = "";
      z.style.height = "";
      return;
    }
    z.style.width = `${n.offsetWidth + 32}px`;
    z.style.height = `${n.offsetHeight + 28}px`;
  }, [phase.kind]);

  const busy = phase.kind === "up";
  const done = phase.kind === "done";

  return (
    <div className="upl-wrap">
      <motion.div animate={shake} className="upl-zone-wrap">
        <div
          ref={zone}
          className="upl-zone"
          data-dragging={dragging || undefined}
          data-over={over || undefined}
          data-refuse={refuse ? true : undefined}
          data-preview={imagen && !busy && !done ? true : undefined}
          data-busy={busy || undefined}
          data-done={done || undefined}
          data-gulp={gulp || undefined}
          onClick={() => {
            if (!imagen && !busy && !done) inputRef.current?.click();
          }}
          onDragOver={(e) => {
            e.preventDefault();
            setDragging(true);
            setOver(true);
          }}
          onDragLeave={() => {
            setDragging(false);
            setOver(false);
          }}
          onDrop={handleDrop}
        >
          {busy ? (
            /* Estado: subiendo */
            <>
              <div className="upl-icon">
                <UpIcon size={18} strokeWidth={2} />
              </div>
              <div className="upl-say">
                <b>Subiendo imagen...</b>
                <Roll value={phase.p * 100} />
              </div>
              <div className="upl-track">
                <div
                  className="upl-bar"
                  style={{ transform: `scaleX(${phase.p})` }}
                />
              </div>
            </>
          ) : done ? (
            /* Estado: completado con tick */
            <>
              <div className="upl-icon upl-icon-ok">
                <Check size={22} strokeWidth={3} />
              </div>
              <div className="upl-say">
                <b>¡Listo!</b>
                <span>Imagen cargada</span>
              </div>
            </>
          ) : imagen ? (
            /* Estado: preview con hover */
            <>
              <img src={imagen} alt="Bandera" className="upl-preview" />
              <div className="upl-overlay">
                <button
                  type="button"
                  className="upl-overlay-btn"
                  onClick={(e) => {
                    e.stopPropagation();
                    inputRef.current?.click();
                  }}
                  aria-label="Cambiar imagen"
                >
                  <ImageIcon size={18} />
                </button>
                <button
                  type="button"
                  className="upl-overlay-btn upl-overlay-btn--danger"
                  onClick={(e) => {
                    e.stopPropagation();
                    eliminarImagen();
                  }}
                  aria-label="Eliminar"
                >
                  <X size={18} />
                </button>
              </div>
              <span className="upl-tick-overlay">
                <span className="upl-tick">
                  <Check size={14} strokeWidth={3} />
                </span>
              </span>
            </>
          ) : (
            /* Estado: idle */
            <>
              <div className="upl-icon">
                <UpIcon size={18} strokeWidth={2} />
              </div>
              <div className="upl-say">
                <b>
                  {refuse ??
                    (over ? "Soltá para subir" : "Arrastrá un archivo acá")}
                </b>
                <span>o hacé clic · hasta {MAX_MB} MB</span>
              </div>
            </>
          )}

          <input
            ref={inputRef}
            type="file"
            accept="image/png,image/jpeg,image/webp"
            onChange={handleFileInput}
            style={{ display: "none" }}
          />
        </div>
      </motion.div>

      {refuse && !busy && !done && !imagen && (
        <motion.p
          className="upl-error"
          initial={{ opacity: 0, y: -10 }}
          animate={{ opacity: 1, y: 0 }}
        >
          {refuse}
        </motion.p>
      )}
    </div>
  );
}

export default UploadDropzone;