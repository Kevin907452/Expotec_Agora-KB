// agoraya/AGORA/src/componentes/MenuPerfil.jsx
import { useState, useRef, useEffect } from "react";
import { Link, useNavigate } from "react-router-dom";
import { motion, AnimatePresence } from "framer-motion";
import { User, LogOut, ChevronDown } from "lucide-react";
import "./MenuPerfil.css";

export function MenuPerfil() {
  const [abierto, setAbierto] = useState(false);
  const navigate = useNavigate();
  const menuRef = useRef(null);

  // Leer usuario del localStorage
  const usuario = (() => {
    try {
      return JSON.parse(localStorage.getItem("usuario") || "null");
    } catch {
      return null;
    }
  })();

  // Cerrar al hacer clic fuera
  useEffect(() => {
    const handleClick = (e) => {
      if (menuRef.current && !menuRef.current.contains(e.target)) {
        setAbierto(false);
      }
    };
    if (abierto) {
      document.addEventListener("mousedown", handleClick);
    }
    return () => document.removeEventListener("mousedown", handleClick);
  }, [abierto]);

  if (!usuario) return null;

  const iniciales = `${usuario.nombre?.[0] || ""}${usuario.apellido?.[0] || ""}`.toUpperCase();

  const handleCerrarSesion = () => {
    localStorage.removeItem("usuario");
    localStorage.removeItem("agora_token");
    navigate("/login");
  };

  return (
    <div className="mp-wrap" ref={menuRef}>
      <button
        className="mp-trigger"
        onClick={() => setAbierto(!abierto)}
        aria-label="Menú de perfil"
        aria-expanded={abierto}
      >
        {usuario.avatar_url ? (
          <img
            src={usuario.avatar_url}
            alt={`${usuario.nombre} ${usuario.apellido}`}
            className="mp-avatar-img"
          />
        ) : (
          <span className="mp-avatar-iniciales">{iniciales}</span>
        )}
        <ChevronDown
          size={14}
          className={`mp-chevron ${abierto ? "mp-chevron--open" : ""}`}
        />
      </button>

      <AnimatePresence>
        {abierto && (
          <motion.div
            className="mp-menu"
            initial={{ opacity: 0, y: -10, scale: 0.95 }}
            animate={{ opacity: 1, y: 0, scale: 1 }}
            exit={{ opacity: 0, y: -10, scale: 0.95 }}
            transition={{ type: "spring", stiffness: 400, damping: 25 }}
          >
            {/* Header del menú */}
            <div className="mp-header">
              <div className="mp-header-avatar">
                {usuario.avatar_url ? (
                  <img src={usuario.avatar_url} alt="Avatar" />
                ) : (
                  <span>{iniciales}</span>
                )}
              </div>
              <div className="mp-header-info">
                <p className="mp-header-nombre">
                  {usuario.nombre} {usuario.apellido}
                </p>
                <p className="mp-header-correo">{usuario.correo}</p>
                <span className={`mp-header-rol mp-rol-${usuario.rol}`}>
                  {usuario.rol}
                </span>
              </div>
            </div>

            {/* Separador */}
            <div className="mp-sep" />

            {/* Acciones */}
            <div className="mp-items">
              <Link
                to="/perfil"
                className="mp-item"
                onClick={() => setAbierto(false)}
              >
                <User size={18} />
                <span>Mi perfil</span>
              </Link>

              <button
                className="mp-item mp-item-danger"
                onClick={handleCerrarSesion}
              >
                <LogOut size={18} />
                <span>Cerrar sesión</span>
              </button>
            </div>
          </motion.div>
        )}
      </AnimatePresence>
    </div>
  );
}

export default MenuPerfil;