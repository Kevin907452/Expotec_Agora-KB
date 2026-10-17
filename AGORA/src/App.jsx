// agoraya/AGORA/src/App.jsx
import React from "react";
import { BrowserRouter, Routes, Route, useLocation } from "react-router-dom";
import { GoogleOAuthProvider } from "@react-oauth/google";

import Navbar from "./componentes/navbar.jsx";
import Modulos, { DetalleModulo } from "./componentes/Modulos.jsx";
import Notas from "./componentes/Notas.jsx";
import JuegosModulo from "./componentes/JuegosModulo.jsx";
import AulaOriginal from "./componentes/AulaOriginal.jsx";
import Carrusel from "./componentes/carrusel.jsx";
import Login from "./componentes/login.jsx";

import IndexEstudiante from "./componentes/indexestudiante.jsx";
import IndexProfesor from "./componentes/indexprofesor.jsx";
import Estudiantes from "./componentes/estudiantes.jsx";
import Chatbot from "./componentes/chatbot.jsx";
import CrearPartido from "./componentes/CrearPartido.jsx";
import Calendario from "./componentes/Calendario.jsx";
import CalendarioProfe from "./componentes/CalendarioProfe.jsx";
import Perfil from "./componentes/Perfil.jsx";
import Comunidad from "./componentes/Comunidad.jsx";

import Partidos from "./componentes/Partidos.jsx"; 
import PanelProfesor from "./componentes/PanelProfesor.jsx";

const GOOGLE_CLIENT_ID =
  "801082715265-u9p0lg3ipqjcg7tl6h7tb806qlgm72jb.apps.googleusercontent.com";

function AppContent() {
  const location = useLocation();
  const ocultarChatbot = location.pathname === "/login";

  return (
    <>
      <Routes>
        {/* ═══ Home público ═══ */}
        <Route
          path="/"
          element={
            <>
              <Navbar />
              <Carrusel />
            </>
          }
        />

        {/* ═══ Login ═══ */}
        <Route path="/login" element={<Login />} />

        {/* ═══ Comunidad ═══ */}
        <Route path="/comunidad" element={<Comunidad />} />

        {/* ═══ Index Estudiante ═══ */}
        <Route path="/indexestudiante" element={<IndexEstudiante />} />

        {/* ═══ Index Profesor ═══ */}
        <Route path="/indexprofesor" element={<IndexProfesor />} />

        {/* ═══ Perfil ═══ */}
        <Route path="/perfil" element={<Perfil />} />

        {/* ═══ Estudiantes (solo profe) ═══ */}
        <Route path="/estudiantes" element={<Estudiantes />} />

        {/* ═══ Módulos ═══ */}
        <Route path="/modulos" element={<Modulos />} />
        <Route path="/modulos/:id" element={<DetalleModulo />} />
        <Route path="/modulos/:id/juegos" element={<JuegosModulo />} />

        {/* ═══ Aula ═══ */}
        <Route path="/aula" element={<AulaOriginal />} />

        {/* ═══ Notas ═══ */}
        <Route path="/notas" element={<Notas />} />

        {/* ═══ Calendario ═══ */}
        <Route path="/calendario" element={<Calendario />} />
        <Route path="/calendarioprofe" element={<CalendarioProfe />} />
        <Route path="/calendario-profesor" element={<CalendarioProfe />} />

        {/* ═══ Crear Partido ═══ */}
        <Route path="/crearpartido" element={<CrearPartido />} />

        {/* ═══════════════════════════════════════════════════════
            NUEVAS RUTAS DE PARTIDOS
            ═══════════════════════════════════════════════════════ */}

        {/* Página principal de partidos (quiz + grid + crear) */}
        <Route path="/partidos" element={<Partidos />} />

        {/* Panel del profesor para revisar partidos pendientes */}
        <Route path="/profesor/partidos" element={<PanelProfesor />} />
      </Routes>

      {!ocultarChatbot && <Chatbot />}
    </>
  );
}

function App() {
  return (
    <GoogleOAuthProvider clientId={GOOGLE_CLIENT_ID}>
      <BrowserRouter>
        <AppContent />
      </BrowserRouter>
    </GoogleOAuthProvider>
  );
}

export default App;