// agoraya/AGORA/src/componentes/Calendario.jsx
import React, { useCallback, useEffect, useMemo, useState } from "react";
import { motion, AnimatePresence } from "framer-motion";
import "./calendario.css";
import agoritaImg from "../assets/agorita.png";

// ⬇️ IMPORTANTE: Importar navbar compartido con MenuPerfil
import { NavbarEstudiante } from "./indexestudiante.jsx";

import { eventosService } from "../services/eventosService";
import { fechasCivicasDelAnio } from "../data/fechasCivicas";
import { CATEGORIAS, inferirCategoria } from "../utils/categorias";
import {
  MESES, DIAS_CORTOS, claveDeDate, claveFecha, dateDeClave, formatoFechaCorta,
  formatoFechaLarga, formatoHora, hoyClave, parseTimestamp, rangoClaves,
} from "../utils/fechas";

function normalizar(row) {
  const inicio = parseTimestamp(row.fecha_inicio);
  const fin = row.fecha_fin ? parseTimestamp(row.fecha_fin) : inicio;
  return {
    id: `db-${row.id_evento}`,
    idDb: row.id_evento,
    titulo: row.titulo,
    descripcion: row.descripcion || "",
    inicio,
    fin,
    origen: "db",
    todoElDia: false,
    categoria: inferirCategoria(row.titulo, row.descripcion || "", row.id_modulo) || "general",
  };
}

