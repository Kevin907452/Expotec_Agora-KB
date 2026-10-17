// agoraya/AGORA/src/componentes/login.jsx
import { useState } from "react";
import { useNavigate, Link } from "react-router-dom";
import { motion, AnimatePresence } from "framer-motion";
import { GoogleLogin } from "@react-oauth/google";
import { Mail, Lock, User, Eye, EyeOff, ArrowLeft, ArrowRight, Sparkles } from "lucide-react";
import Swal from "sweetalert2";
import "./Login.css";
import agorita from "../assets/agorita.png";
import logoA from "../assets/logoA.png";

// ═══════════════════════════════════════════════════════════
// TRANSICIÓN DEL SPLIT-SCREEN (CORREGIDO)
// ═══════════════════════════════════════════════════════════
const DURACION = 0.8;
const EASE = [0.76, 0, 0.24, 1];

const visualVariants = {
  login: { x: "0%" },
  registro: { x: "100%" },
};

const formVariants = {
  login: { x: "100%" },   // ⬅️ CAMBIO
  registro: { x: "0%" },   // ⬅️ CAMBIO
};

// ═══════════════════════════════════════════════════════════
// RESTO DEL COMPONENTE IGUAL
// ═══════════════════════════════════════════════════════════
function Login() {
  const navigate = useNavigate();
  const [modo, setModo] = useState("login"); // "login" | "registro"

  const [nombre, setNombre] = useState("");
  const [apellido, setApellido] = useState("");
  const [correo, setCorreo] = useState("");
  const [contrasena, setContrasena] = useState("");
  const [confirmarContrasena, setConfirmarContrasena] = useState("");
  const [mostrarPass, setMostrarPass] = useState(false);

  const [loading, setLoading] = useState(false);
  const [error, setError] = useState("");

  // ═══════════════════════════════════════════════════════════
  // CAMBIAR MODO
  // ═══════════════════════════════════════════════════════════
  const cambiarModo = (nuevoModo) => {
    if (nuevoModo === modo) return;
    setModo(nuevoModo);
    setError("");
    setNombre("");
    setApellido("");
    setCorreo("");
    setContrasena("");
    setConfirmarContrasena("");
  };

  // ═══════════════════════════════════════════════════════════
  // REDIRIGIR SEGÚN ROL
  // ═══════════════════════════════════════════════════════════
  const redirigirSegunRol = (rol) => {
    if (rol === "profesor" || rol === "administrador") {
      navigate("/indexprofesor");
    } else {
      navigate("/indexestudiante");
    }
  };

  // ═══════════════════════════════════════════════════════════
  // REGISTRO
  // ═══════════════════════════════════════════════════════════
  const handleRegistro = async (e) => {
    e.preventDefault();
    setError("");

    if (!nombre.trim() || !apellido.trim() || !correo.trim() || !contrasena.trim()) {
      setError("Por favor completá todos los campos.");
      return;
    }
    if (contrasena.length < 6) {
      setError("La contraseña debe tener al menos 6 caracteres.");
      return;
    }
    if (contrasena !== confirmarContrasena) {
      setError("Las contraseñas no coinciden.");
      return;
    }

    try {
      setLoading(true);
      const res = await fetch("http://localhost:3000/api/usuarios", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          nombre: nombre.trim(),
          apellido: apellido.trim(),
          correo: correo.trim(),
          contrasena,
          rol: "estudiante",
        }),
      });
      const data = await res.json();
      if (!res.ok) throw new Error(data.mensaje || "No se pudo crear la cuenta.");

      // Auto-login
      const loginRes = await fetch("http://localhost:3000/api/login", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ correo: correo.trim(), contrasena }),
      });
      const loginData = await loginRes.json();

      if (loginRes.ok && loginData.usuario) {
        localStorage.setItem("usuario", JSON.stringify(loginData.usuario));
        if (loginData.token) localStorage.setItem("agora_token", loginData.token);
      }

      Swal.fire({
        title: "¡Cuenta creada!",
        text: "Bienvenido a Ágora",
        icon: "success",
        timer: 2000,
        showConfirmButton: false,
        background: "#fef8ed",
        color: "#4a386d",
      });

      setTimeout(() => redirigirSegunRol("estudiante"), 1000);
    } catch (err) {
      setError(err.message || "No se pudo conectar con el servidor.");
    } finally {
      setLoading(false);
    }
  };

  // ═══════════════════════════════════════════════════════════
  // LOGIN
  // ═══════════════════════════════════════════════════════════
  const handleLogin = async (e) => {
    e.preventDefault();
    setError("");

    if (!correo.trim() || !contrasena.trim()) {
      setError("Ingresá tu correo y contraseña.");
      return;
    }

    try {
      setLoading(true);
      const res = await fetch("http://localhost:3000/api/login", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ correo: correo.trim(), contrasena }),
      });
      const data = await res.json();
      if (!res.ok) throw new Error(data.mensaje || "Correo o contraseña incorrectos.");

      localStorage.setItem("usuario", JSON.stringify(data.usuario));
      if (data.token) localStorage.setItem("agora_token", data.token);

      redirigirSegunRol(data.usuario.rol);
    } catch (err) {
      setError(err.message || "No se pudo iniciar sesión.");
    } finally {
      setLoading(false);
    }
  };

  // ═══════════════════════════════════════════════════════════
  // GOOGLE LOGIN
  // ═══════════════════════════════════════════════════════════
  const handleGoogleSuccess = async (credentialResponse) => {
    try {
      setLoading(true);
      const res = await fetch("http://localhost:3000/api/google-login", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ credential: credentialResponse.credential }),
      });
      const data = await res.json();
      if (!res.ok) throw new Error(data.mensaje || "No se pudo iniciar con Google.");

      localStorage.setItem("usuario", JSON.stringify(data.usuario));
      if (data.token) localStorage.setItem("agora_token", data.token);

      Swal.fire({
        title: "¡Bienvenido!",
        text: `Hola ${data.usuario.nombre}`,
        icon: "success",
        timer: 2000,
        showConfirmButton: false,
        background: "#fef8ed",
        color: "#4a386d",
      });

      setTimeout(() => redirigirSegunRol(data.usuario.rol), 1000);
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
      setLoading(false);
    }
  };

  return (
    <div className="login-page">
      {/* Botón volver */}
      <Link to="/" className="login-volver">
        <ArrowLeft size={18} />
        Volver al inicio
      </Link>

      {/* Card principal */}
      <div className="login-card">

        {/* ═══════════════════════════════════════════════════════════
            PANEL VISUAL — Se desliza entre izquierda y derecha
            ═══════════════════════════════════════════════════════════ */}
        <motion.div
          className="login-visual"
          variants={visualVariants}
          initial="login"
          animate={modo}
          transition={{ duration: DURACION, ease: EASE }}
        >
          {/* Blobs de fondo */}
          <div className="login-visual-shape login-visual-shape-1" />
          <div className="login-visual-shape login-visual-shape-2" />
          <div className="login-visual-shape login-visual-shape-3" />
          <div className="login-visual-shape login-visual-shape-4" />

          <div className="login-visual-content">
            <AnimatePresence mode="wait">
              <motion.div
                key={modo}
                initial={{ opacity: 0, y: 20 }}
                animate={{ opacity: 1, y: 0 }}
                exit={{ opacity: 0, y: -20 }}
                transition={{ duration: 0.5, delay: 0.3 }}
                className="login-visual-inner"
              >
                {/* Logo */}
                <div className="login-visual-logo">
                  <img src={logoA} alt="Ágora" />
                  <span>Ágora</span>
                </div>

                {/* Título grande */}
                <h1 className="login-visual-titulo">
                  {modo === "login" ? (
                    <>
                      Qué bueno
                      <br />
                      <span>verte de nuevo</span>
                    </>
                  ) : (
                    <>
                      Tu voz
                      <br />
                      <span>importa</span>
                    </>
                  )}
                </h1>

                <p className="login-visual-subtitulo">
                  {modo === "login"
                    ? "Entrá y seguí participando en la comunidad"
                    : "Sumate y empezá a construir el futuro"}
                </p>

                {/* Mascota */}
                <div className="login-visual-mascota">
                  <img src={agorita} alt="Agorita" />
                </div>

                {/* Badges */}
                <div className="login-visual-badges">
                  <div className="login-visual-badge">
                    <Sparkles size={14} />
                    <span>Aprendé jugando</span>
                  </div>
                </div>
              </motion.div>
            </AnimatePresence>
          </div>
        </motion.div>

        {/* ═══════════════════════════════════════════════════════════
            PANEL FORMULARIO — Se desliza al lado contrario
            ═══════════════════════════════════════════════════════════ */}
        <motion.div
          className="login-form-panel"
          variants={formVariants}
          initial="login"
          animate={modo}
          transition={{ duration: DURACION, ease: EASE }}
        >
          <div className="login-form-container">
            <AnimatePresence mode="wait">
              <motion.div
                key={modo}
                initial={{ opacity: 0 }}
                animate={{ opacity: 1 }}
                exit={{ opacity: 0 }}
                transition={{ duration: 0.4, delay: 0.35 }}
                className="login-form-inner"
              >
                {/* Header */}
                <div className="login-form-header">
                  <h2>
                    {modo === "login" ? (
                      <>
                        Bienvenido a <span>Ágora</span>
                      </>
                    ) : (
                      <>
                        Creá tu <span>cuenta</span>
                      </>
                    )}
                  </h2>
                  <p>
                    {modo === "login"
                      ? "Ingresá tus datos para continuar"
                      : "Completá tus datos y empezá ahora"}
                  </p>
                </div>

                {/* Formulario */}
                <form
                  onSubmit={modo === "login" ? handleLogin : handleRegistro}
                  className="login-form"
                >
                  {modo === "registro" && (
                    <div className="login-form-row">
                      <div className="login-input">
                        <User size={18} className="login-input-icon" />
                        <input
                          type="text"
                          placeholder="Nombre"
                          value={nombre}
                          onChange={(e) => setNombre(e.target.value)}
                          required
                          autoComplete="off"
                        />
                      </div>
                      <div className="login-input">
                        <User size={18} className="login-input-icon" />
                        <input
                          type="text"
                          placeholder="Apellido"
                          value={apellido}
                          onChange={(e) => setApellido(e.target.value)}
                          required
                          autoComplete="off"
                        />
                      </div>
                    </div>
                  )}

                  <div className="login-input">
                    <Mail size={18} className="login-input-icon" />
                    <input
                      type="email"
                      placeholder="Correo electrónico"
                      value={correo}
                      onChange={(e) => setCorreo(e.target.value)}
                      required
                      autoComplete="off"
                    />
                  </div>

                  <div className="login-input">
                    <Lock size={18} className="login-input-icon" />
                    <input
                      type={mostrarPass ? "text" : "password"}
                      placeholder="Contraseña"
                      value={contrasena}
                      onChange={(e) => setContrasena(e.target.value)}
                      required
                      minLength={6}
                      autoComplete="off"
                      style={{ paddingRight: 46 }}
                    />
                    <button
                      type="button"
                      className="login-input-eye"
                      onClick={() => setMostrarPass(!mostrarPass)}
                      tabIndex={-1}
                      aria-label={mostrarPass ? "Ocultar contraseña" : "Mostrar contraseña"}
                    >
                      {mostrarPass ? <EyeOff size={18} /> : <Eye size={18} />}
                    </button>
                  </div>

                  {modo === "registro" && (
                    <div className="login-input">
                      <Lock size={18} className="login-input-icon" />
                      <input
                        type={mostrarPass ? "text" : "password"}
                        placeholder="Confirmar contraseña"
                        value={confirmarContrasena}
                        onChange={(e) => setConfirmarContrasena(e.target.value)}
                        required
                        autoComplete="off"
                      />
                    </div>
                  )}

                  {/* Mensaje de error */}
                  <AnimatePresence>
                    {error && (
                      <motion.div
                        className="login-mensaje login-mensaje--error"
                        initial={{ opacity: 0, y: -10 }}
                        animate={{ opacity: 1, y: 0 }}
                        exit={{ opacity: 0, y: -10 }}
                      >
                        {error}
                      </motion.div>
                    )}
                  </AnimatePresence>

                  {/* Botón principal */}
                  <motion.button
                    type="submit"
                    className="login-submit"
                    disabled={loading}
                    whileHover={{ scale: loading ? 1 : 1.02 }}
                    whileTap={{ scale: loading ? 1 : 0.98 }}
                  >
                    {loading ? (
                      <>
                        <span className="login-spinner" />
                        {modo === "login" ? "Entrando..." : "Creando cuenta..."}
                      </>
                    ) : (
                      <>
                        {modo === "login" ? "Iniciar sesión" : "Crear cuenta"}
                        <ArrowRight size={18} />
                      </>
                    )}
                  </motion.button>

                  {/* Separador */}
                  <div className="login-sep">
                    <span />
                    <p>o</p>
                    <span />
                  </div>

                  {/* Google */}
                  <div className="login-google">
                    <GoogleLogin
                      onSuccess={handleGoogleSuccess}
                      onError={() =>
                        Swal.fire({
                          title: "Error",
                          text: "No se pudo conectar con Google",
                          icon: "error",
                          confirmButtonColor: "#9571dd",
                          background: "#fef8ed",
                          color: "#4a386d",
                        })
                      }
                      shape="pill"
                      theme="outline"
                      size="large"
                      width="100%"
                      text={modo === "login" ? "signin_with" : "signup_with"}
                      locale="es"
                    />
                  </div>
                </form>

                {/* Cambiar modo */}
                <p className="login-cambiar">
                  {modo === "login" ? (
                    <>
                      ¿No tenés cuenta?{" "}
                      <button type="button" onClick={() => cambiarModo("registro")}>
                        Crear cuenta
                      </button>
                    </>
                  ) : (
                    <>
                      ¿Ya tenés cuenta?{" "}
                      <button type="button" onClick={() => cambiarModo("login")}>
                        Iniciar sesión
                      </button>
                    </>
                  )}
                </p>

                {/* Nota profesor */}
                {modo === "registro" && (
                  <p className="login-nota">
                    💡 ¿Sos profesor? Registrate y luego canjeá tu código
                  </p>
                )}
              </motion.div>
            </AnimatePresence>
          </div>
        </motion.div>
      </div>
    </div>
  );
}

export default Login;