export default function CalendarioEstudiante() {
  const hoy = new Date();
  const [anio, setAnio] = useState(hoy.getFullYear());
  const [mes, setMes] = useState(hoy.getMonth());
  const [seleccion, setSeleccion] = useState(hoyClave());
  const [eventosDb, setEventosDb] = useState([]);
  const [cargando, setCargando] = useState(true);
  const [errorCarga, setErrorCarga] = useState("");
  const [direccion, setDireccion] = useState(1);

  const cargar = useCallback(async () => {
    setCargando(true);
    try {
      const filas = await eventosService.getAll();
      if (Array.isArray(filas)) {
        setEventosDb(filas.map(normalizar));
      }
      setErrorCarga("");
    } catch (e) {
      setErrorCarga(e.message);
    } finally {
      setCargando(false);
    }
  }, []);

  useEffect(() => {
    cargar();
  }, [cargar]);

  const todos = useMemo(() => {
    const civicos = [anio - 1, anio, anio + 1].flatMap(fechasCivicasDelAnio);
    return [...civicos, ...eventosDb];
  }, [anio, eventosDb]);

  const porDia = useMemo(() => {
    const mapa = new Map();
    for (const ev of todos) {
      for (const clave of rangoClaves(ev.inicio, ev.fin)) {
        if (!mapa.has(clave)) mapa.set(clave, []);
        mapa.get(clave).push(ev);
      }
    }
    for (const lista of mapa.values()) lista.sort((a, b) => a.inicio - b.inicio);
    return mapa;
  }, [todos]);

  const celdas = useMemo(() => {
    const offset = (new Date(anio, mes, 1).getDay() + 6) % 7;
    const diasMes = new Date(anio, mes + 1, 0).getDate();
    const filas = Math.ceil((offset + diasMes) / 7);
    return Array.from({ length: filas * 7 }, (_, i) => {
      const d = new Date(anio, mes, 1 - offset + i);
      return { clave: claveDeDate(d), dia: d.getDate(), fuera: d.getMonth() !== mes };
    });
  }, [anio, mes]);

  const eventosDelDia = porDia.get(seleccion) || [];
  const fechaSel = dateDeClave(seleccion);
  const hoyK = hoyClave();

  function irA(clave) {
    const d = dateDeClave(clave);
    setAnio(d.getFullYear());
    setMes(d.getMonth());
    setSeleccion(clave);
  }

  function cambiarMes(delta) {
    setDireccion(delta);
    const d = new Date(anio, mes + delta, 1);
    setAnio(d.getFullYear());
    setMes(d.getMonth());
    const esMesActual = d.getFullYear() === hoy.getFullYear() && d.getMonth() === hoy.getMonth();
    setSeleccion(esMesActual ? hoyK : claveFecha(d.getFullYear(), d.getMonth(), 1));
  }

  const horaTexto = (ev) => (ev.todoElDia ? "Todo el día" : formatoHora(ev.inicio));
  const rangoTexto = (ev) =>
    claveDeDate(ev.inicio) !== claveDeDate(ev.fin)
      ? `${formatoFechaCorta(ev.inicio)} – ${formatoFechaCorta(ev.fin)}`
      : null;

  const variantesPagina = {
    initial: (dir) => ({
      y: dir > 0 ? -120 : 120,
      opacity: 0,
      scale: 0.95,
      rotateX: dir > 0 ? -15 : 15,
    }),
    animate: {
      y: 0,
      opacity: 1,
      scale: 1,
      rotateX: 0,
      transition: { type: "spring", stiffness: 260, damping: 20 },
    },
    exit: (dir) => ({
      y: dir > 0 ? 120 : -120,
      opacity: 0,
      scale: 0.9,
      rotateX: dir > 0 ? 15 : -15,
      transition: { duration: 0.25 },
    }),
  };

  return (
    <div className="pagina-calendario-estudiante">
      {/* ⬇️ NAVBAR COMPARTIDO (con MenuPerfil) */}
      <NavbarEstudiante />

      <div className="calendario-vista-card calendario-real-efecto">
        <div className="cal-anillas">
          {[...Array(12)].map((_, i) => (
            <span key={i} className="cal-anilla"></span>
          ))}
        </div>

        <div className="calendario-encabezado-superior">
          <h1 className="titulo-calendario-spartan">Calendario</h1>
          <p className="subtitulo-calendario">
            Consulta las fechas cívicas e itinerario de actividades del cole!
          </p>
        </div>

        <main className="cal">
          {errorCarga && (
            <div className="cal-aviso" role="alert">
              <span>No hay conexión con el servidor. Se muestran únicamente las fechas cívicas.</span>
              <button type="button" onClick={cargar}>Reintentar</button>
            </div>
          )}

          <div className="cal-layout">
            <section className="cal-principal" aria-label="Calendario">
              <header className="cal-cabecera">
                <div>
                  <h2 className="cal-titulo">{MESES[mes]} <span>{anio}</span></h2>
                </div>
                <div className="cal-nav">
                  <button type="button" className="cal-btn-hoy" onClick={() => irA(hoyK)}>Hoy</button>
                  <button type="button" className="cal-btn-icono" onClick={() => cambiarMes(-1)} aria-label="Mes anterior">‹</button>
                  <button type="button" className="cal-btn-icono" onClick={() => cambiarMes(1)} aria-label="Mes siguiente">›</button>
                </div>
              </header>

              <div className="cal-semana">
                {DIAS_CORTOS.map((d) => <span key={d}>{d}</span>)}
              </div>

              <div className="cal-hoja-contenedor">
                <AnimatePresence mode="wait" custom={direccion}>
                  <motion.div
                    key={`${anio}-${mes}`}
                    custom={direccion}
                    variants={variantesPagina}
                    initial="initial"
                    animate="animate"
                    exit="exit"
                    className={`cal-grid ${cargando ? "cal-grid--cargando" : ""}`}
                  >
                    {celdas.map((c, idx) => {
                      const evs = porDia.get(c.clave) || [];
                      const clases = [
                        "cal-celda",
                        c.fuera && "cal-celda--fuera",
                        c.clave === hoyK && "cal-celda--hoy",
                        c.clave === seleccion && "cal-celda--sel",
                      ].filter(Boolean).join(" ");
                      return (
                        <button
                          key={c.clave}
                          type="button"
                          className={clases}
                          onClick={() => irA(c.clave)}
                          aria-label={`${formatoFechaLarga(c.clave)}${evs.length ? `, ${evs.length} evento(s)` : ""}`}
                          aria-pressed={c.clave === seleccion}
                        >
                          <span className="cal-num">{c.dia}</span>
                          <span className="cal-chips">
                            {evs.slice(0, 2).map((ev) => {
                              const continua = claveDeDate(ev.inicio) !== c.clave && idx % 7 !== 0;
                              const colorCat = (CATEGORIAS[ev.categoria] && CATEGORIAS[ev.categoria].color) || "#8D7BE8";
                              return (
                                <span
                                  key={ev.id}
                                  className={`cal-chip ${continua ? "cal-chip--cont" : ""}`}
                                  style={{ "--c": colorCat }}
                                  title={ev.titulo}
                                >
                                  {continua ? "\u00a0" : ev.titulo}
                                </span>
                              );
                            })}
                            {evs.length > 2 && <span className="cal-mas">+{evs.length - 2} más</span>}
                          </span>
                          <span className="cal-puntos" aria-hidden="true">
                            {evs.slice(0, 3).map((ev) => {
                              const colorCat = (CATEGORIAS[ev.categoria] && CATEGORIAS[ev.categoria].color) || "#8D7BE8";
                              return <i key={ev.id} style={{ "--c": colorCat }} />;
                            })}
                          </span>
                        </button>
                      );
                    })}
                  </motion.div>
                </AnimatePresence>
              </div>
            </section>

            <div className="cal-columna-derecha">
              <aside className="cal-lateral" aria-label="Agenda del día">
                <div className="cal-dia">
                  <p className="cal-dia-num">{String(fechaSel.getDate()).padStart(2, "0")}</p>
                  <p className="cal-dia-texto">
                    {formatoFechaLarga(seleccion).split(" ")[0]}
                    <span>{MESES[fechaSel.getMonth()]} {fechaSel.getFullYear()}</span>
                  </p>
                </div>

                <ul className="cal-lista">
                  {eventosDelDia.length === 0 && <li className="cal-vacio">No hay eventos este día.</li>}
                  {eventosDelDia.map((ev) => {
                    const colorCat = (CATEGORIAS[ev.categoria] && CATEGORIAS[ev.categoria].color) || "#8D7BE8";
                    const etiquetaCat = (CATEGORIAS[ev.categoria] && CATEGORIAS[ev.categoria].etiqueta) || "General";
                    return (
                      <li key={ev.id} className="cal-evento" style={{ "--c": colorCat }}>
                        <div className="cal-evento-top">
                          <p className="cal-evento-titulo">{ev.titulo}</p>
                        </div>
                        <p className="cal-evento-meta">
                          {etiquetaCat} · {horaTexto(ev)}{rangoTexto(ev) ? ` · ${rangoTexto(ev)}` : ""}
                        </p>
                        {ev.descripcion && <p className="cal-evento-desc">{ev.descripcion}</p>}
                      </li>
                    );
                  })}
                </ul>
              </aside>

              <div className="cal-agorita-contenedor">
                <img src={agoritaImg} alt="Ágorita Asistente Virtual" className="cal-agorita-img" />
              </div>
            </div>
          </div>
        </main>
      </div>
    </div>
  );
}