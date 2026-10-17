--
-- PostgreSQL database dump
--

\restrict DJ7LSocnIzZu6s9BLtrhhdu1c7iOAypDAaZ8G6M9br0mVMYeozRexTpNYEToxad

-- Dumped from database version 18.0
-- Dumped by pg_dump version 18.0

-- Started on 2026-10-17 14:19:13

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 916 (class 1247 OID 25243)
-- Name: cargo_partido; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.cargo_partido AS ENUM (
    'presidente',
    'vicepresidente',
    'secretario',
    'tesorero',
    'vocal',
    'fiscal',
    'vocal_2',
    'vocal1',
    'vocal2'
);


ALTER TYPE public.cargo_partido OWNER TO postgres;

--
-- TOC entry 919 (class 1247 OID 25258)
-- Name: estado_gobierno; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.estado_gobierno AS ENUM (
    'activo',
    'finalizado',
    'proximo'
);


ALTER TYPE public.estado_gobierno OWNER TO postgres;

--
-- TOC entry 922 (class 1247 OID 25266)
-- Name: proveedor_login; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.proveedor_login AS ENUM (
    'local',
    'google'
);


ALTER TYPE public.proveedor_login OWNER TO postgres;

--
-- TOC entry 925 (class 1247 OID 25272)
-- Name: rol_usuario; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.rol_usuario AS ENUM (
    'estudiante',
    'profesor',
    'administrador'
);


ALTER TYPE public.rol_usuario OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 283 (class 1259 OID 25907)
-- Name: agora_intentos_educativos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.agora_intentos_educativos (
    id_intento bigint NOT NULL,
    id_estudiante integer NOT NULL,
    id_tema character varying(120) NOT NULL,
    nombre_quiz text NOT NULL,
    aciertos integer NOT NULL,
    total integer NOT NULL,
    porcentaje integer NOT NULL,
    fecha timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.agora_intentos_educativos OWNER TO postgres;

--
-- TOC entry 282 (class 1259 OID 25906)
-- Name: agora_intentos_educativos_id_intento_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.agora_intentos_educativos_id_intento_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.agora_intentos_educativos_id_intento_seq OWNER TO postgres;

--
-- TOC entry 5400 (class 0 OID 0)
-- Dependencies: 282
-- Name: agora_intentos_educativos_id_intento_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.agora_intentos_educativos_id_intento_seq OWNED BY public.agora_intentos_educativos.id_intento;


--
-- TOC entry 219 (class 1259 OID 25279)
-- Name: avatar; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.avatar (
    id_avatar integer NOT NULL,
    nombre character varying(50) NOT NULL,
    imagen_url text NOT NULL
);


ALTER TABLE public.avatar OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 25287)
-- Name: avatar_id_avatar_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.avatar_id_avatar_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.avatar_id_avatar_seq OWNER TO postgres;

--
-- TOC entry 5401 (class 0 OID 0)
-- Dependencies: 220
-- Name: avatar_id_avatar_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.avatar_id_avatar_seq OWNED BY public.avatar.id_avatar;


--
-- TOC entry 221 (class 1259 OID 25288)
-- Name: caja_ideas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.caja_ideas (
    id_idea integer NOT NULL,
    id_usuario integer NOT NULL,
    comentario text NOT NULL,
    fecha timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    editado boolean DEFAULT false,
    fecha_edicion timestamp without time zone
);


ALTER TABLE public.caja_ideas OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 25297)
-- Name: caja_ideas_id_idea_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.caja_ideas_id_idea_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.caja_ideas_id_idea_seq OWNER TO postgres;

--
-- TOC entry 5402 (class 0 OID 0)
-- Dependencies: 222
-- Name: caja_ideas_id_idea_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.caja_ideas_id_idea_seq OWNED BY public.caja_ideas.id_idea;


--
-- TOC entry 223 (class 1259 OID 25298)
-- Name: clase; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.clase (
    id_clase integer NOT NULL,
    modulo_id integer NOT NULL,
    titulo character varying(100) NOT NULL,
    contenido text,
    fecha_publicacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.clase OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 25307)
-- Name: clase_id_clase_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.clase_id_clase_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.clase_id_clase_seq OWNER TO postgres;

--
-- TOC entry 5403 (class 0 OID 0)
-- Dependencies: 224
-- Name: clase_id_clase_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.clase_id_clase_seq OWNED BY public.clase.id_clase;


--
-- TOC entry 271 (class 1259 OID 25768)
-- Name: codigo_invitacion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.codigo_invitacion (
    id_codigo integer NOT NULL,
    codigo character varying(20) NOT NULL,
    rol_asignado public.rol_usuario DEFAULT 'profesor'::public.rol_usuario NOT NULL,
    creado_por integer,
    usado_por integer,
    activo boolean DEFAULT true,
    usos_maximos integer DEFAULT 1,
    usos_actuales integer DEFAULT 0,
    fecha_creacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    fecha_expiracion timestamp without time zone,
    fecha_uso timestamp without time zone
);


ALTER TABLE public.codigo_invitacion OWNER TO postgres;

--
-- TOC entry 270 (class 1259 OID 25767)
-- Name: codigo_invitacion_id_codigo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.codigo_invitacion_id_codigo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.codigo_invitacion_id_codigo_seq OWNER TO postgres;

--
-- TOC entry 5404 (class 0 OID 0)
-- Dependencies: 270
-- Name: codigo_invitacion_id_codigo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.codigo_invitacion_id_codigo_seq OWNED BY public.codigo_invitacion.id_codigo;


--
-- TOC entry 265 (class 1259 OID 25696)
-- Name: comentario_idea; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.comentario_idea (
    id_comentario integer NOT NULL,
    id_idea integer NOT NULL,
    id_usuario integer NOT NULL,
    comentario text NOT NULL,
    fecha timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.comentario_idea OWNER TO postgres;

--
-- TOC entry 264 (class 1259 OID 25695)
-- Name: comentario_idea_id_comentario_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.comentario_idea_id_comentario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.comentario_idea_id_comentario_seq OWNER TO postgres;

--
-- TOC entry 5405 (class 0 OID 0)
-- Dependencies: 264
-- Name: comentario_idea_id_comentario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.comentario_idea_id_comentario_seq OWNED BY public.comentario_idea.id_comentario;


--
-- TOC entry 225 (class 1259 OID 25308)
-- Name: conversacion_chat; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.conversacion_chat (
    id_conversacion integer NOT NULL,
    usuario integer NOT NULL,
    fecha_inicio timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.conversacion_chat OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 25314)
-- Name: conversacion_chat_id_conversacion_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.conversacion_chat_id_conversacion_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.conversacion_chat_id_conversacion_seq OWNER TO postgres;

--
-- TOC entry 5406 (class 0 OID 0)
-- Dependencies: 226
-- Name: conversacion_chat_id_conversacion_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.conversacion_chat_id_conversacion_seq OWNED BY public.conversacion_chat.id_conversacion;


--
-- TOC entry 227 (class 1259 OID 25315)
-- Name: curso; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.curso (
    id_curso integer NOT NULL,
    nivel integer NOT NULL,
    seccion character varying(5) NOT NULL,
    nombre character varying(20) NOT NULL
);


ALTER TABLE public.curso OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 25322)
-- Name: curso_id_curso_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.curso_id_curso_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.curso_id_curso_seq OWNER TO postgres;

--
-- TOC entry 5407 (class 0 OID 0)
-- Dependencies: 228
-- Name: curso_id_curso_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.curso_id_curso_seq OWNED BY public.curso.id_curso;


--
-- TOC entry 273 (class 1259 OID 25795)
-- Name: eje_afinidad; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.eje_afinidad (
    id_eje integer NOT NULL,
    codigo character varying(50) NOT NULL,
    nombre character varying(100) NOT NULL,
    descripcion text,
    color character varying(20),
    icono character varying(50),
    orden integer DEFAULT 0
);


ALTER TABLE public.eje_afinidad OWNER TO postgres;

--
-- TOC entry 272 (class 1259 OID 25794)
-- Name: eje_afinidad_id_eje_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.eje_afinidad_id_eje_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.eje_afinidad_id_eje_seq OWNER TO postgres;

--
-- TOC entry 5408 (class 0 OID 0)
-- Dependencies: 272
-- Name: eje_afinidad_id_eje_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.eje_afinidad_id_eje_seq OWNED BY public.eje_afinidad.id_eje;


--
-- TOC entry 229 (class 1259 OID 25323)
-- Name: eleccion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.eleccion (
    id_eleccion integer NOT NULL,
    id_gobierno integer NOT NULL,
    fecha_inicio date,
    fecha_fin date,
    estado character varying(20)
);


ALTER TABLE public.eleccion OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 25328)
-- Name: eleccion_id_eleccion_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.eleccion_id_eleccion_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.eleccion_id_eleccion_seq OWNER TO postgres;

--
-- TOC entry 5409 (class 0 OID 0)
-- Dependencies: 230
-- Name: eleccion_id_eleccion_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.eleccion_id_eleccion_seq OWNED BY public.eleccion.id_eleccion;


--
-- TOC entry 231 (class 1259 OID 25329)
-- Name: evento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.evento (
    id_evento integer NOT NULL,
    titulo character varying(100),
    descripcion text,
    fecha_inicio timestamp without time zone,
    fecha_fin timestamp without time zone,
    id_modulo integer
);


ALTER TABLE public.evento OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 25335)
-- Name: evento_id_evento_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.evento_id_evento_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.evento_id_evento_seq OWNER TO postgres;

--
-- TOC entry 5410 (class 0 OID 0)
-- Dependencies: 232
-- Name: evento_id_evento_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.evento_id_evento_seq OWNED BY public.evento.id_evento;


--
-- TOC entry 269 (class 1259 OID 25743)
-- Name: feedback_partido; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.feedback_partido (
    id_feedback integer NOT NULL,
    id_partido integer NOT NULL,
    id_profesor integer NOT NULL,
    mensaje text NOT NULL,
    tipo character varying(20) DEFAULT 'comentario'::character varying,
    fecha timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.feedback_partido OWNER TO postgres;

--
-- TOC entry 268 (class 1259 OID 25742)
-- Name: feedback_partido_id_feedback_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.feedback_partido_id_feedback_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.feedback_partido_id_feedback_seq OWNER TO postgres;

--
-- TOC entry 5411 (class 0 OID 0)
-- Dependencies: 268
-- Name: feedback_partido_id_feedback_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.feedback_partido_id_feedback_seq OWNED BY public.feedback_partido.id_feedback;


--
-- TOC entry 233 (class 1259 OID 25336)
-- Name: gobierno_estudiantil; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.gobierno_estudiantil (
    id_gobierno integer NOT NULL,
    nombre character varying(50),
    fecha_inicio date,
    fecha_fin date,
    estado public.estado_gobierno
);


ALTER TABLE public.gobierno_estudiantil OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 25340)
-- Name: gobierno_estudiantil_id_gobierno_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.gobierno_estudiantil_id_gobierno_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.gobierno_estudiantil_id_gobierno_seq OWNER TO postgres;

--
-- TOC entry 5412 (class 0 OID 0)
-- Dependencies: 234
-- Name: gobierno_estudiantil_id_gobierno_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.gobierno_estudiantil_id_gobierno_seq OWNED BY public.gobierno_estudiantil.id_gobierno;


--
-- TOC entry 267 (class 1259 OID 25720)
-- Name: idea_guardada; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.idea_guardada (
    id_guardado integer NOT NULL,
    id_idea integer NOT NULL,
    id_usuario integer NOT NULL,
    fecha timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.idea_guardada OWNER TO postgres;

--
-- TOC entry 266 (class 1259 OID 25719)
-- Name: idea_guardada_id_guardado_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.idea_guardada_id_guardado_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.idea_guardada_id_guardado_seq OWNER TO postgres;

--
-- TOC entry 5413 (class 0 OID 0)
-- Dependencies: 266
-- Name: idea_guardada_id_guardado_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.idea_guardada_id_guardado_seq OWNED BY public.idea_guardada.id_guardado;


--
-- TOC entry 263 (class 1259 OID 25673)
-- Name: like_idea; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.like_idea (
    id_like integer NOT NULL,
    id_idea integer NOT NULL,
    id_usuario integer NOT NULL,
    fecha timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.like_idea OWNER TO postgres;

--
-- TOC entry 262 (class 1259 OID 25672)
-- Name: like_idea_id_like_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.like_idea_id_like_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.like_idea_id_like_seq OWNER TO postgres;

--
-- TOC entry 5414 (class 0 OID 0)
-- Dependencies: 262
-- Name: like_idea_id_like_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.like_idea_id_like_seq OWNED BY public.like_idea.id_like;


--
-- TOC entry 235 (class 1259 OID 25341)
-- Name: mensaje_chat; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mensaje_chat (
    id_mensaje integer NOT NULL,
    conversacion_id integer NOT NULL,
    remitente character varying(20),
    mensaje text,
    fecha timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.mensaje_chat OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 25349)
-- Name: mensaje_chat_id_mensaje_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.mensaje_chat_id_mensaje_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.mensaje_chat_id_mensaje_seq OWNER TO postgres;

--
-- TOC entry 5415 (class 0 OID 0)
-- Dependencies: 236
-- Name: mensaje_chat_id_mensaje_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.mensaje_chat_id_mensaje_seq OWNED BY public.mensaje_chat.id_mensaje;


--
-- TOC entry 237 (class 1259 OID 25350)
-- Name: miembro_partido; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.miembro_partido (
    id_miembro integer NOT NULL,
    id_partido integer NOT NULL,
    id_estudiante integer NOT NULL,
    cargo public.cargo_partido NOT NULL,
    seccion character varying(5)
);


ALTER TABLE public.miembro_partido OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 25357)
-- Name: miembro_partido_id_miembro_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.miembro_partido_id_miembro_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.miembro_partido_id_miembro_seq OWNER TO postgres;

--
-- TOC entry 5416 (class 0 OID 0)
-- Dependencies: 238
-- Name: miembro_partido_id_miembro_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.miembro_partido_id_miembro_seq OWNED BY public.miembro_partido.id_miembro;


--
-- TOC entry 239 (class 1259 OID 25358)
-- Name: modulo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.modulo (
    id_modulo integer NOT NULL,
    nombre character varying(100) NOT NULL,
    descripcion text,
    id_profesor integer NOT NULL,
    curso_id integer NOT NULL,
    habilitado boolean DEFAULT true
);


ALTER TABLE public.modulo OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 25368)
-- Name: modulo_id_modulo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.modulo_id_modulo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.modulo_id_modulo_seq OWNER TO postgres;

--
-- TOC entry 5417 (class 0 OID 0)
-- Dependencies: 240
-- Name: modulo_id_modulo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.modulo_id_modulo_seq OWNED BY public.modulo.id_modulo;


--
-- TOC entry 279 (class 1259 OID 25847)
-- Name: opcion_afinidad; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.opcion_afinidad (
    id_opcion integer NOT NULL,
    id_pregunta integer NOT NULL,
    texto text NOT NULL,
    descripcion text,
    id_eje integer NOT NULL,
    peso integer NOT NULL,
    orden integer DEFAULT 0,
    CONSTRAINT opcion_afinidad_peso_check CHECK (((peso >= 1) AND (peso <= 5)))
);


ALTER TABLE public.opcion_afinidad OWNER TO postgres;

--
-- TOC entry 278 (class 1259 OID 25846)
-- Name: opcion_afinidad_id_opcion_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.opcion_afinidad_id_opcion_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.opcion_afinidad_id_opcion_seq OWNER TO postgres;

--
-- TOC entry 5418 (class 0 OID 0)
-- Dependencies: 278
-- Name: opcion_afinidad_id_opcion_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.opcion_afinidad_id_opcion_seq OWNED BY public.opcion_afinidad.id_opcion;


--
-- TOC entry 275 (class 1259 OID 25810)
-- Name: partido_eje; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.partido_eje (
    id_partido_eje integer NOT NULL,
    id_partido integer NOT NULL,
    id_eje integer NOT NULL,
    peso integer NOT NULL,
    CONSTRAINT partido_eje_peso_check CHECK (((peso >= 1) AND (peso <= 10)))
);


ALTER TABLE public.partido_eje OWNER TO postgres;

--
-- TOC entry 274 (class 1259 OID 25809)
-- Name: partido_eje_id_partido_eje_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.partido_eje_id_partido_eje_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.partido_eje_id_partido_eje_seq OWNER TO postgres;

--
-- TOC entry 5419 (class 0 OID 0)
-- Dependencies: 274
-- Name: partido_eje_id_partido_eje_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.partido_eje_id_partido_eje_seq OWNED BY public.partido_eje.id_partido_eje;


--
-- TOC entry 241 (class 1259 OID 25369)
-- Name: partido_politico; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.partido_politico (
    id_partido integer NOT NULL,
    nombre character varying(80) NOT NULL,
    descripcion text,
    bandera_url text,
    gobierno_id integer NOT NULL,
    creador_id integer NOT NULL,
    slogan character varying(200),
    meta text,
    frase text,
    color_principal character varying(20) DEFAULT '#A3D9BD'::character varying,
    color_secundario character varying(20) DEFAULT '#E6A8D7'::character varying,
    activo boolean DEFAULT true,
    estado character varying(20) DEFAULT 'aprobado'::character varying,
    aprobado_por integer,
    fecha_aprobacion timestamp without time zone,
    feedback text,
    fecha_registro timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.partido_politico OWNER TO postgres;

--
-- TOC entry 242 (class 1259 OID 25378)
-- Name: partido_politico_id_partido_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.partido_politico_id_partido_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.partido_politico_id_partido_seq OWNER TO postgres;

--
-- TOC entry 5420 (class 0 OID 0)
-- Dependencies: 242
-- Name: partido_politico_id_partido_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.partido_politico_id_partido_seq OWNED BY public.partido_politico.id_partido;


--
-- TOC entry 277 (class 1259 OID 25834)
-- Name: pregunta_afinidad; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pregunta_afinidad (
    id_pregunta integer NOT NULL,
    texto text NOT NULL,
    descripcion text,
    orden integer DEFAULT 0,
    activa boolean DEFAULT true
);


ALTER TABLE public.pregunta_afinidad OWNER TO postgres;

--
-- TOC entry 276 (class 1259 OID 25833)
-- Name: pregunta_afinidad_id_pregunta_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pregunta_afinidad_id_pregunta_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pregunta_afinidad_id_pregunta_seq OWNER TO postgres;

--
-- TOC entry 5421 (class 0 OID 0)
-- Dependencies: 276
-- Name: pregunta_afinidad_id_pregunta_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pregunta_afinidad_id_pregunta_seq OWNED BY public.pregunta_afinidad.id_pregunta;


--
-- TOC entry 243 (class 1259 OID 25379)
-- Name: propuesta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.propuesta (
    id_propuesta integer NOT NULL,
    id_partido integer NOT NULL,
    titulo character varying(100),
    descripcion text,
    fecha_creacion date
);


ALTER TABLE public.propuesta OWNER TO postgres;

--
-- TOC entry 244 (class 1259 OID 25386)
-- Name: propuesta_id_propuesta_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.propuesta_id_propuesta_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.propuesta_id_propuesta_seq OWNER TO postgres;

--
-- TOC entry 5422 (class 0 OID 0)
-- Dependencies: 244
-- Name: propuesta_id_propuesta_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.propuesta_id_propuesta_seq OWNED BY public.propuesta.id_propuesta;


--
-- TOC entry 245 (class 1259 OID 25387)
-- Name: quiz; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.quiz (
    id_quiz integer NOT NULL,
    modulo_id integer NOT NULL,
    nombre character varying(100),
    puntaje_maximo integer
);


ALTER TABLE public.quiz OWNER TO postgres;

--
-- TOC entry 246 (class 1259 OID 25392)
-- Name: quiz_id_quiz_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.quiz_id_quiz_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.quiz_id_quiz_seq OWNER TO postgres;

--
-- TOC entry 5423 (class 0 OID 0)
-- Dependencies: 246
-- Name: quiz_id_quiz_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.quiz_id_quiz_seq OWNED BY public.quiz.id_quiz;


--
-- TOC entry 247 (class 1259 OID 25393)
-- Name: racha; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.racha (
    id_racha integer NOT NULL,
    id_usuario integer NOT NULL,
    racha_actual integer DEFAULT 0,
    mejor_racha integer DEFAULT 0
);


ALTER TABLE public.racha OWNER TO postgres;

--
-- TOC entry 248 (class 1259 OID 25400)
-- Name: racha_id_racha_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.racha_id_racha_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.racha_id_racha_seq OWNER TO postgres;

--
-- TOC entry 5424 (class 0 OID 0)
-- Dependencies: 248
-- Name: racha_id_racha_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.racha_id_racha_seq OWNED BY public.racha.id_racha;


--
-- TOC entry 249 (class 1259 OID 25401)
-- Name: recompensa; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.recompensa (
    id_recompensa integer NOT NULL,
    nombre character varying(50),
    descripcion text,
    imagen_url text
);


ALTER TABLE public.recompensa OWNER TO postgres;

--
-- TOC entry 250 (class 1259 OID 25407)
-- Name: recompensa_id_recompensa_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.recompensa_id_recompensa_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.recompensa_id_recompensa_seq OWNER TO postgres;

--
-- TOC entry 5425 (class 0 OID 0)
-- Dependencies: 250
-- Name: recompensa_id_recompensa_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.recompensa_id_recompensa_seq OWNED BY public.recompensa.id_recompensa;


--
-- TOC entry 281 (class 1259 OID 25873)
-- Name: resultado_afinidad; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resultado_afinidad (
    id_resultado integer NOT NULL,
    id_usuario integer NOT NULL,
    id_partido_ganador integer NOT NULL,
    puntajes jsonb NOT NULL,
    respuestas jsonb NOT NULL,
    fecha timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.resultado_afinidad OWNER TO postgres;

--
-- TOC entry 280 (class 1259 OID 25872)
-- Name: resultado_afinidad_id_resultado_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.resultado_afinidad_id_resultado_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.resultado_afinidad_id_resultado_seq OWNER TO postgres;

--
-- TOC entry 5426 (class 0 OID 0)
-- Dependencies: 280
-- Name: resultado_afinidad_id_resultado_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.resultado_afinidad_id_resultado_seq OWNED BY public.resultado_afinidad.id_resultado;


--
-- TOC entry 251 (class 1259 OID 25408)
-- Name: resultado_quiz; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resultado_quiz (
    id_resultado integer NOT NULL,
    id_estudiante integer NOT NULL,
    id_quiz integer NOT NULL,
    nota numeric(5,2),
    porcentaje numeric(5,2),
    intentos integer DEFAULT 0
);


ALTER TABLE public.resultado_quiz OWNER TO postgres;

--
-- TOC entry 252 (class 1259 OID 25415)
-- Name: resultado_quiz_id_resultado_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.resultado_quiz_id_resultado_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.resultado_quiz_id_resultado_seq OWNER TO postgres;

--
-- TOC entry 5427 (class 0 OID 0)
-- Dependencies: 252
-- Name: resultado_quiz_id_resultado_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.resultado_quiz_id_resultado_seq OWNED BY public.resultado_quiz.id_resultado;


--
-- TOC entry 253 (class 1259 OID 25416)
-- Name: sesion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sesion (
    id_sesion integer NOT NULL,
    id_usuario integer NOT NULL,
    token text NOT NULL,
    fecha_inicio timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    fecha_expiracion timestamp without time zone,
    dispositivo character varying(100),
    ip character varying(50)
);


ALTER TABLE public.sesion OWNER TO postgres;

--
-- TOC entry 254 (class 1259 OID 25425)
-- Name: sesion_id_sesion_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sesion_id_sesion_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sesion_id_sesion_seq OWNER TO postgres;

--
-- TOC entry 5428 (class 0 OID 0)
-- Dependencies: 254
-- Name: sesion_id_sesion_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sesion_id_sesion_seq OWNED BY public.sesion.id_sesion;


--
-- TOC entry 255 (class 1259 OID 25426)
-- Name: usuario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuario (
    id_usuario integer NOT NULL,
    nombre character varying(50) NOT NULL,
    apellido character varying(50) NOT NULL,
    correo character varying(150) NOT NULL,
    contrasena character varying(255),
    proveedor public.proveedor_login DEFAULT 'local'::public.proveedor_login NOT NULL,
    google_id character varying(255),
    rol public.rol_usuario DEFAULT 'estudiante'::public.rol_usuario NOT NULL,
    avatar_id integer,
    activo boolean DEFAULT true,
    fecha_registro timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    ultimo_acceso timestamp without time zone,
    avatar_url text
);


ALTER TABLE public.usuario OWNER TO postgres;

--
-- TOC entry 256 (class 1259 OID 25441)
-- Name: usuario_curso; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuario_curso (
    id_usuario_curso integer NOT NULL,
    usuario_id integer NOT NULL,
    curso_id integer NOT NULL
);


ALTER TABLE public.usuario_curso OWNER TO postgres;

--
-- TOC entry 257 (class 1259 OID 25447)
-- Name: usuario_curso_id_usuario_curso_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.usuario_curso_id_usuario_curso_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.usuario_curso_id_usuario_curso_seq OWNER TO postgres;

--
-- TOC entry 5429 (class 0 OID 0)
-- Dependencies: 257
-- Name: usuario_curso_id_usuario_curso_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.usuario_curso_id_usuario_curso_seq OWNED BY public.usuario_curso.id_usuario_curso;


--
-- TOC entry 258 (class 1259 OID 25448)
-- Name: usuario_id_usuario_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.usuario_id_usuario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.usuario_id_usuario_seq OWNER TO postgres;

--
-- TOC entry 5430 (class 0 OID 0)
-- Dependencies: 258
-- Name: usuario_id_usuario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.usuario_id_usuario_seq OWNED BY public.usuario.id_usuario;


--
-- TOC entry 259 (class 1259 OID 25449)
-- Name: usuario_recompensa; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuario_recompensa (
    id_usuario integer NOT NULL,
    id_recompensa integer NOT NULL,
    fecha_obtenida timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.usuario_recompensa OWNER TO postgres;

--
-- TOC entry 260 (class 1259 OID 25455)
-- Name: voto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.voto (
    id_voto integer NOT NULL,
    id_estudiante integer NOT NULL,
    id_partido integer NOT NULL,
    fecha_voto timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.voto OWNER TO postgres;

--
-- TOC entry 261 (class 1259 OID 25462)
-- Name: voto_id_voto_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.voto_id_voto_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.voto_id_voto_seq OWNER TO postgres;

--
-- TOC entry 5431 (class 0 OID 0)
-- Dependencies: 261
-- Name: voto_id_voto_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.voto_id_voto_seq OWNED BY public.voto.id_voto;


--
-- TOC entry 5047 (class 2604 OID 25910)
-- Name: agora_intentos_educativos id_intento; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.agora_intentos_educativos ALTER COLUMN id_intento SET DEFAULT nextval('public.agora_intentos_educativos_id_intento_seq'::regclass);


--
-- TOC entry 4980 (class 2604 OID 25463)
-- Name: avatar id_avatar; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.avatar ALTER COLUMN id_avatar SET DEFAULT nextval('public.avatar_id_avatar_seq'::regclass);


--
-- TOC entry 4981 (class 2604 OID 25464)
-- Name: caja_ideas id_idea; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.caja_ideas ALTER COLUMN id_idea SET DEFAULT nextval('public.caja_ideas_id_idea_seq'::regclass);


--
-- TOC entry 4984 (class 2604 OID 25465)
-- Name: clase id_clase; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clase ALTER COLUMN id_clase SET DEFAULT nextval('public.clase_id_clase_seq'::regclass);


--
-- TOC entry 5031 (class 2604 OID 25771)
-- Name: codigo_invitacion id_codigo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.codigo_invitacion ALTER COLUMN id_codigo SET DEFAULT nextval('public.codigo_invitacion_id_codigo_seq'::regclass);


--
-- TOC entry 5024 (class 2604 OID 25699)
-- Name: comentario_idea id_comentario; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comentario_idea ALTER COLUMN id_comentario SET DEFAULT nextval('public.comentario_idea_id_comentario_seq'::regclass);


--
-- TOC entry 4986 (class 2604 OID 25466)
-- Name: conversacion_chat id_conversacion; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conversacion_chat ALTER COLUMN id_conversacion SET DEFAULT nextval('public.conversacion_chat_id_conversacion_seq'::regclass);


--
-- TOC entry 4988 (class 2604 OID 25467)
-- Name: curso id_curso; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.curso ALTER COLUMN id_curso SET DEFAULT nextval('public.curso_id_curso_seq'::regclass);


--
-- TOC entry 5037 (class 2604 OID 25798)
-- Name: eje_afinidad id_eje; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eje_afinidad ALTER COLUMN id_eje SET DEFAULT nextval('public.eje_afinidad_id_eje_seq'::regclass);


--
-- TOC entry 4989 (class 2604 OID 25468)
-- Name: eleccion id_eleccion; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eleccion ALTER COLUMN id_eleccion SET DEFAULT nextval('public.eleccion_id_eleccion_seq'::regclass);


--
-- TOC entry 4990 (class 2604 OID 25469)
-- Name: evento id_evento; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evento ALTER COLUMN id_evento SET DEFAULT nextval('public.evento_id_evento_seq'::regclass);


--
-- TOC entry 5028 (class 2604 OID 25746)
-- Name: feedback_partido id_feedback; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.feedback_partido ALTER COLUMN id_feedback SET DEFAULT nextval('public.feedback_partido_id_feedback_seq'::regclass);


--
-- TOC entry 4991 (class 2604 OID 25470)
-- Name: gobierno_estudiantil id_gobierno; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gobierno_estudiantil ALTER COLUMN id_gobierno SET DEFAULT nextval('public.gobierno_estudiantil_id_gobierno_seq'::regclass);


--
-- TOC entry 5026 (class 2604 OID 25723)
-- Name: idea_guardada id_guardado; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.idea_guardada ALTER COLUMN id_guardado SET DEFAULT nextval('public.idea_guardada_id_guardado_seq'::regclass);


--
-- TOC entry 5022 (class 2604 OID 25676)
-- Name: like_idea id_like; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.like_idea ALTER COLUMN id_like SET DEFAULT nextval('public.like_idea_id_like_seq'::regclass);


--
-- TOC entry 4992 (class 2604 OID 25471)
-- Name: mensaje_chat id_mensaje; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mensaje_chat ALTER COLUMN id_mensaje SET DEFAULT nextval('public.mensaje_chat_id_mensaje_seq'::regclass);


--
-- TOC entry 4994 (class 2604 OID 25472)
-- Name: miembro_partido id_miembro; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.miembro_partido ALTER COLUMN id_miembro SET DEFAULT nextval('public.miembro_partido_id_miembro_seq'::regclass);


--
-- TOC entry 4995 (class 2604 OID 25473)
-- Name: modulo id_modulo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.modulo ALTER COLUMN id_modulo SET DEFAULT nextval('public.modulo_id_modulo_seq'::regclass);


--
-- TOC entry 5043 (class 2604 OID 25850)
-- Name: opcion_afinidad id_opcion; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.opcion_afinidad ALTER COLUMN id_opcion SET DEFAULT nextval('public.opcion_afinidad_id_opcion_seq'::regclass);


--
-- TOC entry 5039 (class 2604 OID 25813)
-- Name: partido_eje id_partido_eje; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.partido_eje ALTER COLUMN id_partido_eje SET DEFAULT nextval('public.partido_eje_id_partido_eje_seq'::regclass);


--
-- TOC entry 4997 (class 2604 OID 25474)
-- Name: partido_politico id_partido; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.partido_politico ALTER COLUMN id_partido SET DEFAULT nextval('public.partido_politico_id_partido_seq'::regclass);


--
-- TOC entry 5040 (class 2604 OID 25837)
-- Name: pregunta_afinidad id_pregunta; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pregunta_afinidad ALTER COLUMN id_pregunta SET DEFAULT nextval('public.pregunta_afinidad_id_pregunta_seq'::regclass);


--
-- TOC entry 5003 (class 2604 OID 25475)
-- Name: propuesta id_propuesta; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.propuesta ALTER COLUMN id_propuesta SET DEFAULT nextval('public.propuesta_id_propuesta_seq'::regclass);


--
-- TOC entry 5004 (class 2604 OID 25476)
-- Name: quiz id_quiz; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quiz ALTER COLUMN id_quiz SET DEFAULT nextval('public.quiz_id_quiz_seq'::regclass);


--
-- TOC entry 5005 (class 2604 OID 25477)
-- Name: racha id_racha; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.racha ALTER COLUMN id_racha SET DEFAULT nextval('public.racha_id_racha_seq'::regclass);


--
-- TOC entry 5008 (class 2604 OID 25478)
-- Name: recompensa id_recompensa; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recompensa ALTER COLUMN id_recompensa SET DEFAULT nextval('public.recompensa_id_recompensa_seq'::regclass);


--
-- TOC entry 5045 (class 2604 OID 25876)
-- Name: resultado_afinidad id_resultado; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resultado_afinidad ALTER COLUMN id_resultado SET DEFAULT nextval('public.resultado_afinidad_id_resultado_seq'::regclass);


--
-- TOC entry 5009 (class 2604 OID 25479)
-- Name: resultado_quiz id_resultado; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resultado_quiz ALTER COLUMN id_resultado SET DEFAULT nextval('public.resultado_quiz_id_resultado_seq'::regclass);


--
-- TOC entry 5011 (class 2604 OID 25480)
-- Name: sesion id_sesion; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sesion ALTER COLUMN id_sesion SET DEFAULT nextval('public.sesion_id_sesion_seq'::regclass);


--
-- TOC entry 5013 (class 2604 OID 25481)
-- Name: usuario id_usuario; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario ALTER COLUMN id_usuario SET DEFAULT nextval('public.usuario_id_usuario_seq'::regclass);


--
-- TOC entry 5018 (class 2604 OID 25482)
-- Name: usuario_curso id_usuario_curso; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario_curso ALTER COLUMN id_usuario_curso SET DEFAULT nextval('public.usuario_curso_id_usuario_curso_seq'::regclass);


--
-- TOC entry 5020 (class 2604 OID 25483)
-- Name: voto id_voto; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.voto ALTER COLUMN id_voto SET DEFAULT nextval('public.voto_id_voto_seq'::regclass);


--
-- TOC entry 5394 (class 0 OID 25907)
-- Dependencies: 283
-- Data for Name: agora_intentos_educativos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.agora_intentos_educativos (id_intento, id_estudiante, id_tema, nombre_quiz, aciertos, total, porcentaje, fecha) FROM stdin;
1	41	quiz-sistema	Sistema político · Quiz	1	3	33	2026-10-10 14:48:48.508208-06
\.


--
-- TOC entry 5330 (class 0 OID 25279)
-- Dependencies: 219
-- Data for Name: avatar; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.avatar (id_avatar, nombre, imagen_url) FROM stdin;
\.


--
-- TOC entry 5332 (class 0 OID 25288)
-- Dependencies: 221
-- Data for Name: caja_ideas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.caja_ideas (id_idea, id_usuario, comentario, fecha, editado, fecha_edicion) FROM stdin;
1	41	Hola esto es mi primer mensaje de pruebaa	2026-10-10 18:46:03.469107	t	2026-10-10 18:47:04.804657
2	42	holisky birrisky	2026-10-10 18:49:53.173205	f	\N
\.


--
-- TOC entry 5334 (class 0 OID 25298)
-- Dependencies: 223
-- Data for Name: clase; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.clase (id_clase, modulo_id, titulo, contenido, fecha_publicacion) FROM stdin;
\.


--
-- TOC entry 5382 (class 0 OID 25768)
-- Dependencies: 271
-- Data for Name: codigo_invitacion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.codigo_invitacion (id_codigo, codigo, rol_asignado, creado_por, usado_por, activo, usos_maximos, usos_actuales, fecha_creacion, fecha_expiracion, fecha_uso) FROM stdin;
1	PROFESOR2026	profesor	\N	\N	t	10	0	2026-10-10 14:06:24.151168	2027-10-10 14:06:24.151168	\N
\.


--
-- TOC entry 5376 (class 0 OID 25696)
-- Dependencies: 265
-- Data for Name: comentario_idea; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.comentario_idea (id_comentario, id_idea, id_usuario, comentario, fecha) FROM stdin;
1	1	41	comentario de prueba papi	2026-10-10 18:46:38.662745
2	1	42	hola broski, soy kevin del futuro naci en el año 67	2026-10-10 18:47:45.521131
\.


--
-- TOC entry 5336 (class 0 OID 25308)
-- Dependencies: 225
-- Data for Name: conversacion_chat; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.conversacion_chat (id_conversacion, usuario, fecha_inicio) FROM stdin;
\.


--
-- TOC entry 5338 (class 0 OID 25315)
-- Dependencies: 227
-- Data for Name: curso; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.curso (id_curso, nivel, seccion, nombre) FROM stdin;
1	7	1	7-1
2	8	1	8-1
3	9	1	9-1
4	10	1	10-1
5	11	1	11-1
6	12	1	12-1
\.


--
-- TOC entry 5384 (class 0 OID 25795)
-- Dependencies: 273
-- Data for Name: eje_afinidad; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.eje_afinidad (id_eje, codigo, nombre, descripcion, color, icono, orden) FROM stdin;
1	ecologico	Medio Ambiente	Sostenibilidad, reciclaje y cuidado del planeta	#A3D9BD	leaf	1
2	social	Convivencia	Respeto, inclusión y bienestar estudiantil	#E6A8D7	heart	2
3	academico	Académico	Apoyo al estudio, talleres y formación	#9EA8D7	book	3
4	cultural	Cultura y Deporte	Arte, deportes, recreación y actividades	#F0C15C	palette	4
5	tecnologico	Tecnología	Innovación, digitalización y modernización	#A7EFEA	cpu	5
\.


--
-- TOC entry 5340 (class 0 OID 25323)
-- Dependencies: 229
-- Data for Name: eleccion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.eleccion (id_eleccion, id_gobierno, fecha_inicio, fecha_fin, estado) FROM stdin;
\.


--
-- TOC entry 5342 (class 0 OID 25329)
-- Dependencies: 231
-- Data for Name: evento; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.evento (id_evento, titulo, descripcion, fecha_inicio, fecha_fin, id_modulo) FROM stdin;
1	ddd	ddd	2026-02-03 08:00:00	2026-02-03 08:00:00	\N
2	Batalla de aura	vengan bien 67	2026-10-01 08:00:00	2026-10-01 08:00:00	\N
\.


--
-- TOC entry 5380 (class 0 OID 25743)
-- Dependencies: 269
-- Data for Name: feedback_partido; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.feedback_partido (id_feedback, id_partido, id_profesor, mensaje, tipo, fecha) FROM stdin;
\.


--
-- TOC entry 5344 (class 0 OID 25336)
-- Dependencies: 233
-- Data for Name: gobierno_estudiantil; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.gobierno_estudiantil (id_gobierno, nombre, fecha_inicio, fecha_fin, estado) FROM stdin;
1	Gobierno Estudiantil 2026	2026-01-15	2026-12-15	activo
\.


--
-- TOC entry 5378 (class 0 OID 25720)
-- Dependencies: 267
-- Data for Name: idea_guardada; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.idea_guardada (id_guardado, id_idea, id_usuario, fecha) FROM stdin;
\.


--
-- TOC entry 5374 (class 0 OID 25673)
-- Dependencies: 263
-- Data for Name: like_idea; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.like_idea (id_like, id_idea, id_usuario, fecha) FROM stdin;
2	1	41	2026-10-10 18:46:20.28443
3	1	42	2026-10-10 18:47:22.525706
4	2	42	2026-10-10 18:49:55.255302
5	1	43	2026-10-10 23:10:12.814995
\.


--
-- TOC entry 5346 (class 0 OID 25341)
-- Dependencies: 235
-- Data for Name: mensaje_chat; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.mensaje_chat (id_mensaje, conversacion_id, remitente, mensaje, fecha) FROM stdin;
\.


--
-- TOC entry 5348 (class 0 OID 25350)
-- Dependencies: 237
-- Data for Name: miembro_partido; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.miembro_partido (id_miembro, id_partido, id_estudiante, cargo, seccion) FROM stdin;
2	1	17	vicepresidente	\N
3	1	18	secretario	\N
4	1	19	tesorero	\N
5	1	20	vocal	\N
6	1	21	vocal_2	\N
7	1	22	fiscal	\N
8	2	17	presidente	\N
9	2	20	vicepresidente	\N
10	2	21	secretario	\N
12	2	19	vocal	\N
13	2	22	vocal_2	\N
14	2	18	fiscal	\N
15	3	18	presidente	\N
16	3	19	vicepresidente	\N
17	3	22	secretario	\N
18	3	21	tesorero	\N
20	3	17	vocal_2	\N
21	3	20	fiscal	\N
22	4	20	presidente	\N
23	4	21	vicepresidente	\N
25	4	17	tesorero	\N
26	4	18	vocal	\N
27	4	19	vocal_2	\N
28	4	22	fiscal	\N
43	1	30	presidente	\N
44	2	31	tesorero	\N
45	3	32	vocal	\N
46	4	33	secretario	\N
47	1	34	presidente	\N
\.


--
-- TOC entry 5350 (class 0 OID 25358)
-- Dependencies: 239
-- Data for Name: modulo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.modulo (id_modulo, nombre, descripcion, id_profesor, curso_id, habilitado) FROM stdin;
\.


--
-- TOC entry 5390 (class 0 OID 25847)
-- Dependencies: 279
-- Data for Name: opcion_afinidad; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.opcion_afinidad (id_opcion, id_pregunta, texto, descripcion, id_eje, peso, orden) FROM stdin;
1	1	Más árboles y áreas verdes	\N	1	5	1
2	1	Mejor internet y computadoras	\N	5	5	2
3	1	Más actividades recreativas	\N	4	5	3
4	1	Más apoyo para estudiar	\N	3	5	4
5	2	Feria ecológica con reciclaje	\N	1	5	1
6	2	Torneo deportivo entre secciones	\N	4	5	2
7	2	Taller de tecnología	\N	5	5	3
8	2	Actividad de convivencia	\N	2	5	4
9	3	El que organiza y lidera	\N	2	5	1
10	3	El que investiga soluciones	\N	3	5	2
11	3	El que diseña lo visual	\N	4	5	3
12	3	El que maneja lo digital	\N	5	5	4
13	4	Un colegio más verde	\N	1	5	1
14	4	Mejor convivencia	\N	2	5	2
15	4	Mejor nivel académico	\N	3	5	3
16	4	Más moderno y tecnológico	\N	5	5	4
17	5	Hablando y buscando acuerdos	\N	2	5	1
18	5	Investigando las causas	\N	3	5	2
19	5	Con actividades creativas	\N	4	5	3
20	5	Con herramientas digitales	\N	5	5	4
21	6	Jornadas de limpieza y reciclaje	\N	1	5	1
22	6	Festivales artísticos	\N	4	5	2
23	6	Charlas y talleres	\N	3	5	3
24	6	Ferias de ciencia y tecnología	\N	5	5	4
25	7	Que tenga impacto ambiental	\N	1	5	1
26	7	Que ayude a otros	\N	2	5	2
27	7	Que me enseñe algo nuevo	\N	3	5	3
28	7	Que sea divertido	\N	4	5	4
29	8	Cuidamos el planeta	\N	1	5	1
30	8	Juntos somos más fuertes	\N	2	5	2
31	8	Aprender para transformar	\N	3	5	3
32	8	Innovar es nuestro idioma	\N	5	5	4
33	9	A cuidar el medio ambiente	\N	1	5	1
34	9	A convivir mejor	\N	2	5	2
35	9	Hábitos de estudio	\N	3	5	3
36	9	Habilidades digitales	\N	5	5	4
37	10	Un colegio más verde	\N	1	5	1
38	10	Amigos y buenos momentos	\N	2	5	2
39	10	Lo que aprendí	\N	3	5	3
40	10	Los eventos que viví	\N	4	5	4
\.


--
-- TOC entry 5386 (class 0 OID 25810)
-- Dependencies: 275
-- Data for Name: partido_eje; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.partido_eje (id_partido_eje, id_partido, id_eje, peso) FROM stdin;
1	1	1	4
2	1	2	9
3	1	3	6
4	1	4	8
5	1	5	3
6	2	1	5
7	2	2	4
8	2	3	8
9	2	4	3
10	2	5	10
11	3	1	3
12	3	2	9
13	3	3	5
14	3	4	9
15	3	5	3
16	4	1	10
17	4	2	7
18	4	3	3
19	4	4	5
20	4	5	2
\.


--
-- TOC entry 5352 (class 0 OID 25369)
-- Dependencies: 241
-- Data for Name: partido_politico; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.partido_politico (id_partido, nombre, descripcion, bandera_url, gobierno_id, creador_id, slogan, meta, frase, color_principal, color_secundario, activo, estado, aprobado_por, fecha_aprobacion, feedback, fecha_registro) FROM stdin;
1	Partido Juventud Unida	Promovemos la participación activa, el liderazgo estudiantil y la inclusión en todas las actividades académicas y recreativas.	/par1.png	1	15	\N	\N	\N	#A3D9BD	#E6A8D7	t	aprobado	\N	\N	\N	2026-10-10 14:06:24.151168
2	Partido Innovación y Futuro	Impulsamos la tecnología, talleres prácticos, adecuación de espacios de estudio y el desarrollo integral.	/par2.png	1	15	\N	\N	\N	#A3D9BD	#E6A8D7	t	aprobado	\N	\N	\N	2026-10-10 14:06:24.151168
3	Partido Fuerza Estudiantil	Defendemos los derechos de los estudiantes, fomentando la integración deportiva y actividades culturales.	/par3.png	1	15	\N	\N	\N	#A3D9BD	#E6A8D7	t	aprobado	\N	\N	\N	2026-10-10 14:06:24.151168
4	Partido Acción Común	Enfocados en el reciclaje, la sostenibilidad ambiental y mejoras en la convivencia colegial.	/par4.png	1	15	\N	\N	\N	#A3D9BD	#E6A8D7	t	aprobado	\N	\N	\N	2026-10-10 14:06:24.151168
5	xxxxxxxxxxxxxxx	xxxxxxxxxxxxxxxxxxxxxxxxxxxx	data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/4gHYSUNDX1BST0ZJTEUAAQEAAAHIAAAAAAQwAABtbnRyUkdCIFhZWiAH4AABAAEAAAAAAABhY3NwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAA9tYAAQAAAADTLQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAlkZXNjAAAA8AAAACRyWFlaAAABFAAAABRnWFlaAAABKAAAABRiWFlaAAABPAAAABR3dHB0AAABUAAAABRyVFJDAAABZAAAAChnVFJDAAABZAAAAChiVFJDAAABZAAAAChjcHJ0AAABjAAAADxtbHVjAAAAAAAAAAEAAAAMZW5VUwAAAAgAAAAcAHMAUgBHAEJYWVogAAAAAAAAb6IAADj1AAADkFhZWiAAAAAAAABimQAAt4UAABjaWFlaIAAAAAAAACSgAAAPhAAAts9YWVogAAAAAAAA9tYAAQAAAADTLXBhcmEAAAAAAAQAAAACZmYAAPKnAAANWQAAE9AAAApbAAAAAAAAAABtbHVjAAAAAAAAAAEAAAAMZW5VUwAAACAAAAAcAEcAbwBvAGcAbABlACAASQBuAGMALgAgADIAMAAxADb/2wBDAAUDBAQEAwUEBAQFBQUGBwwIBwcHBw8LCwkMEQ8SEhEPERETFhwXExQaFRERGCEYGh0dHx8fExciJCIeJBweHx7/2wBDAQUFBQcGBw4ICA4eFBEUHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh7/wAARCAIQAxkDASIAAhEBAxEB/8QAHAAAAgMBAQEBAAAAAAAAAAAABAUCAwYBBwAI/8QAUhAAAQQABQIFAgMFBgQDBQERAQIDBBEABRIhMRNBBhQiUWFxgSMykRVCobHBByQzUtHwQ2Lh8RZTkiVUcpOUCBc0VYKi0lZXlWNk02WWo6Tk/8QAGwEAAwEBAQEBAAAAAAAAAAAAAgMEAQUABgf/xAA2EQABAwIFAQYHAQEBAQACAwEBAAIRAyEEEjFB8FEiYXGBkaEFE7HB0eHxMhQjQhVSBmJykv/aAAwDAQACEQMRAD8A/KbEiVkWZuKjymZIWhcda2khxt1taAFBJWPY1xYxS0x1mm3nZrZR+JpaJUEoO50j6+w9xgaW8l2UUxUdBlJ/Db6pUEHa6J9yMWttvR4gdCG3EvUkiwoje6rkWRh9MuAh1wP0mtE3AW78YfszxZmbLHgrwWrLZhcaiLbhuuPhxZaop9rJCj+uMQ9/dXnYc5tQ0ODWjTSxosaLP5cNMhmy8lzBrMouauZfK0dVKmHFtODe6vt797rAcoOyw9mk+bGWtx8pUErBdWqtWvT7G+ffHQY1uQA/69o36e9/ZLPZdA089fVKnVkqK0OEresLSO2+GmZ5dmiUSFzEBPlVNMrDi0hYBSQjYHgBB4474+XFfdRFCoPQRLV/clKASkp1rHJ5GrYrJ2o+2NR4Fz13wpKjZxOyDKczy2HMfaLEpCXEKe6JAF7kpGuwOLs8nCKLLEHnsvVXQO/6rGJiTHYUiclkORWFpbcdCr0k7cE3vWLctd1xJkRU4xmlo6xT076q0XpHxsVf9ccmR3Xn3HUxkOqdSpaEx0nShAP5x8cijgmAEyc1hNPrixAUBtrqoUW0DelEIs3fxuTfGEv/AN5QZvZa10DMVVmUeRlmZyWi2G23EHT+8hbZ3G596+u3vgCUIiugY/USOkkOlYFdTvVduOd8N1RpeZZwYUxcVh3zHRUtwttNtLKjYNbc9+B8DDx7LvA8f+zxhcjMsw/8UNz3W347KUrYW0BsUruue4vnjC8UWse0tB7RjTSevd16JlFpfItYT/FiumvpKC0rDjdegg8H29v+uLm7YDoYL96LJQdlDWkjUPb496wW4w/EbfaU8hKAptt0tP6mnQRqAUQSDVDb6+2FyydKqWvSP+atu232GPdkmyCJF0SRRceTqWF7FYBCSdNqH+uPo8mWW3I6HEojmkL2tNWa+e5xflka/MqeleTUhkq0XpLo7jf+XfA7QSyOmTJKXFAugIAtrY8nvt9MNc2GAxqsIIIXII8vK6qZKUOtODpntfvfxWGGeZNJiQ4r0hmQFuNIedWQkt/i2ts2gnlG+9H4wCh9pt8vtxkuoQk/hv8AqB9uK4Ffp84uW3IbfdjvpjNPenX+TSARzY2HP+6wdKm157dljnFoDQpQpSGp7axEjhIbCShIOl8jYEg3YJAJG178Y9q/tim+BMz8PeCMp8PxfDsSWrLkuZhLiuLU2wSb6btCxvfue3GPEHnXpucNqZTHiOq0NhQc0I2SE3qUe/N/ODcrzHMFRsyYjIQ6kwnEqU8562WrRrKDYsmgO+xVt3xzcRhWVqzKhMFs+c25b6la57hTIG6KkZhfh+G0xLdKYhDgbAOhLi9ia410n7gDGffpQb6bxKV/m1CqX3wY3oe0KjNPqkqB1EL3BA5Fc+9fGLcvy1xbkZD0d11Mh3pNmMQ4VbfugWSbr67jDie0BMISLzHogFsLMhaGmnwAkFtJu+xvj23w9RCaciRUScwZiq10tGsLSRytwm6vcUjvipM9KlSnI7bIZEcxWkSnFOOMt82CAASeBY+2KpCXZcB6StSpRabQpZaWSGySAC52vaqHxvhZdFpS39o3Redzm4+Y5lAybOpOYZY88XdRaMdL+jWEOKbJO9KP0sjDn+z3xhnPgjMH3snzBxpK4hadWlAkJbSoUQUXQslIvn+WM5HVGTlqg3rff8q51AtSG22iFgBTZ1fiGu3uTV1icyM7lscRVuRnw5ReZjStdUkLC1FOw2cr6g3uMG10QjbTa4FsWVv77kmR0D1FrBabNALPfR7e2JTo2YTpr80IY62ol5YShCLFWQNgBx2wD5gOIUt5Q1gCg2aNjuffb55OJockOQvLlf4TZ6m5sDtseRhb5dAarKbRqUe8Gp7dRsnKENG3AHCXCst1RPsCCsbbWR7YtyV9xXSaQ6+ttDiwyy4SQgEAkitr232xf4fkSmJBeaHUadBDkbQEnpCidCzwdAO43HtvhnHjNsZwprLo/mPNJ6qGh6qG50Wa4A527410hkgqptGiGgAc9ZTRx64acvqF1aCWXFhAKyXPfaz23vY9sIPEOaZGuY0zkeXtxh02kuKcC1OoWjWFnUTVLsGqPCN7G9EwTn2n3o61vxZG9tg6FoQRZI7AFdb++E8xttiWWW1OJRfrAN6CCe/fet+2Aa6bjnClGiyQ5MXJSgtJYztbDrzhT13ElsNpCC2dexNEGtvmxeJmZIjZw1mfiFLk5ySy2+2pe+kaaRrBRuAANhtxgTM8kzWH4fy/OpMNSYktbiWnC6CHFirBTdjtzziAy5qZlcBUWnJQPTUlUxKgbXQ/DNFveu5Fb7YeKjmADnIUbadMguF/zurvDeYRY+bsyM8jiRCaP4kYNp3KDrDadqRZ2uiKJB2wvzadIRnDkvqMaXXQ+2hFFtsBRKE6R6fTxp4HGISmlqmeWSwyZAfUj8FY0fO31732wO23EdKlOJW2ps6tBcrWiuBtzf8APAtZl0TKgae13QmviyZIzmX/AOJM3zGJJzLMHHA+xEZQjpFsaU2kAIo7VosUPfGfQZGlK1rJSkhIJO4NbC+a+mDswezKUQZb76kMaR+Ma6Wv1cc1Zuxzd4Gg6GVliWF9ImiAaIvvdH2GG5c1z6pDBlAaLQt5/ZZ4s/8AudeNFZ3CgwM4Uyw4wG5SwUBzSfWn4BBAPf74yc6dKlvF5x5TjTK19JpQPSbDhJWEA7Dcn+eAG+mjrNybcR+VDyPULHtfI/6YtfjuMLqIh1bK3Clh5TZSVke36jb5GKHPGQAm3PpeEoUmfMLwO0fH+KflnY7TUpp1ClsqBUGtRcZHOo9uf44uzCWJcoyT133nFF6Wt0IWVrsknYbCiL+bxRIkSVMNtNT3XGUx0tqNltNc9Ou+kk+94LcUxpW3EjGNoZbZS6CT1FbArKifRe50D3wsDth0efOSiH+YQDAakFsFp5J2R6QKV9eO2OqZQotutkNtpWG1qC7PvdfT7YmPwkB1TC0U7QWl07e4JwTkSmIecRZpy5rMYSHwhxl/Whlyx/hqUk7X8G9sWNZ27lESA1dkyMui5069lKnZcAvrDXmmk9UtkEAlI2B3JofGAm2WlQ1a5HTdLgQoFv09OuSr3utsSZa1SOoELYbZOpxQo9Mk7H6cbYi5LktyUErBLawtBcAIBu7o+533wsNDiSIIWxAHVfQnIrT0Z5aeuG1gvtrRaKB2Gxs3iL7sVbrq+itttSippOvdse2/P/TFb5ccdL3QCErVoT00kJJFd/0/XBU+K9HWqI4y2l1l2nCrls8aCvgjvgmggEhecotvOBhUBuO251Xk2pxsBSFDagocA3uPpihkpbbDiUq1b6dPb+G//XBcItiKFPNdNthX4hQ6oOPg0en3A2B3rv8AQYumLgDLIhiofgy0tFMorf1+YKySCgBICBo0ggnfnHhBOvIQhrhspMueajS3/wC5JTHihstPL0crCQWhqtagTf6k4XaVKZLvldBQrdYFJ2H5Pa/ST7nFiFhOWqZUFKS24FJIqkqI3278EYNSxGjpc/aDshSFBLjLaT/iAgnVdkA8CjZ3xvyi2XdOfxbmBgFWZg5GEGOmDFjsLQhCHUh0uJdcA/xbO1nXWjgVjnhhlhvNW3ZkpcdlskKW2gOEGtwkHYn67DnfHXYcNTHmS5CSxHcbDiHJA6z/AFLIIQCfQgAA1xfvsKZzrinHiZbr7Bl/iLS5qbdrbVdA2d62G30wYe2oSHXHh+Lcuhykf5tzvRGeZUmLmUyP59KIsZhL0ZLzoUtxtVFCRp21ELsjbuaxTBlhroBSwrQVUYwCXEAWUKuv8x+tCsDQ1QEy328wS8mMsenpEak2dl/89AnaxfviTUhcch6CHW3ArQlwGvf9NiBigNaWgDZC0mTJQUhpCXAlD2skbqANE/fFsFLDrMgvqUyENE9RLRWSu9kc+m/fB0ZS3c1aceuA2r1sFCCUtUdQoXdWPrgHMWSZxeBkFmQdaHJCKU5fJNWOSdxhGIaWnsohcBM8nZZmTYUzMPJ5bl63OiqToJ00gWdAs3xvVWrCtlS03GYfUylRDq1FdpJTejgXe9fU4Lhsx3ZKIs+ShnQ3TCm0IKVE7gOKsbb0SbI9u2JTFNMQ2vKry9euLpeASdaCXFEXr5WABujaqHviJ7hJ6+nVMaLAlJzvYdUsAbAfP9MNoNTCYL8yJETIKHi7IZ1kaQuvUlJUBR399r4wPGPSiSQuGHlu6W2ZGolKD3A7bg9+KxB9t5wpDrKWSEUA0iq2oX9efv8AOPNphxuL8lYSTZUuRXmHFsuodZWhHVpaCCARY2+dt8XRUragOTg8hp1Kwlu1qDjiTq1aRwR2O/fEZynVzlOypEhayACXVEqIAqr+1DDBD8FMDLi4xPbkJec1usPp0KbpISEoqwqwqyTv9sGaIBInTmyGSNklUEL9DTizZuiABf64ayJEOLlZiMtqLz+hctt6OgLaWhS6Dbn5gCCCdh7dhgd6W5J6z8hLKlyHQpb6iS4FAbn4u99vpiMiS0qE5HYgprqhwyFai6kVWgm603vxyMS//VrpmouhUtBD2lbiAkg0fzDvWNb4MmNFlfh7Mc7gQsqzCUHJAUzamnGwQhfUq0j1GqJHuMZFkv8ATLbeopHrKRuNhzgobstOTXElmvw0trTrG57cjv8Aww6m8NcCbleyh1lXJS23MWhaCUaidSFXqFmiCRuP544tpzUhUgFnqjUFr312qtX8+PbHHlyHnA2ourLKdKEkfkSL/ljqFIc6zrzqioUQkD/EPf773+uAqOJuOsrWjquIDkdwrCC6lBNEg6SOLxWQOmFJ00bFXaht3/32xeEwjALqnXjLL2kMdP0Buvza75vaq++Pm0MuFlthL6itP4yemPz6iAE+4/Lz3xjnkjKF4RKrS0REKgVKB9elAugDRJPb/qMM/A2VZZnHivLMsznOUZLAkvhEic43aWB7n/ffDzO/GmZP+Fcr8JeRYy+PlK1gIbYp9RUfxEOrNFYKkg6T9Owxl5st8NvRzOVIZfX1nEgkJ6m/qI99z+uFuzvaQeyef37rYAggyi/F+Wxcn8T5ll0DMWcziRZS2WZjdaH0A7LA+Rh14R8LueL8rz6Y3muUZYvJoS5nQkvlsyE3+RpJ22/qMY0jSNSLIKe4798MpMRlCaYlNy0NtocdcaBARrA23F7E0fnC6jX/ACwwOv1hNpQXSRZdhRlPsf3dgJVHQX3XQoWUAjeie18DnFTDZWbapfrpCa3N/GJrbYby9pKoj6JDh6iXlKpCm9wNIr3B3vscW5ew95hCWSFqQnqppwbfP14wwSRAVFFuZyaR4k8sznXICToWI0hTjNFhwnahsAv0EfrgaP8A3aZ5pCHUJbdtBGxSQdvvhoMwca8OeUdbyx96RIDzj6QTISGyv0qPFEqv3NDfAJeW6tbejyrLig662gbDncA/CjQx5rQ0jcrq0xaSEbnDwkKkzzPBfdWOsg6kuO9TUta6qqB5+o2wqUHUam0trXoVr6iBZFbWD7YYPJykMzUx0TF6ZFxX3VhKekL9K0AfnPp4O2+BlrjJLSISNloSlxUkJoO1S9JH7m9741oaXSdEdao52oifZE5TnGaZbHzBbLjvlMyb8vNKkhRdGoOVrI2NgGxvj7JZEFjOozr8SROy9DlPsNO9J11PJo0a+tYp/ZslTsqOzDElbb6IyXImp1KnNxSCjZWuj9a2wT+2s8i5OjI5HWayqPmHmVtdHQUSNNH1UCDQ4vC6sluXfxjlv6lMeG3FpRHibIHcpitpmZfKiSS++0sOPtrQsoUNkaPYHcnnasDeEz4edW9/4kceLLCFOsttudIOkA23YQo6lbUeBW+JZ5FyiIlxmPLM6Qh4ESo3/wB7qaLQNBKwF6wTRJ22wraMQZe55hqWuQl1C45SQGikE9TX3v8AIAR9+2FseflkePL/AHQVxMIRDjSkS1PQ3H3FNJKFIc0pboiyQBvtt2q8NC9BfjOKWlDZbiOJXJQUFcgkgNgoOyKFD0C6BPvgZyE+y7Lm+XS7AbkIDz0Y6m/VuG9fH2Pt8YHlQZDLSnFAssqWG0h4oQ4q6ULRdhPzVYfAygkxOy5bhcmJV5dbamKdy5yW8tpxTzL5cCXBpAKFEWQCOdj8YEltPOy6adbedkIDiktWdJO5B+ebxx4w/wAECOQ825pebC7QrSOQoHub4+2CUR1Msx80YkjS4vorSlxAdQurUNBN1R2Vx25Bw2ROg50SwZhaGSvwpmH9niBFiSj4ojyR1HkBDUYwm2wPy93NZ53J5POFfiTw/NyF9GXyH2TKVGRMpmUhxKEOALQjb/ie6R/TC91cdTjJbY6XSVQA9SlnWSCe11Q2obcYszdxuYk5kVJDzzi1Px0N6ENErUaQL3RX0omsG4NygQiDS0kyiPMzGHp7GRzJz8bMGUNyuo2NSwVggLIsfmSDYPx74plokyJDWS/sgRpiC2wWUMrDinACODZ1q79r4GLGHYCMkbbQ1M/aq3nOsVrBjuxwjZGjnXqBN3XHfFU3OHJmWxYzzILrCypL4P4lUNr5O9ncnmtsMp04LRMgeMxzw8UlxBadjznJQdR2YjiXHX0SC6UrZ6YCKA2N+9/G2CJ8tuTOIRlEaAuz0kxy4kNgA1sSTd72d9vbC50LUUJJC00SgA3Qv/vglc6aA++uQ6t18AvOOm1r32IPPbm8a9gDwgDzEc5dDOtK6j2laFoaNakXS9+R9cWuOMpMZEJtfWR/xbNrVdihwK4wTIegu5bD8rFfjvx0kS3Q7aXV6yUKSK9FIocmzviEGEZjUhzzcNrpNFwIdWR1SP3Ebfn9h3wqsWMvKJjC60KptNuSZSnWw6yb6bqLU5Zo9qvfviufHitKbabktuK0JLjiN0XV7d/g7c4+YQVvrStaEpDZKuptex+tn2wYuBBfj64M0LLMMPykytDJ6mvSUNbnqVYPud9tsIcQDffdGRIslOlwthwpJbHpG/HfB3llf/hKD/8ANP8ApiUKclh3X5GC6AptdPN2LQD6eeD3Hc1xirzbn/usT/5Y/wBcea0uJgkeSwQAnGRZU9MzeRl2Qw5WeqcYcKENMFLikotZUBudgkEgdrwsbSwt5tleYhHrCeqUHS2Lq/eq32wV5+RFcbdhIMN5jUGZLOttwgk8qu7ANA+22KoClBqVbsRKUw1pHWj6yoFQtKdjS971dt98aMwgG4CW4ETCcZzmub+JsqiDMhHeh5DEERh1lttDikLWdGq/W5Z77kDGadb/ACAaWVk6VoNjSR3P1w0yzLJ+Z5qzlKdbx6Lj2lJCqQEFwn42G+Izpjshay+tYkdMaw7+aR7EmuwA55w5kEQB19eeK8DO6siypT2UuZHHaiupYdXOEoM6XUkNjWCs76KTxxf1wqkPIdKVOoPVBJXqXq1WTvfattsH5PmmZsyC9CLnVDDiXXB6/wAKt9jtQF/r74GixG5TqujppLOrpqcCVFXskblVE8ckYJzs1x6dyGA3RVxGnHJDr7S+myyoFbqUEBAJq9txzj7LXIbE5D0yL56K0r1toeLRcF7b7kfpisPutloICgUaVkOeoEjg1XFViyORIfWXGeo49slLaOVkjgDg/wC6xK995C9aLpt4XkHJs/y3PGYbE9GXy2nFxnkh1Dm5VoCf39hv7HBv9o2ajxLnc7xEMty3LUzny+2xCBDY7EAcA8E+5OF+VRHJWX5i8lSGHYAbU0tyRocBKqKEAD1qPt2CThWsrjKkstvLtwaFqogn3SR9ff2ww0Q14qxciOefn3rGva4kBSQyyUamHkn0L1IU2SUgAeq67m69sTmNwUR4zqXn3Jdq80ytACEAUEaVg+uxd7CvnFpcjtRKSlS3HGdJN0ASqzwdqFc3yfjE86zBqayymNlsSAyl11bYaeWo0a9J1qOwrb6nnGuZBjbnmiF4hTiSurk7mVLj6VpdU+p+gSNgKO1gDc898Qyt15CpzrGVCcpDAAeUlTgi0tP4n+WqGn1WKViOYJXIlLLEnzLMeOgJWEIbUppNDcA8/qffEHFtNS328ulPoYctB6qNOtPNLCCRz237YKqXGANu5aG9QjIMeXKi5g2l9gpZVammqOrWsAlKe6RV2PjtghnNIsp7L4mcSFnL8tZdEcRI7aHVbq0gmu5okrvbCVpp5IdSykq/Duk7kg+9e38CMOfFMJ6JLjyp0JeXsZrEbmMMNv8AUPTIIbXqJOyigmibG+3GFvdMT0KwsOhQMhmFIbbYjNOOONErckdf0raCQaCSNiPWeT7dt5S8vjdCG7l88Sn3FKStny5AYF0i1VSyR7YpcjrQnZhssoe0kBwKBJ4F9zzvxhpmOf5hMmT1RENZHHlaAuNBCm2llpICARfN737knBfKbEkkfdLOcGGiUqYniMChtJQtNaL3CTX5xe4N74MQVIaCVSEt+SaK0LZRSwsi7JBB5ISe49tsMmouXy8vXFjMS5MgqacD7ziAWjRQ4le1kfk0Udt7+AhCadXDZQgqW60UNoZc3dcspvckgk6dtr7YBzDq4LCD0V3illaIWXMRwx5SY0qfHAfQ442F7KbcIA9QKSfV2qqvcPKcszFyBIzaPHkOQ4aUdV4oppoLUQNZ9iQR84qSpcBUiHLjsqcDRZIfYJLSrQdvavf2v3wWw85HaeacDBYCQjUF6aIXsugQVkaiQCPttgGgaG/O5Y8O0atJmTUbJMncysQoyJGZxVsqS9IVrad6yFgejSK2BBWNNE0T2x2WoYL4XPLgjlC20/gBZWoD8g32557fOHuXSsjgZ7AzZzRmTaGOq8yoEDzI1aA6Ddtk1YTQo1YO+FcuQ5m2Y9ZvLYrLgtzy0ROlopFkkAEnajZvgY3/AHJGtllKW2KuhiMqO2Z0mS+0GzpDVaG63AOx5BWONj8YKby3QwkyXG461MhTA0m3+KFD3C7s+3vhXlLilSmmgpYJJLiUIPrAQfb3Fjjg40UGfCSuIyypxcRTKNswJDcZxZOso0GygEkg997GNcw1IdKraQ0xdN/DMORnCYmT5d4fanTVsGO3pjlLrZLhX1Nj+IvkazsAara8A5kgZfmM/LM4Q9AktJcbLZa1/iAgoQsH8gJFWMGeGPFsrwj4lbzfJk/jR3/w1rTuUXX8R3wf4yzWF4mazXP8ycdX4gU8glKEAM6DsVlXOsL2CO4N9scsmt/1GwyRrvPNF2w7DMwoic07X7/Tfx2WWh24gqWllttshfRDlLWFngHk8/bGg8VZL4V/8AQX8tzCSvxEXHHp0ZwIbbQ0Kot3Vncegb1ftgTKpnhGHkM1E6HNfzk9NURxZHSQBfUQ4gbm67HCnyip7UplXlENBsPrDjgvpg1aCea7gG6+mKSJGaVzXEvdGkH1SefHRHUTCfRKbaC2+slgJQ7ybAX6zseSLG2K0xpDmWguI6DK21BpTlDWAQfqo81+mD/EWXL8Puw2GZqHi/GQ68PLFGhwOG27P59BR+cbHC9S48bLnVKkhx95Y1Mls30/fqdjY4r79sPJEzF0mZbE89lcMtcbzJeWx3Y7iVKS0iQ5baF+v82/A+vteKjPebhSIyFBmLNU2JDSHT/wzYJ7dyRhi82uXlsMKnzKcV0VeYattACLbAI+FkV8jtgNxKWCpSWnUIkNKTIbTTaSUr9NDc1YQSOb+MOzOIjZIJBIhU5jHEZl1K2ZLkxJWhzqjWGm0UAoLHJ7ewoe+30qZBby9EdMDy8pDZadUb/FGoLQ5vw5uQe2itrskdx5a0ltwuNpaZ6bQFN+jneuSb++LH4jnkm5cxSlo0llCesnWFgEik86O11zYxkkkHTm6wttdDkrfkPKaR+ETSlWVBsKPc1t9axqcogIybxZAVNjws8hR32i9HgzC6iQn0E0pO6CuxXG+3asZkuKaDrcGTI6DqW+sKKeoRRIIuiAvi/jG6byvxx/Zzm2R+NpOXeSUVomRlllC0j/AC6k3VmwoD52rAVKrCQxxuZgaTbZDDhcc4Vj5iHH8ymvZdElMoS4t0NHfotrURSj9wLoYqivv9FxhSka3APQtPO2xHYVvuffE5k17MsykSJLba3JT6331KV0gskkn4G9/wAMUtOLccS75ulNoDQANEIO1E/fnFFN5bBKxzRoplY6Ty9UVxKW29KVH1gA8J/r8Y3GTtf2bj+z7Pmn5ucft0pbMDr+hq9CStJQgnewtIJ2rmsYKQp2Oh6KFRdHV9QaIPrSNN6vb1HvRx8paJb7aGGENqS0hvSBtq00dieSd/r7Ysw9fK8gNmee/wCkupSztHaIjl0Q6lpbjQjtN9MoHULYWkkAUUrG9E6L+97YI8MjJ23ZMnPIcxxhUZ8trbdKQpzTSAaF1rKbxdmmW+IsneleD8xhyI8xqSh56KdyHAmgTR9l/wAccyrK1ZnmL4hOswXMujmS756UhpH4f50J1itZPCD/ABwvEODJEeO0eh9E1t2yPJKXnnXYojmWCy25pS2Emt+Vj9BhjAfYVlJiOx9Ky8FuS1a9SUhJCG9P5eQd+dyMBOhszEIDKQ20lHUWySSoD86jfc3/ACwQzJOXvFpwNrBUhbUdxS9DRCyUgg0OCeb/ADfXB4c5CCNCidJs7VDp6TbzapDR6SxbqWjRr7jazgaMUJf1rb6raDq6ZWQCPaxxjbf2ueLWvGHiuTPGVZTl56DTafINlpv8Mfmo+/8ApjNKy5SC3GedQZgdWlcNxK7aAo6iRtvvsN9vpg3VACOp25b7IG3ElARUR+ofMlQJRQJ9OlRNb7HYYYZ9mmYZo9HekIYShLbbbaWYwbbWGxoBCRso7bnkkm8Lg6tExUxPS1NuA6Ox3vj22w1hSYT2c5eem/l0YdMOrZtS0mz+InvfB29sE1pm+unNl5xEJew8PMl5pgB0bhAA577Vx8YJjtRnZUSG2+2tLminHnOillR5RrO217k7fTFssiCYMpjzEeWVKfEoq0lxOv0OIA4OyucURm2H2pT0t8MBDKiwltvVrX2FE7DY7j+OMLp01WHqVBzyKocRpmKtMxC3PMOKkgtui/RQr0Vv3N4pddWhpTCjqAJSQAQduLv7nDaOnJv2Orzhkx5aI/8Ady1f95cWu9e4pCEAaSBzsR3wveaBkPIW89oA6rjldWjXc7HkgffGAFrc2153P31WNNyApvTn5jj03M9Uh9+9DriP8Q7JJPvSRt7HE1eblRR5qQ48xCQGkBayekjXskf5ATf3xLptu5I2Q/FKW5GnT1SHSNAv8M7ACzvtZvGp8Fw8+8Uyc9eynIE+JH2srdbVrYCVsMgAB0aDXUCRQ574Nj2NJzG3Pv0WPcWjNCxkhqO5IKm0ga+mrS0CdF8ge5FjH0mJIYltJfgrjgMIWA9rT1ElNhe+4Cxx23wRk0USM8jwZU5rLEurShx5xk6Wq3BAQCq9huBe+CYj8uE07JiPBHXbch6VlLilpVXo0qsgVXrofY4lYwuhztOfY7+qY95Do3QUZyOxNQ/KykuNhtB6QdWgdt753/rhnAZnN5HGS5ncOJAnqWwtlDnUd/BOtJW2NwCV7Hg7+2IZbEazB99ktxo72hYQha+m3rAJo39DuSK2xSGyyUJ6CERltgepr8xFjVfci7sGvjDvl1GuaW270tzpsUsUmRIWUOuOOhpJSAq7QL9u25/jg3xCluTmxe8mxl3UQhRaYRTaD0xQAvvVn2vEUFpD4ptT6nSU9QGvUaqvv7++OyYeqO4VKU5PL4StlKCrYAgkm+b2oj5vDKrBB1J5zwC1l4KHLUrJ57IkNrZvQ6gWlX4ahYI5BsHY4CSpLKHR2WjSk2D3HP29sFturkyGvOSnGWmm9CFlJcoDcAD6/pghxrzmavfsaGt1AQXqUnqqQNAKyo0BQNm62xzagGSQdFQ0EKOW5vNyyG/DhuyGH5CCytxC+mQhYKHEbchYoG/bA2ZZdJyvM3IeZxzHfbUQ40vlHti+YhcHMXPxi1MZcKVJQkU2oEittv0wG0yXNaCunQm6J5rt9cKyFpnqmFqrUVJr8FzrEXqJN37jBamnBDjrXDWQ8SeobtxINHTt72CReGWcsZMxEYXk+cTHnVNoU4zKj9JTalJ3SDrIUB70NjhVOQ6w3HaXKaeaW0l1Iad1hu79JHZXuMY0mBK85sIRsFbxU0hyhwE8gYYs5e61PXESiUJjd9NgNnWpwe1cEc/bFEFbjQdeaecbKkaDpsaweUE/Tt3w8k5z4kjiC2rOno8jI21QoaW1htxltZX1EoUjn86rN/vYJxcCSIQBpIhAToOb5e4+mdFfjyyAt8Sm6dKXRYJC99xRuu/O+A4sEuSUNvNP6HFABbSNWoXVpG14LzLMZ+Yrbly8wnSnVMpbcdkOFalaNgmydwBQGPRkI/shjf2RxFranTfGQmFLzPVWht1vVupJr0Ao4sHfscJr1flBpLSZMGP3oE+lRFTeF5YkArbEhGhpB0qLaaUoXffk/XGj8HJyx7ME5D4nzSblGSlanpzjLIdX1EIWGyGzRu1VV9ycJV2271GUqaCwa1K1HSbFX9MNV5XIZyOLMeQ0o5ktTjDxkIUQlslCwocoskc841ryTExYp7MLoIQz7DcZTDqeuZIX1R1ChaC1sUEc73dg/T3xOOlsymTPS87HaKk03SV1ZO23ub3GH6fDz0KPkEgiA49mNvNK80HEAa9CEOtgWg2DydwRj5GTTDLfhpyx9UqKXPOMNI1hARdr9J2Av6YBlWQI0n3XYoYEOvvz7pCltptltCDqWq+qsKKRXtWNBneVZNl7WVhjOY+ZuzoSHnVArqGtVjpuK7lG2wGFpafZjpUpwoSd9h898VZgY28Vhbatbll0IAB5ArawK7fQ4Y4dkyOiqq0flkRbu5+VfmbUN16X+yhLdy1kgtF9I1gqoCwDQJI3q8AuhuOH4kqGtt8EJvWfwyCdepPdX6VWIrQotqU3rCBV2b+MQeStVSXHLUT+8rUfv7b++NFTKPFT1KZtKtXLUGAiG64whCEFwB1VOOAkBVdjR7cb774vzPOZ0tlLKJTiNDnWcCSs9R0AjqEWRdbX7YAecWtJQikt3qquT7/xw0cjHKW8uzF9UOUXFoedjKUA6j1LoFBF0QgGxYpQ98eeQRoJ6KcuyyCdUtWlKoRdSmR1SpZf9IDabIrf+fHIxKY+zKiOJOhsNgJa0WLFkmxW53G+3bnDJ95iYpSpLim0lgqV0Y2hEd29h0waOsgCzVXdbYv8G+IZfhx+RIh5Xl+ZdWE6wtM6KHkNdTZSwOxFbHANBIyC57tvt9UD520+vJWZaW8ll9qiGHglWlSiEkg0FVwTzz7nDDxNOn5xIbzDNZr83MlNht5x1KSUhv8ADQAtJ39CAN/b74IdblZTnDicxhOxHWgkdBaaLYWi0EpN6hwaPP3xVFju+bkZbGJlMLUgEqc6KNeqkLOuhtah69tycMyAkOm/28en4UlSllmFLwnJOQ58mYw75jpADWw2lVtuJKFkBwVYBrcc+3OKk5Q4t1TjEqE6hmKJSELlIvp6v8P5c90DfEITjmXy46xlrbzsd2wVWpDtH1pOk0sdtjxWIxegyl4vML6yBqbI4BJFD47m9+OMe7UoadIESrJuYKeSzPQwmKpIPTDBrQv43tIHa/nEMyhSWllEjLHorjCE+bd1EglZtKj2GygKHxiqOsjLltJbjL/GSorUPxbUkgAd6G527kfGKJMdpoOsqcdbfQUjouNFO/cV2r5wxjjEEIasugkqx2MqVmreXQJS32XXgzGceAZCrOxNmkbnffH02I9BlyYzyWeow8thSA4hQBBI/N3F3v3wFoKGgu6Nmu1Vhs6WvPpCEssNIZKVrbcS6pfosrs3ub/oOMVYcEOBB51UjxIghA5rlsuBoOYRnojjzbbrTbrRTraWCQ4D3Hz3x8xJU1GXEC1t9VOhYvSnTqB3I/MNsTM15xkLls+YCG0x4rjrhIZCFXQF0didjtveB3Al6MouPepCQEDTe3ASP54858TIuga3cIllowJTrDimZTIDiNTTg0ubH1JVW/1+2JPqmMRm5rzCkqkKCkSg2UG0enQgiq+ft91zod0JbCXEookDn6n+GLIzc/MX2cuZ68t1bmltpBKvUT2HcnE4MtI680Tc0COi+dlgx40duIyjoKKlOBNqdJN+r3obV9cDK1yHFq25/KBsLPA9sN/CMyRC8QRJEfLMuzEpJuNOb1x3hW4WCRt35G+FK1JB2Snc2QO+/GMcBl1SwJ1RsVqM1GeEjL5T7zzBLS0HQlv1D8Tj1DZYrYb87YD8vI/8o/8ArGJtvrhvOBlaCSkp178H29sR6r//AL4P/mHC2tuZHv8A1H2YTBmR5x1qO91VpUjo6gb02dq7kA719cfZtleZ5BnD+XZow/Cnw3ChxlzZTax2/ltgjybxy9eYTldBtDyGkagv+8EElWlQ227/AGrFWcR3kzVGUOio/nDhJdbJ7OA+qxY3r2w6AxsHX7eCB5c5wINlCK3LQuVOiuNvtsJQ9I0OdP0KUkV2PJAIR/IYpzWNJSw1mT2vy0tbnl1rcCirSfV88nuBeDoZQ3GlLQwh0KbDLiuilSdGpI1hRFtGwN67174ln0LKYeV5avKMyXMflQgvMG3I4T5d3WfQhX7+wBse9YDIQNJSXOhwA3S0TniuQh0srMlXrccB9Bvnba/scaPLmxlsYZnmDkRBdYkScsfjSaeLw9CDYtaACCQhegk/GFDLetMdchyGsvOl1xKndNaDuHQBYvt9cMM5yCTGMLMI0vK0R85Q6+1Hizkr6TaXCOmsEgg8UDuceL8r2g3JWOaHNiUijCTG/HFth1tYQpagNSa9Q+4NYilv+6FSmvzEKCwLKKsAH4J7/GK4mlEtILTbhSvZtzgkHg79+MHT1sywJiwhvWv19FrppSOA2BxsB3/U4zL2u9FmOinkS0uZ1CQrLV5k0l4LML1kyK3KCUb778bi8RzzL5zM2U5LhOw1F4hxChWhZGvT9hWCGIsNvLv2lHzVpl0Ppa0ayH2zoJKwgcovbXfJ4wXDjjM8vdflRpi9DPlowjLAHXoFHUB5GhB432Hti80jF7pAMukJXKy6XAaDb4b1OsodoOBQS2sAoWSDW98HcYpeWIc5Yhz1PI0lpLvTKCUEUQQeNiffDJ+BEy8iQ47EkNtrbSqOh8L6upOo/ko0PVZ7GhhSW0lay2WlppQSkE7UBvv/AL2OE1aLmRJTmuzWVkcymFr6egqaTrUkpCtiKJ7jg/x98S66EtpQGEISWwFLu72o/wAwfqO+KpCFoWC6pbjyEJGrlAFDRv8ATBK0Oqy1xtxtsBXSLRMelkUdkkfBs+9DCQ8EJoG6J8SxIuTZvJh5RnKcyipGluey240mUggXSF7ijYN+2K2cyfYhvZatppMdb6HpADCFrtAKBSiCU/mPBqyPbFcJg5g8iI/NRHWtQCHZRIbaRuSpR3IG/YG7xBpyK4ytSGnUvJYCWghYNruyVWNxQO3bbAXfE36LagyiN1UuQ+ZLqgVrSolSOqAohJN/17d8MXpyZst2RNYR03UHpsRm+khDmgAUgbD+tfONN4L8SZNln9nniPJs/wAiOZyJbYXlbvVCTFdXSFrHc2AAfaq74zC8wcfmD9pSXH1rLalPOvUstobpCLo1QAr22woV3ve5pBgbk6835AsLRBm6ZNZlm8XKpmXswVRW21NOSHFI0kpQvbqDvSiNu2/zgPPVytAakobUlx4ynKYRaQ4PQdY5GgWBsBvthbmUhc53zpdckJQE9QuL9YJPFkkn64JyvyErOURJ8z9lwHnA3KeDSnlJQV2SU36yn7cYZ8xx/wBGVjidfopyFxIzpiwczcfjrLakOONllChopYIskf5fnnbGt8bQvBbcfK3vA8zO5byobTkvrRxoac3Q4L5FGqvbfGOdhsPW6zm8V98X+GhlaSoDgAaaugT7DbfBsVx9cl9iFIcjh9KG3UNfhNlukcov3AWSdtrwj5WZ7SSbe/shmf8AOqEzyHGadbEcyOks8rCbNGjtzYO2/NX3xaG8qaZBan65DaVqdbMfY0dACF2dyCV2aA+cdzbL2G+m2nMkz5shxxMhPTJ6BCvz9T/iBQBII7YgqO7KamSXosRC4zTDzluoZtugim0CtRNoJoE7E++GnsG4Qtu0GSgQekiQ1IYSp0hOhzqfkVfbejY5wwivB6MxHipfXKfWVPDqDpHb0UOQQNdknvhdHbjIkkLadcaJ/IF6XAPe+2/xi6LKkQ2Xo6UIWik+ppSKuwd1VZ499sNpQjfeIV8ScCsKcJCe6wTaN/8ATb74d5iI7ctSGHmJHSIUwtv0NrQaKNrsUDVE2PfCVcqAKdalSky0m7q+qVnej2I9zd4YeGpoOcsOKy2K4Er0CImPqQ6Cd21C9arJrmx2PGEVBlcYuq6MOgbqDzq3mJXm4Mp55Ggok9T0NhazrsVwe1cH3wDl0Z10JfS90W+p01uq4RfG3Pvgie4yqW8l1tplHVJWGXLKRqNJSgn8oo2N+xOJx46zl8dHlo/WdcQWXkObIBG6F/J2+n3x6Mw0Ql+WwU48N6VmUTK4iYjb3WLPWdWA0u11Z6n5BR/rjVeMP7JfEPhJ3Ln/ABDlio+VPvloyoauv1Eo5cb33sWsDYH6cAP5/mGTZPmHhWXlkVHmkHQZUfU/HXrQVlG/4ZOiiasj4w2neP8Axj4r8KQcmkZ5JbaytmojMdJ1r3DRbNdyF9zwK74MtuAPNc6pVqlwIAjn8WQjylJcmjqluE85r8sOoEFF9gbo173zzhdmGiS+HEPa3j+GCTQ4NG8F5tBnZVMmQsyZfYmtPdF6NIbp1kg3pIvmucUaoxia40YR1FxXUUqRbdVsgCrHB3vuME1gnPsnRFuqAi9Jl1EgNR3221gBt4qHXHdJAO36j4w5bYhnwlJlP59Wcx5o6OXeWKushaD1HC78UBoOPp+XJV5NmOz5FUiGh0tuv9UEkWXLr0Ag7CyRW+5wrzeEYs1yMhSnek3a0lSF6DW+6CQRvyMMaxomLoXONtkO0FrKUIJbU6jcI4O+wr9MajxD428Q5/Ay3Ks/lPyEZKhpmIiQfw29Gx6iTz2GEuZs5PHy9oRpypEoobLjRjKFXZUgknbTQ4519qwPlbzDLz70xKgVtrLSA2FjXRokHYjt/Htj3ygCLAkaaGJ75RlwdqUwtp4vsecQGi71GVNNhpC7s6lVuAihQo1ZG2FuZpY/a0hlpxhxtCykONoJS4R3F77n3OOx4mYSHkUlJeKxssgaaF7g7AViTyS+VsxCXQhItTY9J9NXVCr9ub98eY0NJA5/VmaQJVj7LbuZU+6wlC1Wt2IwVN8X6QK77UKqsTh5ep6E5IbQ20lSHKcW4R0ltgFf1sED74JZeOTxER+hmLU5Ej8fU4EIGgCkaAL1oXfJ+2ImHIda/aLiIy4zLgYK+n/iE2fjUa3vnjDWUe0DrKA1SR0VcOVLEpeZKeKUx1oAcUsa0LolFcm9jvx74Hi9KRJdlTJEjQVnrOBJcNnizfc99+cHR2lylNRlL9LC9DaUIRqSVkE1x34s7fGDWogyTxYRn2Ruv/sx/qSoE5os9Ru+HCCCLv8AX3vBVzYgGSRPjz+r1NwcZtZZmQ8hRZVp9IFFJIs777j9N+2NR4FhOZijOJDeYZTBTDhuPaZzv/3w2BvHQbs2Ow9qsXjPKYhrzdxxDjkPLVuLUwp5vWQmzpCgjv2xFqSEL0mLRba0NpNAgk3Z29ffY+49sAzUSNed6J1xAN1eqUt3L1Q5TIL61h0SHFUdAQfRZ97/AJYEYdfZd1pSgXpdCUHYJBvtx/PF8RMXqy/NJkI1oKI6qBSHLAJUSPyAFXG/GBwUreC3W3HVqVqHCAofX7YZMQ4c8l6cyjM6qluawi+qsrP75PJvvWDcrW2iBJUGEl9stOMul/Spv17gI/4hO23YC/fF2QzEtZm8UxIb4ejLbPmWuqGdrLiBY9QrY7/fEoU6VFZnJiIStE2mXik/4iL1FNfJQk7URQwxgBaMpv58uhMk3FlLxVnWZZ/n83NcxhQ25TpAeSzFDKW62/KNk8VgSWptl8sNyW5DJbRqLJI17Xua5BPt2wxhuxnMrmCSy8JLLi1mUg2srXQQhzWQAixZIF7/ABiph1lENhLS4q3FLKlBVpLe9AuE7Hkn/thzajnuLgfVCGNYMvRK48uT5ltyIkIdCAy3oTvxV17m+fnFml91SmAdLqhpeLiwODwT9sFOuMt5lJ0wmH0LStGlw+lJUitYKK4O47cc4GCUuxfKtsNILOt1bxsLVsPTzVA8UL3OEsLg29wtETZTLTAbU9Ffde2CtJaFprlSgCaAJFe+NH4E8SzPDUl1xp+clqewWZKYc4RiWjym6NEgGr9+MZhLrysvSttblJJSvQQAAfevf59sHxZEZLKoComXPqccbBdcQeoNBUQAq6AN0fcAcVeAs5mV4mV57JsCoZfJSwmU83L6LpQC2S3rUaXYCF1aDYG4r+mL8il5XFzPzMlx9DamHfS2wHOm6QdA9Z3HFnmvfAUBp1xtWqmkI/DS7YAtfZRP7lA/xxOSVh1g9Ax4QX1G2j+KCRQVSjzZHHG+NdVIiBKECASn2T5tLR0taWZAEXyqGnWAfw9evQfffud+2F2ZRpQcW0YUhSWXi2tOj8pBNoR7cH9MMcttQfmIQz5nrkONKbttAI47jckgDkY54mVlELPWEZdPkT4nSbU670SyoOBBtqr4B2scj2xr6jmywdOnN01tEupio42mEleXILbTZeKy3H0MqVuhts6qSNt7s79jitqTIhsPMCfpXIbUy82nf0hQIFkVRIBsHB7ElTrT+bzWutqR5dtbUkNOMPUKWAN1+hBG4rfm+c+kqDp8y3rOnp0vYitvtVYWXuYBz0K80NdYaJo+t52BFyxWadVDa3AxHXsGCtQvnYXQNg9sDsw5jqX5QUlDbaNKy2m7BFDZPYmh7WcfMuL6gHmekpxCkLtv0ISdq787ce+GrrCoOV5dKcjpa8weq2FBLnXQhylhwA2U60/lUL+2EhjXEhttSqRBF7rNqbs6UrXx6wRVHBUnLXmQA82tlzUhKm3dl2Rd6ea+cESX4klawyylhanVOBTaK1IJutIPpqtvg4P8T+J818VTDmefzX5c5aG0uPq5WEDSgUKGw2wlwcHbRf8AVk6m1rxJSd1LTLryGA8pq/Qo0D8WMVhFn0q0Iv61hnGcbXEksiEp+W8EBmQl8goQOU6eDYH2xYEyVBuX+AVnToGgC9G1UNuw+uNDZgC6oZSkGdEBIihMNUtl5PllSS2hpTyC5sLspHwauqvHTFdYcSpaUuKoPBCVawQRdkg7fTnDGO0w5FkNvQlF9ZBZdQSOjuL23sVYo8Xj6UHOqyXIjLPSbQ0Q1bfVA2N+5Pc4IMI1Meq1uGce0BZBtuSpiW2H5YSwFkp6q/Q2V7qNfJA4++LsnbWiSktNuOOOLCUBBF2Txhxn6MvfnqVluVMZdFkr67LQU4pbKF7dLqLrqAEHevffE3I8WLOTLjpWltARYJ1lNDkHbYn/AHthTw9ohgvddDBYZxiobH6IPN8pm5NmD+V5pFehS2VaX2Xm9K2jzRH6YtEOMhsNuFpDqQpXXDltubA6dhzv/rgrP58nxDn8rNX21NOSfUEreLq1EIqytZs7o3v3xQIz8t5bSmpXTjj8TYuBmtqv9B+gxMwmwefxP9XRpgGDF9ERks6TH85bcWQqax01mQyHVpBIJWi+F7c81eNROzXIm/DWWOZNEnQM+S64ZUhDtNuAkaAgDcVxRxmsthyJz762EIV5ZgyHU6wyG0I2J/lsN98Cnpq6jpbWhtI/DA4JwQwmYhw1/G66uHxApsI17vXX6+ilJkwum60mK46tawsuuOUaHNJ4s/fEcuhrWczlN5M/IYYaUaLa3A3q2SVqRVVd3xYG2BFlLz55VZ/P7b84dQPEWfRE5nCyfMpDLWZNtMSWog6SHm2wKsfbn63zhrWgwHrlYvMSSxZ+UHFynUNO+YCzrWWro0LJo77b84g1HdlMSJiQSwwpCXHDRNrvQKJ3uvtjV/2deFZfj/xXFyGHJyyI+tslPmPwmiEgndSdyr+Jxmc/jsxJbuWNBsPRUrYccSeoHnEr3IPAHtXNfOEh2Y5Ce1rpzXmygrEtmFXKmoMJiM5CbjOo6hW+1aVvAnYEHbYihVbY0HiXxFI8SPNzc+zZvN5USLHhRWeiptfSCOUqAG6ON+SbojGZcTGXlyyqS+qeX1BTa2vQG6u9d3ZVtVffesdgKQxrfXFUsBvQlzqFPTcPBBHegdj84ccO20c6qQPLj4La5t4e8LxvDmUTYvitpGY5iHzmECS0smGACtvUtF6wSBuB3HzjGxG2Fl9zrqSdHo1J3WbGxI474GWwpT7LKSpLbhHTK9uTz9LwVKLhCWgptxLdoSUHkAn23re998DSa4ASqAZJE6KcyG0yZTvno8hXVW0Omtevi+oNhaDuAe/sMTkHKmUx5DbzWYl2IoONvNLQWFkqQL3FqGxBFji++AiVuuBxSC4quFg7iudt8WSIxRDSpx2OoJUAhSLJXYBI37D+ZOKBbRTuBAgiZ5sr2Mxfj9Hy0p5AabUltIOkIKxS9uKI/XvhmIGSnw07LbnIOYR3SVRHEBFo4/Dds9TfsAOCcVMZqqBkfkIkaOx1aVJccZQ4tZSbFEjYfA/jgN6MhKCHHUIGyg3vwRdj+WPPpjY85+NlTTaQMpHCi5XhnM8tmR4zrSn31x25SxGUhzptFIcsEHZYB39sUSHIc17MH5+cynWkqL7PmGNT8l1em7IujtZJO4HucXZnmy3nWJiY7DK0NNtEMahr0ADWSSTrNbkYv/tEzbw3nOfIzHwt4bT4fZ6aOvGTILrYWK9aARsD7b98acp7NOVJVp/Lc0uEmFmWpDSEOodYbfWpvShSlKts3+YUavat7FHEEK1MrdVqDiXQen09inuSrt2H37YvecYAeRHWnpaklZdQCtZv+XfF2VsRZM2JEnLTDYU+IzklAPTKCsla1kXwCDsOBhjdM0xG/L+l+5QVAc2XVVx5kdGcsSJzDeZNDQXG3VLbStNVoJRvXG49sQl9B1DiwpMZSzrQ2hshtPPoFkmvY4f5jlWWeHc5XGZzVjMEtS3IgcZBC3EAoIe6a0WElBNd73HG6/Mo0U5lma4k6CIiuq5GcNqDg2PTSSi9e4FkAbHjBj5ZAI/+hP07+eRWBrmyXHSx5z3SdK46FsOBDjqqJkNH0jk7Ajeqr+WOyorsQFmQ27Hktp16XhptJFggHfcGxiLUYpYRJKkELWUISFp1Kqr25HOx/wBMMcwcRmMJc+VPU/mjr6WhG6BJLYRQVrHp2oCqvCQ2QboQIBKAzJ/qyw4mU840lISytytYRXFD64KlxV5QpSGM1irW9EbUtMdfUSQuldInixtfztyMFZt+wo8HLMxyl+U3mCnHFyoawNEalDp6HLJXY3JIFHbCR1XXUCSrTQO4J+pxj2BpiRCwknXVcjLR1Oo8pK/V6kKFlXc/yrm98G0z/wC75P8A/Md/1wOcvfaaZeeZUWnQpTZT6tYSaUduKrHOpl/+aZ/+Tj3yPmAGYWU3RIcr2A642wy11Jb122hFqSm96CK5v7YNjqn5lmaoTUVD8zMJCWUtrB1hw+lIHtuR9x2wNlT0yLLjP5X5huagqS280SFazsK+21DB2UZRmmYF45dClzJCQXXKaUpTaED1uEDtd7+498eLuzmaL/r1RNEnKqMxbYgD9mCOE5g0+tqS5rBRsoigf5n6YXSG5HQb1qtNeiv9/GC3YkpMryggqffvQKQtRX3uubI3+mDHmYQyKI/Flr/aKXHEvxls0lKNtDiT+/dqvbahg7uBLjEBJe0A254oVEaE9l0uWZ7sd5CkFuO6gqL4Oy1ax3B3qqIvexuqebVqUSG0+qhpPzyPj5w/yCYjL80ZnSI8OcllQtqSS4hRJPKB+cXuUf64JzN9UJOa5fHjxZLLiW3jKTEALZDilJCDotA9ZBHequgMAWZd7pWYjUWSPK4T0xglqMqU0wC9IbaQeoG08ruuNzvwK3xVKEJ7MnVRm3IkRThLaVHWW0Xtfv8AbBQlFgFtiRIhuuMlp1xtz0OhRFg6exRyN7OIuqWtxlUSGmO26yI5Um9L5Gyl+vudia4PtjRTLH9StzE2REJ5bTcmOcsSuXKbQph0rNt8FSq4IWB347YJyCP51qemXL8tIabK2GVtm3lkgaL2COSbO22C3ZLvhiEiNlmbR5rmZRCmYGWaciE9Rsxy4R3SbOg0bHtjgaZmS1QQw41mZf6YS44Vrcd1EBOo97ob0LGK6BcKgDnabc5qvMa1wO2t0oW2DGV1S2hLcjR19RKVUCSE0KPY/p74pkSWomaOuZY8tUdD1sKcbCVKSDYsb19Lxx5iS2qTCcSrU2slaDuUKSaJ2/j/ANMFPramxYbTk5xplpTjaUvItLQIBvUkWbUTtWwrEz3Pc4iUwNmCAiPCOURM2elqcz6DkwiwXJeqbYEhxs2GG+QVnagccySZBhpkSHo8adIc1NpYeaUSiwfWgoIrf429sBIjrjzVa1Bh1BKmwleyDvR9N73Ve+Po6n2S42r0Ml1JdSv0KsXyascnCAwuJaTY88fFMHZMlXIbcfKfLOJf1No6hcIsKquV/X6fpjkaG6txaoHTCmo6nlhbwQSgfnG5F7dhuReBzMW8+ZDrqS6u1KNc+ya7fbBSdDOXyFoWpKqWklSVAOA0DW1Ajv72MEDFjr593mmktLLL6ZIMtJVPQhEjpIZbLLaG0N6CB+IANyRdnngm8bP+yjLfCkvxm5l/j+dLg5eY7qH/ACwGvUj3FWNxfvtfvjDqlNvQadSq0HqDVqPXXq3JPbbFbL01gicy+GHAFIBCgFqSqwaHfki8Kr0vm0y3MQTuNueVkgAMNhZH5/BZVmr0bKrXBK1KiBpGtbg30WLu674BbcdccZS6h9bqEBtgpA2BHoTVb8n63iLTpQhlSEpS4pFJWDpKdyLu+efbBTDUZTwiy8xXHf6nSeeV+I0hCeN0Wo8Vt8Y8xrmhrJlFmuXQrX4fmUTs0n2xIS+QtpthLbeq6IpH5O+wGG+S5rHyaW3m8Ftlppxaj0A8pa2kA0iyofofjcDCHMGoryGV5YzMKERkqkl8oP4tfiEV+5uKB3wTGjREPZdJEgPuyV6Vsk69uCCG/Wkk8CrrfD6bhTCFxMAtEEKvMJUnMXPxFhDVgjQNhZ3Nc88/OIZREnZhmbmVQMqfkSXkkCFHZK3SUCzXJ7Wfi8XZkmLDztxeWSJElqOoOs6q29F33Gx7V2o4olZ5m2YZurN5E11eYqW5IcmIVodKl8qKk7/6fTChlqHM7RIa550QbamuupDiD09RNjZzf5+Oaw7GXwnIsHp5kpxUvqK1oQCtv8TQUOAkUdFG7IN0Dzi9Wewf/uXseHz4cgrm/tNUn9qJZIe0aP8AC18c71XFYTlEh+K+2qI4+qKgLLiGr6Sb/eI/d32+owRhhEEEflGxxeCSIif6qoxW1EkORX46mhTTiVIAWtF6wd+OOxvGgZlPTW/NS3YbTcNHR8sBUgsEngcfh82s9++A8khqek+cbkRtIQpnQ40FvA9Ak00N62IDgFg0cAqeajrcey1T8dkOfgreIWvtyQK/TDsuUA7HnJXmvId2dQjwVLaSvK48d9yaBG6Sm0LWhwrB9AP5L4/X5xaoyJ09OXuRUNyI7PTDLKUNhvpghWoXWr07kmyaOFkiSy3GWkBsyW1BsPtbocbr57itiBvvgtuMyl5pbExEiQG0LeJR0+msn8m/Nbb8b4B5FhyfFG5xguCNkFfm3ad6jzgKHAEWgUv8jfJ7c/XC+QjXnLClvMSmUKbc6hcW2he2soKzRB5F+/HvhkhJkvq6kxASilo6lEX3AHFAk/7OB/IONQihtESQFu9XqJJ6gABG29Ab8dyKHGEkhkOd581U9IFxiUxbyaRmGQTfEjUmKtbUhsvNyZVyHFuLXXRBJLgobk74zOhbjqUpQ3prUFA9hybw2cjPR1pcS1fTsLWQQWye5I3+2PpWSqU7K8q7FMaM9oDrazS9iRRIBNgbXX64o+YxvcP4FrQ4hQmJMN0RFuSIK20U/GW4XD1Cj8Q7DYLBA7874hMQ242IsUvNxi51WNYCQNaO/sDVDfgb4MkQF5fny2osqOpbqEdN1P4jX4qAooDm9kA887Hg4CkNSHI7Tq1sLOsIKwslaK4K/YG/4Ye2mGCGkoc5Iv3JYyXiEqdeSA6tDXUuykIo7o5Pb9MHPTGUJSh5kLkMkpQsikhJWSqxzrJPc7DEsyeU1HYZaksy23WyrZulx1WQUewugSRd+93gV1Sn6S4jUpboIdAo13oce/zgKby3Sy84k6phMVk7mWJWpl5qR5Ukl11SkuO6uQP3dr9wa+cM/E2esZhm0JeYeGY2XJy6HGivw4AMcSunRKnSPyrN3rrCCMtqO6OtAalBFgl1ZIUACCDVdyCD8D5wc7Py+Xl7DcfJ40CSEOplyG3yRJ9dops7N6BttzhuX5zoiJEfbkflB/k5jdL4bLz0eTJCFkFCyoE61k/ptt3w1hOKypJ6clfXC0LacaWhbShoPG25+eBRGLH5S5M55ciChb7jIBpvQgEAC+mihfseCSD72veK2n2HpSFultAbQh1wlGgE7HuBzsMP+SxgGUz159kp1Qu1sj83noeddkt+hxKAFshGjkGyCNhuAfknbC2bFmPT9Ml6UZj6UKbU6SoOgg0sLJ3FDY98NGZeWq8OurTIZj5o3LC0sCKol9paPXayvRoQR+SrOsnAOe5s7ns9+bKjRWVuL6n92b6bLYA/w20DhHwMILzUqSNOp+3j1Tg0NFklDSo7tgMOppCl1uKNH/p+uCp0OMmUkNPPyLZbJLrZoKOxH0HbB/VZDTMmMt5sBxGlsgdMuAGyTe1DTtR2POO5rmz2Yy1vvvylW2hhjzMou9JINnf212obbXjHMESDpzmiLNJCGfznNJPh1jIHQl2JAfW8xqQdTRIpYHsDsSPcDC1A6T+qg50VptA3CwOaUO3+uGGY9YZI1rUwtAkq1aP8TcD8x9jyNz347jKYaLbamQ+0Az63DRCl0dhXa9sCXNBAatbpddSyt9Ul+L0IbTgGhguV1AVUEoJ5rvv2OHrGe9PwtGyR6NlS2mZanXwmLUhwWDTjw3q7Arf7HCB0OOkRwwouFKUMhSjTe/AHyff3wdHi9FRhykhtRO63UhNCvfFVJrw6xtfn8S3tBAzDdRQxBU2+45L/AL6HwUsuI1DpgEklw9+BVb++INNjpOvRYS30soJe9BWhsFexJHA3A37nFmatvRWERSpaXG1uN6G1oUAgng1ubPv7YKzXMW1T3hEgQ4zCyW30QFOIYcOxFWbr0g0e+GwWQGjZZObUpfOiLYEeS2043HktlxlYVdosoJ9+Qsb1gVhLaXUrbUvmtAUAarnDnMHnGGHIcSXcdHTdc6NpbKwO4P51hRI1nmttjhapNR0vuUCoroXp32Fg/XkYU1pN3fhMkTZO/MryicX8vlNvvnpOMq6YcKAg60Atj0XaBYNil4VNtSXp3SeYbjPuqKnNbZAUTv8Al7c/TjFCFrbbcKXF+sgAtE9tv5E4aLVmviHOlyczmvypLqUIU++vj0BDYcVewoAX2rvjz4e8EDnJQSQIBXcmRmsaYtzKNLYbkoS2p/QPxBY3BtH5Sr4rfH0xclxyKMyaZCWW22SW2ghvS2opvUjZZO4KuScVzmI0OXFVlcwuEgBZcNdJZ2KCboj52FducCxnYy1OxnwF60rQh4OkIbNghdAbjY7fPxgGkZpKFwmJTqX4jjfthUhqN+zo7jnT6TSAQhjsAoiyQDVmzVYpzZUxoy486G2h80lCDrsFFDqADkkbbiuThQtt3UqOolDjYWh4OHgDfYHg7YshyWnZiFyVuKbWKKzay3XfntzjM8Oy+ndr90TWWlR8sHnUuBPKgUNhNr01uQNrqj9MVxUNyC4lQaZQ4hxxK3XClGwur3s8AfJ+cOc3iwn8wlQ8tfdnJbcc6L0dB6BSAKKddHfe7Arb5wsjZbNekNRoAVIckABCWkEqcuvSEVZ329jpPOAqsJMMEoqbwGyTCglwR4Cm6kIeXRS+lFApIIo+91sdq357E5RBYSxJnZtJcitKaKoqQ1apbgWEKCVDZFWTZsbV3w0kRBCMeNmEPMdKHA9LZQQF6AaKwD+Q1dWNsJ2XYq0qblebMRgq8u2Ai02u1fwFX7/phFWiRbqVUx7S6xlUx20lxWtTZbS0XCgJNA8DawfbBL0hiTlsSC3BhRFRUnqPNhWqSq9iSSoXW21D3xJgQFOSX40iVGDLVxwpvqEr1JGhahQTtZvfiq3wZlkZDry1obmGGpv++LbaQ8tCE0tawK9Auu4rucT1RmdDdvT156rq0WWk6I+FmMXIs+yvNfDkcqTDW0+j9oJQ8S6Ba0lI20Bd0OaO+KZ09uYnMX5KFiTKkl4hvShoWSaCK2ok8bfGJ5REzB7KJL7SoojxlIbcLimwsdQ7EA+s7o3I4++NBkXhpjNcjmPvrahKiQlvJLywgSVtrAIb7rX6+MPpBpsDMc9V024enSb8wjaJPOqycaYPLpRoS2sqouaub9x7Ya+FZ8aHmCzmOUZfmYfZVHQZ7jmiOpYrq+jsCbwGGGV5ipbDJbaB1FnX6u1gf0w58OZNBzqbmZmZyzlyIeWPSWOqulvOIH4bCb5JuvoPtjKrM9LI7RPaCLlZ8uPyY6ogXaUuWgAbe2xPA+MSiFLEyJIjvuMuBaeu87whes7gp3qq+efjFjgWWxHcZPTQSANOiyfc1ZxQiKs/h0BYCjZGNe02TxQc6yvlCA71UxkpIbd9Dgvj2F8j2J3wXHzqblsJxuBmEqO7Ma8vLbbUENusiqSQOTYv9O+BkRUNI0mQ2gBV6b2274g6p9bSglLgbfGsgC7CCd/oN8QVGCoBN1Y6j8tsOsVxhUN54F91xIUacVVkHf1Ad+3e98WvtN+UhpafQ8soUVt6COmdR2vvsAdtt8cyyK5Ok6VBpZcDmlx98NIJQNZtR71/MDEokxDDqiYbci23G0IeBISFpoEcGxdj5w6m14BA1A7koPYdSi8mgQInlsz8SwszVk8xt9thcTQFOOoFUCvagsi8Cx8vlHIJU/8AZT60eZDPWCqS2Qla1NFHO43vto+cBFvMCkuI6vlm1i1oSS2hXY+wOOvPTJcGngp1uGk6HNIGy1b6zyrc7XjcTIyxr9ueXcow4lzjeOc9FJ9clzLmJaIXTajfgLkNp09RZtY1KHev4DFMptlTKWMthpWsSPQ9rKnl7AC0j8gs/rt2xJIiuMx0MtSAKp/1BQWuzukVttXviuK7JbbcitPuobklIdQF6Qujtf398JZmaQUutRzgEL6C7nHh/NHpLaHIswJejOF9jUrcaHEELHNE/IxTCjiNm8ZK4yMyjhQecjNumloFkg6N0mgfkY0MMt/+JIOVZ1Hny4UV9fmYkaUHC6rfqLbJJRatAsg9sZt6MhEsELQYzl6VKulUOaG/Owwx1UtfA1tfn3UPyWlk9VVmbKxMWwWEoCt2UJX1AgE2EgjnmsFRISHISX2swhw5QcbZSyXVhakqSq3Sv8gA4NkHfYc4KyhidPitQYqsvQW0PvhanW2nAhIsgqURvQ2HJ7Yoy+IrNo78eDCQVw0OTHpK36X0EgbEcEg77CzeCe5rTncYPXbkpbmiwbfTm/quNqfbitLUemjSphDgZI6gHJ6g5/PX0q8UvtIZfWypbbvStBKV7Xf7vuMclSYoW0hplaWEspQ6lLurWscrBWPRZF0Btxj5hopApDpBFhRrjuawZALRz+plB5c6Fe+2tTTRZaShJcWW/wDNW2x2/nic56GZK3I4eDWu0JcIsAc2QPe+B7YMck5hEjpyxADBjudUoKKc6ld65++BX3UMNBH7NafL6hTjqDrIQSdtB2u6PPGAaS68qmrLBIEoBhxxU1ssoSA4spQ3rA27WT/M4DkPpcVqKRe40gbV8fPOJKSouakBpwD17d67YILEhmVKhMRpDqnG/W30fWlI3XtuRVc/FnBkuDbmB91zKtQmytdjZO1AQtch9RWEpXoCNSHNydKDutNaBdje8CR/JJyaQmWuWHk6FRG2wFNrJNOFdn0bcUDZ+MBLB0jSFKChad7rEXvxAAjTQ4HevY41sROv2UNS5stSM+ayicqVEiSFznsrDLrk6QiUOs4jS46kaarQqgDuj3sYzznTWynox0oSEUs6ySTf59+PbH0VMLypMlx5Kg4khLYFKRve54V7bb44/JSp9LsdlMdLdfhhRUAfi+x9sUMrGAD0S/ltBlRaAS+2HGHXmW/UtCeSi965rYc4k8+GZxchqcjrS/1G6WNSN9txW4+KxbPnvy5KpLgZ1lJSemCBpqsU5gmI1J6UaR5lDd24EaQrfYjvxXPfCKgiC0ymuABI2UJax1lBpetFlOooCCre7I/1w3yB3JmvD+cqkakZslLP7OkCQUJbGqnPSAdZKTwarc32x9EjO5jlsdDcZgNRGlOylxEkupaDgt14fGqh/LCpbDCZPR62lPTJC2qXqNWAdwB2B9vnABudoOgn6FY85XTqfymEBiPAiTHncxTFn9LpssIQ4S4HLQtJI/LQvY8334wn6zn/ALsn/wBOLpa3xICpCNThRqNru7Fg8/fBPncu/wDJzL/6pH/5mGCoxuk+Ue8/ZLibTCtaMd2FJVKlTDPbW0IiEoBboX1NZJsECqoG98a/+zPxt4g8D5hNXDzKRDEvL1xULWkPBCCbG3t+fjvjNBaoqX4DLjLyHVgLJQQHNC9Q+a/pgiVCZgPZlDlyoi3IhUQqLTiXXAscHgN13GFhgqN6+3NPsmB+R2qdNOSHIwzeUz0wIn90U2vo9dwHQXDuCtZJF1yLvjHfCmb+HcuyXxFDzfw7HzTMZMQNQ3W36RGJNkoA5r4PGEa3ETY4TMzABqMClDXWWdKTvTSTtz22xZGmoVkbTDspJIccLbakDQ2SBazQuzQocfStwxOHFamKY0sem/58Lea1jyyoXuuUDMRJenoLyw68WUbuLChQAA342FfT7YuzNyVMlOyH1Sy04hCUguF0pbApCCSdwNhvxiWWxPOZjHjhzz52pGotIrcVZ47frjeeN5kZrw5leQt5NlDc3J3nIkmdAVrEytzrsgmrFGq+dqxQwspANeb3iFPWDnnNFt1ipsOLMhzcyzmYtrM5DKJcNtn8cSCXNKm3SDbRABO+5223GF2XQ8xjtTJDuWKlMwUFTweQSiMsq0BTg+VbUdrwcG4ZjFx0ht9DiNAc9CCj59/9DgmcvNZc6XmwZZeVmGt1ZbiBtkWSg6EAUADe1UfqMerNcTY/VT0jlAVDsuHnzpmZokxymKG0BlCW21PCrWQAEcfuCuBv7jNSnFQVTJjbDzjrhUgkELAG1EjbRe1Hf0isDyWmWxGy7z5eQpXUcWkKIbWfTsP3tkp3HvXbFERlb8hRfa1t2gOIQ5o0b6Be3N4B9Z1MSBf1n1sn0GNJAOiLVDjpZW5lq5DifL/3pfT0pBKqIQLsjcc/pgV4JcCGhDDRS3qKySsV3WaH2+MfuH+zj+zDwEr+y2G8/EjPqMTX5hdaiTzf3x+Of7R8uay7PZMWOn8JDziQ4EkEpscngjHE+E/GTjKrmERIkaXExfp1XRxNBlNsUzMa86XSVEcyojJjsSZHSsSHG0H8MHgdxwn+nbDSQ7L8OwZWWR82jy40wx330R3w605osoSsgfnB3oHbe7wqdaedRGW7JQQ6rp+pyiivy6/8o7j4xVCQ2p8xlSBoCSpASv0FwAhIojuf54+gAy86rnOg+CLyt2MhE6bOil4OtlCSXi0NajuU0N6sGsDMypEWK+21LWtiSUh5pCjToBsavuLrE81hGHJXlzimw9HC+v69kuA+oDej7bc40PiCUmXMy3LnTl8SFHjtBLkOE4ymShFgPltddRxYvewOeN8TkSRDbc+6MQ2b3PikM599vLsqiyMtREda1utyz1EuSG1nbk6NAIXRSO55w0ek5wrLsufzbLJ8nKExX4GTuOrUhDJB1qLa0D16FrsjfmsQzeWtx4ZdmokSJMJAjgKeDqGm29RAaUDQb3OwJB5vH2YyzNYgRIM1UWGw2pSYz7+pDTqiA7pKgKJoH9NycFADDJQAEkEBVuy1uNKjpLWXsKgoEpMZS1CU4gEoLl6vxCTuNgK7YXRHXmoT4MRDiNCSC4K0GyAR/nO5xpvD8HMfGXi2JlfhiDlWWyE5b0VlslLbrbbZ6jjgcJtZHIHcbDGZPVShbUNMhApLb7S1aiVDlVUKF8XuL5wVIFsWtdeDw4kb9EWmGlOSx83diOdIynGlyA5SOoEpIb016SBZ73fxg2Ll6nsofzCSww1lsdQfL0NsqcLjnobZLnq6ZOhawFcb+4wkytYakqS9GDzYH4yHFFKRZqzXsTiTM2azHdy1qW61EfWlx6Mlw9Ja0khBKQaUU2aJ33xslrbenPtdFlkQDddUt0dBUvSuMkaekg6C4kLvSSN73sE2axdKy16CltibEkx3HW9aU6CHVNLQFocANWgje+K9sbv/AML+E3v7DE+KBLmOeI3c1DDy25CXG2kVqK3U0C3d7WTZG2MnJjLjxlSszYelNPZeAwsPhZaWQUNWaNDY+jauNsc+nVa8ugHsmL/1eqMLSCCLhU+HpA/ZEls5ktstymHY8FaFluYoktrtwEBukE78m9qxalpiFIgJcnxISlSXY092O71y22FoSVFsGlIA3Ffno+wOE0ZhJSUPutsNrRdnfc8E1xjmYxgh1TKtSVsghSVirAAo/FjjFLYAiNUF+qKciLmPTm8ueTKYgguqk0GitlKtId0Hfgp2G+/fnDLJMvz/ADDJpOY5fK0QvDyPNqcWrpoQ4taR6CfzOLoGuSEHbbCBTKEwkkIcCVKKllTYAFGhpJ5739MaHPs9ea8PN+EYWbtTckjLMlpxMXoKfcWATr7nRuBdjmucUhucEkwlPeQQBf8ACRBqQtflQhZadeA1FsGzdbH79sOFvKEn/wBns9OOwUNtshIcUtWilknRS11d+3I4wmmJd6iy5qb9I0AkGq2rb+GL1yepSmAtFLJBbGjc7D4A5wvKLhOcQQj1laYynCuLTS+iG+oCR3sDvx+cffnDKNJW22haEOIkOAD8N8bgFBBWgcDvd8ge2GPhn+zLxZnmRO5xlXhfMZUeOhxS39BS0vQdyN9yPYbYQwek0t5DTS0GqW44tYHPBA9zW23AxM2rTMtaQY6HRLfSLYJELRFyOzP8u5JEptpDlFxklDlXRAvYd/1xQ5Dck5VMldGIhppaFuOIeGunLCAhF7ix2G3vimFKktvtLRGRrYsaHG7H4iCN7BHBsE9q9rx86+qIwyyImhcltDrK1162O2wPcg3fsMVOfmIbpvr7cKma4tGbVUrjOsz0vZb6FNsreCFrLZQKugTRJAP37Y+k5M4nIWZzsdtDJ0suOIBV1CvqEHnYjQRW1gX8lxIkxJucK8tl8frF4Hy7YHTJoDpoo/k+buvnFMxmTleSxWlthMKRJLrig4QtbgQUdMoBINb0SAbK+2NBg5InmvVEHEw6deeCSZsw1ChQHA+xOUy3qU0tigj1j0FfDoPuDsNtsK3GFuIVKjMuhoV1HS2UBCudI7fA+2DnV6H3lhPmIhURp1rbCzX5wORf8MMI83MFeHnMqi51mCG5EpLpi9S2PQCQojkuaz/XfBtYGiZjnpzZa6p0SaK7mSlpYjoCn3gsh01rcbWNBQSedhsD84YNZbJXDdzHLoQdyxC2w8sIWtphZ4Q6sirv+QxAx2HEPt5i/NaW3HUYCWkdRXXu9K7I6aDaySLN4JgTpLGRZhlLMnMWcvkvturjNP8A4bmgGlrH75/kPnFGGqAPdnB05+/xKB8hoyqiU26HJMic8jzCkN7dQpJQdtgBRoAWOKrFTjkzyqNRkKHUJ1NnYEigfrV89sTDSFtoU4WywXEM9Rwkloc2UDc8/wBMEyTG8ujLxCLDms9OQ24stv6z6DoPA0Gh/HDWuZZo53JUky4oPOcuCZz0ZzpzXGk6Vvx5Ica4pBDnBHHtvthdMbcEdMUutBAc1thJur77DiqwVKYWxIa6JpSx+CUG73KL39yDiKVqZdXFQ55eO9pafLtqBrfeu1i6wuoRPNPqmMki6DlFDrjaD1PxHCNbi+Rfv/PDlpOXvQhJMdp/psuCUW1LaIIJ0r10QbtO1DgDk3gd5iA7Zj9XSSClkp2/J6+ODY4Hat9sFwM2zPKmWfKLDMRD63UhIRe6d0KWR69vf6jfG0nFzcxtPX+6onmHQLpQ0GmPOsN5gPL0vpKWhQ8wm6FJ3onfn9cTcUHwhRkoUUsejqOIISOyK7GrxCYJaVNdRTgaa1hkcgb3Q9ucE5jG8tlWXzE+VUJTJaLbXTJGgjcgGwTfJo7YIENIAPOSji11REbQhoKttt0guWRq0Ctv1/3WD2XEL6nmpMpchCdLJb9+N/jHzi2o8yH5Fl9hgMIQu3r6pI9ZsV3/AHLNVV4nkLUF+Y63ms1uJERFcLbmnUQQglCEDubob8Xi9ha0gHTrwJJJj7KScvysZMmYqcEy0Tek5GdSuumRYcuq5BBHOCckmpiyTmslrKMybbiuMeVmN7DqBdFCNrKCbBvbbFb2YIhyEpeQh9th40kept2gQg7bGv4/fHZk6M1EhxYrPUcCD1+o2EgtuAUhHJ23359jhWIIc3KN56/X1H0QttKRtNoQ068FvpOgIsflO4/P7gi9hht4ay6A5KQ7PDjcX0a5TLetxml2VBsmlntRoYrcWp+H5xSFdVbhJd6g27gIH7g3/lWDUTH3Ib8lAKAA225SwgEgbgNirB2PfucY4Wka84ETSZ7SBhxQekWmIv8AibSVhZDm559hQP6HF8NrpRXlBl4PFslHQpbekL3JFfHPzeBITP5kkFtS1Ag/5BzguKp8OF5dSnEegrcb1gDYA/UdsA0XG8681QOqWhLJDy1IDhZZLQeJ1aOCbFfa7xJcZclkO9VTrz7xRWqvnj3xuZWSZEfBs6eudNTnyZiRFivMD8SOUEpcJBrVdcWL2xhuipDqkOFbbra73Hf6HvePf8zmEd61lfNIM2siJESB+y0qPUM7zBL8csjptNUNB6gN2STYrahv2wI1EbjOKCyzI6LhSVs+tChuLuxYv4wUjLyYAeMXqAuWuTuex9FcfJPI24xNhmE6Upee0u0UqTo31FdIF/zuhtgHUu1JgJ9M9mEC5GdZU+yhWpLYBcU0bb/X9N+MPPC3iKZkWbZfmmXFKZUJ7qsPWStKgToF8d+KrYYBcgz22H3XELEcuaC63/huLQRaNfBqxx9cU5mwhjrJgFb8Raroij3G4s74eWZRmH06pRuMpTPMp+YZ/mD+YTl+bkvh2VKkbFZ3JOvje+3sRhXPcjOzUvRWX2I5QgKC1dQA7BdbDYnfHWYbvUY6SFlxYLloI2QB898Oc7lSVxMuRmajIjwmUIixn7BWggklBAFAHnuducRvaS0ucdF0sLTiIFvoq8wlh9Cm3unJkJUGy8ygN2hFBCyBsToscfWzicRLcaQteXCUEyWVsobH/FK6AbXuNu/6bYI8JTIUNDkOUww808lDjxdZpwODXSEODdA3BI76AMMc4gtR83zBlUNbC450OR5NEkEb0ACARYXd8e+In0yRbWevfdfSUCBTvtppzVZzRSCkISvTRUob6L9q/rhnEjuyZLaocd86122gjqE17++BIcduOzY6bjj7YKgHDbYuqI99r+lY0/hDLPNrU11yHG7KC2efpilrQBmcqWVCWSEHHy+P0pyzKihxoIDJQCsOknf1jYUDe/thYoNCal56KwSKa8ui20ObVqu9j3w9zNtDTbqGkmkD1A8/OLutlacsZRBZdQJMTpznJbQXbgXrBa2tuhV9zR7HHqgJvuqKA0ad1l2jKiKalIbKW16w2tSLSvsav+eGniN2KWZUxhMFt2e8erFjxdLcZAKVI6S+177cgCu+AXo4RpQ40QFXSmzesni+23tg1MhmOtx1UNp0BsCnnDYVt6xXJ27++AdJHPuqxSBMusQkjBLDrbEtL3l3FIL6Ga19Owb+tbi9sMZGc5pFypnJ4GaLOXddySy2mgWy4C2Q5XBKAARdYDbbeny5khpguENuPuLJrQ33JPc9vvihLaenraXVk7GrT9++JPlZ3Bx221ScmcxKrish5t9LrbegaXVvEFRb7V7USRf2w1ixnWYS5mYIdMZ0OsMKRR1L0c2QdhaPkg7HFOUozYaoOV+aKpTY67De6JAB6iAsdx6Lo+2IS58iUhb7ykJXJeLoZbCUtDc3+GPyb8DisPE5gOc/CRTAaSHWRWUSJ7eWTYUed04mltx9pLwR1iFUghH76vX7WBiPjd5qXn8lxmQxLShtsa2YnlEnQgAjpDgg3Z71ffArMVUuQ641SGm0rdeNIB3PYbfoLrnFMyQURW2GWkBLaivWQNar5sjcigNj8++HGkIN5jnikGpcdmEHCbeLiEI9ClrtBvSNQ+uww1hMpanPZVPUmP1dCpb7sUuOQyFb1RsDffv8YIXKyqVGfj5olzLtSnSmMxGUfJqQm2gNS9wskg3uAL37ZRvX1AkmjYHz9sc5xklr2xp9/Kev8WfODYyq+QmnVtakODhtavTsD29vvgdhSVr6bmsp6dAAgd73v74LfiKaeaCVMPhyl0hV/OhXsd9/4XgZCQF9FS9FjSTV6ffBMAdYqd4ce0OdyIjQ5MiQhDMZUq0dRbaFgHQkEquuOCcTnSm3svjRW8rjxnWi4pUhJXrdSuiNe9egcUBsTd4oQwkrGh/YWdRNH/ZxpPDeWxpvmm5a47JUbShLYTQ+D/T5xVSZDS46LzMI+s8NFv4kWRNhp1zqRmllSK0PN2lYsEizRHHIN9u+NFkGWxpMR4vTG4rgb/DQBRqud9t/j5wnkrjMPuNJcWSLS2o7i+Dd/ptg7MpCYToKWJKmW06ERZ4JS3q0ntXNWONqwL3tYIbv4eyLDU20nExMJYohqQpDY1pFAmu3e8DSZLKcy6ilu6UE7tEg8cDBExSBlEYNuzUuvOLL3UQAwsDZGlQ3J/NYwsQ6opbU2vTRtYB2scbe+Jw8ESNj9EmrXJ7Gy7bshxhtBYT1XEDWshDaO3qPA53+MEwZOYwpip0TMJEZ4MOIW9FcVqKK0klQ5CtxzxjubRlsKlMzlttT4yhpLa+oHiasWi0WLs7/ABgJSVmA4oNuj1bPJbNOdyD2FDesGHNLQTcHwuPVcyp/szqjsyXmDzOX5g65BdWUIjNMsdMLCW/QkLbQOfk8374X53l72V5k/BmtIZkMrWhbYc1dMgkUa9qxbEVlyJ63mpUtLDTjRH4aQ8pPfSdwCO329sO8tzbLc9zXJonit0ZdAiMusPzoEbqTHbK1hbln8RVkC/bHqxcyHbXncpNMNcMu/ssiFILdq2okkAHf2vtg11bLhCHFJYKEBACWaBA3F1yb5Jxbl6ITE9tvMmpr0ZSb6cZQbcB7Eage2+OZrJkTRqL7kiLFbDEYSCnqNsgnQmh9TxihoAAfZLMiWxdTyrKMxzSenLYWXSH8wlV0GmtgoH+h+wxdmcWRlXiOXlmesOtS47rkaQFNp6za/wAnF6SRXv8AfF3ibOM8cz9MnMJGZebhxWoh8yjpuNoQ2EhsgV6a235GFUZ9CXHFzGg+JCfxFOf4lartBPBPF798KcRFuc+yJub/AOrKHlH0Za1JR09Li1N7OeqxyCPbvjmlt2I0y4S28lem1AJQlPO/cmz9hhz4TzlcHOcnfko/asSA4HRBdGttI161IAJqjW/3xov7c/ELHi/+0WTncXw81kjKorTnQiG0lGkU6SBtYI3r2w9uHaaJqF1+lu7bXS8xaIQE3CwCIMhTPWOlKA2XE61VrANED3O/88CWn/yxg5wPNxkuIR0mloI1A+pabo3v77Yt/bf/APTsq/8AokYme6DDVkNGpRk2bEdSlJgsIkNrc1LSSjrEuXahwABtSK2PxiydCUW2Xcv6EhmQhx1tDYHUb0fnC0AkgDtfIF4sUnVEW7GhttBxYJV1LJSvYNpQe1g78745JfTJhtlYbS/DF6w2ApRJJ0WOaO/vzvxhjKLssjx/N/dC49qBzopZWjyjLkmQmKrqRFhtMhjqhQWCixvsQeCdwR9sMleHM9Rk7OaS4q0QnGwUSQ3026DZAGuuarYc3zeESSnyPmHeopxxxYcT0NinYkhd83+l/OPYs3/tklZh/ZDB8EzPDkbycItq6rkkhxbVnR063ugsX7Y1jGzOXWyCpUqtgNXlsBvo5cZS47yG1620SG0b9QAEAk9vWLreiMX5W+tzN23ojZeTqQUIkIQvvdLFgEFe1E8HC7zzxjqjNo6aV6zxuARuLPvtizqxFQ2f/ZbjaWmS084hwlTjhNoJuwK4oVYHvvjflkmxgXXqlQWBEp9lOaTYea5fnbyAhLQ1fix9aFtklsoRexAGugTyisBrUjJ82SYT0h+GuywXEmOvphZ6boN7OCrvejeAYLcw5fKmlaEIiI1I8y8EFZ11obQfznc7Ae57YkZaPLzXFxo8qS900trKnEuR9rtAvcb1v9e+McRGTX7cHhslfLvmQr0dUd1xyVFkqdCEPq6Vt9Ik/v2Pet/fjHyHEKjFT0Z0OyXClb60a9QGmtII/ODdm97/AFYZ9mM85KzkEqRLfci/4SOsFNtgAW3QFgjexdDirxW3Afd8IKUw6y50Xm3nG2whTrnUQQN0nWQAg2P3Cd+cDp/mP1+Vof8A/str4c/tPzTKPDSskcm/3MFxumlltbg2+CRY4J4OPOJclM2VI/C1ngA67WSeSAefjF8QrzaaJGazGkOre9cl5S06ibJU4sAmhtuATg7N87iSokiF5HL2lNR2GGFoGsL6WrW4FkarcWdZ7Ebe2JGYKjQqF1JoGbXn7VDqr3AArPQwp/r6pPqDR2K93ABwCfj+VYKg+cltLy6MpgMrSXXErUjbppKzSj7i/TfqO25xWFyFJjKfDbSEDUw4WToWbskCt99j2wwzGRIdadzKHHZ8osGJ1X2Gg4Sv1k7D8936xwKG2LmuypTr6KcLNWsicnt5Ut0NvsPQHXZLTSyttw7HpkHp0kdiSDwd8c8L5W/4p8SRMmizf75Lc8u09LkaG0C+dR4ARdg++E6TGU0w8qWnrJOnphj8gHBJ4ODIkmHHhqZYgFc1LrgckNvlSXGqFAIraik+u9wvjbHszi0NJsP0tIyyW2J57IvxDk/7HnS8uekNZgIDjkUqZcOgLCt1pIsEHave8UZVlUiW0pcFlbjqAZLmqL+C20gclZ43JB7bc4Iy2bIj+HMxiMZs+wMwebZnxBX4jSFgp72s699I9rwMJb8WSii/YA0tEhOwJIsVRN0dxhcU3EAzC0Go0df4qpakNnLnWJj8hxDIS6FN7NqC1ehBB3FUe3OKI2l52U4FrSnSogg/mXe2x3Pv3P6YZQFyMw60BxEKL5mV1lS3UaClehVIJ4Qgk77bbcDFDquipUdyEW0OKWllwNga16hYJ3BA3A08Xj2QZbEkc5+UYec1hCCmK6ai3BkvOxWl231QELGsb7WfbnBWXwMzlsTswjZaXIjDIek6Gj02mtYSFk/up10L99sDTJinZCnCwypz1JVqGvVtRWSdye94+gvuMMlLl+WdGlSda/xAFjbY9jv98CZiChiwAKvkyZiIrqETktxHg0h1hl6kuhAOguIGxI+eCfnHwmFQWEArUUkdSQep6Ab439v4n3wEA5uHE+o0d0UR2G/thkqFHQX4/mBJV0m+g5DFoLiyLCrAJ2J299saxj3GV4vaNVRm6ZjYCJEMxXGUJSvWDrXYBGq+diK+CMcZ6S4zxZ67KAltt06v8TklJPa62Fdt8djsyXsweaddASE6nCr1oIR3VXHHOC8rMB7KsxenJlKfS2lMVtoU2VE0NfdNC6q7ND3wbaYaYSXExKCjuqZLbSNYaU2T+L+Qko32PyOcdbKEQ2ZhlMrUl5SQwP8AEQdjrNiiCe2GuRyoUvMnG50gx4LEJ1CEuUtzYLWG02RZs7X/ADoYUMIRIbZToQnrr0kuOAIQniyasVtv7XhcjRNyyUZHUprww4ZDWWOtyJCXkLC0mQ2tIWNxdpbO5Irf0fGBcoeTHJZCW233XG1tOG7ao2D83tilmKt66RER0VhK1Fyteq9O3JG3b3F4tsOOBlMVLWvQgthtSlEA7USSbO+w9qx5usjll4XC9Z8E/wBrXizwp4Zm5TlWardbmNnTFcQhZRJcdJcLY20D4F74z2bws4yuA7nLUpUqP5seeditlcWPIqkW7XTWs2du1Yx7UqEnMC49AbVFJWOkFLKWUkjds2CSPc398M/EEqfEzGZEiSW1w0S16BHeW5GXS9nEWSDt352s74Gnh6bHGqxsE69fPzv5oar3uAbNhz6IzL2ZZhvPMx5TDDqx1Hwi2g2D71zdAV8j2x2EGVx3ob2thK0dYHTZdXvo243s72AB22wOic424zGdlyDBAcIak+vXsbIA2G/37/OK8tUuQ0qSH5D8lCOo+4CD00E1f2rj57Yf2DDo+nrbv/qmDHAQT9UTBKV9dLS+vHvWha6bcoVv9fjjGij59KHg5zwc01lMRmRJ8+Zrrf46yUaOmXBwiif49sZ1D70j1F4RWeoCvW3se2v3sCzWJB5DQZbhIXIeK9S21oXV0RwDvY7YfaAYSnNUZ+VyxHS+zEZDTBcbEpqy3IWFi6PG1jitsFZU8lqO4uXGQYrpQ2+hbiOr2WSjWNia/pjuZT3XHmmpjaGWmI3lg3AT0y5RKwV3yTdk1vtgWA7l7qmmTCK+poaWUKtf1R3sk7ge1WLwVM9rNF+chY/SDz6rjyNDLsZt2A90UFxTroILnB6aCeTudhzRPGJxw/OW8+XvLyrDalrWG0EnYk8VwP44MYy5idm0GJDjuull0JLb8lCOsQtKd0GijXdVZO53oHEVPNOPyoxhNx0uSiWmA4umrsAGz+4TtfI5OMp5w4gabHv8Fr3tA+3PJJm2XmZjrRSh3pSkNkrRras2CbGxG23vzjshhSGw6vot67GgLBNfT/e+DnYKG5TsFlZStbwBDi9kaLvbg778/G+KYrBdakzX5So0mklltuKdLi73/wDg23+eMMZ2qmY88ljnAtiECqKmTCepTDagsaS45oWEDk13xyGxMls+R6T8iQglTbdfl4J0jmyPvh7Jy5UHMnmoyIriXwUIQm5IAP8AkJHro/vjvYwtWpbTilPSV9VB6S/xCCFgbb87DjGOpOPaNvzzvTmPAEBOv7PU5O4Z/wD4jezFEERHQyqCyguF3Ytnf8gJG5HbbCuMhhWYOutNuNhpHrW23rCDe59gN6vjBn7LZcmw28sEiO3TTTzsoAIRIItzdG/TApfvV4t6XRjuLZkvMMSWeiWouv8AHCCNesnkWAvf4xnyyHuhx2tsEvMQASEncYZcmKecjuMFAK6bc11Z2A13sB72cEQtRW29PmNoejFDHSlN9TYXtorgC9vkjnBc6Scwy2Dl/RhMNsW4uSdnJCyeVnueK4GK2IaWJfWC23lUdaEItA5oi+3beucUOGa2qFjobdfORzJfTmTzbDDrrzj3Tajfh7iwhtsbaBxztYwKnLUqmNQoklDqiA4XHG+mwBW9k7gI9/8AvhzLdZiS4aYL0hsrQPNtX6OoNiAUHdFV39/bFzkaPGksvLWjpFvqay3uL5AQO3txwMFmLezFhpw9y9ThwzE350WXfbuMqS8ytoSFkMNhAQQNiV8UUV2BFEjHH2GSxoZdW2pyyvXR11+QV22wZ0w9PekRrfbDxKLRzvdlG4Ha8aCTAy0ZnEeyhHm47hGiPKCOqgkgfiEULK70fFY8HGO1Hjz1WS2RCy0eIhHXbcQGG1oC2XCnqAgGjv8AO+49sR6AV6Gtmw2epR/PXt7fQY1Od+Fs8yvO5XhSQ2FZg04QuKhJcLRq7RXxz7b4WwoMhvLXUhCH2g4gdbQCTzQB7X399sSf9ILuzcH6KptBpagI5SqKy3GSFyBrGlCPc7Xv77V7Vzg9vLHnIaXoy7bO0lAJJbWSaBFD2B7jE32VstqjhLKHQsa3RzQO1bAjY8fTGpqG6FJy9lbiloQS4ve6sE+5va/6YcyoS8mOc/S1tIZRN1njk0iMOjP6bYH4pC0Ws7bI52BGBc1gyGs1bhyGXOusgLjBsgosehA78ECv54f5hHJjOO9RbyWl6OsUEBf6/wAsKpjyjmqltNNlLi9vNetCx3Cxd/POGh7i6XaRqmOpNDQGb8/Xmk77UNcZplIcjuttlbgXv1Fk8CuBVc1/LF+RxZTmZlmDG8y/JZcb6YbDi6IpZF964POPmGVxJLhU2h4Is7LCwOdgSN9sGOZgtjL1qb0Rw6Omvpj/ABKG9/O/bFAbnglLa0Maeq+y4PJDrkry6EtoQ0zaw30lheyygfnWN+xr9MLKaW7oacllsuIMkNmwvfYoG2/NWeThkcziu5W3GeZCHyC2HUEfbbtzgeHHdczMsw3EGetwNsCQ8GySdjufRZJ2PIrB1XjQDn890PeDznsqJGbJiI6ECIAVudTqyGAXW6DjegbmgQbI4v6Y6iVlLzeWhyM42I4CZZ80SZHrJtAP+Ht6K42B74XyaT0ldFbkpbjjTgu+osHelg3ve+w45N4tyl9hWXTITEIqmOFstvOP/wCGhFlaBQ3KzX6VzjkGMzjOvObLp0TMA7LTZlEyFzNH82ytmRCyZ99bbLLrgddaNWEHe1iq/E43+N32UZHAYy56Xmb7YckByP00PLD7S0D0OLRW7RND5rtWMOcxTLjQ4zWWxIyorHTW80ghyQdZPUcJPO+jbaqwxy/MkQVq67YkJ3SNCzYHYj3rf9cLpAGAbeK6QLiyJ35/U+lw2XnWoGVIZYYceOiQ8tAdXvVuLHYfT9cXQIcrw5nsgdeM+/l7i0ktOBxskfvoPBG4II+KxReYysicmNIK4Tckth1oIH4pQO3O4G1itsN8vzdrL86ekNIjvtuxfLATf7z0wUVrRxZRuRxXGGmrmksvHI4FQMzQQTbl0mQro9V9PRcU6Rbqxro77Wf4467GUpph7/EtkE7g1uQNr9gOd8MpzmWxVty4MjzDJlOksuoKHNA/I4sihvZ2G4rfA6EqioLcWSi3EEFwHQXG7BF/6fXGMlwmFfh3wRdL/NPtNrgh9QhuOArBb1BvcW4j2XsBY3oEYtznLoDxIgzly1lCw4XGSjWvWQCgWSQQAd6O+PpjqCEtNoXYR0lhBKwdzZ347bcY4W0LbWhqQ4hoHXSz3rAljnXXUZkJ57rKuRAlZS5snXzoAVt/vjF8MTWpLSYJZXKUhxsNiitKdG9hW3BNd/vhpI8t/gKLjhFGuoAgmj37Ebfx98R8EyMqg+N8ozDOlR0QmHg5IW/FMltQF7FsUSOBt9cIfTy0y4AnU21POFLxJABDUlLZ8kVpQjVqR+R/cWDW3x3PyPfB/wCyMub8Is57+3mHZXWLb2XiOrqs0fSSviljVv8AGKPFUhDeZPux1sDrkvVGBS0gLJUEI+AK27EV2xmcxlrKmluOBfpsgbb2b3/3zgnzlbcjc+HRc/E1hTEk3CbOy2ErAdCApC9C0kiwSObHbjFcfOIrZbWW2nltuk6VKOkittwQRvvjOz3+slJUyQNFI3+ecAR2kOOpS64GkE0XCCQP0wWIzCwNiuLU+LOYcoaCtBLelzG9Tjy3fUXFKK7KjxZ9+MVIcZeaIS90ynYFR24N9uScVZfP0xXWFqQhBSn0jayNvb6k4mmO8lNobV60FWwv01zjkQ/MZVba1OqwOZrF0XYaQlDbpW4WxZRvv/lGG/huZEYlKXOy5iZGkNuNqbDwaUDVpIcN1RCTtzuO+F0Vxx5qLAQmO+7qSY9jeyo/hk7AA87/AK4ubbMtDh1qkv8ASS6ER2tQbQB6wvgigBxY+cUNDSQE5laTBtzr+0MtC44p26Isp1jg4uzVlESSkRpjk5lLbalvIbWjQsoBKPX7Ha+/IxbFDzSZDKxHQlxr0plMfnJ2sex9jgZyU83lTrC1q/FWgjc+pAtJBN7D7fTFjMwgU/P257IcQ6xzDw+q+ZQFPJuJYdSSwUrAv52/6YM8T59mGbNw401tsCCz0kq6VE73bh/fV8nttxtirMpHnH2lPlgvpAZWACVHQAEqKuNxtQ22xCTIeUqRGZCojL6x1mb0otHF/e/ucLqk/wCdJUjO0ySlzjC3EDqym067JAN18UPpixt2G2Ay9FEiK2XQ24fwVkrHoUs78UDX1F4uRHcVJb1NIHUXdWADxtfAH35xdnsVhrKYLLWVTESUhUl+SsqCXGyBVN16Qg2NV72OMZkFyTb6/tTvnKCAl+WMImuiN5lmMXNKdbttt2Vjk8Ad7PtglrMs5GQHI2s0kKyhEsSnI6d22366Yc45rb5wucdpTiEIKmbOgLTRA+30+mDoz4Li4wYaQzIU2JFmkJKTupPZAo9we+MJETHNkkNk6qlnw/mSck/8RuxHkZZ1uiiT09Tbj3PS+DsefbC98eYecebIbUs2UJFAEngYMffYD0lDfV8mpSyhsLoX2utu2PsmzCXHkMKhvGO4h3Uh1ukFKiKJ1dhXvtzgcrj3zpzxQEMaYC5CkRIGZMy4wL+hkEpmMApU4UUsEXumyaPPG2LXoYbYb0spQ4Y/VcWqS2oOAgbAVsv43O+KVsNRm0rHTcbUhJXRCig6uPb/AHvi1LsYkttqaQvqgl1ytCtiL0gcb/77HTbfWIH0WhsANO/3/irzCVmDU8vPPSestYfQp9ZW58Ek8mgOfbFcWG9KUFMMTX2lbFSG+XKJq+OxP0Bx9mWZTZ0lMqa65IWhoNIcX6TSRQs9yMUsvS1RDDaeccjpPXW1rOjULGoi6uj/ABx6o+bj3SmnYplmsOGcghzYEh2QlsdGYXAhAbdKnCgIF2pJQAbI2O3thZFlSIzUtluS6w2+yEPIQogOpBBANciwDv7Y43rbDiS4psG0EpFg3yP5YqGpxtLalhDaAVI1Crv5wUgwdEJBBvdVrQhBWDSttik2MXdTLvaT/wDkf6YMZktDw85AGWQXn3pKFpmqWrrtgJILYF0EHWCSRynY4I67H/4MY/8AWP8AXAtp1nf4afVbTDTqQPEH7BEtK0uRpOXFEaTHSXFx4yyjpFoCnytdgkmzQ9sanwv/AGceI/E3hPM/FWWQFvw8vZCpThOkk7lwg73Q3PBxm81S/mGc+YlPhtiWgvNuyKA0VQ4Gx9FfWvrh1kXjzxdlfh+flkPPJLMOb02pDQcAUQAaFc1tVjA1m1msHyYmd725zcFRbTkh/Of1C5j4pkP+CMv8KtoWWITjriA4R6H3F7upIAItFI0LJHJ7ikj0VpoQXkdV5xxbiCFKRoK0mhpIPHHNfFjBU1ZMmIvLw8mU0hBeWsgnr67NdqBoD+OKswbag5/JS5JYzX1KDqgFtturUTxRBoE323FYcWl1m2508UrLl2lEZzE8tmD8MzkZiUFtLbzLZ0Ogo/cJo+1bb4uiZrPayY5EuUF5cZqJLzSGEa7CNFgkXxYq6ujgPLCy9mTUNp8swZDjaHA896Eb/vrHCQd9dY3X9pmWf2exZbszwdnkqU0UNs9F+OHrX0vxHOpsEHXQFA9z7Yex2USBzn3UdQaNdc6rLZRmQyxh6Zl6oTigHIpjvth10odQbWAQdwB+cfkWRWE8kIjvhWhICVehaF9QcAij3O43w6gQXmJsKTlEkNiQNPUkrQ3oWUU43ueN6Bre8E5y5AaWuAjI0Rc0iNtxesqcXNDrZolHIokjvtRrDKdMlpvoVhqQ4W1SDNTGL7yGVvaiQdbgAWQRZ10aFH9bx9CfeaaCj1I5SAnqtrIKN9j8D398fZVCdezxtl5l7rLfCVtIFfv1QWduffbGq8c+HM58E+IpvhXNFsRUuMIkOpL5U044EFbbgCOFiyAON/bCahcSI16d36RnL5LKTIjzUdMgSg+Ct0NoD3rQRX4hHsf6H2x8IzUZt2XClo67SlsqSWgQWyjRrBNg2Sv5AF4aZzlKIrLC5GeMTsxdkuiUxHt0tIoEO9T8i9ZJ2B5G/OFzjOSpyg05K/afoAcbWjoVf7/e6HbvucARlPesa8uEwqG0OJy55tKnEPfh6PSa5vY8D3vDDL3Eu5XIjz8wMgdBbkSGhZI8y6dB34QaRrN7EAD2xR5pzMIsyM8iEHuqhZmOkNkJFigEfn1bdif4nA+a5e5EiRQ/G8s4+g9MhaadbCiDrokhdiq24wYcdQERLSNYPOeCBU0l5K3lvArq1oKPoNiNrrfDLJ23o6pr8ZsuFprqtPJf09CnRTu3NVVHazftgiU2/GLbaJyXEuRW3Xkto0Btyj+GRQFjff5u8JZDWuO2+iMpBU64HFknSdwRXtV/xwx4e0S0LzoIvvzuV816anMkZu9KUZsh/wAz5oOhSiu9Wrb96+fnDTw4/Ci+JosnxY7LkQX0OOyDH9b+lxC+NdC73++Es51cpDLS0qQ2yC02ekAdFk7gcmzzhpmi8umyDNezeUl1uH+Glxha19VukJbUSdrFqsbDisQ1cO91SRYHffnimtqhrQ2F71kfjH+zaD/9nH9iysn8v4gdK+mUMjWt3anQs7cLG2PARFlOCQ2pXTVHUB6V2TrNANtne9Y3I/higsFaEuRHopa0VSz6kVvp4/N/8HN1i5kZfJziLLRDfhwVKSl5TjmsLeSgFylmqBNGibAPOCwuEp0JE/6NylPcXQQFW8pnquKeZ8nLbbWH/wAQt9Vdq1igPQSDWjYek++D80j+GnPD+WuZCh9GYNrV+0W5L5V1bJ0FACBQSBR35UMCN5f1ymYuDIciIp6W44vQTQBWkGzsbFGr3xCM+w66hlhpiK2wgOm9+qUEmzfJogVsDXbFTqZaGyLC/ita4F0BWy4LghIlPLSpIUOgkEoK2grZwJV6umdwCN9jfGGcmLnkXwY9IYjzkZDIzUa3PLHQt1tBIBX7jWdr7nfEGwzAZbTPklbT7iFKbvXbSSs0tIWCjcikbHe/rTJzZ05U7lsaVPYSp9x7prkANaVp3B9yQB/pvhlSnkpgRe0yJ9O/S/itFzIKF68ST+yIbKXFPAqbfQpABSSuggLWaPvuAAT98djJYyrNmEypUZyOzIQh/oJ6yHgDZVXDgHBBq+3vj7PXchzGbOmZbEXlqVoaMWClRftVJDgK9qH5ljb4wsiN+Z8tFjNOKkOLLaktVqd1n0ge/wB8RuDnAZyRbu/YEfhE0gaIhx5lXSVFSGV9RannNdBdrNHRvW2214nnvmSzHgOQ2agNqSHWEi3GyvVayPbVyd9xfbAwbaDiWkvuK9CkoSAEmik1ZO1WR9vnEpmpSFqZU4qC1wsNhsEnbccXtx8Y82QCCggEyh3Albjq2SopRS/V6SQNvsfgYbENMRIrDLE2Jmq3kvsSHFaGy0q9x3AGxB/+PAmQw84eTmRy2I++yzGLs1pCNaQ0k3ax7CrvtV4PQmCHRIjZw55lgBpCHIynQbFANfG6jRArbvjJm+/ot3uhFRy3mM2NIVFLoBQFCltkk/mCgPjYj37YsjBCUFDZZQzfWT++or4CRQ2O/B/WsX5dl7LmVOiLNU3NX0224zYR+IhdlfUWSNxoGwB+a7yGWxktOuMqTmsdEdCnnY6HE+XWtF7ggboojfY71eBLwAI5z3XoKYeHmBJyuQelGX0CJFI0B0OWGmgsE2UWsmkAnvxxQ/Jy11MNtMZ9MlllYeU6sJQpzWo2kHhHbm7vArGYKg+XlQUeVmMPtuoktvL1oWK0LHtuCff9MMVoSrLY/iR2S6rN333dYDjTnX1qJLmgbigSDrG97cYL/IDgJnv357oQIsUuyyUHJsNlsI6QJKys837n2r343OGESTJg5qroybdYQUokR3iTVdl1x84VR3S6215h59aUOLpAolArYD7/AMMGwkrEdjU0UoccW0HQjp2SP8/Hbj64qpSRdIc0TbVcj5nJS0f8BbbTax+J6yAv0cE/PPPHxi2NNk5USRJ0F0Nup6Twr3Fkb2N9uxxXJjNstpUdbbocWSkaC2AU7Ubsk732wVCTNy9YEaaWQ+2GHiFoOgE2sDtX/XDRSLRDhCDPMFGZXnjyXGG8uhhx9xZ1pJLiJDa9umUEfK7INnXhpm70zOM5/as+bFkLlk9Q6DbVEN1oABRVDR7gYRwJa8yz6I+23JEhx71LS4VLfc12ijtoNbbVWHMZ5lMhHSZfbiu9NxZBBcJshBJrY6yR2G3vjD2QATAJ8p5GiU5syQJj1hDvwlNNyGIPVbQUUtk7h0pN7+x2uu1YWqkOeRaQjph1bhpWsqKzXNXsO3bvg2e/JcPRfU4eg3oI7gigBjniGEnUht1nyLrbKBqaC6cIG7nrPJO9jbbYYIjIC4C/3jnh5IKRzRsEtcdQ7mKdchxRaUHOoxstCARegg0ACLH64aSGlmC467lr5flyS4mZIW4vqGqW3VUSV0sm7Gwwx8O+Dr8N5r4gbkxUMROm0yHJBD6yvYkI+O4PviwOTHoEGA9M0Q2FlLJkPLLEZayC44KFDtY396xjKVSo0VIi8b256EJjq7WOLOFG+Gv7OM/zDws74jYy2R+zWF6VzQ4goBAN7Df2H3xmHYy4Limwslho6Lb3Nr/le/1x6F4O8ceJPCsPN8jRKfQ1mLYBbc3Fro2O4tB7YR+INDrig1CDfUpwLdc8w4bJ7gAA+9AfkH39RqYhz3Z2jLsRz6d/cvVjQawZHHNvzlvNK8syF9Ux39qrfgRW4y3XHHGLO2wGiwd10gmtgb4xdlMtx3LViNLlNLjLcdLIR1EL1o0ECtxYBFntirM5UiXM83JW888ty3JDzhW5YoDc7kUNhglMVy3JKCBQXRQAbJq6rjkb/J+cPpl7mxUAze3vt3qcxm7Mxzpul+Z/sqXlUN/L1vPyHHHOuACEAawEHk7ne7rtg2Fk6pUxuM8slAAJIbLa1or17n24/TF2TZY7PklnKwwsaQgNuEI7EmxtdVd4f5O80taX3l9Zsn1hexQa2WD7V/2wwg5RmjpyybTiSJ/iz8jKI0QORoyFllwAo0I2R9T/ACPF4Dfj+VWy84eu22F+tFgNLu643+gvHpqGstZbeU8srhrBXHdQz/iOWPRZ3Aom/rjHiHDmu6AjQpttbwBBpyqIQgDv8+wwgGOzsLeHNVS8ZgDuUthtPvRJU5Drjz3RLqyh7puCyUaxVkj/ADg1QIxWY0dtaWWmXo7WtAZQvYGu/r4/kcMPKR0Fl1chbjbg/GbZsLbF1oN7XQvuN8H5i2+4/wBKS4uUooHTNh5YFWhAJ377j3OMaxv+oj9Irt7I3Slppa81eeSgB6QtDqwz+E20uwQQOBR7cYYvvZg7nTyW2WBNlv6W20IA/EcI40bC727b4Zfsz9nzX2Y86O/rQAJKF6wbFm7GxF18EHCJ0snNHHJEksbHpusoKEBdGuBt2H3wTe129zv4qsANaAio+WS2l5lHkNORncubcRORIeboHXorQedyAas98JMv/uTrWatSWW5MZxDjfUZDoNHnewSPY4FzAlyY89JQXGw4CtaF+4NC/r/AHBefZzNzOBl7E9UFvyEURW+k2GyUAnde26+9ntgWl+dpcLb7cuhqFha4aoGfNhtZq55VS3G33LZMlCOpd3W3o39uMJ58eWC690vw0Lo0LDa9Z2PtftvdYNplokSYgcaK9WsL3uuB/OsdLjTUuQzFdIbbrpocZ9evjg/kOKar3ETMBIpNaYaUta/GYct1AG1DRu5Xe/6Ym+XUOdFh5sp9CzSKAXXG/wB/jDSOZLE9oxnWGUuejQCAAFijZ7Ag/wA8H5NEhyczS086GWVgiwsa0e1gDcdsJfUDYJMXhObTsQOiyqMrV0yluM88onfYkEfb9ee2Csqy3NWSl5rL1noLDgWUUQb2vHpx0NRHESOmhpikMraXrpsIFIvkkfwxzJIzUqM6841LcSG3HEL/AMOgSADxuAvsP1GBc0Rm0TqbgyIK86mRX2ip5sveaLjgeQ2gltCPcL7g2fb+OCIfh7OV5UM96JRlesxnpLeg0RV+iwTyMfqjK/7L8lzD+zNvxFBmTOuI6HHEykCwoJ9aKHI4rHjXiSCy8428YEV+227aCyggA9iDtdb/AFxy21m1HS0n6dedV0aWIcZB2WIjvupy4QWZHUaceRYdQhFgH0b8jkk71uPbF8R0wpHmXWRoJFhxvizsa+nbveGeR5PmrmautZNHIUYrh6a9B/DCD1Da9iKB+fbfFETMHnERYzbI/u7hc1hsFZJGgCjY0b8Vh7XjNbbkq4FsX3TFvLlvwBPgtuSIrG0soQaaCzSCsnaz2H2wyEVacknMlL7YdcKivQhfoCLRdcLBNHfvuOMHf2cZDmXi7OzlEeLHblaA2UNoDSG0IA9ZA77A2e++Hf8Aah4WzXIszkpnIY6TbyA4pkaI7a17gADiwLxuj4cYnwtsioV2ZxT3Xl3ScaQ5qSVqABq+R/p84rblByW6stCOLHTZFkBBPFk3X88NZkSS3CdmtxtbbR0OaCdCATtdcjtud7GL35U/NMvajSkApj61MBqMAQXCOaF1fF/QYpgLrteZgfVZ2ctx/wDGkLpQb6aNLQPH5AeOR35+uFE6JIFPFKUl0BzQDwgnY/ej843c/KGI2VumXPX55p7pGA4wu0eiyvXdbHt/TGRzBlLZShKtF83yd8eY2/cvOBqQWpP4mbU2yjMnY7LRkt2hATp4NWlI7bYyElxCylLYXqr1Emwfp8Y9HXmjc1rJ8iz5BVlEJbh/uraeuELUS4bPK/a9sY/MIUVUxRgtrXH1Eo6oAJQOLrvXtiV9N9Rwbr3rk/EsO8mW27lVnMrLlR8ujQkyXAzHHWS4tJHUO69NCwL7HCuS9HUpksNrbKUAL1KCtSt7I22HxvhwITDQWp6IoKASEAK2vvd+++FE+MlkpcRWhW4GNxdZ+drXG64hwNWlTLjp7qcFLbceS6/BcetvS2sLKQyvUPUaG/cV8/GGUIsJhHWsCyCgb2T74AyqdLitTUMD8OUz03joukBQVtf0GOuS2wkI1g0N9I/hhbmtI7kWBqNpOLij2HHTIK2lhpd3qsDnbv8Az7YLDzxd67q/VqAJboWB7Abe2EBklxDmglHAsdx84eQXgmCllwuAkBawpsC1WeD7UcbTGS2xXSw+IbWqd/XZH5w75+SqY9OflyJCQ7KW+PX1bNi73FC7xTm70XMfPZihMKM4tTaUMMshttIA3UN9uB9bPGOR4iXXWlOL6MdS6W6WyemCa1kD2xbCdn5WrMP2Y+6qFJbXBfeQxYdbWd+R6L0fB/jgc4aTAkxaT1hOxFMxGyDSpbUxEuI21DMlYLDLQKg366q1k177nBEp2RGYeytxLBbEo6/w21LKwCD6xe3wDV74DditRpYT+O7FJJQdNFY7Hf3wW9IZZlLVlrq0MgBtHr3vRROwHJvt3xrKZcQDoomnKI0UFuySIyi6HG4zO2tXpQhJ4r4Juu/ziLWbPOoXHly5KWllQWtsjWoaPyWaHTsC0cYjn76/2oUaIiFMIQ2TBotmkAXtya5PveDMuOXxosObC8QJimWgxZ7S0EuR0rsLVQHqQRXG/bCjABa8ED35y6F5Dz2CFT5CfLakZhGU/LQ2jQ50WXCiOwgAXfHTF19sKWDJklLDTj7h225AG/8A1w3Ga5tlaHoDOaZiw27F8u+11lJCmz6wgjug7GvnChma9EeS5GWEKbBGsD3+e/xgPmF75cbFEWNpwpNENre1o0gitIG6dvzUfgnbFaYEl6G88xEdeYYSFvut7hsE0L/lvi2V1GVSGXVhxdjU5vv3774NyvKTmrcSFlTMt7Nnuu4ppWhDXSQjWCgk7mkOXfsKvBtzGQNkqo1tp3Sx3ROmOrDLUFlawShpCy20Pcbk1i5lCGpTKWwH2VgJJ/Lqvnbcj2+axCDpcS+FITZaVRKtCQed/fYGk++B2Q9JCYzbaVqUvUE0Adh74Ok4NF9AlOEeJ54KspWQtSUkpb9QtX5ew2/TBz02ZNhx8qUYwQklQccabaUbJVanKs7qPJ9h7YDUGuiwht4uLINo01RJ4vvjReMYXhqFByj/AMP+IRm70iMh3MEPxekqNJ4LQJ5brvxtjz2S0ujn5QaCJSBbMFtl8OPHzCQksIbpSFA7nUq+w2od8UNLQllTSgkhaLKiDYIsgffbEX0thalJIvWdk7gAf0wZIzObMhQoL0lZjwm3ERmwP8PWorIHwSfnCsxsQhi8IWahDTxaRIblIT6taLA3A4ujsdvtgfrr/wA4/wDSMbLxl4Az3wvkWTZpmjMdhjNInmotrGtxOoCqBNn1XXtjI65P+ZX/AKMDTdTe0OBkHfVbVp1KTy10gps2ktOFrWnrJVqcdClg2N9O45Fc4bx4j70DM5MjSwiAwB0lIbCyXSAikEgkEblYutj3wiZQUpUm3OpfoWBYc3rv99/tgxxT/SSpSD026srv1hGwO/8ATjDmPgQ7dZlcR2EW9ARJiKfM1JdQ3byXG1hSF72AKo8AH/viHh7JcwzHMepEgLluBC33ksR9SG2qoroDaieaoYIilteRzVoQyyjrircJcN3tv+5QPG5NYPyjMM2yeW1PyrM81y6Y1F6QchP0hDbt0BWyAb3F7rPY3XqrrgNF/OOQtaHuEkJCh9qHKKhFL8YuLU2y8CA4BsLAo2Pr/XBeXNsTUx4YMdtYWu3XSG7uuVn2rv7nHwTDTlSYyoDrcxDxUqR1yOo2OEdM7A3Z13yeMQEEJLv4wXpsrIvYe/z/ADxTRfH+lFUpOJ0UXZqnG/KLmONxCsKQ1ZKAsei752GLJ7MRuWmLFmtvuqWWvM7hlaASi0WLqqPF/GGSUMPeFW4DbOWtuRz5hT5WVyJJcoBhurGwJJHej3FYSNMq8zHvqJS24L0bEb/z+cecS92tun355omUiNBdRy8ALSHJPWbbb1dNpZSbFgC/4n4x9mjmY5k49J/vEtxpvqPuAFxSEChal/5e3xhzMgQIWVwc1i5y3LkTHn0SYTe78Zsba12NFLB2+mLvD4gPT3o2Y5lNiNLb6CzBYDiNBXawUgjWjbAVml1PsRI4UIAmXLPR4i3Wkuy4z6YhsB0ghGut/rt2G+Cc0yZEWBl0hvMzKky4xVLYDBbVHOo0CT+cFFK1j/MBjXZj/Ztn2VSY6M8dfYanQnMxyoolIWUVZS64AqkWECz87XWEjMOfJmQpKlyJUp0hbZIBcc5sAd975wDGOc1roI5dTmoJ7LgQgckydt2SiKvMGIrheQEvOtkt8n13yBYH6/BwyzXw1mUSM1+0Ir6C/FRPb1gIW4wtZty73Os7A2cH5XE6tsFaw6j1tgrAHF8nbgDFmaZU+iYkTY6JTfTbl3Hc6vTR/wA5H5ORd8WOMU5fli/giyvJBYbJHmEFiPLPTkxnHUVbTKysCkDcECu5O3scUxook9BGZ5gYSWhpZWpgqRRGsHSgXv713Htg5Da3oRQEMaW1lyyuijatFXwdu17YWy2W/wAFLHTYK7SVaCCV7i7PINV9SeMFRqimRmIKztEFsRz8pfmSn00p2Q070yWkhJogc3Wxrf8A3WA5KbedcQUIbRo9K17r+gPOGGYtNRnEpWGHOswHNLSVgMk/8P172iqPP1xVHZakydJkqYaU4ApB9atPA08a/aseq4gPDQzdPFKJKhBUtrM1PwEpWGfWOu2F+kA7KRwR/DjElZmHlnrBZQ6vqvJRSBr/AM6ANgv7YtDkZtl0MNrQ+6khHTeNNIJohXuKP64MQxl7OQKhSon/ALXXOQguLacQWmQk6kDer1kXYJ4rAtoQ6W78juRAkCPx9/6osuzmjN6TxbgStDEx1lZ0vptKimz+Y2nVXAP2xTk8aOqSt6S5phJV60Nr/EcQTsjTd1tuRdc74vy5l2bKOWuPINpccYEiR02ml1evfayEV2s1eD84Gue9LgLiIjuNqTojqW6GGgEbBLnrRV1vzSt6xRldlObUc+qEBocIGvOeClG8D55muT5lneQw5E7LsrjtPzXlthsslfIq96337jfbCfL1MranLmxn3kn/AA1MOIQUPbhs0R6xdggf6YZteIMyi5E7lEGZLZS+kNPkStIkNBZLaCge19ya2wmlUYgdcddK2yG0BfI5Jojt/PfHPjEB7jUIjaPv9/2qHfKIAbIO/PX23lXeFomWueIITea5qjKorj/SlSVNlwx0VusoHIqxQNnFE1uGZU1LJaLUdYQiSwysIcANAnfbWN/rgpXlIQYciqe19O1qLba0dUnfY8AN+9774LyXJs4nJ6+VRvMx33HW004gFzQL/J70sACuT6N8E1hN9eeqQ6M17JOvouQurS0uOJUpHWRrBoj8hHcm7sVhplGWx5kNcePnzUPqsSHnRIjuJSOmm9GpNg6+B7E7kYH6ch7Ocy1RXI5ZbcS8lthYDegEdMpBGkWAN+P4YXlS2oxRHmPhIDiQnqUPVVgVzYFEfTG1AXAwYjcLWNi5uuRyU5gh/qdNs6ULcSCuwRR2PJO+39MHZmuL59qTDkOIZaXobWw30iVoGzgSTt+7e93e+KZuTvRW3+u6telTSI6o/wCI07e+yxtsO3Nk+xxU5HX02VrgqQlbOltZtWooFHb3vt2wgPDwYNkwNixCmJUYOpfiRXW1BttS3VL1qbco6yAKFE++498HzFzsrfZL8KOw8GtSOkn8J9FmnCoGl9wCPb64rbUynLm2mlutTysKWjpgAqANWb447VvvxgnNJUpnKmI0qNJbTo6MZ0bNvtBZ6h3uzrHI22wls6Iyd+dFLKcygW4nMIC50ZyM40hsOdMtr0ehywPXVWRsOBeJGdGgIlusJjuKdQtj/DIDjZ4WB2Irgnv8XgfJ45k5grLYsJ+alwrLUdpYC3Nib11tVXXBrFpiRFOFTLrDcd9WkNOvIWtoED17D+WGduRm059Evs3G/ip5e11X5S20PsQ0IClxnHCpboFEjXWxO9GqGBocpf7RYQGmAySS23IcJbRdgWPgH+WGJedjsJzJ4IlmSjpK1yV9Zv0ULreqGx/IartgzJ8smS1TGTlomvxGwV+X0ENgE+sm+N9yNuLxbQdEFS1QBuvo2TIVJYjrZkFl9sBlaEUFukAijx7E9/phr4tiZdl8xLeVhpbEljrmLJAU+gG/Q4tFA2E2K4BA5xGGVu+HYXms0fay13MZBYjAdZDVIRbnTBFLJKEXQurvbCzNf79mbr4ixcvFI9EcAtBYABA9iea45xeX2BHOclQZpcTzk2UXITkCFl2Yl6I4JiVus+Xe9bRQaNgboNCxxh1kSoCn4z0xmUuGUoE1tL9eZAJuiQaP6gG8Jm26uC/GfA9BW2V1ug8g/T9L2w2RLYZy1aGmFR5btOOKD1oW2ONq2IPz9sCJYLkJNchwi6rczVDkQwmYtsofW6ta/wDEDYNIQCfyVZuubx9EjozCFKkuSHESG2Wm0Rmm7b9bhQRrukDg33J++CfKvktTJSHwZBDuuSyQiQgHcAnncAfOLMj6YiGUp0tyzLO5pYLejf0FFc8b9uO+F1aoNz12HS/2hMosyiD9edZ90O5J6vUju+VWdYW30nteihWwF7UAPjvhq70/wocOcJEQlDq0LBbbDpRwQea3Rr/1x9ljDEZxS52SLDsh9tAmNrcb0I0W42O1rBF2SRzioPI6gaKCt0OEh1zcm6AQ5fIFVf8ALB02nLPI54pdSHHdXSMpfehBb69Ept4thkEFdVf/AMdDjfb5xQQuPLeeUlHWbohwbIoCthXfbDmIH4drV0F+bZrWgocNa6IQexsEdu+C3IqZaNDq9brikbr3cQgdgR+/XuOB2wQgdkX4P3KncSDOnObLNtQXXep1WnOlvoc967/9MTbC/M6oywyUN9NC7Jsc3f3NYaNMssy3GUjrMbpb6iKWgdrHFnbj3xc2y0hbSsty1uFHhoCHg3r0E9yTd2e4uvbDR2j2v8keaKlnERql/hzKUxMucjONEqdWSzJkDdutyhF7EEEe+4GNCzlrbOXaf+JxqPviT4ZgiOG5ywy2S42j/EW252J/37Y1+UOpfy5vK8wS4xCbeckIQEXT/HrHO/HesRl7KbWtYOyAu3RpEyXm59VnVtSW8rYghlBZaUVgFsEWeRdb/TAvgvwfM8S+JBlTkqIwGBsZAIYIG5BPY7D641q0S8wiOolodQWF9NkOPUEN7khCO/1vtgQpaitkeTcbcKKKzutwi6I9uawDajASeeKoq4Z8ZWmOnLrDZnl8/Kp70Cf1gXVhay3uHACemUf5xd7jbBEaL0pIccU+iW2NYIpulgfPzvhnbMh9PVYe1Naz1G5NGttFA7Cjewq7+MSzCFJDr6JDifNuAFbr1khw9z8/PzinNnM7c8ktlLLE6pVMfZU/LRJUgr6d62xft/M8/U4zeaxUPIKIrpA5JB5N7EjsBt/sYa5hFeyeawrMIza1eVDyGnFhYIXegkoPNeujXbCmS5VKJWHBX4g2P/c/OFk31TXBvy4hLHUtLmj+7txChJcQiyugLIF8n7/wwS43Hcyd1Trz6ZdttoLjKFoQ2LNBd69z2A7b7DFnUV+G41HACF6iVo16z/T2risWPRpMuM2htC2koX1CWm7vbvfA9/8AthPaDZa2SPWyxjWkw4wEtdkypcOQ5Jl9R3poaWJFrW+gEbDbbRQ29u54wfLzOHJhNoSyhnpwugbAdXYRV2eyySbO47HbH0aPGSQzIjyA8AshyMsa3F2NFgnYAXuPjATbEoNuTErY6D6yhbfUC3K965rfn6/OGvnLBR0y0OBK2/8AZf4S8MZ29mMfxBmsiC63G1REMs6i67VAFABPJFe+MZnOTtsuPw3pAD7bgHO5APv2r2NYOyh3Mp2cxWXs5ZhKc0NonvOFDcdCBsFrQNrAFd8D5xEdZd0T2iw+j8XRWhZvcFY+f5V74Q53zRlse7nAgZSLapdJv7InK8wd64RJfXKaasE9xXZBPb/XB+V5siKYwjPvSGW2XGi3JR1ENFZJXoBOx7g7G8KUFEhx3y8NtkIbK9LZsEAjizY55xbA6TT6VloOWj169gTvsP8AXGmpeRqmCjYB2gXsEvxFlOZ+FIeTZRnr2SyFNIalplOL6TjpVRUFjZKANyT/ADxjMqyWQy7NdkyWS00p2MzJQvW3IdBGzZHuDd1WA8gZaizWFmSyWmyetsVrIKNigD52v5G1Yd5RlrMGR0HV60o5aKwOms9r3B3rfviANLD/AOe3XdW0aQzyTZDT4cZUR+DJhsIdEkaJQeAQUbgih+ezXrvbCHNGo0FxLkXyx6Tx6aL1uL72vbcDgHG48ZwG22g00JAcWi5LZQ2EawKBRR4vv3xj15XJdcbB17+so5NAbke/0wbLnPNl0szQ0ABEeCM0zTLMwcmQHnm5AC3HHW1kFZ5JNc2f54e5/n0/PDLlZpOWXup6A4L6v0N7cnb/AFwqZiCLHbW4gNqQjZAR+Ivc2tfsbFb/AKYPaey9zJvIORLeMgvCUga3SNFBuuKv7/XBw4EFoiOfyF6j8vPniT1WWz12ZbkVuQsNLAC22dgQFkjWB+cizzdYuy99qMw2wxmpYflgomlaabDRooB2u7G4qga3wwWnyU2R18rc0rbXHAkWChyt18cg9j74T5/AeDLsnL0LeQlltx90Nmkb9z7Xtv3x577hosPLv8l18PDjKnPjsJyNiYw9NW84+sPa26aR6ARS73XzYrthNnU3IFsR1wWJi1BhvzQkgUt/e9BH7nHzgmF4hhZdkKxNyeTIfkStUd4vqaZU2NnE0ObsCxjGL84+pTyaWq7IF3v7YvwtQOkEc6qyo1tI9kkxyPJWZgrzDwW2z01KNaUmgPpiWatDLcvQ49GcbC9wD6tu39cfQ1OqUpSFI9O41bE4fZ08vPshEWSGWXAhADpb/IEXwb799sU4ii8MJBF0yk1r6b3tBLot0svNMyzGXMU4tKAGkCiKB29zhX1ApoIPI4JOGE+C/Dcdb6qF7V23HP24wsCQFb8fTHGcHl0uuV+e4t9U1D83VFIacKRoWrR3u6B7/wAsVyGloP4uyiNW/JvDCUqEnLonknlreUg+abWjZJvaj32wGwplNhTQKiAAtSyAN/j42xtRktzNBA7+aJbgxsNlCt+rYrrGi8KvRA883OcW3rbV0HbpIWBtq+PpvdYUQ2kLc1LCkoBtWkWQPjDJ+DIDsWKaLjoBb1+kEE0NztXz/phDSYJ071VhmupkVAtB55vovs9FoNykAKWoWpFG/QTwdq+cWN5lAj5OiA1AQ48mX11yeq4NbYRXTKAaqyTfIvAEOm0hLqHHGb0P9NYGujwDwONsP40WX4jjIVKU2hMRsMIXsFrbQKQNhR0C7Pe98NNL5l3mwv8AjTVdmrXDnEAXIWSdlqTIKAttYDhAQTrFDub7YKzpCsqzBcFcVtC2t3nGXg82rbbQQaKN/f8ATBcjKsrXMmZbCfDiU63Y0uU4iMaQ2VaVWdG9bUbNADnCcyHZEUMOKaQ0y24pGtJUV96+P5YeLt9x9lxnEh0ON/VVzXi62zHbdDiUbUN9C/g9x84KlMj9nQUl7ZzWoa6s77VW/bvt/HF+XFrL1TmUxoktD8Uo1zmdJbOkOBbd/kc7Dm99txhH1UpebeWEPEKOpCx/A/7/AExMXPaJH99+fQQ5pnNr9PZGZa7AblNuZmlxxkLp1lghtzTXINEA/bEnITq2POhkMRHL6Os7qCTvXvRNHAst5Up5bjzjaEkKKG2UbN8kIA7Df5rFuXNPzpaIYU4sm0IbTZtZ7Crsk19cKJvLgn0iXEMVT5KY7ikEloqTZAvSd6BJHteCHc0musNtuzuo2iOmOhK/VobBKggWNqPt74iZUqE2qIVrZR5hDrjZuuo3qAJSdr3PI2/XAin1uulIWkagUKVVWCbx5jyBa09FhjMjsrfUOutU56K62S62ttwpJVxdfrvzgN55+W64mVJLyiSQtStibsmz78/Jx1cbMW4QndGS3FkKU2hwoUEO77gK4PG+Km1ajoddS2lSK1aLBrjYfTnDPmggNCnM7q2OPMPvvSp3SdLZdQSgrLi+yRXBPv2xxppTMlSZSElxm/QVUDQ7n/d8YLiQHZMdmPBWxMkvNqeDaSQ4wGyu0G6BJA10L7d9sCR5KWXGnS02mgUEAA6kkUbBvcg8/phZIMnnN14CIROUQxJmuMNvxmwAotynnSy02Ugr5I5NUAe5GAEFbq1LdUop1Wsgb2r+pwUpyK5lznUVokKWFI6YJKhxpO4CaAsGiTqwGttSmuqgKKEEJKiByd6r9cYGlzi5eLsoACMkTJ+ZGOzIfmSGYzRS0Fkr6bYsmhwAME/+JB/7llv/AOz2P/zMLZKn0PdJ51TiksBtNrI6e35ftZFYs/8AZX/umYf+sf6YOkXMEMsO6yx9RznSbnvRKzHtYQ+vpI1dEFPyaFXQvuRg6LHddDDMUuzntB/CQ2tXTvtVb9txtvgeKpqIWn2ikuNvhzUUWoNgjSSN0b3xZ43250cdXiDJs4kqhzJWTPBxIeWCY7qEOELbK0I7HQldI4/TGZAQCdBwJ9J8WbqVRChvQWYsqSy2jqt9RkyEBQN2CSg3sOBtzvj62nXUMpcXHZWCXEBdAoQe47kfr9TgaTOSkMvtutzCW21EONhFq7hY/fqvvhfqZW068uUmyaBWka178/Qd/wCGDyNERzhRVKsDKmoekyMzIYkMgBfU6iAAhB9+Ow3wV4qyBvIfEUvI2c4yrNmWSgCew4RHJ0a6Qs9+2E7eppBS8qgvei2QduP1Bv6YunPtfs9tLbLpJsOuOSL1nXsT2HHb78DFUAi1u/VRkdrWw2j7oVpxbM1lcR5yK8CgD10UL/hW9/TFTbrzUjrPMlwtL1r6i9zvvf37fOOudYZc2yl9aoy3C4w2ogkk7FZHF+it8H5M3l0mehGYTTFQ4CXn3GS6W9xuEI5PftgP8uuEEEDVWtNZe1mDwzNetxqj046wUWT+Qnbsb9GwoD3qlqS+HAuC8tCWyDbfoPFazR5PeuPvixOVNMQJcxxqQXHHOnG/utMOij1DrsUtAKCAL53rB2XtZVHRFfLGtIK9Yces0eDQ7o57A4K9z09+dUIv3prkWdy1wMyhONt5wl/LxFbM5BLkNsLu2t9jV/QE4aeG0ZInM3FxEvxGjFGhDi+tchsAhdVuLBIQe212MZliTHRHKoq5Dyta2za6QUGu6Ob9djjB6Akw+jHQgJQ4KLexWAN/m/btjWVy5wA8ZQf8LMpkWNuDy5uz8S53JzvPpGf5g3FMt58OLbbapp2qFBI2rbf3wjzOfOckOKR6JEzZxtBDfU99kbVtxVYOzFmZFKerGkRAtOtBdQRbXII+BXI9sLpIiNuqkvN9RxaDWhdb8g17b8fxwOIquebc56K7C4VjWZW6RZHLgRh4cZmSM+YizJGtsZciMvWGxRCyv2Wdhsd0DtvgBESAuQI7+YM5c7DZW71T/eG5DosoAri9kb7dzzisZzmBjPs9VHlNbTqwGwKIJ0AHlAFnYHFDnXbacQpxGpa+o80TZsXue/f3wAaXG/PotqYKGwDrzolc5lDEwF1xt1SEG6PUbuz9q9q2x9kKJqZRaioS4l6O4h0JSha+kUHXsbrYE3yO2NA10ZrD6HWOspxdgBe4PJWRXHH6YElxFOtxQqOz/dmy36GACW7NLcPCzuRfwMNol9OmAFDXIDyCmTngLMB/Z/I8bx5sFMNnMRDWkvASLHfp8Df57YU5ey20M0bWyiW8uENaphPUYdW6gFxqjRPyexJwS+0taEsLgvo6bxdENtBAWKqieaA77/OB2p3WitxtCG3Ymt1UgqQkrQASULsfiLvizx6KwOHzsc4uMyTFtB0RF1OplERpN1OdLTOc84hcPLXWI7WpptG8laPwyaA0IXW9XzZG53peD7kNx1jKnEMuFth9betwFzn854Wvc1x7YuyOdAiRH2Z0Bmc7MQA2688tvpLC9id6Iq7H03FYnBciOeHJ/VzGY0+JDSmYLTBLTuy/xFrukEHYXvucPOJDGwdNOR9SqqOGaQSDfnNkI2G1tqeaYkRIiEdGUtKC6FrJJQF9kXQ2H+QnFkUz5GRoy9iCgrafUnzTaEpPqQToKv3+LFnYDbbDKNk7WcOZYmHkmbuJQ2t/NVRqeXSF61uNt1+HTZ4Wd+eMIlyMvOYF5zqPQetqQys9Na2tf5ARdGu/bDg5vzMpvzwUThmBcNudUHEEdPTd6h0o0dQ6A4eb2varrBmWn9ntGXqQ/NWsNQFtu10HAuys9gORRr8+scYuytp/qKhsxozhkMlrgW0DRBB5B239x33wvzhhmHP6CtTjbBGsWAdfft8bX2GBrNDGWsVrGFzsytyrN5DLkyOma62zOYKZaUrKkSK9SA5vv6wD9d98V5a55FbL0+EiQluSOmw7fTWUUVoXRBqiNwQd+cSLa15YWjKQhlpzrFGsguLIoEbc9u2OR1t9USpSPMPurWgtyEFSFgorWV2Nwa/nicPNQRPPPkwt+Xk7RClKjxmWYr7UpzpyF+YXFVqAbUFLARfdW3P/ADdt8UxWnWW2828suUzrpbi0UA5vtd7n5/0wXMixIy32J8hhyaytDLT8UoU1aALJoetFbWOT/EPKUU+w+6FvxEOW81dN87a+wvfnA5YEEeXPVa0wJF0XGciy21JKChS9CUikAEDm1njck3+uGOUMKlKSy3BXLkNq6fTW4S04DRQ0gWCFkhZ596wtU+JWaGQllDbR2baabDaCB+Sgf4374NjuSXs1cbcQsyn1hD5ac/xCNyfb3N9qsYlcw5+zCoDhUbBTgwRGydifHiuMP244Y0iJbe7n4a2TZLgoLG/GjvhHFejzczK243k4+gDS2orIpHO/3Nbc42rviLMMw8Ns+D5TgGXNFa4JdpHSPIIXVkHcc1ZvtjHRoTchDz7s6dHPUbZckFlbjAa4X1FjehSNt7w4uOrBprvOum9t0n5QY2HanRUvo67DSoiF0wi3AV7I1mh9ie3vgrLHVMOSumyikN9IBoFYNkXxsRsdjf074qyxn9oSkM9FsIQhYbLlaAsk0SaBr6nb+GPoSJMWApKJDvSC+rusgGtgR8iz/u8blkwYIKW5joJCc5YQ+wlcZ1xc9CwEMdPXaANiNG97e2wF3gljz8bLnIZeUzElvIccaWCEdVAIs2OQCdx2XhPGmFp9ryq/KPaz0ZDSy2tBP57WDdVf6nnDWJNUmXKmOR+s0tBD2p0udPqH0Equ18D5Pfvi75jnWsQOfgqJ1HLHfuq1rW46lGtBcO4Wskrqq0fHG2CZ4i5hMhtRob7Smmym10ULdo2sAUQaobi9rwI4/ZbShSArkrQfzi7/AIVh3lmXxnVvKVJcbe6ZWiQ6igF3vrXvW3BF7kX3ONqAVhDlGKRpuzBFwJzcrw45AdS9NdRKbXGWTZYYAIWgWdiSQfr39ypeXMyltIjoivBtCw4Q4G9a9yDZ2rb69vbCvLm0rBUErDqB6zvvvQ2++Nqxlb0/NW8tzqSzAENDbb63QAhCGxsNv39F7cnDBmByA3KJ9MZS+LBZ7M4k/L57mVZnJ/GhrtyM24Cx1AigfQaKyKtffCVyPJE3l7qoWQW07UbqjXHfGpfyvLGZk5l2c48w31TGeaZIK3AD07B9YB2+nfAMPLZbkdKoktDighcglb5Q4CPzge6+9d7wmqS1uZ224TMMGiw170DljTkFbeYwYDLnTJcXIWNZYAoEEdwLRvWxOGOTT58WWmSJDmor1a2joXYJ3vkd/bnEI0FT7biSmOOmiwACAAAN0dr7/OCW5SlZf0Z0Q/3YuUIyEdRxBArfubHftffBw1szpfbn7Xi0uNgo5fJjN53HfmwC9BEkKcihyraJJoHnja8PZ37D/acxzK2VwY0tfXjRr6vTOs/hLsXdb9+cZ8MvJWUUyXQNWhkgoO35AR2OGnhqDNlPpLrSxDbbBecjr455J4Bqv4Ync7K4OvpzzmL6qtlKQQnvg5/Kmn305pBMhIYuMULoNO7esDg7djhvEgmZICIzi1pKCvpIcDdUL2PbCmGpJj9OI2888KFt7Ugd67/JOG2VZE5LmNiOCpKCCvW5d9j9d/4YdXdnbJ0R0KGSY1KLy6I++pQeWhYQAW6JO3b5xzN4L011pYlf3hta9bbR0AI0EDWf6d8aZqCmDSC501sGytHI3sC/fAMiG9NW48LYU4vqIcXVhZPJraz/AFxy6cuGYwu20hrg1Y2PkzkaMpbqVlRQFoDg3WL7E+/OLEZUpbb7qkkNtt61/h8gbED5Pvh4trM2emt54SG9kIWFWB8X/TBGavKQw20lpDJbQNaGXNay7V3+v6YpbLw1m3chqUm4eX6ryXNYrbbbxfR044I6ja104dYNAD223J9xeAoAbjZfmjqIy31NLYAb6OthY17ha7BRZAqudwTWNT4n83mmYSJsnzU+XmD4tCG/zk7BFDk3X64yWeQ1tS/KPQww5H/CfaNgkg7WDx7Yoa5zTJ1UWXO0Ce9VZfpaytgtqfeTIJLxLBDbTpJpBcJI4BO303w8ytl1vrJbkhl4tlsAmtY7ovg2B3wpbiPBzRGde0NBC9AN71xseP5DGgbbQ7HDinkLkk0tKOWr/geKr6YCi4tgHv5dUupgt055JVmuWqcQlbbyXC4gLWsWSi+UE+/F9uMKs2i5hl8ePGdQ2GJmiV0HKJKAVoG/IsXX1ujjTsRJMiJJnvKWtqM4gL9ZGvWa6d9jQJwrmMxnMzHl2eggklfWWSUf8l/H9cG4EjLJ5+lO7KTPRJ2mWksvtzusEgD8lUitgfY7bXimfLadjv8AQQ9RXQdce6q6rYEnc8D6DD+RlkZctmry6O6CpkrJdBAG3Av84I+Lwsay1+C7FzJ+G5Ihl8tuJ3Q3IoArbDg+CONwDgXlrBJ353IaT85tY88fugoxjORG/QA41YtDYsg8i+5v9MOY2VSFwOsLJDhbWjQbboXZPB2vv2OBkRlQZTCZavLh1Gs/hlxccWQELQa3I3HuCDicOdPEMwBJK4Jc1rZWu0dSqsC+aFXgfmAplRuWCE3yqFJkSxMRJjsNRGyFuPuBCCEAmgLtaz2rvi7LMwkFppkQOm66dnHDrK6NUANv+uBYRhzjImS5bLMhsj+79MkO77gEbChXOL4y3IM9swnYurLySuQzRsng6/3zv7bfbEjhDoOh54qvDVCbhPXZi5eZtvSVLcU2hDYB/wDLR+RA+BuMWznIy57wMVcBLaKCCS4vX83Rs7fTAkCOufEEgIbBQQlx3qAetZ2NdhwNtsXt9KbGYy2c0IUguF4zHXDa0L4BHtY/P849TYxmltffuVNZ7hAF/twJVmDrklxaXnC5Ik7lYTysbm/k4GjxZmWSC7JS82pt4NoBQsHqDfY8WNtudxgzM33cvcD7TbK2d0IIRs5WxWAdwf64mc3mZ3nxmeI5bj7RlapbZPToaAB66oLNBHFit+MOYCRHOapTsRDhlH5X2bS1THlTZImGcp9a5Ul5fU6hvbatjzd8/bAWYF6U09GbffbjugNuI6ldRtBtAWBQIB3+uLGMwfEZ/Lm5TrcKU+lx5paxoc0H8PX8izvgMOZapbiHJraJrUkANEkEoo2fauO2Fw0OA9uaRt3LrYZ5LLCyV5plcZ1hDYY6wbRQtf8AusI42ZtxEsR4bXl5LMsvpftBWNhos1fIuuMbl9pSYxSUN0Vn26nHP0x59m4jwXVq1BvqHlXx89sX03ODm27O/PqumKoNNxcbrni1MWLCVLmR5bObGUsyOoAGzYsUn8yV8k374zTeePBbaussISfUE9sU+KszXOkVNU/5pJV11uLKlrV2sH+fzhQy8pLBatXSWSQ2eAa5xTVrfNblbovnKvxN9KuQwx+eWROaSWJatawASuyRteBX2G+uottqDP5kBZ3o4hHAJHUTseKPGGceK2p5KCsUpFfmx7D4YzLhrzdcx5djHZygZ7BiuKZ6rEkJA/EZVYT3/rWGfhmHlT+YtIzaQ+1BUfxHY7IdWn6AnEIcdiP5mK51EKcb0kocNHcGiByNsMPBGYP5HniZ8Rel1kEoXoCqsEHYgg7E4TUFWkw5hPcnYXB56wabSh38tZjl3U8wShdEo3se4IwseJafdaS62+iy0ha0ndPuAeMaOe82lSHG0ONgtk2QLJrj6dsJWWlmZ5hCFULBo6bFbj9Mc9oa0Zl08bhrhrNVuvBGXwc8LzGeZkxlUJtgMtS3W19JlaNxpbQPxF1Y3NgGyTWOSlMZbMcytrPosuJHttiZFQulg2vYGiQSasj6YHy+BmMTJG81YWtiEqUSw0HtaOoBvaPhBSCSNx9xiiTHRJatbTZlaysr10F3vxwO/Hv8YYyox0unXnlpp7KOphKjT2DEIabmOXsqirbjiFNy/WoSG2OsqS7dt9RCzoAGw4+SCcKVQ5jTTMh7zcVh9specSAaSsnVpAI2IrY839MGsZSudP0LWhtPUAWS4AuuSQDzsDvwNsK5L0sONxYzinm0IUkNMiyQCT6x71vtdfbA1awec7jooW0WskQb/WUFHblyWpUxptbgis63FE/lRYQCb53IFfOKElqO6yH0olIQApSErNUdym+x+Rg5qW8Mrk5UwywEPuIfccC7UAiyEi/r9b2+MCxlyWojxaWlLTp0rAG5r22+e33xNUnXUfTrzosptJN1CMpSnGCVIjI/wVOJTwO5NbnY/fB+VgonNNOSGYh8wg+ZWFjpgbBZKN0Ac7b3i7wyrKo+dx5WcNNuw21h5UfStQfCTu0aIIC/e9sF+MYkNtZzXL0xWstzJb7kJiPJSstIDpADiLK29uAveq3OEuEbgzI9FXTaAL7JP1IqmXCth590aiVlWlNcBR+br+WAwUOuJVIOlBI1qAsgXuawwy3MZOXZo3NgtxlKjKS503mUraVRulocsLF9ji7LcpGbZNMmR5bSpzCi4qH0F35cIUpb2v8AKEggDSd9xWNyyJSX1CDlKHbzOYzCMB1x6VCSlzox3Hl9Ntah/iJTeyu/88COuOv+XEiUoBpHTb1gnpp3IH6k7YtjQpMqK8+hpbjEcILro4bClBCbvjehg2c7By/xPNMOL1IaVOsxg8+HSihSVhxGxINEHj7YwueQAsytmR/PTmiVlxtMNTKGgda0qS7wRQ3HPzjr7jhc68gBaihISo7VQAHHsBibgkNTfMyB1S9bilLbOlYJ3PHBNixjheCkPhKGmw4CSCkq0DVdA9v54dmJPgliN18VOiK6512k9VQ9KQbIPPxQoWPkYqjNDq6VLb3NFPUrbnnBPk3W56YDo67g2QGVhwWdxVbHncYulZPKjy5DanmB02Otqcc0axzQB3vtXxjC5odJWAEgFBlBUXAI+pKj6QFWpv1dvf23xT5lf/myP/Vg7LpcSKzJaeSsuOJQhCkttrCRfq2ULuuCCN/jAmnL/wDzpf8A8of/AJ+DAzCx+yAuy6I8iTAbXls9p1CkPrSqO44UoQsAg2B3Br9MOH8udy7zc/8Aa0JxMZ/yttSQ4uRtdhHPTI/f4wrZjWtpx5t+RFaT1HkoXXfeiAqr9O5HfFuUty5bwy5bOYPshJfksRmtSgEA+vTtwCecEHZR2xP0/PktDouCpy1RDEaddYnMhcim6UC0lqtxZ3Lm49u14EfXFDLaoznUekIPVQ41/hUsgIBJ9Vpo377drwbKltSoMT9ms5dE8lBUHEa/W/6yC4epy4QsbI4CLFVgVTjIilTimX1J/CY1BYNVzXHNc+2DpluuiFznOKvyvNVMhSpMFuZrCUPGU4dRSjgA8o9tvgYhnUSZDZjMzUdJD7LctpJIJKVj8+3x2/hgnNncyhZfluTzA20163g2emXUKWdCgsga0D0WG18XffAkSYlplbjSGusnZzWwHLR9TsDdDDKVJgm2vPohc9xi/P6pKkQG8tQylmUt7Wuy4r8NA23Qjm9iDZIwRFjRnkTFuzW23mka2WlI6nUIIsWDQGg3Z5qucTYQjoRo8VmTJlF9ch9rWhTS2kDYBHIWKXe+4rFspvy8px+NJS8y63p8wYpb6hIHUFH98E0T+mFsHaLZvz0RPcSJiybIOefslrJswflIy6MnzflnVmmuroGtDZI3Noojsb4xyO2jMHCJHU8uGfX6NkAA7IrgX/1xzLELnuMMwsvmvSmoy3ZOgaj6CT1AOwQ2K/U4JS7l7UpmRDkPAtth1wrps9Q9mwSdYR7n9MOcwuZJjpzVKovDHZQrPC2XyDnEdGWRvNFC21ttlsLKyTt+GT69wbHsN9saXxdEyDw/4tfey3PG/ELKOk6ht5kt+s/4iFjugbDkYyclmNl+UQ5bGcoXmTqz1GmQsGO3xuv5+L2x9kSIz0nq5iiW/ERaHHIRpYoH1krFb7c+xwqQxzS10ATbb0+ioa01CS4T6rW/2keM8z8YNRns3fW7LhMNxoDMdtAbU2LK+ofsCOQd8Y592M7C6jjyFuam20fgDZsXdiwb4/XkYsnuocLbp0OKLf4gDOgD9wfB45GOyHUPNtoTDirASQt1pBC3SSTye4sDbsPvhTmlrwRpzhXRo0GsZlAuo5qyuRHZbdjNoL7Acbkhtf4hQCgIB40bWeaIq8CVMivrDiG3A+jQ4VigRVWOCMOssRDzKXBjz3/2c3CZWQUWeqUHWGwBdLWSRrO1nfjEXzGkmUiNDfZiCSSwhxet0A9lmqPaz78YMAOcZN9YujyltPLlS2I55NSpKkhtIcptHUpdcmwN67X3wS5NLDj6GmlsNur9YogAf5As7kfB5rfHWIqyNC19AE0sgHRV/v8A0717Yl0ZEcSn0NuFoLoOOesOAngE7Hg/O2H9sWBXJexrjLkU1KalTMvebjof6NfhMlbZIslaCsVW3cdq32wlkMxGfEaUxlyvIuPkIbA0OOI7cXufv98PcuzCHl+VTmpMB19MlkNRVtgt9J2wbWfYixovfY9sVobnPSWM7gEMZm0tbzbhZCEHpWLF7E3YoDcj3wFX/Nr89UktBdax+u6VZ35abLdzQym33itYMZuKtCI4QaRudjr5+t3iUDK0Rs1ZlSZsRGWLlIacdDa3Ebo1n8I7rCO/z+uGeaxXBJLcSY2xFbbRJGs6LXtaALNmyas1sTgrOH0t5OIrUZsW91FzOiUOrpBQWwbrRZ+u/tgMgDIYdrJgLwCT1vz8XS+Dmj8DNH3vDcpnK58xDoMmPIWyjoG0LaLZNNoPI3J2HvjJGHTwSgrlDT66oVtvVXY43+uNJNly5RYZL5LQHl20WgBts3sCdgLWv9cZZ11xtdLcWTooLA2A9heG0g9wDiUEhpICvj6G0Kkag4kMEo6ZIQhW/oUaFHa+9mvnBECNl70KYt9bbstzpIZQoLDjpXsemAKOg0SSRe1YDgNrcy+cFy20BhAdLRP+LvVD9frj4OllIWWi2CkdMJ4Iv13t34HxiouLzGbm/qPNI/xeEdGabU1IjrZeWkuFMR5KAg0g25t3NVt2OCXvDrjZVGdkoXLQsFcVs6yhs8r6g9H+TYXz8HC6O2vqJS0lxmt2Vk6Nu5J5/TGky5EQ+HJbzuYRESyhEdmEIpK66lrJWBQ2Ox+2IKodSfNo7h3/AL6G3gr6TmuALrSkM+F5Y5giclDciOG2kBtY/ODRo8VV8bYA64YjCIyvS4hwuJdSbG17D4/rg+ayluGtC9ZcICEEmqG+Lm8wdeiOx5UGLOU+406itaA2RrFBCKG47fpuTgaZqakTzv8AM6rzy2LKWmGFp/vhcdcALjTbFELI9Yv63+t/GIIjAT4vlAsqWgUgLBKzR2+L4+N8VFAD7cl9GsSFAlxwEAEGjZ/OBRB9++CpgU+lhCNPmVrWl5adtiRVD9z22/hjHBpJm3OqMdkANumceXLlw5WVszpBZfJkmKHPRHr8966s0BuDiE2NKbgv5ZmHmGZTVMIjuuLQWkf4l6CNxZJ3/wA+wwtdgyRS3CUA6EX06sXyP93gifOXMk63aeeW+CSgkXtxZ37bb49GRkN0+vPdNDS89oKtuJrlvPQnX22kAuFwrAKAATV7az7cE+2GGaxpGU5e3EmQ4hefCNfWCy/GWhZtFX6LBFg9q4vEXI8MsLX5d5mlr2Tvoon0FHAo0DZJF98DZuiMmShDsxb7bagFtIWeos/vlF2DttZ+MODyG/MOh+qmdTBOUJchCG2kIlQwuQ64VmRIBAAPB+e/x33wTlWhjLnWnXwA48EqpsHQANyDze/HfGi8UeI3vEeUZQ1MjrOZ5fHDS5Li0FDjCN2EIRVI0CxW5XiiJBakQ3mWEOB19jqLab2CNBvWfcVexqrHOCZVa1xM/nTnekPpHK3N7IdrMHHeoGlAkG0LQhAABFL2r22+NzjU+F8qzPNyzAySM7LklBPRj/iLQKPA+l3jMIy5qCh9J6y3SELRQBA9wTe1fAPbGj8IPPZeWn4Dz8eZuAttzRtRF2N8AyrDm5tOW5tZHUpH5Ti3XZM4GXK8yJIlrQpay0WygocJHBJJrt9qwdIXSy4ta1uLA1uOOE6zfJPfEoTfUdakuvBarQV2jXYPcja6wRmBWbZsEi7IRYA9698VQ4utpffn4UrBDbjnPNLOoJC1KdWRWx213fx7f6YsWh5TpRH1vMxgS2UDpo0XyRsf13xcILzE12GuXFKAabcQ9bZ23pffe98Xx4jhkN9Nla3XV+tpBK7HND5H3xoOc9oeSYKQgEeqCjA9ArZZ0Nhv8QLNgr71/DF8OHIlgLQlD1AnphdbHjf2wzqOnU65ILzrqOpQ5BJ3v/ffBTT7rLWllNJqyjRRvYV/LbDQ4NEDWFjcO6ZKEy4IVA/ZsMecdYWSXAj8h70B32G14L/aaE9RkRw2lblbfkXQ9ubsXzWGeTz4fh3N25j6I7HXQW1FbF2e5bRYpe1E37nCFzS47TQ0O3q0EVRqwB9t/wBMT0XPPYf/AKEaeqa9rQZGieZXIhy2CUoREeQsFAjIBGj98Hf0ccfPbGlyTPWYdx1uBABrXXBximI6YlobtDYB6iG1hes1uQfknBkJh54W68IrIFj8MrKyP3Efxwgt7Fuap9F0GV6Nlk6FmrriJSej1LJdaJKx7Gjsa5+cRzPN8qy20zXi2wRpbWuh8fyvGLfzOHlzEfyDj5kEfidQAIC7PBG9cc48Y/th8S5lJz4IbkKXEDevpq2pR2INY9/zUwczrA891fQe94M6jZfoZrNPDkn+8Q81Yfhkaii/zu/uWO1DGLzdcyPmKpJ6fTWs04hwELPc0OBj8+eDpU2POflNS+mw2NbzAcrX2FDucemZR4niZz1HIq3JAQEIIWgtkLoX345xe7CDDtz7KOriTXIBW2KqaD2t7rBwKpAABKN9zdituPf3wpEV2fnrcvMluS2nZIU8gkrLlnjWTfFbk4IbeVHnuyVX0zrWgbrra63+tYFzAOltqQ4yWUujUnWa7XRxNXBqNOU6hCGgEOjRfZ7PhftaX+yI0jKoLiwhTYe1LLZIOj2WAQOefthe/PWVhoNCihDJ6eyFgbi/f33wY5nJmeEz4fGWxA+ZXmBOQ2Q/f+Qr9sAZU0zT0WQKeWWwXOUNos7n/UYTSaKUHU/W3l5911Q0lwI0Tdh4Rn2zSm9BR1NABPt+Q0F7HjFTiW3Sqml9QKRodWa6YAritzxv8Yvjweq4Ql9vog6Pz2VkmhV88dsWy4UmKFPFlxTQOg0srOv233vYmsOFcAk6JDqRBtdI8wUyyhyQdwuw5vYFm7F2R74VwIreboLbecMQVC1XJWsNlfeiLo1/LnDrMWUOtradkIBCDaDf5Pb72cJ3IsPL5sd6HHXpYCKQUbAiivYco27/AHwsteT2IiPf6eqngNsZlA/tSTnWZuzMzmGUpDYZK/3/AEI0IH2AH6YOYyZXk4+ZGcwGy+W0NldLWBW9Vxv/AN8MPEOZL8T+KH81YyeDHdkgNiLGZ0Nk1QNf597+uKWG5/XKpS0PGOsRnHA4hzY2KQRyNsKotqmkHVBlO4EHy/afULG1A1uiFhOhua9oWytLh0Aig20SsWQf3NvbftgzL8rkLzQRXusw4N7Wyu+PYCz/ANcMPJw20BEVt4thwuPOON6Ci9gLuj2N+5rtjQeBs6cyLPU5rk7SG3EILf4y+rQIok382dvpjXCoacjUo2DI6wSeFC6bhSuOEO2EkOj12DwN9sXZxOkveIFuqZLBCEKQUCkIH7iEXvti7MDbruZOIeej9alugbuE/XhZ9t8DzW5El1DTTReIQVlsArWgC71irBwAYc0Tca6emmirNekad/JKp9ypKkh5G6yKB3Qfc1i6RAyZrw49mD+ZSG80DjbbMYMjQtsDdZPvgjIyzBzBxS0obaWFuOL6eu6HNdjjPf2gOMuZe6vLHlhsthR17FF7EA/v0e/fDhTe4Bsxfb6XGhQ4eo1z5ibeix3i/wASNSIzkGO0sLDg9QoWBd/TCfMS08xDXBgSY7zTVyXHJHUU4R+920iu2KDCcYbdlN+pbVdYlaBWvYUm7Pf6YJgttqbHWQoqodMJTYUe4xfSwwYS4b6mF0aQNbsTEaDp4rYRvGcZvIAqUC5LG2lOw298Y/xXnqJsfSGyh51RWuiCjRQKB7++PpgdjtuITHbejPrT+CpVkncDcbjcn64zsh5oIDbjIDiFkuELoncbD2rfHiGU2ZCLgc2S8fi6rGlgtOqAcKn+o6tdu8nWrn6e+IM31BotRO1YgjStzSAbOwwZJfhlLQix1oUGglzWrUFL7ke2JaLm5pXzRk3JVraltqIQQAbTwL+4wyywJdkoRqR1uEEkbH5/3zhYG3VafQVUBR+MMcrhJCJCnUPuOO7NHSTrN+/xjrVMU5gaYsJ7oV2DpPLoG6ZvtKEl9txgx3UEp0a9Vdqv7YEW49DcLzaUuLUggahdWKv64NiQZslh1yCyp4tNrdcbCCooQirKvjfn64TtOPPag4sahYA7V9cSVMV85rqYEld2o1tMNBkHqmb86OtpL7KHYxBCVgvazr0UsgUKs2a7XXbDFDKG570jpwtS9CmURxbCxsP+/wAg4yjMmPHzFtNK6RokLGqj/XGn8NMofcC2oy7dbPQ1uIQ2op/xL+3AG91zjjuzHQ8H07kOGrNqQ12ybuOPs5Q68wywtTj3TsyKXVWfw/axz70MAZOwouOKlOuWVopAIA53JJ4FX98M80bZjPJhOJR1UBALjixaO+5Gxu+e2JEZWuBPeMHrS1lDbLmsh1vRZJDY2II2JPHbCPmgAA3kaqjEuJGYJZnnRD5aaSUJbQEIA/E6iwdyfYEduO2M/Oy91hl6ao6W1khDqFiiTvVDjbthh+0HHnJLDZQ0kU6hYR67RuAD2v277YufRm7Cmc06LFZl1WW3JDbZQs1ocNHYcil0N+N8BQ7TDlFxz79Fx60B3VZoGSwwGUuFDEhAQ+G7AIBsavcjn9MG5vFzHIp68rkFpTrI9baVocbSXG+2klF6SNx/MYgGi7NSY5ShTqwAFrGx99Z4+p4wRMnoi5S3k6YsJbLcoyPMJZAfJ01o6l7oHNe5ODcXDxSabIPclIQ6lSW2vWCfwwhJuz7d8T6jzACXV2QgoAKBsDhrBzyZlcvL8wy152LmUSnGZIetbagfRXtQ/dPvgfza/MyZspT3nX0WguMoWhwLsKWdfeuCBz7YW8OabbKlvtzZD5pFZekMiDAdGqM0paer1STp9a/i6Jo8YpD8qKlSockxvMMlpaWHz62zVoVXY9wcO80j5CqK49l0p9epHWbilFlg6tJQpwgazVG0jv8AGFz0JpiChxMuK6+4pSFMhJKmaIqz+XcexPfCmuyhvOeqx1BriY0/BQUXpNzCotKU0gErTqBJob/UXiqWhZS22hhpKQApISpKlKCveueOO2GTs/MYjD+WtzVpiqeLjjbZGhTmkoNEdqNbGqwCqKWNDDpSkupDqPVdgjbji/4d8PFQuvbn0SHsIEFVQXCVFlQ1NLSGzq30DWDt7H/U4fT8mjQ8wjy1R1PRHXgsxkvaAtF2Uhw3VgEa98LVmattrLXg463FU4ENIo6Cfz8c8Cz8Yq162fLFkPuWCFqWdkgboAuvm8UgtLYlIaMo7TZlaj+zWDkOYZ7mU7NM5YyCNEhSJMLqoLgefA/DYvudx+mM1mMxeZSmXJKm2y4UpCySQ0kbb96H9MRbYUxNZjTWui3qCi2pZAX87XV8WMHT8slNwhmDsNuPFmPL6Ki+HF+hdFFXe3vW+JQ2SXF1jpzvWPcS2ALhQjwYJzFOVOuMON/tHoqzZtxYQpvj03tR/NuL33rEf/C+Y/8Ak/8A+0x/+fhay2XWX0IZU6tB1kg8IGx9P35+Mc6qP/JZ/wDkjFFJ9Noh4Ux1sUwUicFPQI6ZIUfQ8004Vh0jck1z2NcYJzhzMy/1JEx9boQ3GWdYOwQAGwRyANq+N8BwJaI7chDkcPuvhsIcWiy2kbkp352Av2vE1iTIjOLYaJZKda0psJBBIB9trIFbDBgGLIsuyrzFxyVJ1vshUh9RWpxQ3XZoEgbCq4Ax8zGelTS1LdQyp1QQXniSlJsbkjsNrO9DBy2G4uTF15pSFzFFcZ1qXf4aSQULb55GxNH7YokmOuM3L0dMlIZcAeJLiwgWs3de/t7cYynUaHQiLCWzCpzKM01KCAqOLKkOIQ4VaSg0Sr68ivjFwkMofYjZYyA4tBaeWFFSXyV2KSeKFD6i8GMuZS2015XL1pkvxOm55lzZp27LrdVQIoAG+/uMBx40qU4hbcJdLvoIbQSF7iwPavjfDg8E5tJQtY7Loi86VDjSHY0BmWU6kKU5IQG3dej1o0JNBGuyi96rBaHSuC09LYS6wlCywlLlLJsbXvQ2NXXesWx4DbcRjrIblKdRq6SNiCTaCtd78nbnYDBDGXdQqiuOMR2JK0MqlSQf7tvY/J78cHY4KA1pEnTz9l5oJOmiJyHLBMQWmMyilxxwMsojMuPPrRo1uuaEb0hHN+xrg4Whpp1lx5majWh8NttGwtwG6WBXBAH0sc4JMhuJlrbBjMwcygKWlMlp8gyUE6CAEbdQErOuxYFfUQsuOyUyGVsW6gLBbcQNiDdgcGgbH+uJJIaA8+XOXVYYT2m85p5KS3swlOKhxZCw5IBZLbRAW5rIHT25BIG2D4MuXlWtbLshgPxVtPlCy2X2l0ForvYHHfDbw3mvhKB4SzqJm3h/9pZxNDbeWzULCERACNyj3sffAktK3suLrS1oeQspzDWgdNsrc9FUTd1yBtxxjwe14Mge0JlAHMWutznmhcsTGnFiPNzJyDHQsIckOW4hCCdwANztuR8bYPRn62oj+VRwiQwtxhxt0t04C2KNLG6ARyB7DnHysuaOWPurnt2uX+BFbXRWgg63SOwHA/TjEsnyDMsxkSEQYjklMSMZUkN16GgfWvnfnFjqRkbLTVYTmmQPT7IfLG40WR5uVFRmIbJBbdB6RobaxzQ9rHGDsiaLLgW42j8Nk04ga1oPZdXyK2var2wHHZQ3JkNSmluJKD00AigTxuP5YcBpBaYe8+X5cxlanmumUFs66FnhdgA/f3wTcO5rgcsfpNZifnAgmQVGOFriFDj6NLTJWy2SaXe7mj298E+EIGa5hnkKJFjGVKQtzownEBeshBJ/DJ3rn+uA3+q5G8s22+s2FoRo+as+++w+uJmTmUbU1GQ5BQ4hyMXEAhbnBI9xwLqv54e5st7BEgc3nVR1czRESDzw0WentuRZjK5IQthanCGA5+I2smrWBuNyCL5xpIeVSHEqaclRYjDhQ2848ugg1rAAFkncnbFvh7wPM8Q5FmEuMx5hMMB555k+uNzvXcnbbfYbVijLXGW8ufyxPlX3ZCG0LeW3+K0ELJJR7WLsfTCnPbUPy8wka91reHmpaVOrTBfl3tcaItyA047B6UZBeKAytDZJLjl0Ndk2dxxQxXn+UyYGaqhuNvsuxiEuNOoF6+/2/XGu8PeHc1zSIp2PlKJCY7LRccjt0uh6BQG1r7/QnnFue+FJbOVftYRHuk1ueq+AUC6Iq7PI49j7Y5/z2U3hrnDXznmy6bmio3KGmee6xHj0wJ+ax58Tw61lbAabb8syVdOQUbFyzxdbkf8AXGGnRHni7IXDSEqQsDpEgNdxQ3NDjfbHo8h2SYcmGJhLbloeG9lAXYH60ffGVzeFIXIdKVuBS+EAGiaG36Dv2HfHbp1JfJXHdhXUW5QLLKZg2mXIWYyG0WkBTLLelAAAF7nfeycSlsmK+GnJKJb4bCyW1dVBFA7H3HfbtWHgg5dKjMpaWWM2Mkg2gNMdKrBLl7LvaqA+bxXLirS01BQ0w286+hRW2grWvWNkCibAv6m8FmExF+XQim4gE6KQjIk5ZHebbRofQ42xH1h1bQCxZJoUL4J339sMI/hbP/2NMzyLlr7uV5c+WHng4gobdIuq+139ML7edbaaNIS0VtIIbWECjvQ/ifnnFsnMJLmUeWW+sMLQgdIOegrRe5H0O3GJqpBaIHTz689lXSpwYBVUKdlbuZyHswjoaYkNugM9ErbZJRSFpAI/fv3r54wuYf6bLoaWCsdNRCDo9YJo1fI7EYYS4khlox+ihalrQ62jZZWgoNLb2sirJP0x8/EYbyeIXJ6VvrWSyygCgg/vrPNmgAg/X6iQ5rYj115yU5tFj4I8EwdayeJ4YOUSoAfz92W1JbnpnBxgMlsHplsd9xfcGxgDK5z0LOU5kmMwingtDfRHTvfavYWdsShf3ac8tWXCU02gsesdKgRQWRRIN/6YnLUzbq2ULQ07ZjNuELKN+5717gb4kosAFiSTc+KY+lltsiW0B+KQttbwQg6HC4saLNC7sADfbbnA3kVsyW5jTjaLKCy3ZK1jcX7VYo/X64KDMhqAyXGumXwXeo5RKwDVit613sf6Yk0p7Q+0dDPUorQKrbcAe30vfBGmSbWTRACZP5JmUfMVQs5jSm3eo4hyMWw103NjRAveyg1R7cXijN8oRHabLiUOOBfSQgo0OAjix3453u/fFTS5IdfluvOdNBrqrWSbO47325HtvhrD0I8PyM2eR1C0+hmI63LDb7EitYPS5W37muaojCH5mNIPOW16rW5JaSFnA0uM069F8w244UI1t2RybQb+Lxpo07Jpfg9vI15UwnMOp1UT3CdawAAG9HABJrXxQwlmOr/aCZLzixIJW8v/AIZQe4ocLu9jXb3x8VuuSWXeqx0UJ2LncfI7e2E1sPTrEfM/+SDr49P2vOzMJyb+CceH1ZfmJcirYZv1to1q0N9TavXz2PeuMO2I0eKtK29Tja29Da2TVWP3x9av74S5c3GQsIQ0FgVbQsBz5v5+N8avw/BjyURWzPYZL8kILSwQUIomwvj2G/F3i2lRD6Y+Yb9bCZ54rn162QwBZMV5UuHFiPB1t56ShDyGg3+dBJFEduOK4OAm3qfetmLIDSOn1Vg6GxuBoHfna+MMYcVDkRXVZtNHQsHYVwT/AK98WOZMkOsrdX14qwUIDKRvub+nfnFRaQYA0HPskUTmb2kGYy1xjJqOCCCAWfyAg9xtzzeLsjjSEutKbeYeeWSjQ6gAAna99gfntWCmI0F5GYpltT22dhFb6wtZCwaXt6xVe2HCpKHYDTbuh6Q4Aha3wLQL7L5+t4UWuMhwt5qvKI7P2QOWRsq/bDj03L21sFlwIaEldNkihR52PAxXLix0R3NLzwcWvkrsj79zxR+MMocZhw6W3aJoknvQo3gJ5vzMv0FsNIHFb/XFBptpt3vax5+Uht3yFVICHiJhW48WyLKzrcJA3cN4oiNr/ZxbjTAUy3l9SPfNVRWPk/Pbtg55p5UdMhlbYcWShYG9osWCO1i65wI4EROquMhD6kbgkkX/AK3/AEwx7RBDW6e8SPZZTOe5KllmVTX3R60NpYHVSVrAHIu+5+g9sNJ7KVthMUdQev8Afvg0eP8ATCeYtcchuO8iUAhC+q2skEneqIFVdVxYwbA8Jyc9kBWWPeVSttbj2p/kA/kG3v8AXET8rB8xxgHf9K6lTdUgNCG8QTIGX5WY8iWyOkAAtygV8bWLvnjHkWe5ejNn1vNqWy0bSSHLCz24xp/Gsxksfst30BgrvXufY/rQxm3Mw60DpNB5mLoCW2mjsVg3ZPP6d8dvCYXPTzannPBOLvlDKRCyIYdytKmZAQHtY3bcBFa9wSOOOPvjff2dZVDdzF1K30R1PgbxzrII7oF/xxmc8ytpxmKW0utulRC0LQAE+2jsRXc97xpP7PEwuuwyVtx30HqNu6ySs0OSN+RxxvhtRrnUyI4FM6mGCTfvXo0jKltoaLSpbitAbcbI1rccN7iuOw98K80bQ0w0XGvSEa/QaNkfTttt9ffGjWDPb63mQWQdLjjYo6++x32vAj+YTzkz+TLZQ8wwVvoJQNaDQQV6+arauN8ckgtYDNvP7/RBnaT2VkuvJbfdW66SVrC1tfuOH/nA7b/xIxbIVYUplbKAXPQhAJQNz77gew9sGvhpyQ3MeVHIIBKUDQgbmkLHtQ7YJjZWh5xDbr0dtxaFmpB0IR3QAfp78WL5wjLmEBa+rHaVMBpbrrUQEErWUhanghpB23N8fX7Y0CDJeW2J6ithttFuGgW0AegA171t8/fCKF1WnHGgAAbRdA7X/KxzjQOynihTgWw803oapDaG9YH5CtHO9Hf9cKcAAROv1+i8HOkFZmRFGrqN6G5bgCTSPxNHPP3O3bEZbLi4kud1UJeQtACDY9C7F2BW9VXe8aOYMuzJ+ZPbkxIsht5BMINkXrv/AA+1Ct98JWokl6YGmmDKcc36KEFd18DnG0Mhkt9uc3S6znwAecCzcdPVfejJ6baXEUXXFkIbIO2/Ydu/xh7lbOVMrUtmMualxCG4zLwLbutfK/wzWxGwPIIwFPjx5OpTFMqQBd2QVjYk+1/wrEpDbTK3ltPyFsAABx1GhZ23FA/phodmBEn7fvl9Utwcx2Y3TeXGKvPOnLpcRpqh0+pYaJ/JrsWeDg1vMXDlLMVuAwiI1IJ1toAcW4Ub780RvXGAcrGaKkDMo7xLrBCS4z+dG2yzt9RfxhmxFTIdMfKPMOa2WmihbADjjhN6BV3vx3IAwo02kiRMGfDmyIOqQSDCAjaJMN1guznpTbg8tGaZBRW+smt9Y2o/6YDh51mEeQXsvmSIrqG1tNuNoAK0OfnBXyv233w96UzKUM5nBRLhTSsx23EILYoAhe/FmxviECNl5kFmc4/FbLNsvIYCzfFlF3yDuDePOh5JAt6nmiUxr22J19OfdZt1KXVtvAuIUN0Wd7+nfjjCjNQmXDZhSWtBYWsa+CuzdEf7rGzkR5a4QLDg8vHHTtCBvvrBJ2JNnk4zedtx4gecU6CQSVrQdaHD3INDFInNEaKinmGliV5LmyERZEgyGW2ytZ6aU6hQ++G/hZcYxC6pCVlJNjsBW33+MI/EkpvMJ6nW1Gj74OyGK5MBaTIZaDbfUXqXRKQdwB3Pevg4fTdVNbIR2Y1X1GHhpubjp1QnimP1E9ZDyC04PQltWq6/ze3OM3HgyHpgQ2kOqVS0pSNV/FY2OYLZWgMABWk+lfBKcB5Ww61JL0ZxbbgJKHG1EFJ+uKH4cPfJFgpsX8O+bVBBklZPMYLkWQpJA2O9Kv8AlinpJHr3+duMbDxS24qUmR5BuIlf4KmkIIAKAAedwe/3wM3l6DE0BBK7oDff4rHGcB8x2XTVSH4O5zyG7IaEgvt9dDSW2kUnSF2eOd9/fD7K5U7L/KudaQyCrrMV6hseQDt+YYdxMpyBHhNLofSJ+uiyRyO2A4anIbiab1tr9LjRoam7BIvtdcjB0sZ/0MJLJIO+h2X0eG+EOoMbfxtv+OnVLJ0iYHXnIz621SQpLnTVpu+Rt2P6YSNsvLmdFAOqiT9hjT527HmZrIlQoggRFLJRHS9q6SfazucBpihH98DD7rCSlBfSD0wrmuKuuBisBrWgREqbFYY1H5gd+e6T5rEQt5b7zjintI20fmoV29v6Yc5RmbMTIV5T5OMt3r9ZuRX4oJATpJ7oqzX8cXSXGcxl9FCo0RDMa1dRwDqqA3rjcngYk1l2Xqk+ZYZWhj8MKUs6zZAtewG3Jr+eOdXIY4kDT2Qf8tNry6kr2nZjbaUklxwIps6BaKsADb+eKVmTHaDybLRBSDemiQdr967/AFwXMjxomYSG4mZDMYTTy0sykNlsvjsvQvcffFMhyZbzroYDZZ3BtrWB2Qa5Pt3rHPY3MM/X6c6+ihxDoMJfIix0OOPNvdFxtCEaD6ytfc6xtQ/kcWuvR3cmkRpqpE6W2G2oS1ySERmwSVgIOxu+Nq5xCI7Ky96PKcPTlAhTIW2CA2RssXsbs9qwVFRH16nc06qHmF28hg2hYBKGjtsTQFjajjQXUnyRp3fbwUECoJm6St5eZK1W62w30SttyQdHUI20Ai/Wfb4xzKobr2aRNeWicPNoaLBXoL+4HT24u6sDbBDjKQ0lGhxDhG+s7G+CR2rHYSX4zzbzg6jlgo1g258iu2G5tY0/CxtNxsic58NZk14kkZNmTEbJZcVDgcRKcQkI6Y2bsDdfA91kj3xlXnH3TTqitSBQ1Hiu2GeaO+ekl6ZJW+6sHWta7Kz23OKwudGhMRVxlKT1kSGw4gKSkHbaxsFkfQ0PbC2vDrCwXqjXMieH63S/1pAcd3SonQoja9r/AEvDFhtlzLW1Ah15D9Ka1G9NXsK33G5vuMW5Y7meXx3o7TshlTwcVoC29GkJWhywe9WK22+2IZyxMy2aILrRy+bDSAQOo2sGrrfcE3fA/TBaiAVjH5SZSuY+C6t5GlsqcsNps6B9cVKUGSCy8rSVFNgEbf7PGLX23XJKvUspqyRRIQPesGPsTWsjacdCTljsoqbcQhBt7QjULG4oKG3H3wlrYiUNV5m3O9QY8inLC8iYtUo2Cwlsp0DTQVqvej2xCBIhtQ5yH4BlLUzoYdU8UeWXqHrAH57AIo7b4vgwocxue9MzJmOuKhtUdoMqJlfiBGhAHGxK7Pt84p8shrNnITDynXEv6WnQj0q3oEp5H05HGHtdFt+bpBBPgvo7i5KF5el5qJGccMilD0BQSaF8/A+uB2g4VBkEvCld7BrfbvtzXfDed4cmwRmSZbrUeVl7gbXFdU426r1FBpCgCaoE8UCL9sBZcxJny+jH6ocHqQGkldDnat/rg2hpBh2npz1CU/w1QsN5caUXGzpJaohf/EHcfRXFexONR56D/wC5+Ev/ANnuf64SPQWUx3nQ9CdptQSRKpQNjev1273eFHXR/wCSn/0DHn0qTjDxMd6ym7KJWjmZDJYyZjNY6XpeWLKGnZTcZQbQ6tAV0tZ2sfa6JGAz0i2Q0+GlbMFDYsrPdfsEcD5/XDrNtcbw+9kwkTWwkplS2mpodYdfVWhWkbIIQuu5PxWFEcOIk+dzYPll1lZ6xYDgWdCgg1Yv1gC+1E71WCAqNYd/Dp38j7u7NjsjUMuTYCGkMsOOSHFrZdOhDpoC7INUAg7H3JGELaygqaSCUA6kkiiD7/pi9pqmwHKBsHcihfe7w1TCyxb8NK57xDzLYeIZ0kOk0UJtVOVsQqwDZ9t0OaHCRznCiksNyrvDvkWpUJ7MsrZXAeea67zqFq/JZUlJC7pY/N9dq7iZ1mTErPZMuFCZgsLfLjMdh9a0MCxQBPIAFXg+NlejKVS50yH5WPPMFcdp9Ad1hsnqIG/osUV8G/vgQsRcwTlmXZW2svOhSHAWR+I8o+hKTyNtAsmgT7E4qyAEEdI9+nCpxVYGQOWTrw8IYaeYkvsMvPymFMtPuHprpaw4tbiD+HsRyDYsisNPITJEF5cWE8/Ej/jOHphTbdktm1kevegD332vGajxlwQ9MlxXEeXcEZy2yOg/dgL766Q59xgprPHoLq5EgRpICQz5KUF6HkEEoWEINejY8/n998V03AzP181NUsJbzgU3Wlu5Y28hp4xYl61hA6TYK6Bv/wCPb61gJuT5WIY647DhcQtaXWwOosGtiv2Fbff3wLmErpecCWUBWoOPoCAEI34BHHttjQ+F3PDeW+Hs+jeIWH2fEaOk5lTrQI6bl2sOHiqPYHjEFWpF4v3eK6NKpG+qUPyIrrDISlbbrCwQ8SNZHNVXP39/fBseG8EKk9BZRrQ04tSD0wtYJ0L9jQJr64lJ8RSc4yzLIUlMJDWVsuNMoDCAt1ta9ZC1jdZu6PbBk0Iy/PMxZltHLXUOHotCT1Qw5YO67N0NrBv+ODpNbOYppqg6aq3IG3o0jzTSisxB1gsC6I2Rd8CyMXrkNxnVdN15xOgBzetZIOsbdgeP5YXyXXormhDDiVIQCBvRJGzm/wBb35Bxp2PErkbw5PydUCAHMzisNh05eG1x+gCStBB2cJG55J3x1qbC2nDWz7c9lBVrA1A06JO/KiRssJ1Fua4ukIAAtHcn3HbbvgbzExyK0ov6A2PwzV8GyBinLM5eynNHXsnmLbeb0LjF1lBcIurogjuePg4vyqO7IQI7mkFAWCNwCsA6GyaoEnvdb2cVBgdTglTiu75uaIEc0/C2XhLJPEXiKM7msTKlzmsujLU+dZQK3pyyexPA/wAmLfEHiSHP8D5bk7eXsRZWWPLdW6DfmluVbhvuAgfBwgyDOJ2V5c+hmSEMzEBqToBaoXsgkck8/A+Rj6YYYbK234pDtFADdFs3XfnYA33+uJGjKSAPPy5zTpVQKoaah0uEy/aD0KOmHlLUphxiM351wvkha+oshdCg3+egOeffC6Loj5q49MYQhbj2hzqIA0X+c6K35vbAcKey8XVsx48Vss8o3WCigDvvudz33+MWZnma85nic5FeXIWgKecLi3OquqLpu6s18fTEApkVDax3/uvl6J4LRTB1XpXhzxa9kuZtRYc5fl0IcbZlRytoUsVvY2ugR8msZXOZjWaR5QajvONNrDgddP4jaO4NbUVkbk/zwvhuPPNJ6cFdIQXHC1+IfYEXwivqbwE2+6y28hShIbW36FIJQsV7nv8AphTcGzPni5m3Oso6mJbrp1KbwM6Y/ChZsuQYcRDjqFshsOBdEIAJ7WRY+/bCXMM9nuZyrOpEuUZqLXa3gN0I0Be2422xW9+MuJHEYNtIFvSDYQ45zvzwCBQ+uCIwZiLEpxphDyLXGXIZ1oBQbFj9+9xvfzjo0qYaMxBC5GIrF0tbcc9ENAjBeVx+kFsOlZpxFFYJ77c+iq43vEnsmX5BuS4luWSvyra1vAOdTRwRdgD34wwccS1GbZia17oQdwAtwnlA9vbAmZOGUh6M2ypEmO5pedd3Q2SbAKT7EHf9cR4jGjDEm5PQ84B5K2lhjWAgx37c2VUhuLM8PvredIzFp9puMhug2WtCwsjuSCNzxhbmcGGUOPNLQyoBH4ZOs3XP35+9YKZyeT6ZDy0Fp94MtvPuIQAsmyT7IHvW14vajuRH8wU48jzDdx2DGI0WeVkEetsouiKO4wylXzU21CLe/osNI06hbN/ONgkUtt4tdNQDaUVv+/2/Xm/gYKyd9t+R5ecp55wt9JnpNhZCwNtj225G+HPl0GNIjGHHLi3mz1lsr1oAsEoPGg97uqGOw4kGGPLwkdN5uit2ytdgm9BHCOD77HHqxbWu0R0VTZYYKLheQcXHd7uIcMnW2XNBA5v5G/xhWxkr0qel2K31GyjphCzsg1tv2xoMuyxlS0uvLQhvQSHF3Q9ve7qvbGi8ISYmVeK2J+ZsoWx1i6/FW3oa4JCKGwN7cUMTEFsODdObrScwMrKzMnkSgXYvUiurQWnAV61rAAAbAr67nttzzVDy+U2xIjyFOesDWKK0LrhZ9iOxx6F/aJ4tyTPPEbuaZLlHlUaBrBQCjXRs1VVWM6h1MuE48uasFdDogetwiqB3uq71tVYfSkgPiCUt3aADlk0ZU669IfaQhCUM0ELO6ASBt7k9/wDpi2Fkkh+Q888wstx42vq9ZDZaQBe1/n2G1c42GZ5bEjoe8pMLyQhshQQfxLAJ+gB9+aGE+eDLHIDXlXHuoaSttwAoQANzY+b54GBczMTmP1H2/h8EbHOiAFig+JLjqPLLcdWii4VkAnmzzr+ffDX9mwHYCEsqkWhZW408EI/DAFb3uSde1dhzgzybLZUjU4yyV6219MFYr2rj9cTyB3yTjsxKWFPIQW0dRkLBJBFlCwRwTv8ATEooOILXH9hUPeG9poRGVq/CbjhQDzT4SAutAb9yfe/tj0BrNZT+Ux/DURTTjIlB82wjqF2qX6h2v6bb4yGSRPxGilrqAAHcVRo7Ejf3xuvC2QJTNTP0LGtAQv7Hn9LxXVwfzHNa5uaCDrpYx6Lk1HRJBixREPJ1GMAlYGtRHUItCCT8cj4GNQxk8eNG6rKVoSXqDl0L/wA5/neGGX5XGbohIIs7Hsjsa/TE80UhpstIcQTYF1Q+g98dVrBvbbg039Oq55qEmGjvWan5cTHDRHUSgrJRZH0P1wDmkSK2+XsvWtxha6SJApfFnj2Pf6Y0zqpcmQpn0LdWAdjZJr24oDFLmXxY0h1KOjmjLkYhBNt9NZPP1H9cT4hhBD2gk9Bve/1nw6qqkXTl3SEaxHS88jXK2LJXsAKq6/TAdIkoTSkF9u+oBQI4PN2cNMzh6+qhbnTUjhC0m/peFrbTLLgSkHqOLqyKrtv74a4NDg8bx52Rta/LlP8AEUEp0dWMle2soQNyj/Yx3MIq4jj+XOxx5xtHUeGg2KI5PtuL+ax8tKEhK+iEbA6ED85r853xeHn61LcRa1hdUCF7UN/ah3wQZWeWkwBuN/Xu5CDNl0CXfsyeiBHXLaMePJK1sOFuh2BXfNYzfijNHY0YRozxLjoXTiHL1o4J2PwecOPG8+XNy4xG3nGWGrADSj0x717e/wB8YeflLsjLmZJWXytXrcAolZ3usXUMIyQ+pET054q+jXc1nZ17tksfj+by8dd4GKxrCEOL12vmvfe79sS6qHcuU68hvpj0LpnQjqBFAgj4N/NYcjLpLXTYdQhDKIxtZHYgn9wHv/TjCjySf2VFDOjrNkhwoOsP3x3ofbFQe1rjl4JN0Zl4FktzSO35RlYtZLJcRocB23FEdu/OMktcuIiOtottqcVaCoUR8k8Vv/DtjayMvX+0FsGO50iSlbpZpaNjvoG9D2+MB+JMi8hGaOZsToRdZR0W3hfVvZZQa2HB+l4P59N9uflC6m9ghaf+ybOnnG5ETNZKFuHdt4uAgi62rnGzZ1mZHMdLD/XJZT1dmxr9F2eAPfHlHgt0QIa3nWVreQoDfYbDe+91XHtjU5R4xgSy5GdkIbkNuBLaAsdLQd9jxziHF4fNM78nwUbqDjJp7a85otXLyWYy4fPxXGW1o6iSWNaC2CUBwgbFHa8U5jrUvTHjvMdC0SQXFr/EO3J24AHyBjknM5gW41LmSjrZ0oC39gL1gEd0XvXfBTSustOkU+6s9QINAkn24/744jmODiTr9UTZOuivyPK/NNnpRnGdbdHYmqP5ye+30xcxCXJkNoWs9EUHHNFrbAPt7C8P8rzRnIcnkKZdQ3KcR0i3V0g3Y34XYo/XGNmZ205MU9LFMOrtxxpet1CAfyAH4/l9cJD3E3HTnPNPyNkAG5QOfzsqZkvNretqOsONrWANYuwavY/GBnM/8nl7syItxlZIKHm1eugDdHlB77dseX/2l53eY/8As7MmVMFJJLaiSD3QTWMrK8RTmoCMvgZm/wCVKfyFsJ0XsUk8ngYuOHptaH//ALR58+6VXcG9h2y9Ak/2pBiNMyhxkuxQ8XWAlQ/xKrWTV8Cquu+Fyf7Qm/NxXXYvmwHLfR5giwT6gDxrPvjy1Ip/W+hSk3Zo1f3wxiuuy5QCQgOOEhZAACr9xx+mCw2Sq/I5sc9lM6o51mhfoPI/EeU5ytn9nwF5ayt5w31Oq6Af+GSDvQ2uhzjVIK3WInTeWy6xr09MkmrvbsKx4F4Vj5lk3iXKH5sJUVARrbBZ09ZB2sn94b8njH6GyhyHbCPM6NfNt3o9z8/1wGJw4pDLsVa2mXCQ1PW/23nGVs5HKkMBqE246ht2kAD85one/wDrjPyI8WHICURihLtLLW4Wge2s7nbfDCaZyW0q0LQw5+Q1QX7kHFviXN4+Z9JctPUMZhtllwABfoHfjbn5wim3LZoQmgQQW7pZNa1RF+VcWjqVrDewO/tjyr+2mZ+zmWYSSWX1WHGgCCirG5Pv7Y9GzfxCyzENIRTSNe+w+v17bY8S8Xzf27mjpUC2pfqb7pHsPjb/AK4GmKvzBkHPyu7S+HA0jVeYtbxSPLoMlyDIfU0CykALWAPTq4H6jB8JCG00Ug6qBUB+Qe+GcTLXA22ltCSEshavSAAPcf7vDBnLFU6Aw55VFOrKQErUg8f9Mdam4AnKQQN+brtYfAfKY3YlZqStCnnEJ1lq+O9Di8M8onN5e669GihxSAA068i9HuQngnkUcXsRoqW3HXFnVvoRoBsEf73wM2thpSW0Mh0D1HY7jB1HgtI5z7p9PBEOzONksSzJfmvKdQtfUqnFLHPub+uCktPRG+ih8pWje211qo8g4ty6M5PmlLZ6KQkqUpf5E1vucWx4yzJUl3S7o5PI3+mOTVbDYgx385CqwtFhcWtu4/dQbivpabJWV6dtjYq7OCHHI3lApTSi4dwrtWC3EvMRFPMh0ICukpwgaVHmr+g4x3J05o5msmXCeRCchRnHVh58NnQBS0AkbrIJ25xC0VKLS551K69d9Kg2KYuB9EmzWU+7lbTOtwttLUrSAPSTzVb9u+Ko+Yxm/DE5uS08iT1wI/SH4ar3VrvYUBtp3332wnmLWVrpJbR+Yi7IH+uFrjT0kFDLbrzyl+jTve3t78YoqVCwXvHJ/q+F+IYouOZgIPO7lwjz1nYTkl2Q1oDgSKUNVm+3PA/ljb/2Z+LY3h19D+bZJAzVgMus+Xkoqtdes/I3r648wbckNKbWlS0LCfSQK07+/fDxhaXQFtuOPurFuKPJVe+IaxD4JMn6f1SUaxrtc0i0ddVpjP65uLl8QthstrQbK9t+oR9x8bYXzX+o2w2ppoKaQQtYtBXvYK99z2FYoiyOi2683GiroLapy1VfDgHuOx9+2PlhfUity3G0BxAeBJ3AJ7n5A/jgGNOaUWKAyfRckBwN6xHR0UNjS6Nib33vc81fGLIanUONpb3bdNEtuAV/pv3O2Apg6c91HReLaDTLUhdrCOwJ+hFViTC1BDikB5lpDfrCAd9xsf8A8eufjDA1upNu9c5hLTMXRCW1Ord1yA3obK7Kt1kA0K+eMSDsBjLpLMhSVyigNsPpcWKGu17d9tt9vjAr095xbq3FjquEE0P97YrkPNKQ8khfUtA1nbYciq5u8JPbZlIhMBgyEvlBJWpUZOtCAD66B7D33NnDDLChUNzKlNzvOPrDa22llJdAIprRXqVr33qvk4Adapa1MhYbQa1OVe/9ecW+ckqkIkuuIW+0rql5xZ6jgB2s3Z/n84Km3IRF0FVzqg7SAWypSwhplaHNkLTz6+Pt9MNH5AeU69IQEulPSppHI7ka9ybHN7XiiZmHVB0r0JLhX0kJptFknbvscFy8neQMvRHMlzMZF64KGFh9PcECt0LQQQfrt3Ouc1pidbIABE9EqWh5vWuIl5DaEAOX8+/tdYJZTDjwYmYMux5D6ZStcF2OooCEAEFSiaUD6hXI0/OBmB1ZLzaFuKaWlRWU86ObV7gbE/THYklryzrUvW500Ex9P7i9YPHsQMGCRfbn3SXASgUFQSVbIBJo3W+H2SxcyzRyV5eQl5uEycwkhTqGSG2yL0EnnfYDf4wG81DlZdH8nGWJybQ+hIpvSlOy7JNk0b4qthvtq/7HfDmVeKfGMLw/mstESLLpS5TbwBoWdBB2v+IwiviBQovqPMQCevsEVGmargwbrL+Ks2Ob51Mktrn9ORKceSiTKMlfqO1rUAVq9yecD5POzGJMSqI88h1K0rJTfYGga7Vd49d/+0T/AGU5X4EzDrZDmEKdCebQhLC5FyGl/wCdIH5xtX/43HfHmviXMo3iOT+0GMny/JnA3HiIjwUaWlFKKLh3vUe54N4HAY5mLptqNHZM9NtR62tbpql4nD/JflBnvv8AdKstzCXGzFMmMWhJQhaW9TaFo0kFBFHaqJ3OFXT/AP3Z/wDXhy3HjsvSWZ0V1KmULaC2F8Ojgk7iubrntgTy6f8AOr/0H/TFTx2p3SMsiCU0kZzmtJUmfSWpCpQfQApXWWAL1cjZAABO1H3wIXYfkIzOl5Lp1FZWhKRuutljcgAcHgk4qktEvu6AhBcRqVrSGkbb+kH7ViCylx0tRkBBbFlatrAG534v2w1jyLIQIMovNVM9QIVGMMJa9DaUjWk8ficGzz9xjmiS6iNDdW/1dGlCHDSC2LOxPAG/3JwUtOaTGIedT4yVwmEoaaW6yEtvpQQKA26pBI10Sd98U5tmESepTjUHy+hBS2jX+Gi1WaH32H88Mc1pBfPh9CtDpIQbbim3h5UqQgrOyjsSRVfzH3w9ay7LWsvmHM1SmJiWg3Fa0ADWNj673riu93sBhMmYnqqW25oS6jQoLbHrJHrNmwPrzjQSPEeYT8vyDJn0xVsZP1Oi/HbS24dZC1hRrcgWBrxjTkIcwTEj2170p2Z1jzuQJaix0x5TcoOrKlynES9BbKULpFgElZNEFBr9N8LUTlrW+6pSklZJDYFNhCvz/QcUBg28jcXOP97ip6WqMOihxQdCzSeRSNHJ3NjjfAkZ8pbacTJQ5ItWhPSBSi+5vbc/HscCXkWC8WgwQurcZcafcdaeV1KcZe0pCloCgCCeAPkdxXvjY5rmXjOS5G/tAk5dHjshwQG8xEFAaWQ2RVVoWdF8Dcg98ZHM8ozGG1Eky0pKZJJYtRKFjmweKO/fkHB8SIt3wsuU41MWy495VAbctsOD18GgCQdgLJpfHODYwOIedRuge6BGx1Q8aehqCsdBsRy6NZQlGsqpYRubI2vbj74Yx0IRAYQ0w22vphw7Ba6B5IHF335FYVgjS6422pyOVoiqU0UJW4DZA0c3abse1XjQ+E22YjchUyHPbky2HGYzyFlpGvve3rRWxF998FTbmPX6880YrZJThLM16O/EjTwS+gBhtqWFDp3uhy911o2QTttWFeattRX5CUddbdl4Orb6fVHKDoPF74MXFypBlaSjMmjFbdD0E9LyZK6txtfK+QR2JBvAWZzUaCEzJS3VrpZ0BtstFsAcb6+RvtX1OKKVaB/5jnN0bmhxyv1Qi3kTgOtLWtxpvf8AfFfuIB7Acb/0wc2isrSH8xDwcAQWmtwiuNfz7c8/FYVDp6RKYZWtkp0rUo7LWDuCRuAeO2LvPf3eUsQ46A+4iukiw0jc0LNjc8n2G+K2V3FunPJKNJgOq30SL4WdyTOicyzOK5GjRxAieUBXJojqlW50URuRzzsNsIm5bK2n05qiRIc8shlgba7A/CJJukGxt3AoVWKgZTKLblhh2QsNOCYtFuLvcG/WhBDg5oH13dYoYzqS3lcjJZLwbyx+SXXkMxmyUH2R3CPajgRIh/PRTvEPImb7odppfVdW8ERerakkIpGxo6OwH02xdk8pMR1UNM5xDZutBJDq/kfYfoMEsS35vkomaPT38shocby0E2hgLJOsUCAi91oG53ArA0dl9E+RLElhubEUgtsqY6gcoVYQRVDa79/fE9cuzBdDCEmmQ5O3JCS2481IZcUhwNUhZHUO5sIr8h37ADbA8cvRJBmNqCNDxBQtsLKForZaD23AwLkCU/tVTryywRZJbR1iDRrQi/oOfnDBh6AuHMbmRhIzGW4043K8wT0wLLgKP31r7k8VhlNjCC132SsU+oAHMvcaJW47RTIlL0tN/iltaPQXKoA0RQJqyP6YeCN/7EiSGluOTUOFp9oOIIW2uigtoHrH79n3IHfFD+lkGa1ELcToONo6nJF6CvbYrAI24xrss8U5Dl39nmb5PJymJMzSXIQ3FdX6JLQRR20DYDnt3G9YTXq/IyuaJBIG3XkqdlM1ZEwdfFZfL5JZkR1xXH48qM4gxHEAawsGwT7Hjjvix1KHdSyEBxFhZ7WefreBYDbzhcdgMocVHR11luytCLvWsj22F9r+cNWm1t3LdaTIS4AslAIQP+T/ALYJ9MNfmjXTnO5XYR5eInRB/smRH6zD7JbdGiw4j/D/AF45H8MXiAXI7zzaW3OggOOG6OiwiqPJ44v+GH7rLzjTrzTzK23UIbQ3DOvQtYvpkH12KI7i8IpsZlyGht9F7F1tbYv4FHvZvAizhmsumxlPLmabomR5ZqGxEjK0MoZabcb6Z1uLN63P41V0avEc3BkIeQ5GuQt9DbLwAZIaFjdtG1na74+bxKW85BkqhlpuOWBoW2D1aWBvZ/3X2xFt5LrnV8ygvLXZQhHTqt7vjfABpbrzn3Xi1lQiDyyLjx58IiLJZLAYC0LDho782P1xdPU666+JD63H0GnFrsr/AN1XOK8weW9GiNKW2htz8Zxbo/Ec1m7K/wA6xV732rAuVpbedkMuZiy03S3GdH+GNrArc2bArG0w3R/OWThSIgjSLr6Q60GkoZaC3wSnQ0FoDpO4O+17kVWGmUJecaaR5Zhvpo0aEN7rC99z3J98UupS+Ylob6zrIcH4ehCCCbbFE6/vRvbDvIpIyqYw4Y0V9txvShDwNEdjtuD/AK401DmtYJb6QAJTCXkzTUjptyiP7sh1tbiOkSdF1tfyPnGXmKYgTVSm4zcpskt08A42daO2ja9zX2ONY455lp1ZbKDQ29hW32rCUQ/ISGY7sZcdBBKgAANBBKFoR9a+uArE1Zi4I7+eKnoUhHb2WcWzIVC6iACQ5o/KHHQa3A74vyNaY8tiWsiQps8rogHmiOCNzeDl5PmEpCmMsacXKcWCC1YWD7iuDWHeXeHM0yVoiSYkR5t4IWtwjqAEUfRz06O+3bDaGWmSahg7xqeeqVWN4BnulGeG4vmo7S5GXslIX6HEIp0gDdF+329sbLKgtLLcbUOk2sqQhYBNkAc/bGf8NIQ3HCW2l6iv/EQTVe1duxxsMsfXIzotx4aIsdplBQ8BaHSPz7bm+CfrigCjSh7hAJkW0N/S0qKsx14vbqjYnRZiBlpk9VYPUWvcbnke2A5gIa/Ga2X+T9efp/1wxEbS0VrKA3uQb5wtzDrPtBOs9P8Awx66KPp7DfF7WsaOw3efMLlU2ueczjbRUtMtFs2lxbhAQ3Z7Uf4jasWtNhuG4hpOshHK6H0B/wBcfNhLICE8kVZ3/wB7YGfSpxCBoFIFIIQfX8/XBmmZ1g8+ya3EgWa23VU9JDzKkNqo6DVV6O/9cLZ+Xx5C0rW7YYIcHuCO+2Jy2Vx5Dz0FgB9xADinPyGuBsf5YcdNn0qKg26UIV0y3oK7uzxRHziX5TXnK9sD2N7d3Seh66qk4w0oLDM8P6WaRKfGZmAYy1t9HqeYO6Cf/LNbg4OjQEKHU6blLQTsKJ/7Yfu5c06+4tIb6VEaFgrQDR325I7YjDivNH8JHXcA08bHG4XNRzBxmL7COg8vxe1yNX5uUtEc1WRz9XnYCoURDPUaAC9AAofPuaxm42VreWmKhVMhY1tr4BH/AHx6PmEBluH0egW1oJC1g8jsK4++E2TsIcc66gA6xbbZ3taCKINcg1i+jVqFnZbcW8tjv4956Talz6LWf650/P33Uy8mQ9G6bbbEcoRRWhd612aWfqPb23why7IJ5IZTERKmIQtxwJAQABya7bfyxsHJMllxUTyiFqcRsCjgHmvna77VgWWl1Mcw1oYUA5rvfqOXtRWe3fAfKFNvZB/AO8eP61KezFAb6/b3WZdGTocbcltrWlwC22zRHN/qdBqq+cC+JJea58Goq5jfZltsgLc6ZB3BA24INfGNTl+SOt5upvNHmUNC2tQjdU7A0Nvn9/vtjuYZCyVy5AlPRy6QrSEHQ6b3sjiuaxCBNTs90EgmPyri9hBnfm/7Xkuex8y8NMvuxQ4lps7SUEWDSLH0uvn64wqf2p4gzRScqZAkLBX021UAOTRO/Nn749I8bZHGkTJDz8hWsoWlKdG5XtWvfj5+MeeZ4y5CSoxn+gLWjy6tloRXJVtd78Y+j+WPlF7jc7xz8ey41UQ+G6hBxvGudxQWXFhwoquoNxW1XjUZJ/aLmUhb5nBJQFXu5RbHcfOPN25D0ddsK0HQUrUDYIOJOKLksNR22G9tPoPpPzZx8zmmre40WMqkCDov0dlfixqbGS83SHGNggL1/U7+99uMJ83eMrL1JgLRbpRZQNawAT/E98eb+Fc/8jAdy56USUva2SncJJ2cN80QAKHOGc7x0IcIogwmmiSRaSo1+u39cBWpEuMCyso02NAqHRZzxS4tx8pU8gpCK/JSwAdgfc1jPsOaI621MoUXKoqFlI+D2wTmMx6fIkTJinFOH8QbDue+KEtFxFt2E3Vf774a6u6pUBBsApa0Pcco8EMpSwNOokDYA8c4eqXCazFK8rDjjSQ2tR6dUQPX9sCeTevovIWALodwffBs7L2TNqA26zGCEfnOuzW527XhlBopVCZ/SJmHqghwaV6L4TgDNIb04Z2plwxHERo2suEoui3QvQDufbGz8Juz2nEsPFxam2wAdFhB4AJ7b7WceaeBpLkFCGmmULSt+g8Niv6E8D4Pxj1bI5GXSUBLqgHGiBS1/nvkj3wOJqwIPkvocNhi1mcDxWqzTx5Nd8OeQdka3FNlr1Noqr/UY888U56tAad1ocdFLQHATZvhfbjD/NXmZ8yU9luXuQIQIAaXvZH7/wB8ZDxqnrZv1ekHkdFsLKGyDrA7/J9++Odgm4eoQ+no7l+bLt0sD2CHtiNunogHHF5wZiG5optu0JcHTLlVrCBvvzyeBj7IvDMjMJHTjQ1u0guEp3tAFkjDDw/Fy52Y4jMIz1ED8Rki29+a4O3bGuhNo1ug0txpAbSUOUB78bY6NZ/yRDFTTBfZ+ix2YZO644HlpQ2w2UaiPTrNXVfTA0yCHXeg2t7p2D09evf3B+mH3iRt3qNImhDcgoPR6Q2PtfxWIZZBd6qXXdC0jcn9w4HD1s9L5g362XVexgeG6x0SmRkHRgKeYpTwsBGivvhFCy0vTHGlqUVcbkXft/0xupjaPLS31l62q6G1ov5OK84yyGx4biCDMQ9Mlqtxpsets4nxGMo0XwTfnl562VFGia+WR3DvMLEygI63UwPMtBxAQ6Fiik/vDbteLokZTDS3dCiEfmq6F7b/AFwYzlTutQl9ZCEepVc9/wCPziDswBpYRaUrbAoc7d/nCqlQlwDirKNFlIF8JJMQhuUW0G01aDexrnnAzaQV24v0roFRN6T7nF6IqpstCS0h5zV6EqOxv7jExIkMRZeTIKBHeeQXEdNGtTiLAo7/AOY8HfE5cS4Ajw5oYXFrk5jFkMYEZD8wzMwajhlgvselSkyiFUgJobXRNn2w68UZ94Z/8Pw5vheE54fzdL5S+3GUu+l0xv1Ce5BNAd8Zso6aJrRhxlhxHqU7+dvSbtJPfseecLJCkONobc/Mg2DfvzjnnF1G1zSNwesdO76H9L5/GYNtaKhMFpOm89eaoZxtwQyWlpW0DQQSdQvckD7bnB0SQ466JBWOqsetwbAJquAPbA6m3wlTJcPSqk7ml1fHvg2BJeVlqcuLi0xG3FPUllN9QjT+fmqA24+MNcDZwG2vORClpU3Z8rR5KnqL9IY1odNoJQTawRRFfw++HoyrJ4MfMo+fS5UfMmmwI0eOhCwXbF618Vo329x84BTlyJTb+YMuKYgx1obLjhT1NZBo6Ab7Hi62wLMIdcDqUobVV00zoFewH+98JqUngxMfXmoSMU2RZfFUM9cyXZC3iBo9INm97J3G3tg9idmuZwMuyr9pt+XiFaIzTxCENA+s2v2J7HAkJuAWpXnA+t1bBEXpOVodsUV7bir2/jitFocb6TgLQFIK0UAPn9Tg2kwQdT15wrkuIa4W0TOV+0D4WixpSY7cJ2W46wsob19QgBwkj8TQBVA7ckYVGMjzj0SCtb7YVQcA2c7WPr/XBEeJ5iA9PQ/EbbjuNtdEuHquk3uhHJArc9rGNV/Zl4ij+C/FMTPXctamhINx1LBCvr7YkxFd4aXU2yQLDqfHv9lf8PoU3vyuMTM8+/msM8hEYuNydSHUoOkaAd/Y+3f5xWqM8rKHJS3GEMMvpaKNaOqSsE/l5Ioc8A/XGo/tDzlHirxDIz+PlzEEzJBLkdtwFBN2KRyB/M4ybsYAlFrckElISQP1Bvn4wdA1HU2ud2XGCRrHX+puJaxtQtZcc9fuh5DXQkBaFx12A4KpfI4I4sdx2wa4mdIkRX15i/LkvtgIWl4uOt6PQEHvsBt8cYlCmtxnW3UR2/Mt2C4tNhaaIWCPm/zc4vy6XGT5kR4GjMHFMKhSW5XTRE9e4I3BBsD1nYDB1ADBao2tyyXCyAclPQWHoDCglThUw862CFqb2/DsGlC6PHIG9YOy/KBmMOJaY+WKDLpL7xWBICNaypZ3rYaAQNJI3rc4pz/L2o6kFUovZl1XUTWkpQlppQV6S24CQsHc7AAbYPzGVPyHMnMvyzPouYtCIGm5kZbnT6SwVuNALra1nWCKJH6nmBEgabc28FKf9R1WZi9HUEPOLaaWu1OhOs8Har3wchTsSBHebehhRdWklpwKd23sjsN9iKv7YYZUwrMcqzJRz7LsuLERAcYeXoVMCHEBDaAkGyLC7NXR5rCyPHhMOrXKdW4xZb6kfca99xdXxYxpy3AWUyQ6QjfMSVsynJao853pqa0vOlTiCQPxEUdyB/M7YHhuPxX0CCw4qW22vzYWAtC0DcjR7AAH7XtgMtMpKHJTj6nHkBYUihpGsg/wHxzizM/J+kZUXegrQood/Ohytx8j5xga1phg15yIROLn3OqHdfdeLjzrjqy6slxxZK+ff3P1xb5GR/7wr9F/6YvypMRjN4xz9iWYLqeqsM+jqJUDRTtv6q/QjDv9kf2e/wD6bZv/AP27/wD9GPOadip31mNNxPhP2SVD0RoQEsxfNTeqQpb6gUKbIpCSg8KG5u649sVQtBWW50BCUSG+k26VlptBAoOGgbo7n3wNJj+XSybVpkt6qVRpN7b/APY4NRJlqQh2DJmrWFdHpoQQA3esJG55qyPjviwQ4w5TwRoh5c+TJYaYmOyXVJdLiA84emgGrodroWRzQxSuFKiw2pqgOgtehDgVYKhuR9RthtnUvO82XIzzOUyJYmSPMSJPTFLcVYBKx76F7bcHFMyNEjIkpSIE5xxphxtyI8sdDUjWr0EblP5VXwePfASTYi60uva55zqrID8dvI5ckttOzVqKHFuSNBQklH5UjnVawbsVfFYEazaTHAW2taH6UEPBfqRZ3IquRtfteKtTrLbzLMYpVSesXqJBvbRsK54wdOcS/wBBaI0F1ZihZ8odm/3aUkigq6P32w3tA94Qanx/n5QzTTT7/mc3kSGmyzaekgKcI0EIIBoaLAB32HvjZyP/AAnlHgpOTGHPl5+sB519LyRHiawB6lhH4iCQgiiRSiLs4xOYeYU65JWWrl+q6SSBsQNuDx2wflKMmksT2MycfYnuKaEQtgCME6qX1F2SEgURQO43wFNpcb7jr4raoDIImx5K+zYzGtWVuvsJjRpauo3Fm9RtSzXqQLKKAoAj9cUuZg0/mim1Q24kEPFTcJbi+kij+Qm7421c74XuMBlg04C0SsDf8+k/9cMWUGBJPTl5dJCldFD4BcbSVo3WEEarGwuufnHg1zSsLAWiVXl5RJlIZgRX1ZhIdIDISFN6DZAT+9eGDUp6U41Dc6jaGSsIacP+F/5noOxJr67fTEs5yHMcmVl0nMoL2VrzKMmVFJH7lka63O5FDjfAuSzoEXP4M2XEczFnqJdeYcWB1V3akE+xNfOFghrS8X/K8aWYgJqUxkAx2l9RpC9WtDWlbhFi/XuNt6xY+WhG0sreccW9+GhYQEdMDZZINhfx7YE8TZjHf8Q5jMVlH7LRKcLzMUG/L9Q2BvvVH45GPojSfJLnCfHLy3uiiOpZCyCLCx2q9j7Y6FE52Zog2t0Upa5hgJ1PXlrryGkRGW0CIhsLbSbfXZJdeCF0VizxWwG3OF+R5Ymbnqct6sTQ48Gw4490gN6sE9vtgNimpLq3oy3rcQ3qDhvbYIBG2LHJL0Weh9IcacQ5aBpNhY5323Hfvh1Bz4IdaFr2wQRznAjsrCsyUYmV5eJU5bfS0MtrcdfXxrF3XAO298bXhgiC2rpxYSpPVcjIXJ1s+tp8A7EbkoRXNDcm8U+G4GYTs6jeRUGMyflEx2h/d0CgFghzhHN0aoD5wszHMFtKSuKZQzOO8D5gOUBrvWPmz3veuNzhjjlYXHQc8+5ZTj5gHVPIMqS2Dk8FuLHf1Fl6QJXRQ6F7EOb1Xv8AH3uuI41PGpxcWO6gLX1AhwuPmjrWV73uB7UV+14R5c8+9MbMdSltIc0sAoDhRvYRwBfvhn4eaj63ZLm/ll9XpEFBcrhsEA3ZFb+9Y1pFVoe20junqnNd8okE87lciAtosyG5EVlIOu3HKAoBe4788Dcm9u+DsxSvMn2ZMl5lhWXxemgBsdM8rALiP+ITrG++2JzokSTLl5guQ+xDa3ZakMU5JdNhYbPCyCsHcg6N+RWFuVw5C4Ut5lBcEdguPreWj/DKwgLRZ3N2Nr/nibE4cPcC8WGh21j3080xmIJpnIY62vpMJw3FeREbkrjym3JI6ra3T6HUI2XV8gEVX+mJsRWcvnOvNpRPTLZW2huQyOmw5oNkAHciwQvYX2OC5LM+A+zluYdcsRoo6DUpwANId9YIo1VrvFEd1mRaWmkFxta21hAJPagfcdwcbXoUy5mYQdufqyVQeXBwBkGxPN1xp+R1CCtEZMjQy+sEoQUWL1hHI9xWPZvF/jHwlmX9nGXeGxlhZmxzfmY7YKNaByDtYO32x5e5CaeLKGpLb6kRm+oWVkob9rvg70e2KnIq2yWVyF6o4tZ0Ao5od/fvhFbDMq1A/QhdDDNFhzomMLyyGm3EBXmrILrbw2BIsaO3fv7YImReiCy86hdBGjuhFmzXtzvgLJOl1HUypKwkkb8rRvv9a9sPozUV2QfNKjEIP+KCtaFgEn0VVgkUfYHHnVC4rqsa1iWzYmWnpx8vQ88Vsg+tka+rVrCADuOd8J3IpAQ70g4wdwsWDxuiuxw3Q55Z1ycx5eK83G6gCydyTQIrgjEMqy6VLlSJohuSMujMB5/prFx2zsFldVZI+hwT3ZSJGuyxrmssdtzCoy6JIkx2RLLiEL2Q2WytZNEIFAXvwPk4pzWFMgBwO30GB03221jW2RwPtYH64MiCUiQOkHHHiOogIXvY3+oqrwchDWYSDPzDQUNIQFo6gQt29gv3Jvc/xwDgQCRzn2VYBskjRDeYO+saWigIsiwfcHb27++GUON52M7MQhwaDbiGSfwxfPHFkfpvjrcGTnTTiYrLiI8bXJ6bQ1gGha1k713I7dsdyZ6UW1POWhzprZoLotoN2QdjuLG/Y1icVGzEyY54eywMeeyQmzeYPUXl3KcdX1HivkkHkkdvpgmRFTm5L+WazIJHUirXvZs+izZQBQF74oy4KYDxVH6jCA27rcNOED/IT7/e8XtF5zpOrQhncdEBullBB/UD3ODbVIjutznsgqUQH2stZ/ZvnrPh3P2ZMtpw3tuKDnyPpv8Axw4/tDzzKvEef+aShceoy0ILbYWSscE/Hb4xlfEOWDzrTLSJUdthto9KVRcWTyQQNxe+IRlRIsd+XNJ6bRBX6CSbNVjWuY4iq50W6qQYIVXioAZWiyaBraSKta17Acbnb740kNDiENMkqbCFmwi+QKv4NbYVQ2vwkuIoKCRoA4+Lw7ac1gr1eofiFZO//XHbdlqUxTGi41djw8uKrcQHNhsmqNDcYqcaDEc6hZG/zftg4s9RoPaygcD6HC/OpCFLoWhoHcBfJHteDFzfZRh5JhLFudJet2OtbX4la3Ks/X4sfyxS7K8y+46UIYSjdaG0aAj7YGfHXmKUC2GNGzlmyfpi2ZojONdPqIpFPL6lgg/rW3PODZUbTYJsYjf6fhE5gLrBGFtp2MVhQb9BWHCD+lfXbCuXk7+aMhlqS/HcWu+s04epY9u3b+OPonWWsdJ1ZYqtYXtzwB398O8obQyt9nzHUJX1CNQ9AIGwHYWMKrPZiaLmPHZMgm47/p0QvwtTDOFRpuL829Vbl8aQXAh131IQQPYHnDN2MluOV6aSDeoXucB2mIHOoVkcIAN7nHFyToKHVubo4BNX71/PGMADQGaCLd3OSlMqk6m5m6EzUAQnKBoo1rHOEuURlltySVLHUX6wTxt7dsXy3XnXQypok1sSTsOxH8cFLkeXjmOjqA6qJbF7Hm6+30xWJYJ5zyVNMdiOqEzCA0rprQoB4Civ234wExEtgJaaefDQK1k7mr7+w3/jh1GashtbqEOIRqQaPr34v/XH0tgNuKUXwy0jfqNpNL/3ePVKgbYI6cmyzjbT5lNylJWhsOLC9dLr6o597OC/7WWmcq8GZeGZxemLtCENN1rQRdkjcnC7xXmycr8jHZih91ZIWsA+s71Y59jX/bCHxT4nezLw5EjjL3C20s26RuQdrR9SSPjCqWHc6ox7RafC1/NXEEgknQe/0Xks+S1EkF2S84sC3CVmwf177e3fGVzZmOJAdlea6C0B1KFkBxaD3B327433iiC4601AZjuP+XIPUcCD06ravvR3329see59lyW3JrKH1/gEKQXF0FCuAP446lfGdjIN/wA871LUY4dpJ3z6XG0IR0yn0BzfSCf3T/XFMlnW+einShSjVr1EAe5xc0284kuBC1jqUhQSK1/77YdNQFryoSiVFpz8JbYCFFa0/wCUbGq3v+eIGYc1R8wiFOSEkbUGlFaumsr3vnb+mPpkhxCdBSoKcpy1H6jjjHzKUhkIcCihatVpAs8gUe3ziLzeqXq1vLccBC9WxC/9OMIrucWwwRKaHOjuQ7Dul8pVf5Sn00fjv8XhjAzDyRSpj0qQQsAixYNgkcHAS2HGdKVtKbOgar21XuOccjoWlzSn8MqSRv3xGWPZTIKbQqFrwQFoMllsO5ghzOFlbTzilKSghJcJ9vbc41+RfiyhAdgNJjSFudMKJIC/r3r+uMXlUIpfD5bU8yzpIUpB2Uca/wANKUvM0yQz+QDYbV83j5agazsSGyY3nTuX6BhGU/8AkDn6g26x3+ei1rXh5EElLjKHmlr9GgVQ+calvL4KGIq24ymwQOosp1lZN0R7bVgrL5DDyAyFMH0hVjgE1797wRHm+VW4nShehCwhC2QQb2sj3rHfDHtp5J06rGPl2aI8EvzPN0wtKmWS82tn1aCaO+/P22xlXM7jInyEvR21pcBPTQ9sF9ifet8Ns0ipe6zxQW2yaSB2+2ERypHmBpZQtfU2B3PviinRa0AmfJW0XCHfdDjMZKuqzHQQ2twEVyb22/3WGmWZtmUaG+iRGZCgOmgLXRCx3Ndu1Y+iam/MJmxD1+nbYb/cN7k12rCqNEXIk9Ydamibc17fFDBSHGHaea6jcOAJaPpy6McmZlJ/HlshywRdn+BPt7YbZMUN5Y31V28u6QNx8H+f6YI8NZNHzKS1FkTiwwtzbqbkWBvXF9ucMMz8NIgZuxAhSm5bZ3C0LAo+yzxe3vWAfVa2pAO09yla/MflmxHdsrI6hLYCwhXUFrcWRz/vfCOa3GZkS5bjK0JQ8htAL3rAvkbb7fTD9nNYcKEWnW37AGpvqDQtd9/iv44yGbzELLp08ruu1XiKpUDpjVdXDMcy7jZV5rLPRkoiONrbDh6aKJWtP+f2BAoV9T2xmXepHdQ5mGXqWw5uhXUKDsTdfH19sE5jmEJER+S1mJbkdXpJjhs+tBBs6+wHFd7wgmyrOtR9IHv2xGXfLGZ10rEYhryabTYapi0Yzb2lxiS+qmlBBbCbWTun3oi6P8MUzJimzrbL7Uho03QCNCd+/N9sK2nwXklCiELTpcKmxfN7fw32xuv7Qc/8O59kWTQ8nyJuBMYSG3lihrNAUP8A8bez74Q/EvMgTG/Oi5nzSTlDZB32C82lSZSjSHCUN+pAJ43v+eOR2etDQ4oJQW3LePVRZbJ2pJ3JG/8ADbB77MZehlxlcNTRcL7yCXAf8g09txub7/GFTqkMMDQvqakDVaa0n4/1xXSa2BIXz2JDnPJcSNVxRbS+sNakpC9TWo+qu2+CITzDQ9YW4n4FAGjsfvX8cBx2lB9DunWCbo/vVh1luXdeMZzkOUuFHUnzbrQvppK9uxCeRRO3bBPbvwJdJ7m30j3VcVwRHpIDcd5D7XStxnVQJB1ovhe2x+uGXimFDdz6UchZlRYSIwfZZnPIS4GwBweF3dgDntgXw+zEf8RQkZnPOXZe+6A/KcbJ6bZOgroDev6HAWYR0O59+z4by5yPMdCK622SuQNdIIRzZ7D5AwgVg15HqeD9pGLLHGBqPz9lR01oWE9UDqgFCLBAGDGJiUZStl1HUbT1XWUIZ2bWQEBZs1X8bo4vzzK2svkpjIWxPStlxxtpTnTcjkFYKHhtocRovRuO2+EmaSnZb7sp+OwwZB1EMNhsXXAQNkDv2wDnEtsD1XMyNL5mxCa+HZeVJzBaMwXIZiLbILkUBTocAtB37a6sCtrxS7KjuSHUuBXSWCb00Sa22+frhNHTTrihS6FgEgfr/pgvQ+43JlJW0EtJFgrSDuapAPP24G+Jm1BN/wCq1zS1oyrWf2dtZBP8QZY3ny5DWXGShuQ42LpHett9sW/2xJ8KR/GE+P4He6mUX6HKJJ4Nb9gRsRyDvjHz+rCWpryy0KdZBQHFklAPB7b89uDi92UC71XSt9pxAbUCqnAAACL3qqG9V7Y1sudmHOc1skAF+Yk+GyHcZXGzAInR/MuL0OFKViiCL7c84sSWVIU8600A00Alo22XRwAABvW5O++BgvS+2yzSV0N1UkX3o+2CX6MhDanOtsAVM1d8Dc7E7DGmodJRuDS0qqM8iIylaHGkOJJUNDduG/QRZFAVZG3fDTxPnWZys5YzCVmRlvx0NBt5IQgtthACEBA2RQHb698MJPgnMmvB0fN2ckztDpfcS48tn8NYNdMI9iAF67+MZhxlUZt14hspQfz1ZvjpkXsOf0w1rg6wM93komlr+0O+6Jzb9m+dPlSRlzhDxQggutdQE9OzWso4sUMAy4fk3mA6/FkF+IHEGO9r0EjYLPZY7jtgVv8AI4miQsivivjBMkdFttxiOPxLSoqWFabOwIoFB2J+hGPA5eyboJB7QKvZhtmQ1CWy9DdA/vHVskDnXRGwqj9vnGm/tV8G5H4Pz2JAy7xEx4iiOREOuSYlANuHlNb/AB9sZPU+IDzzra/LOOdMvb11QLo777YOjoYyx8v5rlaZqSw62GfMb69A0Oeg7IBUCDwePfAfJeajXF0DcR79fRa6q3La6VyupLLQVMU8W0dJtKiToQCaA9kb3254xV1HP/ef/wAsYIYcW2lUlCCkflcpegODuB88bDjA3mYftJ/9YwT3CdFjWs3KvyJjK3Y04z5D0aQ3H1xC2CvqOg3pKQOCBzYrnfAbMmQlQLRA2PHFHnE0yQ1KdRBKug4opAWgaijeieaNHtiPQLfRccKktlWoBSCLR7i+eCPtihju/n3UmU3Gy03hfLcszpMfK1zoOWv6npT8idOU1HcS2kFDRFbLNKAIJvWOMCB/IZslwKyZzLmn8wLnVTKUW47BBpjcG6sHqGztxhWplEqa8iClxYcWotNLRbhTvzW117fwxNi46URlGMq3tLqHHD00ncdjv8kbcYqY8E+SQacEySiJhlMZwX0BK1R1JWpD74dS4W0CzZ/MDXHsaxYmCrNMzDGUtt0WFyJALgZbSBa1Js1sjge9bYZeMc/zHxfl0XOc3zeHJzGMEQfLCKhktR0IHTUNIAWNiPcV84VlhhzJX3hPiR0MMtBtpYtySrWb0lCNiLJ9dGq5xhguzEeMHv6wPovQQI50QPTKcua1wnGtbiv7yddODYgVx77j3xpMryvw9mHhXPM+zHORlmaNOobiQmo34TwI9fF1WFBlPZrIajSi4hLTelCQNXTQNwhN/kAN7e5PvihhcZxK21tHqIWXFBArqD2o/wCwLx6thBUpgseRcabxsnUn5DLgOeCE0Nv2ttOh0hTitRCUUN6H+/jDbK4M/P1ZXAjRmI6jIMZmbS0h99atSErdPpSew4AAs++FEZSHnghxS0KX+bQLv2FYZPJzBWVla1Ory9h3pA66aS6BtSRtqod+cLAcQRPB1QkTEKpbc9nNZcWWlUh5kusOn/Go2dRvfv3++OzExzGakshKi6ilu6NIbcA3QAAB7G/nE4brLGVvJbnzNTpSHmUIIbWgC6KgedR7iu/tgDL0uIe6qHEIeSfQHNwTx/DfnHstoRWPgmMd2TGlRnGXW5Lp1gjUHdYIper4Pz2GDMrlNAsR57Z6DetTZDSPQsbDqGjrF1Y9sCMRGXGG2ELfMx121LFdIitgLANjcneuMOWv2xC8PSZrXWYjvRVtvl99siRblOAAnVYJGw3rfFQY9rRljrE/37JJLTOZDOGCqPHktzWn1ltTSWEoU2tC0EaSe1HWa+EUaJxUxJWY7DKWAXW1lz8hcLhOyyR7AA/xvFuQ53MyvKpi46HGhmMUwHEqQA261rC9+53G/wDPBMXI/M+HW8zhxsx86HnW1rDemOWw2DfVG17rsexGGMNgGzfz4PFATftQqJbbSI7c2OpTkcqQ0p5bgDhNeukc0exP0xZlaVdJtbuZR0pLzmmO7QcbpA6ZJ0HYjYcix84MabhZlAiQYa/2c8A60+/NlgtGwFhtACLFlO59yBtvYYbQ2hxcuT5SXGc6fRDNLQv/AD/QcVzx2wyDVlzjv4d17nyQ225zhUWBBYhQZaUhcsLKZUJTBCFtggglYPr1mxW1UMO83dmyskiZlKkRikrXFZioIK4iGzdED8muzW5J0X2vCowVs5ezmMqHKCXdDkUuAdNxsGlrsj179hx84Y5nk+hj9tQstls5SQhlDkpxAcdXV6wB7jehYHucEzK4ANfIEzEelh187JZkG41TmFm0+bkeXeFWZK32WJC3YyGNiHVkAbmq7Cr+b3wvXFQ2h2NPdbYkIWY5a17oO/N7AAijR74lkjK7baBy4NyAt4uSAWukhH/P3utgLJrF2eNRFiK3GUwhQbQlDqAacA/fJJNrJ3PGN+ZIjn41Rhjm2bpzzQiHkOywtxS0M7NlZJWL/W9z/PbD3LJrTaCWmhuaWjWSDyAfcbbYZeB5fg9GR51D8Tw81fkSIvSipZkfgLds7ke4JHxsffCWbKbjSVeclIefRRugtC1opAQFo5GgA3wTj1RzWNzVNP5zaEFDO95ZTaZHdbyR4caj5meq6hbKyQemKsV7fX+uGJbfkw/JuslttawAHXNCGyTzXfYd7xJ1tUmfMVNjhjMFuILMeK2gMaCLIFE1tVV83gNqIStCCsiuUIG/Pv2OALWhoBF4XUokk5jomWURcrCHjLVIrorDBaKKL4413+5jSeHMwVAh5mh2DEWJEUdPqskLABBJRfHfnnGTFNsPpKS4k7335xfMfeiamnHVkOI1otZW38c8m7+949EEDRUVDM76eC7nEd5DZnutFlt1foCGDoPer4sAjb2rBmXSVIyh9gdZh7MOmF9Nwlt8d+oCffevY4CzV7L221Mw3X1pOhK25o/FDuj1r2NAE7e9DBGTPQmkh3/74itsFZjuk0HSijxwLr5qrOAqB5IIPVMpuY4doJ/JgZAxksLyyJSMz8105JcftjRoANACxv37fOFshptp0ojx2SoEhv8AEog9j1D+ccc8/GB4U5ppDLaEoQ60CoXuVnbnub7D5xbAegLcZ8+ghhbgcJj/AOKir2F7VdGj7Y5tNjQDldN+sxPuuowHdaT+z7wzmfibPVM5fOYjSkCiVr5bGxFdx8YJzfw6/F8Q5iM4kBx/1uSV7IC65rA3g+a3BdYkxnluFBKkOoGjpuVuD3429sHvvLzd95xx4uOA3RTuvf3/AN8Y8KzAHAddvvtzVeDKwxGcuGWLac5olLWXzM4cgoflLLbDZjRtVnpoQg6G0AA7bjau+G2TQJMAsrZTrIW0vpE67IO5utwD2O+G/hzLHPPtVJcH4hNVr0EirHzXBw9cy79mZaA61IIDgt7bQQOfvfziN7mNMa923tv+rLpCi1xg686rP+Ls9fzvOG5sxpxx11HTShKEJbbaANXv3N7YSSMuzAy2Ew3m0NAjrawSCj/J9caWTkDwyr9t6EeSLnTAIoq+R8YIyaCl5YjsDqPOE0Fr2b579gOcNwbadYENcYna0RtPj91mJojDMBZENkfn0RMIJZiOEvBYLZHoF1/yG/44pyZSkjovPrlU4SCvY1ew29uMcfX5bqMvNa3gsprlAA2Ne+L4UJ2KGpzqB5d/WG1hd2Rse+2PpaLGhwLptIF/2vj8biQGOiJKePlCoyVlY6outafj+tVhDmMZZbRS0Uvg9kHtgnzUcDUtYIWaRrXVj+mM7mUqe5LYZbjjyi2yX3eodl/uUO4xtRwpWdLg6NBptzhXNpU3EhzSJjr+VGYQQXSAi9gEHbmt/bCzOJq5zX7PLzwT1luotZBcJRoBrt/phuxCZXlzbXTCFt3SgeTft3x2fBaaX1EKZWLoOI9A37AHfti7s2zG4PL89gmnMNQh/CeSutQ19WatJWSbKu433+2NPCSzFaKwgFxe1VROFUkrbcbU0l5ltpsBxBXYQvv9id8ATPEeXOSUIdkyemunApsAldbVZ4HbAmo4tLg2Rewie725dSVaLnuu7x5z2K1rDqHLK7+3F4qlPxmmFKJQHEcb2TfOMf5+e8EqbcLbaBrHz8DC6bmYmSxHcK6INlGx9wb/AEwwUgXSNdeStZg5Mk2T6Gp1yS5JdQyvXslGrYdtvnDMNOlgPHQKIb+a+mFeTMkNxUxkoDeshYcXdc8e++HUpottpdJAbd2sC9HzvziWo4FxAF/r4flV5CIg2Pf9UX1Gnm09dltKkWPzkVtwPucAkyHGHvNoQG0L/Dty9Y/z/G+Ml4jzd5EtwNvBtsGm3Ghz9D/piEPM58guxnm3i4hGkhxXO/8AD64nqYQgCo0x56+P63VOFa95h49kTJix5KyvqrLpF9S99e/B/wAn8cRLcMZWqM6nrOEhtwdGi0bJBsYMdjs+RuiSK6gBrb2whzN56LMbS68A45S9z+ehuLHHbDaIc6iA46HnXZdN1Q03kAWIQWZxIj0Z4strQUAp1uIpZruP9ceT55l2UO+YfQ9KKn0UwV2V8+x2q+31xsZfiGYlySsKLhWtYZF2RXb59sY3MGJjX4rTblqLZcbCwdPJ118+wwGDwmIyl1d9hrbntv3oca6jUIFFsk8/aDWh7KMjYy/oONpWQ6tZFLq+xH8+ecZYSXVRmWXGmW0hZW28EepG9UD2AOPRvFmdKhvpgPQGX3PRYdb18fnofPz84xmctxnHZPk4nTjFCghvVa/e+e1cY6zG1G05Dbe35XNFC/VZp+KnzqWUuFAUdO6xWq6/NxV98WZhEUy66ys9TpHTr0EDnkfU++CIUV2Q41aPStVNoNAmzzfA+pwxjMTG80acefcdU4Cys6A65awRVHn6/phNKgQ6YlYaWYW0Xc08OZrl+SQ89ldN+O6gJRq30ewIOAcvZQ868p7r+YUPwSCK+QSe1cVjRO5fm7KYuWzkvLZSjqxm3AvpyBe1ewPuf4YNyvIFS0OrLLjc5Sw40hCgG0IolY0EWNqr6d8V1AwPFp8Ngn4bCuIzGyZDJVfsDzbj1Zg4GmhBKN3xRCHEdtttvv3xZk2ZPBUdGXxadj69DNa0AEUdj74etwH4kKPMQy31QsOIJFlZBAA+3asGeG89mM5zmOauxY4lyW3G3HAyB09ffbuK4+uOJWYxzjabr6OkKgplrINkLDzGG5E6MZDiEtr6TfU2WK3tdfnPI222GNnkT0CJlOYx58cSG3WQoyG1leg0aXsL+K/XCaNlmWuS31DL2HFOoHlltLX+FvudxuNu+NLGWhGVuKbeeLpb/HQsAAkL4B79jeEVcr6Za4X5f9KptOpIaNLcnl0tyvKOpHT6fTQNV+Qdt8M888PMrHmmtDatCBoB347X2/1wyYakFDL+hxDRb0MOOAArQDvv8E84NdejiAHdYLgRuVna/j7YnqPMiF0MM0x2gvP15Utlt0MpebddAR5jqVTe+tHze36YzkeF0prikuIW0T/iIJIX88WP0x6dNjeZy0LdWBa+UHge/wBcI8whNyH1LS03ZXfVCK1jiqGw4v740GLTZWipVzzEpRHhrW4FFYQRtSfrzvi2aXG2ior1tsHY1sf05w8bjI8unUi7oHft7e+E2bx3WVuBAQGhRQQe44IxLiKpbA9FdgmFzi4rHyM0dEm5KOo0LFe/6YU5nIZYbLamilaFbBZsjGmkwHvNyH3ENqUGS6StwCz77/XGLzWL0RT1oXZpvuj4IPGIqTKvzXPdp0XWxjmhkMG3klUtSFSwpZsne64+owTEaQ1LYBcLDiiCXHEAoF/HtitmGl1xC0/lr1BXN1z9MMnk9diMhENCA01oWWtXr3O5vvv29sMqA1Dm0HPNcOnTcZJGqDbgoRHecJQQhQFBfJN7gd/+uIMM6HApCykjcGuMN1h1wtQ3lptlvQghOjuTRrk2eTj6NDU51emhBLewTq3X9B3rE1J+cGLQY4Ve3DNF3gBL3ghpKC+pC9CBpaAoLHO9c/fCvMZMn9jjJkyWVQ1SDJ6SWk6uqE6LKquiO118Ya5iULCENI0KS2QtV/nv3wKDlyzADEAhUYXMW48VB8672A/IKoUL7nBU3P8AmAGw9fX9Lj/F8KyoAzLN1VEzSKfCTeSnLITbrUtb/nnAfMLGiunfGj225x82+A0gtFxCTQc9NocrcIKODuO/9MQz1TUt2S6qSuQ850+m4SRpA2KSn4FAE+2AYqZLDzJbLiVJVqbUkUeeQftgnUmuackglcmg99P/AM3NkJt4syHxB4fTBezaP5Vyewl6KNaAvoV6ToHAN8+4PfCWM2vrx71tkKRocoNlG967/kbw/wAxhzpcNnN8yTJ8ksrZbkG3NS0IsjfjkX7XhRBMdx9CprjzjIBDiG/zpAHudt/6Y8SaUCP2oH4aQQ5wJ7tv4hpgbLylpU8tGtVOuEBTm+xPNHi+cDuh4xnkNSXFsNmwHDV2d9vr7YYOehLimC4hLrNOBaRuCePpsN9jgnNMv6cjzDhYdcICViIKQ2so3bVtV8XV3vjXS5mYWU1Wk1rwAhYkAGM+pUmG+3H0KQAaLiVGthV9r33A+uPswZRHy5pxxUR0LWskNuErbA9FLT29x74IYjJgxmHm3tClAO9VbJpCwfftuP4YhNjp/aE+Lnsl+FJaStam3WSVqdA1hsgcEk88DE1LK535RVIpU7nv59Ul8+steWU4tbYBSEuHX0xtxfB2A2wQ20gx3VMRVvUQA8DVb9hXPGHGT+E52dZe5Py5pt5iG2lyapB1+Xs0haxzudtAv+OBEZdlY8JyZ72YvNZuxLCUQCyS242Ru5r4Gg7EHmxhxYREhcxuKpsJm/hsfdI3NfoWpKNB2SBx/rvh2y1Jy9xEyYhlkOL6fSQtuwNAXWj9wGxv9e+Ps0gNO+Go3iEZ7lj06Q640/l6QQ8wEUA6raqUeK/1wDmCoUZwt5fIDjLiEOhP5yhdf4ajQsjfcCvrhLXAm3ehfUaRqv0h4y/+0BkM/wDsib8KnLVPvvxUMuOEkIQRW++5P15x+e4KsufhZv5jMm8vHQ60ZsxOqZLgOzQP/D2J342wvhynWJLSsvQhEhBKg4tAWtHoII32INk8Y5HcjxiVNNNznQhxFOItoAppKhvZI3O+wIHOMpUsg7Jg8508FAxpaCNldJyue3FMoM64fV6IktHW044EBZCV8EhO9WDgFDWpT/TU5MdQNSC0nWjQBuVd9tsNZOaNteEIOXMZc2h5uQ87IlGyFldUNNlFgAUsAHcjfCuHNey5Ujy8p1pS2HGHPLv6OolzlJI/OitinDQXbxzdE2BZVxmkvuojltAKAvX+OAogAmgTsO/1x18oadJj69wAnUoE8iuNh/HBvihuMw4y63m+X5w5OiNuvKZaW35RZr8LcAawBRqxhYZbpW8s6bWkiiCTv3v+uGgscJBPosL3BO5WcZrLZYyyW9MnwIzxlCILSG3FgBy6BIJAG+M96v8AIj9Rg6I+iP03o0mWyFt/3nproqOs0BvxsjnAP95/yn9BhQGWxRh7U3h5dFkZFKlNLkRHmU69Txpp5HHTSQPz6uxPAPtgVic7GjlhTKCVKKXVKKrWgaT0yL2AI7UdzvgyVIZmZJGjIjQ468vj/wCI0o3I1uX6wSbXvXooUBeKIcj/ANmjLmYEdUp55Y8ytRtSFIADeknRz6gebxaZEOIhKiO9NIsrIJPheevNgp/O3lBEV9chwdAooqUsUUrC0DppHII32whiyk+baKXmY6tPTLxRYF7EkV7fGLmo7Ud2O1Lt5C0E6G3xsoihxdEGrHesDOJeR/dVoQtSVnQnbYkj25uvpjX5wJAgjx99kLWCb78sisuQ45Ae6RMhzqJ/CRsbINk7bjaqvveC4H7Hn5uGXXhlUF4p6xDKny1tbhbF71WwJ784AjIkqXJZajueZSFagNevTXruuwHOKY6WQWw+2S0PUSBSikmrHv8ATD2MLyBMHxWf512VqGlpzVbECRJdbtaGnUIIU42b3080RyN+TifVDMkrZUyl1Ju20lJSQK2JO3c374NTHRGS3mSMmzRGWozAtCWlwosVfRC60hyrP34wDDf6E1sPRlOtrcKmwVlB17pTv2o1+mMy5Rfb69Ucgc9ueqZJj5fHgqlh5DJkNp6bWlbjzY3CtxQHvvdivnCgjQgI1s7pCyLICr7YZwmYPkZDc2W3GmKS+h1T4Kx6EhaUpSn1hZWCLPp3+uCczzJrOok516cpDiZSVQYflk2uwEGy2AE+kDgbkYppgFvasYP18v2p3uh3YFrc0SVcR5hSkktSAnQAtoFxF86LG14kvyqI7JjNOmRpUJGoDQk3sUV8YuiSpyoS4EaSpDLziVOMIvpkp4cX8784+Y6zrrhdfUzG6I6yktkgbUgkCrs0L+bwga2F/sntAAkqxxx5lJiyW1sKDFKbqjS6Nn6gA1h/4SzDwuzmLELxLCkvwXIzrclxloKfYJR6FoFgWF83e2M4h5S3R0eo66+gtrD2/ak7jnb37/TDEpL0eYW1f3aKbV19HXC1+ihv6zZ3+BfbDjm0brHW4/iFwa7VVyHo4gR0VPEiNJXobW4FsIRySPZd1xscMlTM1X4SkxouZuIyVM78hlFHVcWOQ1e/oG/YbfGEURD7bGppAAbpSyHKJBOwrjkXhtLTPziMZ8uWw5KBU4ylSAku8lwk7DWOTe52q6xoyk9m+3n32SnUzHaVbBd1rSh1pbdf4hQEmkE7XRIu+fnBS1sw4rDwy1yK+sLUJLjxWXST6NuEaKPyb3xXEkuxXEuhBjlshxCCbbK+O+9UffBzeTIZfYdQ04h1x89NmS300UgAklxex3sV9PfBPaGGQYOqcxhOy+8R6TNTlWWZvLzTL8sbbbiOLK9CCaLhQD+QdQn6/OIPupdkR0SOmW2PwlgrIIF8OH4urHbFjvQZebm5brhOmITpSvqevRoW2BW12vajoHvzirz0GJKhdDLQoRwC8HCv+8H5AOw7UDhzaIbdlhrZRkgw11zG+qvYC2ZDb0ZyumWzrOwQ5zxv7Y0DDz2byJrwyvrPMN9cgMC2KIJcPbRuf1F4zUV/oQ5IXAQhyQ5oEgpJDaKBpFjZe16wb598PMnjR3ZDSHMxbhPtpCW3UUUXfK1j7bnELMQ5wLy2I+3guiMKcwEzPTgXzMpupCwyOsRTbrRLfTtes0Bzew34rbF0yC7HkJ8wI7L3T/w7otUapY5B2uvnHcujNuyYi1rM3Qsh+O2sjX662XW1++/8cS8oJLjy5T2hLZBrlxe4FA+453IGK87GCet+apjcM8uC3v8AZt4c8R+NzLlxJLKH8qiIQ24tzp9NCBshFcfXtjPgtNyXUvJIdasXe3bYjjEcgnzMsblohSXIVANvLQ+taHRdb7Hnn22NYBJVIW+6HrSXAhmxuu9tddxz+vvjalSkcrS3wtz7LadCrTLnF3SO7lk4bC20S0RW21pWW0F12gtBvYo32+17Ysz6Vmc9CZEnMFzWMvYDEdzWCgIB/Ii/k3R3o8Yzst2Q3mCZElch5K2UbSD6yAKFE3sKq/YYayW20ZW1HRmiCy4yJb7KXvQVmwAB/nA5vj5wBpNaC5o5/EGd8tBSoiY4Q7FQysrOlzqOb6ALPP8AO8aDLGw20HXiRaDra31ujaiNuO+/thK3GjNNp6rzEgGN1NDIoNE2dB1jeu/88afL4qJX40dLh6jgbBslzQaCEWNtziNgz9u4nY8sri8C2sbhAHLOtnK8wb6jbiBYARpAQduPfBSEPJQqQ7GZQ22vpoKD+cUDfwd8aJuAuAub5uUgSENr1i7fbdvZBBrcnki8BwzA820y8xKMUuDrIaIQsoHAHawb5wqnhG0XzT0JurW4r5je1eNERlTjPnEvNdZbaDba0BCHLNc9tuBwDjSZBmHlZHVcCEOo4pAo7VwOcYqNIeZfcQ2qkuEo6ZbvYgg8/fDJjTJESAQyt5tfT2BHBsOFd7ntXxhdcPIimL9/JVNJ9Km7t6L1fwdmOXCQtl0toUvdtAJJO29E+2NN4glRnsveiRXAeQOoi+eduL+ceUw/E8eMWkPIQZS6cccbfBpF0iwB6BtXvjVQ88W94bdU0hg9UjpumurW/AH8ftjkvwZe7K/T68/nVVHK6KrLwevuptTcyCWsvmNNzoLZvoqJNBFAChwN8LFtuhxSGmXEWT00ewvucIpniOXDXoWS2pf+Q6yR3O3uO2H2WZpEn5Z1nXnm2zRAO1ouzvd3dY7OCovZSJaLHp9dDulY57WmY5zzVk0NNtFZKENVoOgUDW31GE0vxX5VCvLs622xpcJ22+B/XAOe50hTojMU8ls73wcB5/HeXA0I/DdBrQscX2x9Xh8OGgEHm/39V8Vix8w5XWSxfiqP5k9R5baiu+m5xXsPY4boz9KwkttW05+Q3wPezQI7YwsmEgRnOugvPrtYNfvjhF9h/wBMVwJeZNsKXF0ORUEgED0AA77fXDHGmHBg12/Xh7JtLCgszAr0zL85jORiQpAUNyeMWMZ/AajIDkhDEhxwhsD1k39tvffasYrIpuWL6GX5g1IYQtet9YVa6I5A+v2rFOXZmxlrxDvq2WgLcIF7/wANsQ1ajsQ4U2gtIvMdk39+nrK6eHwTKfaJnum+i2+YZp5uOW0HotgGm0CyVk7We/tYwtkNt9RKQUI6Y4rt/s4W5ZnuWyXOq3TmhZ0dTbf2I+v2xY9KjodLr5IbXxo/xL77Y7FBsMtoenOCFz61MGrlGyfwnHW4SlN9N5ROlCD7/bC3LmEuz3nXFLCl0Se1d9sG5RCRmjaGcvPqQx1HCtYAsc4VN5vDgLeSqYgdNO5Jrt/sY8xkAgGXbrz6cDNEBbuHKjtQylx5CDovWdq/67YTyc8ycvhTkwloL3QgE6+/OPMfGHjmAWmmooBKN/cYB8P5iiRl5fnH8TWAhtB3+2EHCG526IKBEiNQt9PzMPrdkUjTYLKORVnn3PvhnGcbd3FdY7lfYj2Bwq8OeG5GYFqRIe1pKyaArnt841kiMiEx5ZCULLaKbCNjo+MSgsYYLtF16zn5ey28JX4ldRHyspUvWTuvRyR2x5XnGcOzG3lLk9NthsBvWSS5/ptj0jMxJzAqgNlDbsgV8AfHtjEZzk64OaGM1oW4gACxr1m/nsNsU4cMaQx2ov5dVHUo1HMNUaH+JVkmTznWmJJX6XCtQWBY9qscCv8Ae+H2SJgwJLqXA2sOtmy4rZHIFe57fTFzeVuMwgn1sgPWbB0X3H3xZJyxLUx2Q6y2WG2epyUEkcVihpYG5QbH157fRPw9FzCTll3OclZrO/D0OXDTJbbcWpCCtbaniKHv77DGSmiSmCW1hRTo6OmgFL2+RRG3J3x6RAlEtS2nGWXlSBobWtYHQPICD/P9MJcvkswZjwzKPFlNONlOhZG2vuPnFVZj30nQNIi9/ewRB7X1YOp+q86yyNKlZl5Z1xb7CF0txve0X2PtzjV534Om5SxHfn6GI8l78NxBHYWF/T9MMBlTERARGYUsONl8rbsAbev5B7XwcN88ZkxoUNEuWzmoQyHGKcWQ2ijtXYjEorT/AJ/fqn1aPymAEjqs9DahOT2G/My347aKKHN166ogVsvfa/1GNJCaSzGd1trcmOp1uOr/ABATvY90H8grf6jCn+zYT4OZThHy1WYvKYWY7Ska/L+7iD/nAHfti3LM1zDKZAkRFgSBJDzEk+taLOxC7ocWTXP2xFWPzqkaR4X8VFiMWcHTBtPS/VNTKM/pNPLXLZbjEgN2PKb1SwR2Ptsb55wzyTwxIn545DcZcZjuI8wHVsHZFWCUNk7fU7YAR5mWh5TTUqQULQ884QBRr8Qkdxd73xv3xtPDebR4+XsNnMvL5eFuIcKHtB9A/EG9A0DxffHIrf8AnJnVXYXHio0GnrvZcfydeWZbCmJdcpyxs4BYB4ABujXfEPPwWEf3zJ2XGwClvQsgoK9ta96XXbFGb5kw83FCm31jrIcjLQKHl9yDvyTyDx2wfNipR4aZmuIYcbfkrIcsoKwNgACOPvziB9X5xh2m3f8AxfW0mgMBeJcfJWZooSp6WcvTKlMobRrMkALQaAIFdhW2G7WWNRnQmfY2H4AG4BxV4T6IBeZeQddo0Eb19cMnwVPPJbQ4XFq2Ureh2r6e2DLtm6BECaQDQUBmLKRESy0whuzr1hFE/B+wwKcsbAS4tBPtQ4wyl9RcdtCj1liitfFn3xOMFimpCyjWe42IwoQWZudU1tUtdAQDeXxW0pfcSgayeG7XX174x+eNx3ZBkN6FH/DBJqt/yYf+IfFMWBmSMsQylbzgtlQBpH1+cYfxTPcLrzy1rWXNwscAj4xzsNVp4p5DLwb+PPFd6hRqU2532BHss74rsNl1TnUeWvY/+Wj6YyXQefnaQ6lbZIALh06/1/nh7mEn9oIe6bZBK9iNr+2FE3poQa6ba1LsC997/Tti+vTDGS0dr370NVz6hl7uyPRNMsmZLHYzFiZlqnDITojuNrIMddjff8+17Ypy0KU2mMlhYStzShyjd+3tZ2xXFynqxJEgyyhTb3TDakkKXtZP22598P8AwojMoSYjTam5CWJzclmO6bQ46aG6OCCAAd8IqPcQHFc3EYgUi4s+vT6IlGVsxsugZ03mkfrOSS2WgbfB2/OCKqrrAWZw4bMBSyw/qTKLaHT+RbY9rA3+PbGpdcCy/wBGGiDIl9QZgNALesu6wGh+4AKH2wkzTIs4T4Ym5sJji4LTiHJLK5Oy12QCEE+si96G14m+YWAsBmfogwuMc8h1QxeL+Olvbqsg6PNT1E6GOq5eu+m2jm7oGh9ML3YrDEsa6ZGsH1euh/XbBE2cyTtGb1a7JaO1e38sC5c602+zNmtKkx23kFbG34iAdxv+nGDY0tBI9EWLrszm0mLKhmPEeQtTkpLa0rAQgIJ12dzfYAYukjqteqS6Q0AllDiT+Tnn/fOCsukZU25OddZkpQ4KjtoWkkDXdLJ5Gjv74u8O5LmvirPmsnyVgy5TyyGWi4PyJRdc+wxol0HSeXUjqlKiwvqGI/CXsuhLTzSkpWhyNoBf/cohdt/cUPrhc8zGSGkRuoFFH4hcIorJ2oe1Vz/pgrNGJSMtVPkxyhtuV5RbqCgU4LOmhz9a9sELleHkZU+0WJKsyWhlTMhwlDbfPUbKd75FL244F4YaZY61guLXxlF7SRcg7QpwIcVbzkeW2uLKQsocboJQABvY5u974xQ5JREcdgQZL62utYZXuCsAjWRxdXv2wmkykPPqp8EIpOgX+GPYfAxJue5JeTFJ6aVlCW1obJKPkVuTXPvjcp3NlzX49hYGhokI+Y+65k6Ujr/hOLBSFFy1newBsjar598JQ9+Ky6VHrc7orQQs9+/GI+bXHkNORJTiHU8uluqJ2X80B3+uA4BYdnMtSJRaaW6Ct0oKwizuSnv/ADwvJmgjRc9+ILjdNGJ7sZ0hDriFOAJVRpJo8V3F/wBMWnNZomrzVuUhqbqc16UBBFilnRWjcWK+u2As1DcWS41EleYYS5TclKSEP6DstAIsA80cVIcUtClOdRx7lsoob9ye/wD1wLmuc35c26beiTUc09oa88+i+UHVZeGHOmIrS+rbYQV61jYXyRtx23xVJT1H1hL4c5t1Q0hddwD8dsVdZTT6Vsq0OoIIWOQR7YsneZQtIlIKVrYQfWLJHYgdrA/TAhoBUc9rVFMR2kRJEx2Swgj8NtpCNa3CRdVwECtzyCRtvgRwqcSHnOoEuABwj9/5/h/A4oI4KN77Xv8A9sMcvywTy0yc5y9gKQ4bfdUhDejeiSPRe9e525OCyOKL5sGye5TnmY5JkWeZOEZcG81ZbjSm5DCS42jXrBaP7l3e19/YYy7iWQp0l4Xrohpu2jR2+xxxzrmO8kvgMoWLA2QV0a2Hf5+uOvrSn0RpTiWXSNetGjqV3IF3veMDRnLm/wD1r7D6LxeYE7IprJn5UVD0RBUC0t3WsdMOBBpem9iRY74qSy10ltOPPGUhIDKQAEI3JWDe/HFdzg7Ly9L8Muqf8TmIILiG4kB1bh6iXlfiFsDYAaQVe+2IhqDls9LmZI87GWt5tUfzID6Cg0C4O3uBe9c4LtMEmD06pZdn02V0TJpIz9jLocJGYSX2GyIra+qHFrbsAVXrF3o7EVvjXf8A3J/7Vf8A9EPEH/0eMXlmaTctzBnMsrlLiOsOB5l0GltkGguvcfHz2xuv/u7/ANqP/wCsGf8A+j/pjDk137wpXvxLTFOI8YXnENslxpUMrS7X4hWAAm749xX9cXQ5EFMZiLOZUYhfBWtpA66PfQTtRobHH0U9JLKkxlNkf4znZYPF3t2wRKjZdFYimLMROckx1PyktEpVHOsgNK1jkaQskXsusdZ7QwBvXlldmUiHJSpuXJTGkOP3JTMUAX3AgFdA6qRtuRztvhU6jrIffYaYjtNJBLYXZAUdqs2o3+mJrfky5IWslDw9IXsNKQijdV2rHJrilsNp6iHAkEIcBq/V3rv8dhieq7NcD783WZcp1Qin3XyeogLfUohbms6137774dzobsbMswyzM2GETI7XSBCgttoJF+jpnTZ99x6j33wrV1EgJUAw0sgo1i3Eg7gjvR+MXP8Al4mZriMzUvwo71Fxlu+rW3VCF/HY4EAET3hCHFphqrZfL+WiO5LfWpDhUywCrSnbdft+gvYYrWpL74Q650GwkBJ0HQkVyOTuf53htmE+KvLYqWPDcePKjKWJctK1fiqKwU2m6QANtquziqAwMxkxEZovysPQWmnQ1SUHciyBakg37nthj6eSL6idOSiYS4c8kAhuO7SGfw3ejr1LWPzjcgfpQGCpBjMREdOc3JWtHpQWVhUf13sf8+x9xS/0AcAZSC6Geo5SwUquhvsQNh9OcNMvgqmR58nLoEt+NBQH5EkNFXlmtegLULrcrA+DxjC4NtH68l6xCDiIStbpZUUJQCQSvSpwH0bbVe++Olt1pl0ONMuqdSka1i+nwbB4v3G+14nTL6XHErTFS2gLQ0olVHYem/eycXzJDcqNFgxopY6SCXPWpwuuHfqHbbsK7ffGw0gB2hHd9ijAi6iYyYziG/NJR1Al2Or0qG+2pQSTR525HsMXFtTTjLz7CI7zS+n0yjc9tx/A3XOKGXWWwR0W5Cuh09yv8Jdilgjv/wBcHPRswbcnQHHW3xEc1uKQ4HG9xRUHON9gObOPNpNa7N5RzvWGoYykIx/LZKHHYx6okKQC7GHGsr9CAkXe1GuR3xN9pbeTw5gZbSFrcaCwgHWQEEkm+Rr5rYHAaZEYPIdaZlGlLLzi3qcIJGi1+9e3vhlE8tHylUXNGnCEydaWgspWsUNaHBdt9qIG+/tiplAAZhvB8+p7lrsQSA3ommST/B//AIIz6FmGV5k/n8hxCculrX+HHbo2CADvyPuOKOI5Ay1KDLeYuxIUWMgOqdXIIccQLWsNAgjqduK4Jxno7a5KXFNPIjBtC3qJ6es8aEGtyQdh8HB0PTByyGY2axJbkzWHonQWFsEEo0LUsVZBvb74uLC5oPT8RzzULWhrnQTdE+GpK4UvrFaGZC23Clbg16NiCRwL43B2OKExiuQpb8VkNtsdRZa2q0besA0brb5q++BFrdGYNrnMktLWsgEaEAk2dAGw3rYYML2dLy9+Y1D6YgsgypAQELQ24aa9u52I5vfDm/5IYsLZIJV5nLDbzcua/qWyhaKbBLjg9Ab3/IACcT87JaiOxsvkampMZHXGitfT9dVvwfn64xT4lTHEmOgOJC0tIDTZTrJ4ockn2/6Y+TMlRWkgyUn1m2wSFJ33B27/ANMcynWBMwR/Pv3roAtbK9Ejy1yMsZW/HkBoPLaYWGQOoasoK+5Fg12BwW4t5WVRJKZMVwAOaY4ttbACxa7P577bnfHneWzc3eZENomQht1CGSVaShSwQEjsL7/TnFZdzB+SlGpbyEqptKgacUfi98B2qkhvXn5sVUzENGWRfn88F6iPOFudJk9dbTbgMtxEoDWTuB6OdxyL+x5B1tEUHiVLIcQRZDiCDz7G/vjJeGZs9nM24aV9d9fpaCFg0edv6fTGmE96MuchLseQ3IQgFbjAXRCwvYkWgdiR9OMV0qFyHcj2+6lxWLIaMgmETNcVHbajPOMFqkOAIIJo0dCyN0fTthlkaGZGYuHy5lI6brtNnp9KhYWvY0hHJHt7YRyTGfjzZwCGCtwOMIa/wwLNiybPx3wdInMuZwTlcYMx2g2kIjLWAvQj84J3s8nC7tqAT5qU1XOpnY9F6Z/Z9/Z1mvifJ25GVPKcbaYKiHE10nf8gP79jf71WBcwhPZBLdyV1lyO42tAWsPEIccBJ1lH0ND25742H9j/AI3neDciV5+Mp5qSsBGp66XRNmuLN/pjFePvEEjP81XNlPA9S1PN6wEC/wAmiu4BPPtvh7wcxaQMgFjv+fbx1UGCrYh1bK7MTJkEQB0j9yfRXzGOoWlNdRZ0dNayUH8SyaBB3HG/PPxiyNFeOTvzHIwZS0+iMRaCLIJuj6zug8bYWxJSEAyGRFZZcIBbH4gRsKq7PbnsSRg6XmDJfYirkAOtuBpIdHo6Y7GrKK4oYlJll9ec719FTJY5ob+Ux8Yy8tXn/msnU6pgtNITqT0j1NIClEb7bH64rh+JWMg8SxEqiZXKbjAtshv/AA11ZCyvayL2J52whkLZaa6zkhkOLQQhu71m+SeK/qMZ3Oc7YZYhBUNpD6ErIQ42PxULPBI+n27YlNBwGU38edFZkFYwAj8w8Ty848YZpnkZtmK5KQtLjbaPRS+1dsbCJmqctj+Wakx5RcZbJQ2sgNuEXyeCDtjy0PZjl+dzZWWShGamtuNrEUhSOmskFG92j67nnB2Q50yltxOYoW+4YxjRPL0CF8ArAHrqj8m8VHCGsBI7MDx5zxupU30R2dQt3DnyJI6zi470gkt7Eejfn47bnbnD/K8zyoTD+0IDbkOMjplouEdU93Cfez9MeOZdmcpUormyjFYKCHHOjZcrtXYngHtgvN/Ej0fLklkrS4XBrQ4NBIva/bbFWHoAS6DA6I8YysRlJE9V6M5LjPZo4vL0No6ADw6j1Wi99+/053xXmmbEBRbWtwuDSjW5fTPP8r2x5XL8SB0KdBRFlNU2yjWSDzuCeB7/AFwyyDxAM2YjxpbyESmt20aRwByPiu+OwGgsBGoju6dP4vkalGox5z6evPqtsUreCkyGyh38i2Vmwja+D+uKWIzS2yhI6gXVUiqJF3/1wLIzdwJS6haEqrbqm0HQN7wlyLxUhEwx3okhjQUa3FpsA+/0GEim4S5punURIAK0a4oSw42uQOqg6kIN0tAHzvXGMVn2bwpjbyohbccaXR17G/bGxfnOS230yVvI6hNrI9bg9/oTeMHnjUBx3oxoQaKUnX01Xr3/AKDvjnUXY6pi6ZYf/PcRfodv6uyG0m0H5x2tlj2/FWaRpAWl0ithrs398M1eJ88zGMC48G9VgLB3PvWO5jAylEZnby7osW4v0LJ7/G2AISLKUtIHlw5aFrO++388fc0WNA7XlYL5pxrE2TKFmviKDGekMuuBIAbJCyLBuu/OKYEnMC648+68uU4g3tWx7Vg1xnMXXWUOqW8lCAGdfYbkAfxxs8jyttpAW8gIB3s97+e2FkCC8jnPwjfRqFwZMlI/DWReZbYmSwy82glIbcuxzv8ArjSZY3FRMShmPs1ulaBfffBMmS2VdNpJLTQANrFr+QPa+2HHhCC8taloabRvsgi7PsfnbHLIaQ5x18x6cK6lJopNFNp87c+60vhvM32o7uhBW6s2NHo25/kcTzuY9JWJLiFRdAI2O2/f5wVlGVSV9RZQKRsgA7IGF2YZZmUt8RmKtawHN9gB7/6fOPn6raWHGYDTz39T5+JXVoNfX7M8j2QK53UkOqaWtYQ2AhYXYC+LwAFtunqtoWl1B0OPOcX/AMhwzdjxoDgYab1kC1FZ74TyS5L6q0qCGaskHa/b64rp1wW96GtRLAGNNugTKHLQ5Ec6kjraAStHN/bFMvNPMISY6OiCg31Dz9ucI4GjLJBZekOOOn0BZ7DfbGkjZW1Jh9UpDjbgvQvgjGAZ+2vU6rmkM3Gqw8wPefamMOSKdeJW2NrN19R8VgWXFlDLSp16IUyJLbqI9+sXeg/ANn9PpjT5vAigaRo1dYKIQaI+N/tjGyM1gxcykNZg8h6CtxdN6AFsOHhf8B9sU0w6hkYwF06wJH68t/ElDiKzXtLiQDtOv0umbsN/Lcxbh5quPqW305LsdnqhG5NCue24o4tbzCdlziZOXTlr6Q1I0N7Hjaq+p322xaXGoEISWlvy29ZaS6EERySjYhfINHg1z3xzw2Eqm5gjMoaOuXNKB1KbaA3uu6NG43vDgym+SDpqLedj3EeAhc7E4t7KYaL2XYWWIemasykLiNuthwto3WslBNDiuQf9eMPPD2VZIJKXs/mBeWw2SVhpBJd0GrR3HbY1eHOeLgZtChRY8ZLEuCsNILTdeZHu5vzsOcKI8dyetxl59CFOP9EuCtDd8k9tuaxCBUf2n9ki0fcW6ei4uLaKhyaiJn7G/VY9yfm/inPHMryd5cXLZEodNsFxaLJ27WDQr5o4ey/B3ieEWstzRvMek4kvRkLbtvflz42H8sM43hzL/Ccx9tvO2ZGZhZJcZWQjbgoI337D68Y1+T5tnUnMf2nLb8+OmEMtSCToHuB++AOe2+IcVJcSwx5csfou58IqFlBoDQQO+8/TuO6T5X4QZc8PGU5Jmh5t4Nhpx2h06PDZ3uxdjjE38t8T5FJjxktRZ2VuN9RBkL6oasEEBtfcWe9Xjc5j5qJlUFxMZhlp2zaHASSDyR+5V1WF0954RFSIklBebCFIDqtwdx/+P/v2xymNc1ozXPpfTv39vJfV0cS5znNBtPkP4sP4Xly401tbinHSNYQ0v0Nt77E1z7Y9GakuurS+lSDX4nToigex+fpjL5bHeejPyJSmWGQjqyeo4QBo9z79xjVtJjRcrTJkyW0MLpSHV0EaPr73gA+nn1v0+8KjEurPIlMumuaw7MWhAN3QWED6AYnIbbJbfSg2N16+LHFf1wqa8UZMmHGUhxtbbhPRUkaOoByV/TcD7YQ51/aD4cTmZZXna22lDlaF9Nvf6bc88HCfmNcQAnUsJXIEiwSvxplwEpzUj8WOu+KWD3/njzvPoKyttDzzUES1rWh6SukaEc0edyeB/HDP+0X+0jKjFP7OeTIQ5t6rtSAe+9i6+tY8tzPPpGYSXszdaiIZaUgdAvnUQdW6EHehX8R74PC0hRaCGgE624fNdWv8QZTYG1H3ja8fZNMuy+S++VwG3Xkk6LG3+xi7OMobhOuIdctRb6mkGzt8Dt84VP8AiicIzIQlLbH7iEA1XthOmVPfU7mSZAjNk9Mq6lGjtpHc7Hj2wIruBOn99/Vbisfh6dMNYJPLrf8AgzK5ExJnutSH2VK0vEj1rAFkIJ71v3xoJElrK2m1rjdc6x0W1/vm9gfj3qjjz/J/FS4OUIhJbDjjT5c6pHAND+mNQ/4jgZoGVynEfhjWR2vuT8YnxFQtGlu5fP16hr1O5HZZJkNvuTJaqcfO7Vaxte2O+JPErDHhSRkLsGC8468HUSdNuINVQPt7j4xnJGcJXLC2ik9Jy6q0H2H0wrzF57OJjrvTYY3WqkDYd9h/IYjotzONR1vwhfUbTaGv2ulLkp6QuGy88rpRqbQQgWgFes+172dz8Ye54vw9FayeX4ekOyJIbuY3LhBLdgmr3IXe17YDdZy0TZTsKK83FcH4IeWHVo2FmxW9g/Y4SZ1KVHUEtVSkErFHb2P6Y6FWu2mLX2XHfVfVqAgkDcePXVM4kpjLJDb0mAxPjfiaGXFqCF2KskHkbH7C8LMvXJbcVIy9b6lR29bhbBOgcFZI4Fkfrhb5mU5CTHK1qYQsq3Jqzt/pg16bMd6EpCyh2NHbQpKCEHQnhfpA245s3gaD8wzO05zdPxWIcTljUX6enqqZrTLuXiUa6geIUAiyNudft8fe8L3XnnihlbobZWRqUq1en5I3I24+MMm0MRZjrEsrZeZaJQLS4nq7GjWxBFgfNYo8OTYWWZozOmwGp7DTgcciOk9N8X/hqINgEXvzjaRLn5je/sudiu3IG6Gyp1LCpCWojUpTiNHRcZDnrNiweRzY73WIy48yKgMS4b8dS20PC0n8RFGlj4O++CXHluznJuWRVdBq3HEIB0soWvYe9CwLwB13HZSpM1590KOlxZWbr4PvV/GKsrTqL7ftc3LkjKfH+qzLl5cnNEHMy+uAlX43RIKyK/dsi96wJl8d6TmkeLCJEqQ622xSx+cmhv23rFzwS6pzoo/ApQYC6/CTd2f9fnFTobDbY6KEaasBNE7cknff9MIl0FoWvbLpKmQuI4qM42fw3D6XFWGyDSth9ALxa/KZLcRDbLbZaRTjzROt6ze97WONvbvgaSmMcvSuImSHvyyNRHT3PoCe/bviYd1xQkhrWggl0pKl1pIq+AONvfGOaD2jzZLzH/Km22XXdNC9Czbiwj77/A4xFx1amwy4+p9LZBQQbQLAu737AfbElOQ3IjQTFWXkNFt1SV+km/Sut962PbisVwg0h9rzRd8vuVdHSXDttV/Nc/OFRuEsNgSpQY6ZOYpQwEBTqiG0OOBsDYkGzsB9cfNqUklpxa0H98VR398EwnAxGW8FF6QSoKSWbRpI/wATXY3C+B/2xWtDDi1PMobjoQB+EXitZ+RY7/1wdPN15znRT6YJU2stdfEdmE6ZpfcP91RetBGwv6juMUyCt1Bc1MAOLCC2ABVJ2Pto+b374YOvQ3IL7HkG0yUrDjbrTy1hLej/AA6uhRBJPPIwKX0oit9JpWouDQ8456AdrBHFYFxIPhzgVDKJIkqqT/eCp09R19SFqcU46BqFWFfw474qdj+UUw3KjPIeUgO0pf5krFpUKGwqsW5g5IdMjzCGHHOupxbrek2bo0U7FF8Vt7Yrffe0CMVjpR7DaL1hGs2a+fn4xryD2juluaRZDgvOugrWo70bVQ/6b4h5V/3H/rGChHe8sp9tohsn8/b/AHxgryWT/wD4Sl//AEI//mYU54GyW1pcvQ/7coPhPJPGM+H4Xzt+fF6lvtNtp6DffpoWn8/JHbQPfHnFtdVwyGVrafRqATotNH27VvsK/TE0yGnUNIcQ+0eodburqN0f+XbcA++5OLYbbmX1mDTSCEKKEPABYJ0DcWasAg99zWOhTL2ta0nMQNevfv8AnvKe4gk9/OWX0bL9YSp2G88gta7LqATsvQQd9tiT9MV5bl89aHFx2JCW2wh1TnTUUps7KUKsir4BwRFiwFIktSHJJcUzqilCPwl0uiSpe+itfAJsVgZuYpEXpQnVlsW2dYGuj2H6bfU4WwGZgzdLeTOZuhTzP8+T4hgtKlt5aH2nXJjhiRW2FuuLctwLKACEBAToA2GAUPZQzJOYxfw2H45beiIWXHBrCkKTqcAs/v2Aasb3gAQoDTMV5OZMuvPNLUptLRuOUq212K3Ava/mrwI0h9SVvBLjjDjgQs2AFKO4B+cMY81BYeo6e/LpQoin2eXXUNFoqLupERS/TR1g1vse9XvWGuaMZkhlUDNXJK5mWJCYraX23G20XrWnY/8AODt84EhGenostzmmm2+qltDrlBonZfOwJofwxXFTGZjtqdebClqUnds+gADnbuTyNxWGZDF+HncjzEWVUSLInSWEMNvy3nCdISCdxZrj6k/GD2w4iEiQqGsolE2ppekLbBo22P8An4J7gYJyTNswaiNJVLksQ4czrtstthSDIKDVixZNUb7X9MDPSXcyzWVJcLJlSnC8C0gMoDhN+lAoXewHG+GNoQzMD384UQec11VHguSPMPNapEVhIC3G0EoaKzSNZobX398dEObAEWWl1cZE1twsLaeBWUhZbN0duCN6vBeVIkx8xBfUgLU6IjvmXAhHNdjsBR34FYqcgtKzJ4xgwlhlxaSBJQrZA3o9waNHviNgc58uHOnqqHNDGi6oUz0VLH59LwSkLqyKJsi7/pg9DTuaGLBy+EklMlTKJLApySsklANmvoPbApeLEZ6GlLa+q5r6hRbraqVSQr/8azXxhr4tzCLmma5TLhR4mUoVDjx5Daeno6zQ6a3S2gbA1e4JO/N4tblkGCSb+HPqpXOcRGyWy0LYkvMNjQz1U/hBdgmyAfng+3O2Doy3mZDplwpYjjQl4Pmj+cgbke4I2HbAjSswagOIYdUrLnnEpWtKk/i0dYsHdVADbgHbnE5igtiJJlhdFsBDzZu0ArQFEc3Y3G2w2xRTMieh/CCS3Tf9o7LpMnoTnGCjyWovIjOErbQVgi+b1gbA/rgeYI0/NZD7TKGWi4OmDXB2oAc2fYYsTOYkQVpf8vKZekNulPT0yVEDRQXWw3H1r4wPlU6BDmSH5UZEttDJS2w8opWtzSUg2jiidfIuu/GK2HMSCddOfRCLDRCPuOxpBZQ82/6NNDhv/TmsVpazTMViMyt6R5dClJA9gLoe+w/hi5Xl0sLLCGpDSQnqFSaIrjncCzR96+mKSudHZdaa6zbNgvFpWyygkX7GiTv8482mykJJPPH6JvadbnOSq8lbmCc3JijqSozza2mf3lEG9kckDTvWL8vfirnvycziPKZUlanm4q+mTqBKOQdgvSfoPvj6BOKcpfS3GQp4PJU2+Xj1G00bATdG+Sa7fOIyZ6URFQUIhqac0O3p1rQaJ0BXI3VuPf6Y2GU2i/0QAboWKFhkvJCFp2sr339ucHaFtaTJeWIyiCkn1en3Cb+P4YWxVqbKZCAHG2VailVGvax9cNlidBXKjvMssqeQC9ugoKaCwByN9jsd7rGYQsBjnin5zlGqqyouuzERno4r/ESrSfw+PVtyKxvXJspyEh9qJFMKPFEW3W+sg05r217osn+Yvc4y2UmKiM44w3IYWleptalUQmjpX9zyB9u+NEYuazmhLby5hBdcbbZQWwyH12RrA2C7JAJAobcYa613DRQ1nAkDWV9MgtF1l6G+2xEdfKENrH+GhGjdY/yb+54xoPBniGLl/iRWZZhGgz4oWt15nooQTfPT2pH6ULxnPEOY5g80jJWnXJcDKFuGKz0g0tqxrdIIJsWNySeBgTLFxoUdxky2XuqnWheg2aGwI5G+3yDfFY5L6zalTJEgraTgLkwvW/7RPGMXxLPYejZa1lsSEy20ADb2gixzuTXf4xh84WEzTGakx30kgIcZOsEGtr/T73jmQeINUGTAmyUeTTIRKRFKQW5DiBQ6h5QNBI2P6c4EI82hrXHhMRYzhdkoDy6dPU2vcnZB0DR2353xmHpNotFKk2G7d3r9voqa+LqVSXEgmPpze6csTJORozCI6yWMyb6a20LJC2lg1ttRB3P+uHS8+y57MGn8uy59DHlejmBkOB4vrX/iOIG1XYIHuAcY/IVMxZjUyXGE2I29+PH6xQFt6yQCeeOPbEfEr0hqW3OjKgxYcv8AHbbjnqrbYWsoAWRuCKqjvVe+LfkUms7Q38edfVRjFVqlUZTFvJGS5AZnsuOKQGSChFkkDnax3G38LwnkSYAccD6SZC+BWsXft27nCTxA/KLXVRJ6jQvQDegAitgfgfXjFcaEliatqTm0ZCmm+oH/AFOtyBY9DZTdr333G4IvbGVWtBhzTbSw9u9df4fiXNMtOq08Se5F60YwGlqkI6QKisON0dyL9xzf6bY6EKE2iVlsHXbRIKCOCD7+2CIctcqI4udH1qDILMjRdGz+GdxV7mzZ2+cGZWqYy0hAWHFLR0mGtyVoJNo+m91iikx5BE66c/n5+kpYpriJHjzh6pDDmmLOTJbbc1o1qCVrsI+QeSfrgPO5q33nFNMhzWCoNub/AIY3sK2ugOcWzQ3KfcX6AsblKOOa2/ngPMmU9dqM4oudMfko0g8ED9BihjwHEHX7J+KouNKGW6bpEp59zQgdNCSqwFbD355rBqs2dnvyZTyUlxxaFhZQAsKGw3AFDGs/tE8Gs5IiE45mcOUqRF6lJGzYAvt3OM1kmT+dU35l5uK3otK1Cx8bDHTwrqVcCo0nLfkRK+WxdCrQqEVEQt2ZFlR3XpQeQtAdbdKrIB2pVHbcHG48LI/bTUuZJkMXHiWyUIQ0HenW253O535JxnH2EJd0vNtuNncrKBSz3P0PNY+fdgMxUR4DS46kL/DlE0txAHBANe33wnGS5kCxO+vjqrPh+FDyCDI9Pytw0W5DnlnnSXTWtBsGiOPtjOZ46mG2XArWpxGko7Eg7cfbCrK5M1+dJmy1oUgqsKSKSD7fGBczlvZnJUOmyNGlsBCKNJv/AF5+MFgnguBIBnuFvub+CrxOAIbKVByXPf60p5mkGggAUB8YKkZM21k/7QRI9Rc0qjhBvYbLJ9r7Y1/g3w+3mc9LKkIBCB6tqFc7e+DP7Q8oRk8dnpurcZ18H/p8DHRdjGU3tpTLiZ8umiW34SHMlxj6rz2HnuYRsvjQ16iyw+t0nVzYr7Y00bxSZLTXmFEMNkWUVr/Q7HCLrId6im4zQC1KUEJbso2NC+4/0xblOVuZk6jLW+ul2gFjRoSnet/j3OKMQ5raDnNHauYnx5Oi5tPBubUAaZC9G8OCM+jzTDqwpA/ERro0e498eh+EwDHSrpBiK0C4tZrW6a4H37Yw2R+HJfhp1iQJkd5l9HRW3Hv8MH3Bv9e2PWMv/YsNrqyXG3uohABJ7jjjvj5ar8SL6YzCSel4/nmrm/CC9/ZJAGs833Fj5pllj7SgXUtBkuA87bYDnrQ6hwsulk77o7Ht9cAzM0CPw1rRpv0GxxhVN8TMxnDFItwE+ge3zjnPa9xsu1QwrabYcluc6lvuVKQsv/hrJ2K/f74A1NxBGhKSC26SGwhBJHyT2wYX4pWHigoSU2UBHH0wJm/iSBEYVUVaFk6APfG1aWIfSDaNnd97JYdRa8vq6AdUd5XLmZbapDra3HGy5rbFr2+vOE+Y+KpM1GjLUFDNhs+i79q+cZyRnK5bvrU88h1egkHasEZXl70qclXljGb4Os7De6+frjvYbCFg/wDS/t4+8rlVMUzMRS8z9ED4o85MDsfqsAkV/nJrfWPrWMzm+QSHhCeRDBSRqU4ASAL5N81x7bfXHp2f+HOm2lbziOsvYgEEAD5GKsshttgRnAh+r0FbdAjuDfuLx02VS1gdT2/nD9lzcUGRD9VhIzGZRoj0Rl59EcuBxluyEFfvRJ3OOZMiTBgOPlDjjy9ZPpJ1jbcHsRvf6Y9Fm5eHUsshlsNONl4FpGsgG9rButu/HOGvhOBLC2WXmG58dxC1rA12gVue3FX8j7YW/GMDO0AOt9ed91JQokuDp9uQqcmEh3Kmeksrc6JCyUUTY/p7fHzj6NEgteHjmjmYMjMxa/2QtvW4s7gBZqvk1wP1F2SRUSZDDCVlmMZJcW62T1DY3FXwKsfa8MHEZMwjMoJyp/OFSPw0Sgvdr/4O4PvfG/OOHi3CnWAbMHUdb9dvbzTaVNz6bj057rMeE8nXNYjyJLrbMQyQZL0hBDg9w3udew22oE749DyySuMW3svnPkeZ6AjUR0/8iO9miD96wvzCQlqF5ZTQYMaKhxksq6luDlHNDj117AVjuWLfnQlPLSwwGkB1ch00KJ3RoQKu9/eh7Y5VbO6oXuPZ5zr3DU9P4f8AKawQEyccablvNSV9F1tZKHFgrLvsK/jd7Xi6NBZkwm3ZKPLyG12eTrHYWeML23lModZWIr7EhBsobstbmig9r2P0GFn/AIkkyJZjPSD047IaW6KXroegD7c/7GAq0nuGVq7eHe59TMdP0tnFcyxchTch+K2zMQSvqoAbSUC+21bd/fHjf9t/j64UfK/DM0mGtWmTJaQaURw2lfHG5xofHWbpT4fXCQsLmTW+m2kr2DZ5WR29vnHiWeZU2zIRG8xpeT6lLdXTbe/f2xyIbRd/6iTzXdfTf8Tzh/nUnW5p3x9FxPih+OllGt1QY9Y6g79r+Pj5wrmZhJzBlbwWgAJ/EWkhB3XYPzua2wI4qQ7MTHKS667QWEbX3qh2rCqa0G3SlGpTI1bVxi7DVmDa55wLifEcbXc3WWjy5ZMwy1IjAIeR10kqUg0BW298kneh2GL4WpuOstJQ+CnUttdWgos3vyBV7djXfC/Lorpm9KKkyFJ/ESC1YUALqr4w4GXZkYjCUrWqMn8RsL2Gs/n27cV9sMJFM9vfnLLmU35gCBBVCpiENLjEtNJ2IDJJA2qrP6nA8lgKaXJCw7R3WL17++NEnLWJs1TzhhQRIUVrbjNHQwKrQLO/0+efba+E4jC2EsmLHZcdC2gZQGjRfPsNvf8AnWObiarWOMXHtyeda24lzmNFQLzKDAdZgJznRIVBRJbjuOFlCwHCknRoJ32G33wHIkvSJafMqCW20AAsNBJ2FWOLPz3x6P4kyhnLM3U6uKHA2haVsvAoRrqt/pjDzG1obTrRrUB+4TrB9ye+2ENrh9MZ1FUaWvOUr5UqQlhtqLLQtEirZ36gCDQC723/ADjft24xONPzKItjpvLhODWyHg5oGhfoXZ7A7gn5xTHhpDoEtDiUBZCy2aJHwTgnxJBy6QzG/YMbMgWIuuYiQ6CVEKrWkDhNEfxPGH0hSLTPOevVIqNeTuSVwvIDT/RT/hrpwWToF1djYi/6YAymDMz3M3YGXxDLfLRPH5EIO6wSRtXc4oQy64yXmnOmstnrtoHTCEbAb977464xOgyW23swbR00B5stv69BoVui6NV/XC8TRY+MhufRG0PBBARcFufEzaVEhOua4yH0LOgWprTTljfT6OQLPNb4GYlzISYqDHamQmX+s2zIZtlxw0F2DRP5QDRxx5+C750mM886ttJYfUshaXL1LK9zruzv8A7YFXmL6ssREkrkvR2Q50UF49Joro2E8Dcbjv8AbD8OWhsTHQXsfpy6RXYXC48eefup5iY6Zb1Rgx6r6LZ1ADv6jx8YobgrfjyVpZeSG1ArUUEhCTdA7bH2si8CL1tNrSpykmiUg/mPb7b40LGbsr8LnKkQlie++hxyaJCx1WgkgNrbvSaO4Wd8bUgABtgF6XPfBEpJGU+4pDLfrHqKLoV3P39PfES8y+40hbroQAq/wkqIBN7fX+GLYbQQ+2thbi5AIWGwkg6gvgVya37Y+benpQ2lBeLccrcR/wAl0ST/AAwppIfH08+eKS6mXIh2E2th5EeWWlh1YS06A3qBoCgDyaN9htvvgRURq0JdkLDjitNqRaBvXN2dsGuZhLcyZcV5555kHWUA/h6yANZ/56A/TA7DK8xlBgltx91vUgJITZr8p4A2GPZ2gXXjRgrjscPPqixmGHpLklIZebtA3BGgXQAuj2r3xHK8ybyvM3ZrUCDKBQ4jy0xvqti0FNlOwKhdg+++K5qg7WthDaij1Ecqrmx2/TsMQgllt0F1KdGsFGsUFi63I4HvhbmhwIdoeFJqMgrS/wBnOUeFp/ilUTxfmacnysMOkSGx1vxAg6Bsd96P2xnHWAzdNqW0h46JAR/if7rB/hzKczzzNnMpySHImPKQp11mLRK2mwVqIJ2oAXgrOW2MumuZPkGbuTkSYiGnnI3rblKUsLKBsCAPTzZ1oNbEYpDGvGmnT2/a55blqEF0ztsOv6SRtxK5DSQ0zsvg9zyb/liidodkvqbYLCbtDaN6Hb6/XF76HkuIU7HWwlAKAUN6LWNt773V+14reWgtpQy+4h8GljgFKeDZ3u72+mEkRtomNaFSwEFwA/iAkDQDufvgxK3MtzVPSbLbjSuJLA1bjkpXYvf2+cA0W2x0+opJrXtXfg+2Gq1PzZy5KZD06UmP1HlyUlwlVUdjf5BwT7fTG/8A0BuiAMFVmPJEdtURhxxp1SwkJTuQjuTwdif03wLCSpHVcdZbcBZXQcBrcfnHyLsYqZdp5BW5oQK1JTVqH8vufvi1A1rWgNuiPeoX6ihG5+l19PthT3TAIWwStznmeP51k7MvOMvyZvXlrUaIGGeivpNLpboAIQXDVcGwNwNsY7ysb/8ADMf/ANC/9MGw1TXMnRFefQuOgOOsMOn/AAd2ytQB7LFXosmqrDj9o+If/eMu/wDpon+mBpYIART06C8ciVNVL3EGB52WYiufgusR1oKpADJ1HgXZIsbXQ+cDtB4PNpeUtbTbn5TwD3oHuQP5YfuNZO63NitMrcQHHFQpzYK3Q2hB0IU0DQK/RajuKOFa43ShdaW9031kFLbrSzrQrh2/1H2x1RLmgwnvAlfZmxJyycIslLjCg02UB5X5G3BrGwJ2IXuP647BbQrLXOhB825HfLipDeukIoAaxVBJO4PN7YocjpRMUhxlHU6hBBB0kduNx9sHTszgtKnw8m8/Chyq6nWdKnHQEpV0nADRT1ASDzxfGFAuby335uhqMIKWxpDbUgSgyQ0pwFTTa9HpvdF7miO5w38RN+HYs5bmSpnrhL6ZjvuEJUhdJW4FJ3ur0/x+MK8yZVC1IkFK5D1kqaeSpsjtdd7F/pjsxkoW88lhBSfw+msA0SLsV/sXhjMwF9fPnil5ZMt5zZFPzYKBCk5e0lATE0S2SCUdTcFVqsWrZXFA7DjAsx2QlyM6680+lttCGlN0RQr47XW4/XBM+RCXHaRlKZTbQhNCc2+pCtboVupNAegmqHI73gJ11ibmjsmQhuIHytellnShBrhKQdhe2AdUfnEeq2m2Arlz2VhTKosdaCghuwEqaUTeqxyfrt8DBcNUNLL7qksR5MRKEtx3ELdMlWoAknhGkb+3bApkx0w4aAG3CkqWpLbfqCu13tv99uwwMFmOlqS08ph93WStJI0jihWHurkkStLCZTR5llLvSgPl110NuONOoH59ZoULHe+3NVgidlkOLkGVz4z7cqQ4l05jFMZxHlSlykanODrBFVVcd8KY7i4EpEyPGplxKw2ZLOoEgUSPke/Y4veWZMx3pOnpvBDiwhZQhYoEprkkHvvuNhidgzdnZaXzcaqENqM9HQ2h5syCsp0Oj8MCvz32PyfbF70jKpCUvhsRy300hjqqVbYT6gFG6JN7HYWKxx89HJUOftBh96QtxC4+gWwgULO3JrajsB84Cb6kXoSG1qQSoKrcUexvud/tiiQ+LrA2JlbFxSfEmUIENUOM+y2tyY0uS02uQQ4On0kEAbIKBQ/PpJ7Yx7wKlrcbbKFtj1qcctRJJAoDuAR+mCJ7sc9MutrDqmQH+qAVdQHsNqBATzvi6HEjzY059LSWlA2wyFGq1J4vc0D35vbfDWPzjtEnu5KFzA3RXZLmacuV5heWM5gUdRKI01suR0JWhSdfN6wSSO178jCt0rTE0kMlSqSD++ir59uf4YPbmPZXGkQTDQ05I6a1KUj8QAXdKvZKwdx8DAjDiFuojkOOJUorpLmrb23HPzinKMkAkdft3oGkkzEo7Lg04yqa5KfL/U1FroIpbaU3q3NGiOK4334wsUopee8u462ldpQkfmUCaINfy74gtxBU2vQ7dUtNaQa2RWJeUkvuSHY1FDCOoVg6BsBdX3+OcGcQ3IGxp7oyCBO6KZlQW3IyzAD5beCpbS1FIkCwdFD8o5FjffFctcFzLisBaH/MHQyF+htqroe5vv8AriUnJ5UfKYebSVhtuaVhgad3EtkBR22q/vtihPRefMZ55aUJVSVtjUPsNtjzhOVwGkHb698Lwdn3U248lmOmciNIaQ4taEOEagaG4453/j8YeDJnmXPLfgrLDZcXT7TrbfoBJBBo8o+e3bAqZIZfL7PQb6gCi2iwhC+Nvb3w08OzG4klbzuVx56nFgkSm61OUQKWK9waPcX2wdMVWkEm+605QYamaMznry2PkzDMWBcRuM4Gow1yKX1G1rJv17jcVhwC7n81iGiSttUnpgqdfQ2wJRBCyF0A0it9H64y8KO2nM/LS57KUtm3JLZW8gej8m3PIBrg/TBzucMsZwoMSY63+sHGOm2W2kevhAPIIoUscX97y2jSAcbT7k9foufV+bWJafLw7ktfypbcUsOtITofokOWV0SNdcUOO33xciNJiMR5i3G1qdBCwuuAaPG4P8dtsaiXOl5wt6RKeR133FylNoQG20ObWUAccV27YO/s+8NL8ReIXWZmbQo4bQ46tcxWgOkC9zz8j9cQ1sNToMdVdY89fuipUqld4psvz8LLS4OYyHGczzaRFdS9+CgIAIWlDYqggDjYFe/r5vB8vzjsYloJRl8RlB/DXaEDuR72TdfOB5k9WUzJ5aqSlptYSHSFtC/QbJ5IvauCQcZpyfM0Nx0TA8FI6qfwyS2Se4x6ixtAENiOSnDCOeRM9PSy3bcXM25GWvqhGI1MbQIrrlEOA7E61iub3PGAs1iBnOZUaC83KjoX0g+0heh0E87jc/6YUzvF2cZ3Dy+LmE96WxHQWmWdZpve7T72f0vBOXPhDiekptBcCA24eUHckCya+p/hizCisTmq7T9Tf0QYvC02N/8ANUeJo7DsZmBCW4+6SkJpG3tQq/tXOFrMWelBnSX2X1oe6CGHXPWTe5QjmgeeBvvgibLWkJfjKCwhwUQut7/OD8VVjjFbCW+k5McSwQ6vpLA3II7/AEI/3ziuq01LrME91Jt03yfK8w8/5Bx5EWR61PBxdIRRIKCe1VXfBkSYhwuturebea9CNr6rl1zftiWTtdeAGWAWy0S25sDsedAPwN/fF68sgxnyvquLHUCkMlF9dFHve3bbC6dUg5HX8Oq+oDh/zNrNtfdKs0aL0l1bTTEFLhJQ02oqCCjajvfz35GAFoZ6Ye656raNYbvVrPcgj6HnBMwBhbpQgdekAuHtvssG9jwMLWGSZKnmkIX116wQBd2OR7WRhFPDijVLwDO/8vzqrqmKfUpNg6pupteZxmla3GQsW4HADrF1YPwcMosVjLGmFett1tH+Jd6zftVCtv8AUYXZW404UoeWhkC07nbX9ePphmt4S0ORktLX+CW0aO18X7i+e+On81mUtK5lYVKlQOnx+q+ci9WSpKYz86I02XH1xyRQJIuyPRvX+zjOORi80lEZBHRVsvuff6/GH8YSYzpLqXiw64hLzaFlFgndvb3rtxinSy3nD7PlkttoeKkBtZXobqgixucIdVzOiCTzr3q3CU2k5TpbnChFQJmW5WxOlRjFbdvoO6P8Wid8KPPltha0a21E8gbEH5w08QyJrrLceTPU9DYQQ0Tegki6Ht2vGaRFkOSTFZZW48bGhPJrmx74bhHAgZoBPTpzyTviFd1FwbSFo31nyTfw/nciFmgmN36ONHAHfB/iXxY7nDPRfUUo12AE9vfnGWlx/LKKNYIQQBo4Pz98cS07s6+3rZT6PcXjqMw1IuDjfb78/YXG/wDyGIY35e/PZGSHm2CFNrU6VKvcej/vWCcrzzMEuKSwstyHPSVoXpKgTZv3H8MK3vSoulWnUCmkCrHfY8Y6whAISVrbK6onsL5xTTpmoI2PX15soa+IeP0t87nM+TES71vxboEmkCj3+Rhzl+a5v5ItGQvUQU6xuF4QRICMwhtsxHabsEuLQUBePRfDUNEDLghxCFqI5WNyccB2HawEtAie7ll16ba2aJIEBZ2AvM5CAmQh4dM99hhj5aaXWgHll5ZoLujv/usbbLoQktJmJ6bZ7Bf9cLczgpZ1LKW9LaNe67rf9TgGAVHEAQr3tys7TpSdt5+LGKXtBUSaJP8ATAbEaCGzLzE9TmkDgG/54D8STkBDRZWgpAo7b7dsLVyem42p+y0scfXHVpYODYriV8Y3pMJ1lLPVfdc0IjxSum64J98aoPJixojDMdfm3GR5nhYXd19NjVYQZW2gR1LcW30RRbs/wH198N4K1LbdfXo6iBRuxQ5s/HbCsQxrGyDYdfCPNNw/b11P5n9eCauNLXljaiKSB+hPb6bYhkg6EkAqb6T7Y66EGkBCzVHkood9zhrlk6GYTgcQ4ttts60EkrCO4G23PbscL2JHTyuZGaa/CmI3R0wbANij27/piNlQOlo257dVBj32aQo5WtbUtpllYjnrFLKyKKNfoOs9xh1OzGV5k+G5TbbZYQIgdj8ayd9ei9d0EAfPbCVceZJgPMtRy4Y6Oo461uhCOxF/f6nCfL21uEJ0AuAW3yFhZNAoA9qv64hr4dld2fcT+Z+uvuJC9QxL6YDTpzlvVbvLJOXxvC0OYzK6ec2sNtEa9DRNG/Yncb4TyfKrjebggdIADWE0Wz7rR77GsCZXPZjeIGJWaoMxbX4rgVZDqweF0b9t/vWJZzMDi3JSEOQVSCtT0dKLbsm0C73Fdz3xjqLqNQgiZvP28udFZQph/coQG4fTbcnS+nmRWDEj9GkLF31Cb+u2NdlDvRhtZTBkrUzJQFONx/yXvoPvd7kHi6x5RMmZkzIbmTWWBDd/BBQwRZRV7/5/ev641mR52tDCZIkhmQwQsn8i9Gw/PvsB+l4ixDi9snT8de6fquzhfhL3Gy3yskZjIlSZUlg9PZstiw+5Xrr57+wx534gMiE48iE1Hp1Z20X0wTwfc/OL5mfySvyLiC+6t4mkWso+cI/Evi5rJXUoy+FrlaS2t1wXyO3+/viVrDUNj1mF38NhP+UEO7ROgPsvL/7Xs0VD8VoYafd/DjJSW9fY70fbC6RnDciAxlstiIAp0PIkJ/xaogoUo9u9Y9C8Q+Dp/wDaDDbkw4DUKc0gDqLH+IOdJP8AXHlDmVT8ozCXl01DjDzFIU2pBUT6t9/13xxviFXK7Ow3iD3/AMWl1ejVNOp/gkEaQCBprv5dy08/LYGWuRJEFDMtGsKpS9TThRyPc3vgJnLIz0BLjCXUTFOGwtICNFcA89zt9MUOx52TqDbjZLWiwFb0SOPrxeNCTDMTzjUt/U22jqB0gnXVduPYYb8OqZqbXk6rnfEsWBVNMNiFzwlEjDMG0JkMRKsL6j6EXzdk7A4Nfl5OA2lC3OqXN0Fv0aKFG73N7V2xhXQpeafha3C4pFLbXYBI3B25+O2DpY/CabbaX1m3l9a7qhtV/bFGJk9o6dy5eHIe6JvHVPY0mA3MEaUtkNLcDLjgbvpov84G24wTlU2K3mLgQtb7AXQWdiUb0fi73GMkGXGjrdC12jSs3Zr4v/e+H+UZJnLuQrzVGWvnLmpCGHpKEHQhejXR9tt8czEwxkKmm3M+SU7zR1mQuKzEjgvI/DICKQL4A9zvufpjJzCiNMkR24aH32lrauifXRBqjRo8G+2HwblJiKpGw/4gvbCYwmQt1ZdDdC+5BIHG38/1xPQcGnM535VVVmwCVT3UurDzXUGyAvWuye25wZCiwA4US80bDZjrcW6y2XaWCdDfarIG/YH7Y6Hgy0IhpEd1ZCyvdYIFn9dsJo7i2m3UKtAcuihd3/H+OOnTDHAjy/nPfSZwcxwIKaZsMlfai/siPIjvoioQ+HF60uSL3Wk9kEUaPe8In+gHgjy61JAIG+m1e55/TBRX1nCwzH0LXoSkG+eO/vgV1haoplBTamg8GyNY1WQTxzW3PGJqpqvdAFleRSbRF7qMtpXX0oZCF6iotm6bN8AHttgpDj0JpExLCW5brnXYkpOnRRWDoQNqvbcbVthWtPUv1qK+Rv8AfEUylM+sLKV7EV73eKhSPkudUNKbiFfBiokS2qjuSFDlhJNuUP8AN27n7YvlPBxiGtDgKYzSGw2tdm7JXQ9iSTt746AZHRWSinVkbUT8kgb9/wDTAsoR0vlCFJWgroKSDsL5F/HvhLxct5w9ywUWN7YMqMhKEpQ42+k6taSByP8AmI7f9MSkONgLCClAsL/CBGmxRSATt74hIcbIKS4SEelKQ3RIs7mu+Km/xmtBXoKRsQD69/6YVSHzDEXU9Y5TKPYiRZGZJjTp4Z/EK5MpP4rYQBdiuT2+uF5U03IcKEKUxr1I6mzikg7CxwT3+cSZkNNBKFM9RwuWpYcpRR/krsb3vED0EtpR6XHHVjpnqVoHz2o3/DD4Iu23NFI6pTMSbolsszMwZQGyUrcptkr9Rs0AV0Bvtv8AywyyWBAczp+M++iKpX4bbYimXuSQvZB2IrY4TvoClRZDrkfpPL6dFwJKCABqIA9A4PzviyI/pjiKmclpKmS5SEV1Fdknvd8HgducedOQiISDVzOgG3uiMvnPwsukQIr6UJlG1ukFBTXYEb0QRY77XxgMTZSM1YzGMpDMxp1LqXGqbKVoIIVtQG9ce2DcsaymXAmebzhOXvx4xcYStlazJcsfhCvyHk6ztjmTRkzMyLU2SiHH6biXXnkLWlsADY9MEjkC6oXvgspbBjVTPrseC0bIWXPlTpK3Jk+RKkF4uLcfcvqLonVv9797GBY6lrChKUC3fU2buzxtx8cnD7L8vhZhFziZnGcON5mhlDsBssrcM06hdKHFIBNn2IwqcloTlkdoOB4o1r6a0fhtE7bDuVgC+N6wdVr2Brtc07+OsdedFOyq09kbKLEOAiNLVJzQJdSzbIZaLgdctPoN1pG59W+4474XrekdFxXUIacJBTxYsE/a6x1TUl1oPhtvpLWNgQAkkmh7jg4hHUtCOoCw7QsNLBVW/Ncdv0wLyHEACOSia4tXweSphDJZSKUV6kp9R47+22CW7k5kG2GnHGi4CG0J3IHwDzQ3398VOqZdcLsjXocVf4QSBRJJofufTEHG5LQUskaFuFOptexWPavr/HAWPaPgvOeRZXtOPv8ATYQPwm3FrbB4BO/f6Y+8u7/7sz/6jjvUdeKVqsEoFnRQ9hx2ofqMF+be/wDwiz/6x/pggaYPaSc1Seygwi2nNTx6gWNBA9B239R3vjB8hWaTmpU2ctMhbkn8cOWXeppvX8bA73vgvMZUXNM4WjLW32m5UkIjRFuAJaFaUJ1k1sTQPtzgNyI/ljr8SSttKkhQUhuQFUuym/QSCRvt7HFtKWjx+v0NlW4CfBVyEhQ6CVF11CUW5V6KHF+29Yv8PzWspzLzEqBBnRln8SJITbbqNYtIXdoPPqG43xTmOdZpL0qck1aOkgMpDYDY7FCBVYqy8MCTreW+hhsJ6imFjVRIB5PffbGuZJKB+RwghQzsp87JVGYEaO4vqIjg/wCDZPp+3HvVXi5tiEoLlJckIZDACLKQovlPp55RrBs+3ziOZswV5i4rLTJVlgXaFvNhTrTe35wNjXF8HA7DjbDrrLdOpK9AeWj09O+a7dsJfLSW7Df8IWQFNphTKpMd+CUutI0uqNnom71bcHt84pabCVq6cptS1NkqWsfX0C+5wyiZlmmXZJPgMNupg5sA2o6SgOhtwK7bHcDbejxhYwsgpWjU05uOqlfJ9z7CucACD5LxkWRrjT7CkykOJUypsOr6DoUUBfIJ7L23Ha8HZ5mmXT2MsaayWHA8rl4iuOM9Ql9wEkPmz+c2ONsJ2wl0voS28t9RtCgbCgPz2O/v9hiyO9K0JWkLI62xr0ErHFHk7DBMZmcCQSQja8wW7FTkFuUkshbjq2ySFIT6COSAOff45OOpkLcyT9nuIUgsPl5v8M6lEgCr7djjj0aO1laXA6FOqcpPquqJBP0O3IxxtoKnICJTYLgAQpSynfg2e337Yc9pkHdACIhfTYjxdbZSNbIvQ4ElCCQBrorrcd77/bFzOU5g/EOZtxZXkVvhvrOD0FwiwjXwVkdue+JNPxwG24zKGW2NYLztOLXY9dg+g/AG/wBcPstzVUbIWMulZkxJylTa3OiqMVmO76gWwOAsj1hf0s8jD6VJseG6U9ztQFmpCXlvLW6GlOIUSA5ZBrsL5x39mSUsRZL62mUSSo61PCxRrcco71fODMoTMTLKIy0RGZIoPTdkIC0He+177jAqWFvqS0w+KQlJDjrmn6Cr7G6rDWtHyw+PLl15w7USqXGn3BLcQ8XeirUt0D8yFHTe9bcfri1bSH4yJQYN6KsrCdRGxoDtuKxMxZjc2E9KS0A8yHWHJDgKFgWBueNwdj3+MfNSnHdSDNaa8ysodUPyAFd8AbIBs7c+2JcDnfUc2qm1cmQOZ385Khl8GTNUUxobsgspW64G/wBxCBavoAN7xNC3jGTFfdfbgKdDi20f5kApuuLo1ePoTCXZKo7brzYtKU+gArJ97NDayMV5hJLjw6fTaQEhohpsoBA2uj71Z+cdUtY2BrOn908EINp56aqhLJU4kha1FWoNhtdaV9jv2OGLuWS4GdmFmMXyr7NNONdOzdc1da6N84qjyJKUyEQnZTkUNpChQDZOoHce2sAgYcsxc0yuHA8WuJQlC5aggrUhVut6Tookmt+424wFJrZBneOc080ESDAvqtV/ZjC8KSJ8Gb4xEqRladbRjxVoQ4HAOoLBIPTr98Dc7YzfixEBM52XCVIhZep9zykddOONtCyi+1WQL+cLvEmfys0zh2dP6jrz5B1AjYfAG3O4wRHRFtxmWhYUVopKCg6TRsWdyfgfPfB1B827TBAi3jz6L1OW2ImeftGsQ1wZSf2suRHjS2EOjpKQ4txC6JBo0Pff2AOD4eXMfs15yWsQlNU631GyVuk1Qsc6Abo1QX3vCnxAzAh5gUZLmHnQgBfVabWhBJF7Be4A4N3ZvB0OOtlhMhbDyCsANvLJpwDYHe9gbFDbb4w0UfmBpP666deWU1WqKQLvzPTUJ1BbbOTsuvkOa3+mgBkoW5tudZHbYV2xXm2aJj5aQ20w1MkSTrldRa5GiqPo4Gx9rONZlXhXM808JPZ3BzCOhCHwx0TJO5cI3A9jW9DjGMz1nL2kHL1Rnn8zbmkdRt8dAtUdthayD34rDqWIFZvZvBgx482UrKbWVQDab+3571ms6a/aWYtNQocptJ9LEdfrJ9jZO1m8BQ/NxY7zNIAltJQsuNj1NlQKT6uNxyMfZk2VuNR0LXrTw4tRIcRf1244Htji5Oh9K3f8YagpK/yjsNr5G+AZhy1wa0QB9+X713W1GlpL7+nPstG5lkvJHDCn5eG5aem8vSAuhW1VxyCd6JwzYkPCGnzzLy1NN9ELdZBbQKK0Cq2BB7e/xhJGlxw46kLIbAR1A82juKWRvdg1Q9rJrBWXhiTKaS8klNnQrQStAN7Afvi+w/hjahe1uRm0fbrz6qWqGl4ceeijl8HqpkJzSOaLNshB0dJw8LO35KA2++NHO8ORsu8Gw/EklLEk5otbDTDS9Gh3gL22NVxtzhfIccEMQ1I6anyOojXVAHYH42xRIlvRlsxkItglfWb1korYAo/j7HC6rcQ9o+S+HTve24jZJdWZlyv0jQQIPXTncjG25cfLG0qixVtObBynGgV3dk16yNxtQ+4wQ/MbdzV4QAUtyA3XVAJFVxQ2Fg8djvixEab+zGpOV5y8+/GZMqU25+GI4Qv0dPf1836NxvhbJmojPuPpeHVIpZQvcgjkkbHk/wAMU0mHUG/j3/wp+ExGcZX/AOdvKya5vkbrq46G0oW7LADbbYvnsewxm5sRt5tKmmBHO7S0lYCAsFZ232278WMaDxTn7rDZhiGy28w211loXaNZ70O5s39MZvMFmTl78hkupXHcOsIAH4ixtYIutiPphuV5bPO9WVMURUAFgBwfVCdUustoYDzYW3pcC12FkGzwL222+PnDBMtBzPy2Wh9DToQB1HNayao8djyPa/rhMz523IzjSGWwTIKHV6FAIG4s1e3bk403h7L8nklx7Os1ltwet0nEMtgOLRQsoB5JHa/1wgOaHSy55r3flefiiGHMTz7pvHaTJhPNFEV4ut0ysrpDZr86O+vbvtf1wqzFuTDlmEWHIjzHoeH+Q/Nb333OGOReTaaUoL6bLv4Tf4h/D3FLd2O1Wdu/GGz0aFIkSmmlNOEFfUWggFyuVk8EfOCAAdbTfw6idYJ+6nwXxF7CXPkzpvfgWUz2EFSEIS30wnZSaPJH56O/zgFOWKZccXoIUgehaFgEgkgK/TGtdKZ3WLzrxkIQSwSeprPABN7bDvfHG+Mh1pv7QSmSEMq63IQBQP75+MW0ml2o/wA930/S7BxjTB1JUc5gZXGeSYrjtFoAhxYcXrA37Ch/vfCNxawvZOpVigB+gw4gMeazHYLJ1VYG1+x+MV5qlqXIJjrkegn1KO4SgbkgfJ9+MdNtJ3ywdTv+9+SoK2IYDAt0hIm3JTpPTsq3HpO5vtjX+EfCzk5DjkxaQW9KUskEqNn936dx84n4Mylt117RGDjYb6rjjg9YFb1+uN7lTPRYa06w4s0APWdxtXf4x5teJaXba68kcupA2mxudwJ+llX4fyryMhCNXUIXXSG4Qj3x6A1GgGOGXnW2AtGtDgu+OMZrJnJLsjpyJCNTCygNoF7Xuff6/fGgzWSuTllKUy81GQtIcjoCLAuj/H6459ZxcGtAib+W0yNTvuDK6OH+KNHZmen3iDpy2iXLzxOVulCFLcjtAlDpAGscbj3xmvEGemSHFQXevKcRqXo5bPGjf+JGE/8AaJmEqVF0CIiKoOWHGv8ABWCN0D2I2P64y2Wz3UMF1aAtSLA6e5P1/rjpYbAMIa53+vXztbT63UGP+K1T2Gm3v5eaYx25M5xpERtbj2lBJO519yBiyfEmOxGYCnJDAQ+T1Fit+9n22wVkb2ZZPMbmRC2ZCAeiUeuidqOND4oOX5jIZGVmUHnGSZOtZH4h/P8AFdsNxWDZiCKLxLCNZvM76QOi5tDGfKp/MbaoDpFo+/ervCeWz8wzFrKQyiW4asIoood799sbB9tgR0sx1uIeCKe6hoWDRBPfesZjwOyqE06Q44282UaA2RZF8H2NYeyWJTcuKqOt+XDQCUFbeiiSSRXv8442Lp1BiBTpkEAdOnfp0XawmJBw5c4EOnnf42VqD5W2ZNhTrILYWgitZskH2r+eHEyImZDjuOJW+pBDiC3uSf3LHuAD2xmpLjqJIVObot6FkurrbmvpxWIZNnDzLoRJmBCep+er0A8b9sA7DNDDIn326KPGPLnNiycPx33EFTjxNbICDuPt2r5xXAhNvZe5PcSgS0OABF+tCLI3rf5/ngifLhl5xCJ/nWEGm3ygovbmidv67YvcZy2G7DC3lrfYYW7LjSQW1hfZsHudwe2Ja72teCJvfTu0vp+T3qak5xBEgR1PftGqTTPNIbcdgqbe6i0dQk0EIvkH6/8AXF8tx+RlDQShC1dQ66WNxVUR23798UOyOtCAW6yy3rttsC16xtwOD332OOwEZtFyzMkxJTPl5MpEST1FgA8kWPbnetjWE1a7iZ25zSdl18K8NALteaoDM5zU+OpEiEx6NzV1ugAADtVXf64SNzF5Uh2PG6b2iwguHXQ5NE8fpjbyfDqJMiK5EjOBssLUvXTaAsXei/3BQ5+cKZiYQyx+ktrlW2st9G21gXZvkdth98RVXCMhX0mA+JMptlum6ByhcpyW0806tZW2AS2d9hVX7b1vgrL8gRJzx9eYJbDjZB6bln9LxZlc45ZHjpy/qGXLR0+mEaNYvj3OGmR5e83EbmqtxxxwhHo/Dsco+Dd7HEWb5IIbadud8+virXfEM7w537W4ykMNR0tNJIboWjsMW+M/DXhSd4Wk5hMKG826NDQoDqDnQffCjI3o5/GQqlHYtgWi9wT9cMIbz8hZ/wAEtI5Qsbn5++ORnDXl+/LKD4rWGIphkwvAPFGV04lpLgeSw3TZQ2EAHkj7G98ZSJ14caWoU4HDRQTdk3sP0x6x/aTl68kkq8ghDNAPN3RJ+/ttx8487aekZnIfzGR0wQSXwgBBonsP14xSys00pZG9lBkc2qA4yY16pC1BW4HZjKwzFCw0SHAhaCUWfRd6PnjBCwYnUZbKNNC3EPkhYAN0PZft8Y5mK4zQdktZY49GbP4xa2orBAtdGrP60cKEPSemla1lAcrQst2QR2/jdYV80VWyTboNvZDl+XU7Iv8AVO4U5rroUlEd5sWksr9aNxRNdl9796wa7NS1LV5F2UxlYe6gaceK67AEjYmgd6xk1yH0gPH0GO309h6dFnkgcm+Tv+mGf7RjyoiVvMDr6ysdKm21or8tVyDvfzxiF7GtdJEyOWXUwrvmDSIWqHiOEy4pCH0OMIo/h72Pmxz2wtbeRLmNBmM+ppbwHl2qHUBI2Br85vGehInuxxJSthEeO+TocdQPXosgDk2EV7XQxqc2gZZDh5TmDefNyvOtrVIZjI/FikAkIIJFnjfj+WPMwjj222jnP4idi2g5DufskGdKTFlBgMOR3UdRtayv1oskUa7gbHjvhM48lpCwVFw8By6BHY1zg+ZKcdbV1Sp9doaRqIXsKpAPPH+mAX2EM0vqOkrZ500Ek8j5A4wzDy67llaGmApyZRkS9chslZbQlJKiNgkAHe/bBGUyIGXZsXsyyxrMWNDiOmXSAFlBCF2OaO9cHjC2ShbdqUtGtYCqTWwPHH8u2Po7y1q/DvqhOkjc6k+36Yw5nAglHmBp5CoNNLXISjSEhJGounQAPk9r9/nFMxcELeSwhxBLDZpw/wDF216a7c1eCuroS5rVu4AQFDn2OK3GGfLuPNJKg36VLLgG54ITzQ/3WHtqEO159FDiaMixQLLpKL0BxQ1bb373gqMtovNFzpIbOnWTekDgkgb/AFrE8jzPNvDeYozXLHlsPoQttDqACCFpKFj7gkXhcwVoX0i4lrfTd8fcdsESXOm3d+1HTqlhgp6uKj9mlTk8pcXZhBICxIHU0L43RwT6+cL5BjppqO0VJH5y5Wpzf449sLkr0Oai31DzpB2wXGWh1hyK4GFuuUWXHHumG63PwbArf32xjWtdpz+/jxSKtYiZUppdehx1vByPHQXUMK6JKCpKQSL7kk7+1+2K4UmIt55U1yWnqhKVOsJSAkFadZUj94VdDbesUzY6UxC8hh1KDoIUpwGgR7D3IP8ADALYQkXfqqxXv2wwVCRJ5/NlA+SSEdMVEYlPmI2t6MVq0h20nRZ0bdjVHk4nGnvmLNaVGYU26loOuFkFxGk7aFV6Cf44DjPpYdC1stvAL1FDl0ofNG8VKcQ28vQjW32Cjdex2wDjLZ79FgdB53optxhCWiplxB3NldXueP4C/g4LR0Y8aLIVLaeU4HUqjtkpWkg+nqEiiCTf0HbHc1fypzKstZhmQXwwozg5p0B3Wa6ZG9aNOx73hX0lLjdX0kFzTeoFd17XdfONc2IDeWQB0iU4lONtZc5GmO5g3mLBbShp1HoA9djc2igRQrezx3l4WzNzJs2aljKIWagMu6o89jqNK1tqGuudhuPkYVsOKXrefLziVKCV0uifub9v4YPmtoQxGbTOgvpfjpc1Em441kdM3+8OaF7HDC1omd0AEhDalKacW6ES09CiSDbZAAG/arHwax3K3ERFtSVSHug5bUlMdWlwNk+ob+6b+MWv5W95l2Jl615kttTlKipK0ONoFlY71QJNgUKOB1pebjNBZcLO7qdQ0g3sa270R9seLSDe0dP0sLhC+zVxEnNJEpnWtDj6lIU42hu0XtaRsDxsNsUNNAhTiloQB79/esFZVElZhPbh5dHW+84v0NspK1nvskbmgDx84uaRGJe66lEoR+AhtFhyj9bRtZv+GEFsWC845jqmz2XrjRVjM3ozLCkLdZpI8wqhTekf+WdV0DWyjyKwu84v2R/8wf6Y5kzUSXMjsZjO8lF/wy+QV9MbmqFnnj64s1xv/J//AMDf+uKG0y5oJ+yQXCSJhBofLKT5fSlSjpCtRKtJBFe1X35w0SMrWl0wENIDsdKdMsn8Fy/UUFCu1bFVkg8YDbd6KIbpZakR47iyi2RTh2NK7rHGx7GsFR2WZWXuPjoNyG12htCBZPt8/wBMXUaBfeeBXueJulz0kOSGnDZU20B6hQFXx/T5xQha/KOoBbSHVhenSkk1dUe3fbvhjNiMvth7L4igypelCSsu6jW9qAFcEgUO/OKmiyqIlUkr60dDgHSFKvbSok7FN2DW+F1Zccp5wIA42cVUZjqIC2IagxHcQEvhJIL+4OhXuAQDX3wzzzLYOWSJMKFnUPNUB1CG3WULDVFAWpYJoc+miO2AHqajx5EaS0HmTqC2x09JJvigbB+o3FcYORGWrKX82kTozqdIQlKXglwPOBe5QRvQQbI90b3g203NIJNo9Z5+bpZgW34UmnPuKbabQ++Y6LU22tywgnmh2sj+WDXIfRyuRJZjKmsNvNoU+pC0ljnQFAGvX9+NjgSVl0iPJcjKaWhxtrqOesL7XdjasSejtfs5uYmdEaeDgbMRCXOoABs4TVUfrfxhD25TcX/qIOm6sJS/5kuEOFKEhKkIugKArYV7Wf5nHVoU3AjuqCFtuOEaQ6mz2IUBuBsK++LJsNmBMWyy+3OY6Y/HjOFCHapaq1AccVXIsXjXZr4oyjMP7Ksj8LRo09udHluypr60oUle1N6TWsVxV18Y3OabwCCZMW66zrpzxNjM7OyQPwsQXFy3WGFur6Ddpb5PyTRO14JYZQHGVuqZcaSFgoK96HxyCb298CtsrmOIYj63Va6qqsk7fU74aR3puWrCmVOIfj0p9S9rIX7HexVYc0ZrtCAiDBKHjynIsd+MwllLclvouFbCSdlBYpZ/KfkVt8YlNKXGYyI8MpcaaCH3Wzq1HUSFXW1jb7YJzjMXsyzNUzOVPyitsDqLFFdI0IWa9th9sLUq6rJ6DJvSS+oE0gWKPsCNx98HlyePP4vZ7QNETGdbEwpltylFADa0LXWhdHe/3N7NfXEVTC/Cp9uOUNqASekLoigbuzWn5/jipwuPRXU9VtaGCtWgrCSLIFi9zZ7YPg5yr9huZW9AhPxvM+bU4htLb66QRXUq9Au6qtsa1xJEbcKwwLC6AhyYsKfHcdYRmTDbgX5d20tvoG1GjYuq23xWtSXljTJaSGWropqh3QPer784vS7JehxocmU03GZBLJUkFSbsq01zv/HALrPW1LBRrItSQ3pA/wB/1wM1IzAarS3oiVS23JGtSnilaAhzqAFZRtwSOa74ulwGA0l5l9t0LQT0mlElsBRHq/y/umt+e2KHEORkOR30KW/6VIUh60I24qjZqu+2DMjzyXkz0pzLiE+airiqKmkLPTWRfINHbkb4toOlkvGiFzbnvVmVONQJklajoQppTBQ2bWkrQdx22O1H3+LxRlkd7MYbqEIfc6a0X0o+sizVk/QHbv8AGKc16LGYuBqR5tDbh0vUR1ADzpO4++DskdebYddYiyVqWPL9SOCK6goIsbbkHY84B1MurgtdA390UjJbVDOZVLjtJfWwlCQuiFrFpIURSk3Yog2CLxfKgylTWWXEPR5C7UhLjex27HvuKwV+ycxiMS5LsMx1RHA1KQ76HEE+4O4v49sXF5qQ82pDMwNxl6Q445vVcADZG4WdvfHTOHYADOvLc/KUJAiF9DUuc+4ZLA82+4SW2xQK77AfU7I98PcreeacXGeQhLCtBLbhUgpQTxr5on2wNLmt5pnJmJZbiqbQ223o90DYc/Tf74jEcglx9cpt7qlFxVtubBd8m+Rz7bkY1mHlgb0+qhquIlzf1pz+3TxeYiJHX03qdo22FEaCCKWg/v8Af7YUKnQpJV19TynEa7A3K7/Id+DXIx9mKVlbK0oU4UFGtTiASHBvR+O9HFsdpt6c+91Lecc2pGxXvfwPfFVJn/zKUzLRAqEb6FJm8uDmtxPUQLKi4nhIGw1f5PrieYq8464HSh1Au32q/EOgAbgcChtQPvucab9ivPZcpEVYQ6hHUecee6aNiSBvyTR233+uEzGSSXnC22hx5a0dRQFo5HIusG5oe49y6TcQW0QevP0oQUwhlLqylsmM3aE9QoddcXQDhBHrbFcCqsYvj5qxLehVEbR5dwNhxpOgrQLO5sGycUSIMlh9DEWQ8gsDprND32quR3OOxIhkLbSqSkUStGhnZCyNx25oYi+XmkrPnWGTU/VOQv8AZzahJiwQ3JYQtK3W+qtr5bJ9yg7i+NsLm5TLctTkhqQVNs026gAdNaFgha0EesAHcG7vnE3Tb6Eyegt5sBxzqPufiCv8JGjgX7cE8+yybluYyZz/AJxordQkuSkvLDZbr0FPv7bcn9cIa17jDWmOboWjKczyOdy0GYZr51b0osLXLfKy+vZDYBIrQgV0zV/W8AGDDaYeTOdeptguRm0AuEL17IWB2O/684lCekoQctiyXHosjQ8uODQLgBCNf/OLO23xjSeLZDgyhiTIDz8h1kFDp/DW4gDR9+KrvWOrREBoaPVHhqLXB5edFipKozS5Bcfpp9AaZdLdLSOTsdgDsD7Vtgjwu4lDhYYZf0STZQ2kuOW3a7R3O9fPOFKXZTkJpT7QcYBIHTVuF1+et7+ffHzMpb6EvLlObaEub0sIsj0e9VvhFYtD4vK86q4sEAJzmLsiaiW47mC33ZC0OrLgNOLA/OT9yL+uHGWZeZGXybmsaabT+E2AHKO+x/fPueSBjPZezlBckJmz1x0hHUif8RC6XWhYHBIJI/jzj591ZaeWZDnXD6Oi803TDiAaske3Pf2wDA120DpHpzwUtQOiXGfM89UzfbRIdfejIWy2tFgSZKEAEHuaAPGwww8LZ8pmY4mRGjy0rbfUTKZBRrINLQBR2AsD3rCRtEWXLQnOc2by1ssWqmS4StCCW1FAs0s0NZ9+MUZWGnM4jw3J7EdtDK3C669Tba+ndXvvwNhzgszQLGx57IaVIgwnjk8KhqmuqbZUwLcC1kOOr4/J74z2eTJj8l5Ajakhsaz07tGxK/jtvgJEx1ySl9UpWtCVO9RaLtwWqqHcnvhz4WhSJDsudFivPLjNl0krDawLrqEfv73Y/XFlKq3tOOo/Pon06JaAC7dH5ZljggNFWzsxWpho+vqC6/lZ+mLouVsqy0LCwtDiR0AD7H12Pev6YNzfP1Z1nK5iokQytCEkss03fG6OOBVj64YeFyyLakNTViOguNtIRy58/wCQAC73uhxirD13x/6W6ja3fHfqk42sGAZTPQ73UPLQ2hBkiKIDTiCguPLIbdcHJvt2FDDiQ0zGiQvSsTFt9fWtxHT6Z/IBW4PNg4TT4zMhAbl6iW0IcQhxBon3Av5++HeVNwzl+t1xDz4UG6AILl0d62PcfXEVTMKtwAy2n35payW3FudSyzLr+UHb0J9fOeXOfs2a3E6IWFglZLlBCzwb7c8dhg/9pMNxtDhCGwe3G/J/rgBqK44471YwLJtKVrBongj60cfO5M+Y7ynKW0TSASdAI71/sYaKZaRkM82+vmpGY3ITmEC/PZA+KJTIgMvMKPVRYLbm4dbI2NVtwR74SCJA8upbS+g042guIXtW/a+2NHLy+I1CVJiLWt6z00EUSbNH2Hz/AAwnlwnj1W3HQgLouaTe18fG9fpg345lKx26253X0XWw7DijMTPn76ovLlz4+XOHL8qGY5Yx+I9IQgFcc8Vfa+f0xfNzNuPlSn22XFocpIC0U2Bdd9+bwDE8RPZFl7mX5XOL8eQR51ltGsEb1rNcXXet/fGaz7P5C85cDb6HGCnpixaC2F66R7AG9xz3whuLFXsm4MmRPJkquoxzQXAQQQItwj7e+lybxOyiR1ZqzFUF+sBB2Irjv3ArGxH9oPh/y5DiwVCkix2/nt/XHmkzPYMxuOxDabivaHdTj6AsEOAfqe4JO1YRZPmEswJynm4yoq2fKuukjWRyNrBsVsfpd1WEVasWeBG23hPfCopmw+WZI7revOi9qzHxPlzsRuW2CDsEtBBForm+K7fpimNnEfpuzmYjZDTIUt1+MVhCySEIOxvj4xhYgXPb8yjzTeWhZJcPrCDo2JPHIrBsnOM9ayNT0Gf05r7yEGnAXxobs60CgAsfv87Ee+ObiKr6jMobmjYc2v5hFUcRHaiT0TRvxC6t9KV5dHX16dGgBYCBYJWLsb/74xosujqk5ZLnlejpopGs6ie138Vzjy7xRPcccZYDzMtwkzOpFb0LQtaAShewqq7bc1h7k8/Q5pbEppZAaXGkNizvfr9+31+mLi4vaDoSuLXcWGTEjuWpaEh1oraYeRF2Czu6FrsDdfY7Hf8Anhtl8Rp7op1uLamfhdMNgua+9DuORgfwuyRFU9JltxW271dRzR6wOPrWDMrcjLltdBTMd3qFzqF7ZFDm9qO23vtiOtlu1SNxz7EFNpLUjL5iYEh4vusICXG3WyAg/wCTnevt9ML58RKPMJcS4iQVgxkEDQRtZJ/cAvnB0x1nMZLEhEpkPIcQ0RuA/wC7jiyfzm++HnjudGzqPCy3w/M15g02USWWVDWgUfQf8/f7YivIa0H7W56rv4Z+RuYleYZdEVPzSKkTC2BssyV+gbm9H/Jfb640mWNtSX/JwECiinnHXqbRXezQ47f64zeeMmBmDDS2Cwy5u31Td3xRHHbjj64syzOJsSa09HQOlGXblI/OSTeske1jftiPFAg5QIK6jH525pW3yifHyVoyVr6DYIQSEE6Cdqr5xe6+g5j1nF6E3oQUHYn4xmH50h6WIjTa5D00IdbQ2jqErK9gD72axW1GzP8AbIVKy59lIfcacIbICNB/E/8AR35rHOdRl1o53JT6ocJchP7WJ/X8RQ8qCbAQgBZHBXyf5Y8qcHQzdtpbwWla+nrAvYmv9/UY1/8AazmsxebvZVl6es++tuOwUM6FuFBHTWi9wT+u9HGEmykPZXrKWw82fWQ5/wDiFGj43sjB5WtYCBbfv4OqxtT/ANS0+I7gjsngZ14imZd4dy2N5p11bjbLMb87p1k/ii/3DZFjYX23wr8RwH8k8RTYuZxlRmY8oNuxUA+lYFLAsml7G8CZRmc3LnGZuXSfIy2iVMSGgUuWBwCN/vgxnOcwnnN5OZSm3lTQgy3JDAdW4tB1iidxvQJHvvjA6iRAkdbc54JhNdtYEQW+8/zySqSp9xMiM8+tnTuW1J/OeyNu/ff5xXlsR1TzDLauoqSCEtBdm+Psbw3yuCyX1WeoTRcGvZG1WcF5hAg5O/EOUT8xdzBcYJLQjgocfLhQW21g7o0d6u9sRfMDiQ0efTff77qxrzTiTdLHMrntt9aMy882xpdW4hJ0NoJoLWO2+1n3xfJZacy+S/KcUMwDnoRXUD6OD6wdiOd9qG2CHJLbMZbAQ9HfQShbd0CBvR7kg/HbAj63eg2gtGlkuNmh6xdX88HA/N7MdVZIJmUoWWUNDQU0ujSzZTXNgcWf4YuklIYK0iNoZPrBP5rPAFC/+3tivVMkLDbZ1K/N+QA7j+Rq/tibH90fD0dbqCyLbJonWe9cDFFiOydVOapkgjRVErlTvwY6ULfcGhpsfhkn90fFn3xZJacgT+sy26w/qWhbZ36ZsoIB798WTYCoTxYft19tWnSl9LqDr3BRR39jzvz7YHKVtAFOpsCvy3Wq9sA8ZHFvXhtzonUjnYHdFZl8VtagygsAurLfVkcIRtR2sg334/jiObMBqauKpcVeha2uu3fTcAJGsVvX/THwWlqTHbUytH5+q7d6TvW21dv97YZMpS3l6czXMjqeDi2A03s+2SCeoRVFG5F3fxtjKQv+SsqFokDw0+6QBplDX4L1r6etbehVXr/IT8De/msWxHERGJxdhR1uvoDbajr1MHVZW3RrgVv2OHPidMN6WHocgynnSXH5Tg0dVZ347dx/sYBtD/SQQKG1WB+vz84aXua8Bm3N1yyAAQ6OeEIAvI/Z0IGMhPRdUeokICyLuiO/PK/oNrwIhEZEiE880XWFLHW6QIUd90Wra69tt8GPtlxx/RobacV+RPYD/fvi5mI15YMOLW4tKipDYfpJscgcA7b2RtgPm/8A0e5RyCICAzRlpqfJixI0xj8XQGpI/EG52XwLBAFVXOA3i7MbcdUpKw2NVCkhAKt9tu57Y1WS5hk0Pw/nH7UiRcwzFxbS4ZlsOOWaX1BrCxosEHvZAxj3Gh+c6tJ/IVd/p98MzZ3GRHO7TcKfQA6254oqOlI6hjKjlfQFoVySfQUpCrtW9/rWJZdGS405IeS861HcSX2mUn/CJ3VqAIT2G/uMRcfZXDZAJQppGjpn1hVndY9j8fGH+RoztvKlZVk8t+DHzmK55svPoZakpZJOi/3wNHHdVY812Ugxz+JbgXaFLITYzKTIgxZLcZt5LjoEqShptIbClJBWfzGrAG1k/OA8qfjR1upmMhaFD1J0kL2BIA34Jq/jBWcPmU69olpkxmEhluQ5FDRULKxsm6JN7+w5wFFanPFL7SFuUVq1XZ9IF/JoVhrXPa+0dI21K0xAVkSOnoy1OTIrC22taW1kq61qApFAgGje/YHFUdKEsJU2+ovJesoDdgAVSgff4wxcX/7AW6rMo5Q44EJYr8Wt1aqrZOoVd+22K/JQRCnyH5kmM8lDbkBpcb/759dLs36K3N73WNYLjPv3rHEDRDyFzcunuJMt3VZJWgqRq1ilex+Dj6KpLocYD7yEOAayv8qQFbE++303xVmTiZUpclqGmMyrT+GlalDjc2qzvROGPh+YrKM8RMcSlllSlNPoW2l4hlYpdtq2V6TtxvWBcYuL/dZeb2VeUyHoavwFyI0zUKcbXSq3FDuk783gqK1LZjSFx1lvWjovFSKCxtaONjY9xsPrgZwMvuSnmhsmyhS1qC/zijfckf1wdDfmKZGUNNzXnpJB8sVEgunhYR3XRPPveDpFrJIkJDySIMIV5hUiXUVtZSEawL1rAA5JA+u+KvLf87f/AK8MsozvMckD4y95TDq0KQ48hP4nTKClxu/8hBNj4GF2lr/M/wDoMKNzfT3SHEQI15or48xHWkuMtKgodHTR5ZtVFRr8Mkm9HxzxiyXl2uFGTCccmDyfXklsE+XGtexsCux9t+cA6S+HlKeERkK/Bjo1lPU2FAWaNdycVIcW1ZkLc10BoBsLANlKt+MdLNUYIA5Oq6Jbmg80Rz6kQ3X4KJKlx0bvlsrAcP0rbmsAvOKdUypltDKKDab2BI5sk9+T2xdNS2iY4csQ/wBBCASpWkncAE2nYJ1Hb6++OoTEC3VOLbCmg2rpLKleYOoApCkigKs2f54Y8EiNYWGwEq93NGz4eiwWspYiTYzi1ic1YdeC+y77AcVXJu8LXXNbKFtNlLaDxQI474vShmZISmMlxK1BQUgnUBudCE96rSN++IuNpZZaQlC1OqtTgKSna6G/t/rgW04AJtPOcC8QSJKuZjwV5Q4468+zMbW2lhDbKS05ZWVa3LsUAmhSr+MSVBBW3TrL61uX0W00LPKNf032sffHYs9MaHLQiBDWmU30XS4gOLapYWVNH9w7VfteKFBBjKcR021JKyhCU2pQ2O4PYC6PxjQwPkxcIHDKLFVKfkqTHjpIOg/hgJuyTsd/fb9MXlh4viO0ylSgkr0O+mzXqABO+4NV7YuRm8o+HVZL5WItHmvMJf6AL4JRpKdfOjvXvvgfLZrkSa0+w8+y83oW04hRC0ujgg9seLCBAN16mbw6yvGazNbL5lvhcZIajutr0qQRZ323/MRgmWw7CySOH4TrbmZpS+y8/oPUQFLSVoPIBIIP073itMWErL5jkhlzzi2Q5GcaP4RtyyV3xsCAB774GzCGthxkrbWyFth1KHFA+he4IvtXvgqbYbAtznmtJdM6qxzzTEtMdLwJJDZdVVaruwoXdX9QMTbjvKDjLjxa9C21HgP6Dtvwd659sCrdrLEa1PB1sqDYqkBBrcV+/wA3fasVhUxLK2WlrWy0OpSTYABIu/a1fxws9iSV6c2miYLzWQ1mELM4zURLsdhLKQY7dKKUVakVSib72TziljLc0mxpDsaG7JRDj9R/y6LSw1YBLhHG9c++OSjlkaShURyVJZLSFBTyA0tC+4oEgjbY/OCJuZKabUyzJeaQ40GlUChRZJvQutlgfxv4wQYS0vH+jueeMeq8wgdk6IrKMhlyP2eEJaQZF6FvvIbbq+5X+UfUb9sRZccRJlS2YuXBVKK2wkFtvXY0BC9iRvQ3o79sWZfmGb5izFguTOpFYQ4Gy89oTWnWUWT/AMtAfpzhKiSA06ypS/UrWlW9kmqBH2xcwshomSib2R2t0a6G2GCgsJUQDoWmisnhJI9qxpfBeW+F88y/MjnuYryxUGEVRCw2VmQq/wB8n5445xl4rK5X4aNQfW+A2Gu5O1D3vYDfDCRGXDadit+bRHbIttwDdZrkdj6O/thz8M6tTLSctttdfv8AdGyuGPDi2QCl6UstEOJMd1tsj0rRfIo7Dmqvn2wU5DzjI22lOqnZYh9CZbCV6mw6En8NwDvvdHtip1905SMu9HSZfLwKBZsijv8AQYjIMl2Ox5t5xaEJW20Fgq6YBvQPbc9uLw00mtidUlji4mLI/N5snOpSZ+evPvTZDnWflOK1uuA1RJPODsmZ6Ljar68EuDW2F9NbiELO663soJGv5rAzkMsSEn9oMS+mgFGhVt7i6F1uCSDtV4b5Y6hUZtbjVMltYbsGisWSi/uMYX9mBYbK1uENR0OQudtPLbYejMtx4j6Vltkr1LQL2uwL2rfvXwcWQYKnHEyJby3FOL4KwCP12H14wPlCdM0Oupi6AfyFwaNqJ2J7/wATtj0+dnSPHGbuSosGBlS8uhFX4biAHW0bGtxZJNUN6w2hiz2Yb2Tudlx8VTFIlgPamOs/wLExoy/MPqZjMMJuyFva6A7BZ77H63jWZplkWLJZkxcum5fEfYQ8zHkvIU4sHbWNHYrBo+3vWFnk5P7OGZpZZDYcDQWCQ3YF7fQVf1wZDkSZ4S/JeecbcXR17azwf98YuESCHaWIXHrOqP7Jbc30RE+N5wqkNPKCUEkNIFIbOvhA4PYmqq8ByAlnruSUaw4CgdU6ygAgEEXsOf6Y0TDPUjdZC6SD2Rsa+P6YXSG0PyEuNinVglzqIon7Yx2UWA5oipU3EdowD+eeW+yz5hPSPNzG2W+i0gFxDrgvc0CizZ+gvbA86Sh556bKjNLkrXqtDelr20BA4FVRHvh2vTFcceKVsPo3bpF0AP8An99/1wP5pKojSGUBTR0IXaxR0Xt77Wd/n4GMqO7UdffwuibUFNkA+XN0vypqM4565hiKR623dBcXYBoAD3IA+/GIIgsrzQoZ6YLoOzjg9G1m18HfXz9MGyHoruZI/vToZDQFuN/4aiLKABvV7A7c374BckvrbfjhhhkuAg2gfAJBJ2NDn6++GNmefhAcTfKdud65HiIAZkuOoWemVshj/gHXRQ4FirAPAurwfmcEuw9cWQ2N1gudYI/cPAO9VeABmqGoEWOtlaOk8Te6yVroHftYA++JpUqU4pCPx2NkttuUDzsFjmvnfDKRDSd1dSxebsxAKx7hdhyhGQ+FNLYWlYQ4EijuQSdr2uv9cLW3yHY8mjKYbJbQHHNCen2BA/ILJPOC/EZjs5q5HfiLZLS76KVELA3tBsfO19hWL/FHiSbmyWIAc0xGI7bMaMw5aEN0SAdgVqs8nccb44uJrB1U5Tp+V0qYZkHfz6oCS5HQ0yWNCnmytL7JstGl7Uq97/3zjR+EvFLmS6gmHCmiShxlyPObKozdikLSfcWa9sZNvV0gXQtX4iRRWBZs8bbHYfxw4LU2ZlL77bU9/wAk+FOoCApDCCAi1rG4JXoA7H64KgQ4ZQtqU2v/ANbKqRIS8w1GdcLIWUOL9G3sa33r2+uBHHFR6agP2h9v1kI0bHlv6Gh9cXeJ5mYpMeDPcfuNHDbHUa6ZDa/XVHerUcE+HXIPRWHMyTEWiumgwi4t0H89r/coe3OHsrCo3KRzh4LpVRhY6B+1PJIaJLRbkPsMMJeGltygQT+/o5Xt29thvWH+WBPUVpR5hDTi0h3/AAwChfoWPYbd+PrjO5VDEh99uM5GZaKCQqUQCR/kB5K/YDc43K8pzlnw014gEZpGUsPCID0wDrRuUEDerJ+O+NZUIfJMA6Dv8UDn5hlAuOnTw09UJl8kRc4Zlw4qH2UEgxX70OFYokrH6/WsGGe8w0EM9Ml/QXHVotYIvYH2s73zgqBHh5uwlDSWHHnvX0m7Ba27EbWf8m9fGHuTeFsxzJbmYutfi2WtC9AOsCht7V/HHq3xGlTEuMdduffzsg4OrUOXU7fke/f1EygmZkZ51tl+U4tlCA2hxsDqL22AH1O++w98Nsqhx5cNhrrM6AdTiEIohY25HN9h9MEseDnIiXczzAr/AAw4IzdHdffX+vb3wOHUtaRHSWUsALNbb+99hfAOJsH8RpYkZRo3e2v96jyW1MC6mCTqfHrp4R36RBRbmhuO10X20NtuOAth/W4TQJXXYH39wcFT0sDJE5t1FvKdeLEVcdYC0OAaytxBN0AbO2/vhRkmZNMzx5uAy/Ddk63g8sIDjf15QCb3FYTyM2gyX5ahl8/Lo0kksaD1ELCAQ2dxZRZPsdwPnAO+JPOVgnxHSeka+Xig/wCOlfMR3+MfTv13hGnPmdD7kVksxNdUF6yQF7es7g2LvnDBrP8Aw3G8N5zAzTLzInLWjy0pZI6QN8/fe++M34cyWdnOfsZVDSxH6pta3XOmgo5Bc5obgWfpgUwZjhziMzIis6HG0Li9baQ5rIBbB2OjmydhvhWNfRqnI8mbHfyv+4XR+HVK2GipSAvb7881mZcqSZL7KX5EUuUHAs6EOArFX7jcHGcZkI0vvtxytTG7iwANtYF/xHvjRZzGjNzS8pgF5A6b+sfhggkGrvY/02wFNgwVQYsWMyzHJcJLzr+x2AJ7gUQd/n4xfhn6CmRA5y69iHZxmeJJ6IleWMZxHVOydxUiNChIlTy4tEdzqcONpv8AMRY47HjAcHzCqUWy8mynpNI6mwQVkV7dyfvgVvKxFlrbCXFstH8ZxtAcpIPII2O9V9uMNvDWWzcxmIkS5ZyphetDMx09JokIJKCR3KLH3A74KnSc4l5IJ59CjpVAwCdAi2JKmsgdhtTh0VpPUaQVlDpQvWPgi9x9PpiiZO/abrbKnUMKQzuha6DgCLoLP7/sPc/bFsfK4gyEuu5i45P82WXoaGyW0NchesH32oYmctUy42GY/wCOHLpxG5+D352I4rAMewNNoPhe3OqZihlIMzK0T+fLzHJsujwY0CApqIWxIjMlD77hBR+K4eNrvt+uDfCuWnpNICHCloUEFII/ITV770T3rfjbCzwxEmSgib5cMxhJDIkto9DDqzZOgbnYGhwMajK4CW5wabWXILpIBOxRXKLO231xjHMYA2evP6uVjWHENLhradExMFIygFmAAp1a20LQsErqjW3O39a74YZcxMjra1QADr6ocWzWukAEXwQLG3ucCT83S1DOWOuuJZGhxxAojWjYI187C9/njHUZnlYgPLIkCYhfVQ2jdpCPY3ySa4/nias6G9x+652AwzmOOZqe6nI0KXEnMLDJKElpextGwQTyKJOMvIgrDUuZcdjywQ3XXAccrbWgc3xt2wQ1nUbM40tMhT+l1HTbdaGxcHv/AFPPfCNBLkcQkS33yhsaFn1rbq6NDcj9ObxyWVHMPZFjvO/hzzX19JoywTcLjj4W1HekOLeMZYWhtdUN7+9/6/GKXJ8lqBLjB/TwCDfUJWbJ0HbY99jvgCYvy51x2aojX1d7H0AHtz3vHzubSG40WKPKhxDa9bnR0dM61iuoASRVG97v4xPUqgOzGyqNNzzlajsvlvNI89obAWysLjoB/CWTTaws2b217fTbGryKdL6qY0mfLcbb1iM1r16HHDve+1nn5xkG4rMZhMp9sB8i0FqSCED/ACFA4PBv6YqbzSfl+pTDDbzjpAIJFgDcfI+2IGV85iSeh35snvw4ptk9VZ/bRk7UZ0ZoVoZDj3RlhCisgjYkX3IF7d9rOPOIbUlqM8aIYW4tuu60Ve9fFY9WzFBl5VL/AGplocZRQW0LAB3rfsQSKv6G8YfNMsaiQ0xmpKFhB1FkIIcCNq1mqI3IFexwyq9zKWQi6RTptfVzEpEgN+nRGILnbXQNHeu/t/HAuXOAR3eo+vStery7W9rFiz8bnjB5KZi2hLk9NCUhrWGyvpougSPYD23+N8DSIaILrrqHacJCkOt7H4WPa/6++JJaSSRb9c81Q5xBACay87Zef6zOVxYvVjBpCGSsgbUOTuR7/reC8qOVSvEcHMPEENYycuOGWjKnKX00AWUC/wAOtt+9nGfh9RORTFoZglCpDSuq9ZdVV+hFGiDdrHwN8DZlPbnSVOsMpi9Sy8yldNgE2htCOaHyTzvhhDg8EnTnJ6Qp3tDhlKZuDLUMTlvrnsPtrUIgdQNBog0skg3oN7cmuxxzI53WZzKGMpiSpMttCES3niDHOv8AOjerPG/vhbKejTYrq3pTvmgtCempC3XHKbO+vsNe1fPxi6HkxkSUwm8vmKmHX1mlFKNCgiwAT35JB7VW+BJa17n7eXTvHPoQqHLkVUZbzywgRhsdJARZJHYnDGW2zFRHW6iOXSA9rD9/nFhtYH5CKN97NdsUxWY0WOXYktySpbZCtCC0Bv8APIqvb2wbl2Q5rmGattQYzaJfTM5kySGg40ga+ojqUFg1t71hRLdB9eQjqVCBmJSyRoOYiQIzCHFuAiM2khG+4A34xCS7+M6WloaSSHUoQs6G+4A37cb3gtmS95BUB1euO+8JJabbCytYB3FbggE/7GLs3L2WrdgPONqW2vf8ZBCFrAJJIG4qvoRh7tROqyjjT/gqrMlZU9PeEES5YILpefWAtRr1rWB82aBPPOA2VMeSWGIy1Oii4sLv0Cwdq2F0cArcbU20g0aX6qTeGGe5guQ3Cy9pbj7cBBZjWsaOmVlZAHySe5x5jGkzHPP9/dFXxBbT1tzmyqnSYzdsoX0wQErBOv1gdjW2/bt84k7FRGKkFbawCgW28TuQTr43G29YBmOSYDiozgej7oUQoD84339jfbF0/wARSpcaHHeEVxEVtY1JZFuWvWdZ/f349uMUNbE5hBGgv78K4z8QT2RcFdlz0OyW3DEbjpCEBwUXAtwcuUe59htigqQpT8wMJ6YX6SiPTYWTsPYbXtvxiwNqhTHPPsr67DiFONOCgUc0aNix7YG/akoRHYqFqbjrWVlvkd+/vvgHEvEg85+0lhAkFEzMtlpyuJPmRX4+WyOu5FeS3s9Xp2s8axoJ7fPGAIKFiRTcaO8pTKwlMoUEp0HcGxv7H3rEpTLkdCFulYNHp2vhYXv/AEPYHEXldVa0MoRvsHErPrG5O55/6Y1rXOEDXkd68XhETJmVvGYtiAuMX12wELtDSK2b0m7Hzd4qlS0vCMGMvYaUw8XLVqJWDvRBNaBX8dzikpb8kS/12nCCWyB6FjbauR7k4it5CoVul4uorpuJXsBft9ucMDmi/PusAJiV90lom9ORHbS45+Rsg/vGxX8vocWQJBiZoJj0SM8pmShzyrrQLLtKNpIG1dsEPZzOdgJyt/NGpcVyQiQ6hxu/WhsNo9dayAjbSNtuMLAvqFKksjpJI6gbsWOPtf8APGOBJh26MOEIvO3o0vMpk6NEiw2nZKyiIyVluOg70nXvQut/bFQUX3EPpX1FtpRq6rZVqI7d7AH8MQYYW/1nIqWz0kBRDiwCvfsCfUdxsP0xHqPBamCvQ4pzhPCT3qsaGw0ADgXhc33VkxhwBtenU3qUlDib0vUTZTY445wb4UzN/I8zj51BcY83Gc1sJebDqL7FSTsfv+mA5TLKc1LMFbik2OmpwgKs17H3wS1piOUl/prK+mSEXQ7q3+p2/jj2ctcIOiVWIjKd1dJnF/NVTWowQha+r0zTgIs7cDbcj27YLjusuuOrWlBkOkJZc31tmtjQNDfb47cYh4lzJU3M3n24sCOzHitRgIscNBxCAAHCAT6zQJ35wCXGIzjS25PUcaWSC2QRdgj22/rhQJd/rXdL7Q/ym/hCY9lWa+ciTFsS22llktsB46+CCk2KqyT7C8LusP8Azlf/ACxgPqusuqU0tTTtlJGshe+21e+LfM5n/wC9n/52HNxBpjLMQlHDucZiUXMiwjHcR1cwcUUtuxlmKG26P+KV7k0DwRsd+MG5FJPh/NiEeRlodIacafIVGcSFV+KNjX7w44Bo4WTXXVss9QKCg2NFEkFJ4O/cm7rbEDLV5YIRr1oGyauv85+nxjsChI7l0pbPaMoyFlc+eZrrbToaQoB18ODpNBxYGpw8BBPfjAT/AF0RExuihRjvqV5gLJSQdND2ra75N4ubWppt1TQX+OdLdLND7VuMNJ7issW40wthYcYaVpcbDmhfNUb0EHaj8/TDqGGbUYC6QUuq4NfCWtMxXWWJCwwpf4ltNLKVk87/AK7VzX3xEJMtKENBelKAyCjaxyAfvfPxgmO/BSsPT0OPladS22k9KiQe/wBa7UcSYmq6biD0mw4vUEAbe/6Y6dCg10SPVA6o0WTDN8rhMw4Qyt1qW67H6TzSWlhSHQugrSutyK44398LXYEptkspSVttayt3SulDjQdtt9u3OGsXN6dckqQVvKc1LLiyQ4du43/2MUynytpxpcoMpWg9QFZAPfb5JHfFD8O1zZO35ULq4aco2SbK8ucfkeXLlJIO4UBW2/P8rF4qfguMJdccQ806hYDaUtnm+5vavb/TDLNJnRYZQhi1pB6hULCz2PFjatvn5wJBzFwx3UOJZC7CkuOosoIN0Pa+MTVMNRnoedUxj6kCdFbl6JMWRElx2FyX2l+aIW2VAlJu1j/KKv7nA2d5nMzObKkS0thcherQ0hDbd3eyRwNzsPfBrsx4w9Ud5fVWjpmuNJG497wn0lC1BxJbdr0FHY4GpgwGAs3RMcDr9UyyzLHs/wA5ZyPw9GfW7Ok6YsZ5aNjR5XsL59sAOsPMvLhvpVraXpI1X0ze427k4aZdGdZQ+gOSozD7Oko2srG4v41j64FeZ8sNby3HkBy7b2H8ff3xCMDVbfQe46/hOFZgMA33UZkdDSmXCpE9DzNoW06fwrNIQoVsoUdu94FkOh0uddxby0gNtq2oAXx8cYm28oNOIW4rpqHHvV1Y9+94hBdkRW3HGwdOyXfRqBBN0bG35cTnDmA256pnzPJERX9LilAEa3PQWiEhPFHRx7YKS1AbdJkNBehZ1lLh6ZITWxAu9W+23b5wLKnvSGDDaZjtx1yC/wBFDQSAsitid6rtdDH0VUrzKHWEkLDiQhbApYI7gDv84pfVZTbMRHP6vMBe6NUTDkiGtCkqUXUqUUrXQCdqFC+d7+MG52rLpMeRLydKokdtKECPLe6jz9mrQQAF0ee4vCFGla3kvKBLaNyyASed7/TGkyXwlnTvhfMPFUSJ14UFLaVuawQ2tZqxuLIPdN0ecSHHBxDmmBp6lOaxx7AE/VLcsVDUem48WFAEPJ6ZXdA1XtZ2+OfjGr8H5HH8RZhlvh9kwkOyZYV5hx0pcAO3T32+du5+2EceO2w8F5rJjsrdihbHSAeDm1I/IaHFG9xzi3w3OZg5i7KKVrdToMUJtCNdiya3qtYx1JGQdqZ05Pr1UTnuaTFueC3njr+zdHhXxC5lUnMY5aQ4NXlVi6IO9H4H8cUwc4/Y3g6dkKcviTok+SVxZjm7jQQeUDtdD9fjCzPJ+ZDMHm5jq2XULIeWs66NE0D7fJwNlzOt9K3UrMdtOooQ5QF77c3wO3sMLq4Rr6YD7mx8xun4T4tUaOye5VT2WWklbL7VPsD1IZPUQa/IrsPWPzg/zIwZ4YgtyluuPLCpHRBQ4RdrC7O307YHzSI1Fzd9qJLffy5whyyT61gcECu5XR7Yb+DWwvrNx4yXHVgHUUXtvt99/wCFYuY9gZd1xzwXFxNXM8TabpnEjzHY7wekLCNZUtpadSCuxdgbbbfywbGBiNiMym3XBQtF3Y9uRePUvCn9mipfh5JdeW3/AMRtFbo9xeM3O8NvZbNeWdHUQPwwEXo+b5v2rHPp/GqVVxYPxPerj8GqtY2oJM98xzTpCWNtMyWEiLE6bgc1dMrJW5sBRXxzdChzzimAz1Zq0ylgpXuHAsgt+6AADZ7b4dRY6nS4lx3WLslf+/vgpeWJbKo7ei2gV7GtgOQDv3xW6rJHTxS34d2Wx9lkZMVTUQvraWGVrWhFC6A+eP0xnIWWNuCR+z4o1WuS8EtgrOnle/O1kgfXHp2YykjKm4K2nnGm21qQ2VnQhw8rQK70PrjITYhzBtrNPLuNiXYbC2SgE72Pgj4+uMOKomqGVYDtp5qoXYWtkzMMga2WTlxelIdYPTIQKX03g4gg/IO/fHDG8xJcZyzrPofOlArWsgHYdu+NJA8LLaLrjiJCQhZCw2m6RdED29vrWFsuDJZ6imoThZNs2VVQ3IB9z3xW7tCxnlvfyuuayzwHCPBLY8BE+E431GT021qe1r0EgHgjYFe5qr4+MW5iz0o7Sj1GwHjaAgIGih3/AE/h845Gy5oOiKUtrC0FxlBQVod4pA72bO2K87nuScxS4/OfejIS2ylbjdGhwK7b7fTAsPaJMffr9/NWhr22Fv3038UheyJvxP4r/Z+RxZzjq0/lCNQTSPxF3uemDv3NfbGedYkKd6IiLcU+502ntCr1XsG+Pavv8Y03h3xHm/hmQ1nkKetqYI0limjpWArvffde4/7jO5rrkSULL6i++tLwGs6Bq2oA72FXviCoxu5v9df1yI+gov7MAW57KGZQZeXQWG3otsSGVPRlu2QofkcIHvrQfoRgJp5bDchpD0hrqNJJCSfxDYO+/H+mGEl0OSnpDxcXIU33SGtC7F0BsN77YJb0qylcURm1uballZtujWijfOwsVX800XZACBf6X5PVFVc1zjGnOd2i5mGUPyvEMiE0y/5k6G0NFwvPvuKHNpu7522IxRHUymYpt1lxCELbDhTay0hB9ex7/oMGvvGM0nN358yLnMZxDbbIQtpZKUlIcDlbFvQARySdu+AHHHZzkySw/wBFmgVh10a3EDkAnck3x9cOz5XaX32SjLphMPDE6Dk3idmUmHHzOG2tYLUlNB0GwCRR2Gy9xyMaPJ57DkxJnNPzohWVqjtrWyCs7bLBIRW36nGd/aj2aLgQ0RorTcKIWmS0yEOdPWV04R/iE3RJGNNk8mO5l6bRE1Ma1Bp1BCFgjY1fPYfIGGUiXiHNjz5wqas4UjLFvfAWSRGluRnmlx80jygpYXbfTQKu0f57O3tXe8fpzwj4Uy1EVUzohbr9FxbnehWw7HH5Q8P5mtWYQ0qkuNq1/jEuFZc49Yv/AK8Y/UPhnxaxEgMxnHG+sUWvXzj4r/8AkGQ1mPqXaOk6rtfD3HK5rDc3udkR44yBDkN1ll0dAjdkr0A/Ud+2Pz/4phNRn1M/gAoXZrex7UOR3x7d418VxHWCyh5sSls6kexHtfY/9MeA+MJ63pr7TaVhDX53CjZA7FY5vDPgJ+S54aCAbxy/4QfEsQPlhup55ee6xfiXxBJypwRmxohyVk6G0AEE7FBJ3447bnHTOZdD3kHWERWn2yGluEuoQQbC1oH5LG596xPPJEN7+8dR9yatBEsFsLQaXtXxsPvjMLL0cutSFv6nNyEbA2Ntax9jR5rti/C069PEOdUMg6Dv9lEPlVqQIbEank+i1AzRvLJrC8vz2U+G4qCJRRocY29bYAPrANgXsedsZ3MM0UtqNbbjMSjoXo9bm5Fgf8Q2CPji8BOS5OXHrRniiQgGnWllJO3H3s73jPoizy4y4lJQQoBHUWAN9xV9tueMdlogg2MftBh8uW6MzzN5M+MI4eQQ0NDSQVlWmx+GPYAkn9caHwF4hY8J+Kn1HJGJjaoLkdcZxaX7cLXKDRHO9b1xeMYlMforUl/W8oELaUhY3vY2Nj/DEYyGUZe4+t1KVtn8NsOHXq+nYfPxXfAHK5pBFjY85+bQTTu03+nAmAzh9UpRhqMFt9ksvpAO49jW5BIG3vipLzjEduQ+l1BU9dOJPrH79b7VsPm/jA8liQ++rVEV1NQdtN2kGibP35J2xFLaG5DLwaW8hHrWhatR+9dvp/DG06+V1ufX11Wua8i60/h1Co87rSWygBQSjqt2Vgi7I5/JXFcjEvFc58Fx5L5ElaiXARuEHuCcLsqmTVzVSmJUR51fUdcbUCNBXtf1F3QPbGwkL8PteEJOUZvlQfz9MzrJna9RdvboFA2COTf05xJjq7qohoI7/wAIfnBgbN4PNedyq8IvrdbbQwl+WA4ttFggj0cBHIuz+mPQsvzLMm8kYypeYuPRWPxm0IQPwHCN6vuBQ9rGM9kkDPIXg/NPFcaHLkOtTWmlyyC51CRRQTe6wdFWN998fHxa69nrfnlRXnpFOGQ0vQ2smgQSAKruO1nCqNWaF7kWN+FOpUWVat7eSalzry2oxQvrMM6YwKEbjfsOT3vfEZhZHl+ohBCAVONkkdXtf/b2xIrhxs3lOR2I8hbSFtoktr9Fg8oIO45r9cIc7mzZk9rLWpzl9QIWhs7973O3z9zgRi3Ccw38ojr97rH4doHYM6fXZHy32mogXGZQwnWVFBG679x7CjgOWl5lhMmW042V0sAgoJQeN+/vXfDDxfEzLJ5g8N5uiE3IhOdQlIQta9aAQC4ORwfjf3wrzPMFuwG2prpfcDhp4tkrAoUCsncAAgDaud8T/P8AmMBDpHOuytp5WOuF9PEgMMdR95tqS2acF2fWRYHPasCeFOs1mISEMTVLZJcbKyvoAWga0Dj3G5/pgKfmiCjQ0OmARoJJ9C9gCD9rrDRHRittSSqw6HERl3drCxdk3Q3Ow3vc451ZrniQeSqRiWsJW48P+Fok/KMyzSdPYZ8o3bcNayFuFf5CjuaO+M7IZjDMfUG2HjQQTQJRxxximTngbabMh1t5wgNmiVuorYbEgew54GMH4kffOejM9bL7LKGtIjrLqKIs9T6bg1wdvnCmh9Ay25QVMQK1zbnJXpSIsx7I5suI9IehIcbbcogAukEgaOT3/T3xm80gILrazYc3Qton1gDe/wBf64AhZmynL2YbOYPmWZBLiFoBDZrYA/nu9iOK0exxbNzNOVzW3JC48uRGWu2nQFtue10dxz/D3xbinmtRECPeJUtCr8pxJMpTMYkoQ1GajemQ4XGS2gdQlFgixvQNc4S/4sZZLiEBgoC0C7PPr/Xb9MMZL0mNm7qsqdla0aHEOLbLayFosEo32329xhASBFVIQt4TEObVQFCySd7uyN6r74kogBmm3RV1KsuCZ5jDjZbCy2dGnxJjzqXHS1r6oaslJDrZFBXHF3z7Y+yvK2ZbkJTbkuI7MZP4jrelpxwLr8MjkDYb98JYqErdCXpJYStCyVqRq3AJqh78X2weJLMaBD6cmO+S24Ho9rK2xe4N7C6vb3w6k0hpdMnytfnj6pD61MPBDYHSTe3VXZmFs5iFoW4mQ2TTyCda1hezn127e2Dhnct1uWvNAjNFTQA87KT60EEkOBY9YXZsnvwbwrm5m/MjR3XHSGo6ERmQ1tVWR99yb9zi+bmaXm1obi9ORJP47TTBZACAPQACQQSLO2xF99lFznON4HVIrVWgZo8kH5zZSWl7o5s7r98TflTswfZckz31qiMBpjzLhPTbQNkIvj4HG+BJeuJmDqJjfTUhZbcbB7DYi98MkJX5VvMnFRX1OuOJLKniXWEAclH+TcUe9HAANYJU3/XmRWRTP2TNXmvTjMpbYd8u3JYEgOLIKNBF87n19tsLEPRm4C2VJYW+tbam3Ss20ASCC3W92D7ivnFkyU6ctktuOul93ptltDaChbSLXzyCDXHbnAU9aHUw3CFx3iwjrEr1WocOCuAQBthwGcyT08Oc2S2Vm5i4BET33mZI1us9R1HV6reyHEH2H69hhaFEG9biHALRo2r5vHZS2S2tYYDesDphtygg3uTe+/8ADFy2Z8tEt915NR22yvzCwhZGyAEA7n7dtzjzm5QHC35Rip8xsInK80Vl+bwM7djNPdN9LgZrpNnRtVj+f+uOzctzvMmnPEGZBP8AeX0J6ji0oU8SVD0dtumRewGJTsuchsOftB1uJPDLTjUF5hba9DgJvcVWil331it8KYj7qJDhaSy91WClZcaCymxRNHg/P3w5r3PhxNvW2/0HIU8RNr6c9UyU5FhTG0uxWsyjLIeUUlaNfpNtgjcAHk1yn2wC26Jf50imwN0C1gcAex3r5wxzvKHGMgy7O1T4rrExS2UsokJW+0GqFqSANCDex74Cy6JOkIc8mw8tDTZW5qUNAF+o17cb9ubx5r80gGbn10jTr+lrmA3NlwMTszmx4jEVx6TIU2wyhtvdZ3A+qyb53xPxKcyiTXcszR5vzEIlrSytBbSaSFAaNuALPuPrgR150OOsF1aGVOa+kyuk6kkgDmgQCrffn5wQtE6DCY8zl5QuSlMiI+tBSS2CtNo90FXfuUVjMuUTF9u7qjyyVVIgOMLZOYuNtpWNepLiVlSfcUeT2+mKIwflSmo7SHHlvFKQlI3URsKAF7f0wSlcZ+OlxMqQrMy6EJDmgNdLp0Nz3B2risQhrebjOdGYwy2+3pfTr3Gggj55AIrC2Ok9pEQBomXiBqVMUzmRiSoeWhkswFynCrqJaNFCV6RqNnj5xNrLsjfyp9MTOpEmaXNXlyx0kmOhGtRKyfz2CAiiODfbFTeYZhmeWxsozHOX1xojLjsRt+QemwDutCAb3WEgDjesLKjvnqUiK1rIWEKK3Anbsfbf2xUHvfJqC5Ot+adyCACA1MMpfgMozOYibOYWtXSZZFFT7JvqBbnY1p4G/wAYDegLhIiPPoUtMlpTif8AKDdCiD22J/TAylJRIUllY0flDi0aSB70CaNDBLCFSZCXULQEx20qWVk7gECz78/oMPNNpaGxeLR6m3gvNmSVzT5DMHeqhqSGlLQtGsppe4BHegaP23xS+dm0J0G/xTpNkfBOCGmIk+HKeclssSY/TS2wGlkyAVEFWvcJIsc1eDMnTCgPSlSiyt6MvpriiS4EzGzYWjW32FXdgEe+Jm0cwkBeDmg3XM3W1FzzzMGDLYhiQFtMTVgvKTQWNe1G7u6rfEMriTc1EtEaKZTvTL/TQgKUltqyvtroIvjsN+MDuyHZyTJzGSp9ZRoLy1a3Nk6UhRO9ACh9Bjr5dyZ99mLMCy6ktLLa1DWjvtQNHavjBObIhunr4Tp9VodF3KMRt+U+I6Yrr6223HG0s1rAAvc72ABxgDpO/wDkOf8AyzjVMpypxtxb+bTYmvpiM84hB0gXSilHr4RpsdyL2wk/bOe//hzMP/rT/rjwyAQShN7lHeGHY0ef/eluIZcbVr0IRq49NXxv7b4HzHoAJXEfBSn0AArs7fnN7C/b4xKADHZmPMykNr0aNBGouNr2VW3tve2JS3PNttN9ONGcYYbaCWmSC7v+ZX/Pvue+2PqsnYDS1KuSFKcXnXVKcWjqgJKw2jp6KHAGw79hi2LJTCzJiSYrUy0KK25bWtBuwTQO9XY+cH5NPjLD0aXFQ/IfcQsuulSlgi7rfvtY+NsdzZCHJS/JPbdMFCUp3FgGviyef9cVU6WVpbET3/Tngsc3OQHacskzrqGM1W5GZLLQWstouykbijffBkt5tpaECeJra2Ww4puz0hQ/DGsb0aHtttgB0uMqWwtLWnSW1q06635+D2xd125C3JMtb/RAKQtLSSVKr0JVuL4HHGJH1spjdeLJbJ0TXyshvJPNtMMSMv8AMojrJ9DgWPXRANgEEi+D9Rg/J4UnxJnEaLAhOPSpLgCW2wVEDit+frjOPrmqCjIU4vQhA9SgFkCgiwdzVjGi8I+KYmRsvzWE5ijxC082uC7EWlLCQPzlYqyfbtucPGIIEjXT8fvuU1ek8thoQsvK5uS51IhylGK6glC2nkXx2IPyAd8I32JL75UtxRJIJIBAI9xX3w1zvxDJzrNpMqaQ55lwLfdctS0m7JB7exwGzJ0xlLEhDBR60Bwk9RQOwA+/fbnDnsp4ikQ/zhbRFVrBJk/RNYOQvCOyxFWVlbOpzSFgoXZJBsb0gDcbY5mGXv5cyetGLCgvpaJApS6PseBvgzwtmLc19YlHqPr3S02nSLPe+BRrb5wT4laS4+DakuC1lbhJv4+uHUqJpMFJp7IUL69RtUZhB6ocR25zxkaW4qATTDRW4gEi+SSbJBOKJsB6UgobaHTbbv18Wdrv64vZakw4fXmdMGQSemysHe+Cex4+2CoQfcjtefSEaV+t5vYf/HXc4NrOzpz+LwLqlTNv3LPz/PqiQ4i24y0R1rLKUoAW2VrBOo9xsOSQL2wnfS+y44hZrUSFpB9Bo8/xvGnkRJDsgvNKccIVuuh6wV7UOT9MBzoMZMCe9PelienpiIgVoPrIXqvegOPnAuwbGjOPRdJrnlt0lYjqckNocDLi0khaVOUFAC6v/TBuWwlSJEHLokuS1KlP9F1JbCUJNgIKVAkr+RQ/jiWTRZ7zycmgsDrZgAhdOJHVo6wCV7DcA8jtiiAr8ZoFpi9drLi6SB7fw+uOHUoDEMdTPZd6+HN1VdpDtRKFRlT6XZiJKkRnYiVdZtxdGwrTt7mzi1bvkZLkAOIfaKylelxaWl9gscGu++IskkF06EJoo9V1ve1Yi6tbCgY+l3QoKDxRqIABob8D4/0wtmANFhaNufxb84RIEHnCrocVbbDMlxwNtO69DgN69HI70bqtu+Hnh9tHSSy40y4hD4e9CPxDtRAPtXY98I8pQ05KZS6fzjel8f6Y9O8KxG2YzMlEVh4Mr1qpApY39CwRudvpRxY1jW0w95UtXNUf8puqaZdBhQpmYOZYX32g5/dJLq9Cw1RBQUCxZBI+O3OCIGQsuNKWF6CtkLCNwFjsRg+QqLAbenyXXHOpoDaEbrcJ717e5+mNdkUaJJhuSZUNHWWdRkUbQN/R7b2cQVMfSDixpkgX155KzC/Caghz9zqvN3cnYD7TjustDWF/gncC+ACCRizwNGjLkB9DqI7regrbR+cG9ueBXtePSczzmBFiPQ2YLDjbjJWS42L1gChufpxjJ5Gt53MWUdGOWVkrXoRuN6ogdvjCmYh9Zji9sdObd6nx/wAOZSqMyOnqOar23w34jQ1kryGw48GEWRuXFk77Yyueq8/Idkl0h2qQ24uh37du+KWMwTAQlZ0FI2LZF9Q8VXtjO5pmDTqyttpfSC66jqKuua9+RjhYH4dVpV5LpA0X0hxjDTDSL7+i0eWRoHU0vBh6ia3P6fzwdIyeI8tUluQNRtaN6P6m8ZnLPEEB51XlnlvBsIbeHTo9Stx/1xol+JYbTGh1jtuUAUO/bHdcajxNI2UbWUJioAgXciklrpBZJu6J/OSeR7YSZ20pH9zGrqFIGhzbpk7b3wO98Y3GTz8uXHC3prKFLR1ASNBKDxscE5x4fheIssAWakAaEOtLo6P8n0Pscebjcrg5/wBEmv8ADw8RRvbSy8tysqiuPLmSUEuILY0LIA9d7Abcj6YWZgy07Na8y704pWOs7+cke9Xi/wAWNzMjzBUOX1m3G6bQHbNC7sD2r+ZwpQ6h2Wy+41TrjdIJFbH+m2O9Ta4sD2b/AEXx1epSp1Sx23Xr3qnPMlhxMxlIyl516J1LiyHEdLqIG4XR7/TCiFlOYTXPIwI/mXXHilbJUSJAR66cN1ooE9jeNohUNxgtypEtIDBLaGnAsIXXfXsON67VjNTGmmmD5V0qbdQjWjWdzyDXHHv7nDWgkZJv379/kUD6oa6W+23dz0K8/wA/yvNorLGYuREyIE0vCK50Shi+FgcUsbGt6wq/Z+Yx4isyaUEIZW0lTjCwQhTmogX2Ox2HtjbP5TmWZ5K4w6vNZcWJrcZj7qaYs+sgfPzjGvZetyamLHhvIRIWhLbTQLlr2r5PPHOJTh3OJDoBBPptv0iV16OLpPAbT2iZ91Vm8+VL6JkSVqjtthtSU7lO5Xov9/dZO/vinLiF9Ult5agmmltL0/iFQq7B1bA7bHv2wwEPQFxQwtHUUF63QXFBtJ3RQF/n2sVfGIPtxjBaLOrqrWC2jTSAg337myfsOcHTwotsm1KjTJCIkKgvQZULMWFrzhMoLTJS8WwhsJOtoN8WTRv4OF3lmVREqDDmsr6fU3oCuAPfv9saDwjlgmQ81C2MtfXGbacJkTOg4kF0IPTNgEm6PNDfA0lLMqfLVFS5FjoctloudQoRewK63r3rHvksMgbfjfdIdVM6qzw47AjZoHXoqXoqwsohyVLAPo9HqRRJv7YaSHHnAifGlBLK5LjbCHZKPMABAIC0X6EAGgeMLklucmPlMCIuXMKDobdAaA0DWfWTR2C9jXArfALIZQhptkWktoDjbiNO6+RrBJIAr2+mJHv/APXIx2mvX9IoOXM4L0v+z7LIr8J3OJc2NERHYW4yl9wtmSQR+GCP39++21e+HczxG6y6lxmQ8+4+G1nn132qhuLrbHmzs5lERUQKldQtocWCbWSARoCwfyAVXf8ATGt8NxIjuWSJvmGJZsBltC1odQBSy7o7NEWi/wDPX1xBUpB9Q5xrEd395tNQqfLYA0X374+kA+s6xY7NcznqcSt9wxx1ykV6qF7g+3f9MNWM0ymNkWasZtDXLlyIoTEcccKC3ZsLI7/TCvxC9BlPyJEKCiCw4v8ADihRc6Q4As7/AHOM3PcDcIIaYS2dZC33F3aL4rgV/XGOwVNzYPdvBB5r1SaeIqB+cRpGnXryFRmkWPHZivhxx5YvrLCwWjwQEEUdgd+11RwrzFTpnqjSoHkHuo2300o6SEEI2sdiRvZPucN5MduT4ezGXEU/P8s+CZx9FBaB6Ft8i1gnXZ47XhDEYbnsuyVrcc8sUW0dgG1kjb71+vtgnP7cGBz6+6JpZ8vs39FSIzLzazLZmvO69Y6ddNDWje735IN8VhJn8x6Q42kQkx40UJYQGhaSQN++5/6Y1GauNCIVuJW4qg0yhZoNgfuH4rtjNZy0lU194ohNs6G0BEIkNKJbBod72s9rsYF4c6HDW4T2tFI5dv0gkRS02zJbYKo7moJdKdnCB6wL+v2xrvDGX5j4nzeOiMvKob3ULgmTShKeohF24SK3AoAiia7nC3K40NEGJ1PLI/GBW46gqbQFkDdSPyVROjexZwVNdbCHmVqjzmHCtlt1vYUD6DZ/4Z3IFXubrE01c+UOgR5T1jxThUZkuJP2SaQ+5GkStC0y+m4tX95ZF6tQ9Y7ncfkO364pisw3lKcfWaaUdkJ/x99gBsaN1/H4xtXmModgM5YU9SLAZckrddiesurrZwoPrQNwDY9zjHKiqE9EZjXOcfYDIbDa0lokbDnmhY5HO2GurtYZdYeCJuZ0GJPTnVHZc71JDqgywht0hKEEU20bF0ex4G/vjeZZ4iRnMCJAfRlrL2VMHohEcdd+3L0bC1kDfetgax58rMX+qqm1s1WtpKCdZWKsWd75s++2C4xRbEhFlSD+IhtFb80FnfWN9zfxh+GxFOppcLnYqkXPBfbnNV6h+2pmXeF52RpzZlzJ3fxTHbe1oWbHK++3BHfCtzIcqdzGmGCymNW+srbdsc378cbbYUIZzGIwWHo646ZLAkMtrXSH0XsUE7L78dwcbNsGGRGzV1mU62gIKC51ED0bAL5NAj6VWEvw1BgJYBfmot070dKpiG6+SRuKRlrjCFqe0r4AXsR9u1fzwoaR5nOnIOXwPMK6Dqw0XjZXubRW5IAG3ejizxZn8VclqDGShktWlcgIIcIINoO9LG/56H8MIpeaLl57EGTywvoMhoSFsiOglANLvni7Wvc98cxoJdl1Hdr5d33udlfWltMF1kxL8pCm3Zz5RE6wpbhXoP8Aznv+mA8zzYONhMZoUb3d2Bqt/nvgTLokaZDeTKzZxh5tHUQtQK29AB0I90G6A7b71WJ5NHly5KWY4aK42twMyf8ADNDchB77nBNolzQwm+kc/iSyuM8npzlypZnm+XSUOGBDc0lwFsuKstos7L7X9MPn86ltZblMfRkzjIWuIWWXAXCAQUdUgdy5s4DZqjxjJz4DsR0SHkNtqukNBwEgVd+1f1w2bVlOY5FSkrZkt9QraeVTRSKI0d9fJI+lYnylmZp3Her3Uczg6dPx+1OZKfzTZ6QsBDDZb6oJBRQQgCvYWa9sdy9hDGqTGmFbpWsI0M7exBs7EoN1uRthQc+S246zGZKOmyWxaALPvXYfHbBsOU091BqDJbQtwAubUN9j3J7e+HUGh7pcpMQ0sb2CoZ45SA7E1idrtLigKAojfuT7fO+Ekd5h93VPS++6hZUtK3P/AL4AAtAWODzavp3w8zqU09lT0JlryiHHjIRe+jaigndftVn+eM5DytmXPiNMvCO49Q6sk9JgHezrPb5wyoSXdkC/N1MCIvsjUSZ3lZUuLPTGQ0kJDeslx0E0Ag6bJQOST229sDQXHm3BIEFBVQPT6OtBoEEm7vufr9MNMilqjw3GUsNyC5XTW5/w6s0Cfk/rhh+xZTe+cMrYZLNopzp7kbWCKWLomvthDab4lomL6aX9NVYHsgdq/SfyVl2UxHkOKkPqY6TRLWkKOtdikDsO5s7c4YZGliBLkmS82yUw1sNkRmZAWtdjezXBJ1jcV8DBz7oyfOWJOXzI0hyPvrLCHEA+wQdjwL++IANyZc+dBiPRRGqU2gjq9IWDZcrbc+3cDC7spw0wpXvJeQ66RyS5GU0yxrQpDZQspVqB33WL+O4+uCAiTHQFuIQXiyHU2sAaNwbHcm+Oa33xZLdakzY8hxiysgOfiWVk3Z2xal1wsKghxvoletbhbskA7X3AAvYe+FgnNBSa1WGyCuCGh/K0MxY0ZbsYF7qtBa3XELr0L7Dp0TsO+94gBCcyxkoDqn23D1Oo4NBQa0UALsb2b7jGl8L5ocjlCfkmYT0SGIrjNNoRaytshwVv+HV2vmuN8KJUCKy62rzMpEZ8BTbzjBAKP3yADvR2H0vDm0HTlabcmdbe2ilbVzXKBbKEtSG1OI2P4egWHN655+n8cULjocY1+XsNvesNg3VWTXAFD+GD8uzHyk1M1hZhSGnw624yNkUeUA9xVg++FuaSGpIzAnrLS6sKZcNJI3O6h8gnYd8aynlPa6c/SMOJKWSAHhqaaYsbaEXrI4v2w38L5HnHiHOxkuTMIly5dIShx5tBuiSCVnY0hX+zha240ltSVRGW2nnEhClu0pAB33G9EGrr+WLHosNEpx2PNaZ9S6b0OEpHUAGk/vmjfbj3wGV+UxY7Tf8AvIV7SBCnOMpCUIlB5clWynTIDgWAkAC+2nirrtjjjEN7LGk5cqX5xtpxzNEyHGw0SlRKOnW59Hv3O2AcyYhtSnERHnX4zaylLik6SvnfT2GwxxSus5GXHisx9KQ0NKjTqhyo2eTY9hgiC4AAQI9PJHYG6izIR5Z1l1JUkimxr3QbHq+drFfOGGd5r5yorfVTBiNhuMlKlISKFFZQSd17XRwufQ808uNLjuMrYWdaFI0lB/ykHjf3x9IBISVPtvICAvQg7IJ7V/OseBaO/n45KKAiFmAy4E+YfeJaQtxBZFF0Hdu9X5P+b+GIPuHzEcSW0LZQdXSQvcIJvTe9bfp9cGZLna8uyTN8vTEyx5OZIaZcckx+o6xpXq1NK/4Z7H3wujOMNhwLilYWlQBLhAHNHbmjR+2GMrZhGXTTnmsywLFXWyDHKENIUoLT03W9t9gSSd+ee1YnMgyo8qTCS0l1yPZdS0eqEaBSzttXe+MAspQEKUdZIULpNgDvR98Mei20iPHExxJdb1ulr8RDaVDcgIPNbEH2OCY9pOUi6wtIuoO+cnSWWaLz0hTaGXNGnUkegI7Cth+mKxFkGG+75SWBoQ6VAHRo1EajtxewPGLnopgsmVHfU70JPTbcLZ0kcpPFA7XRJ5wTlkefmSmI682REivAsdWXIIYbSLcCDV0L3Ark4opsc6o3PqfXu590BiCRsgRPlJhyoPWQGX1IW5baSVFAOj1VY59/rxjjbL8z8Ur1ttIUfW6lJCE+oj4529ydsXTH/OupU5GixErUOophFbGuxPx/u8DvNCOtaUuJcQAlQcbUTST29r3+xwFbsv7NwObowAB0lQDTzTfUSspS4Vt679J00TRHPOOSFpdXHbWkNFKQhZDYFC9jtycENzJbUFzL0OtGPIKVlJQglPPBNlPzX3xXEiOPNqLfTKUJJOtwJPa6/wB79t8JJkwN0UWVUjpiO2G1kuaSXNVe5qvtW2L/ADIaaeQhXrkISg16gQObsXv2rH2ZxmsvmSYjbrE5CFUiQ0T01j3SSAaxRIMbyzSW2Fh7RTi1OAi72KQONubv7YE9mxQ5gRITnJshzzMoDmY5VDelqiFRUw0hTighItxekDZCPTd/5xhL5n/+Fj/p/wBcH5Vmk/JHnlZNm0hlUllcd4R1LR1Gjy2viwfbAPUb/wDJg/ocAXZTC9ITBdR2gxTCytAcJTuRY/KT8bbe+IylLcdQ5rAIaSkjXZI4rB8CYhb5iIGpEloNLUllIcUsmwkKN16wBe1i7xW60yxm6oU8PKQhXSXdFxJulkaTRI3qzRx9rnbklIsDG6k2wJDr0uO0pLba9aukha0RwTQskHa6G/viL+ZNry0wJEmUHmklICSnpuK6g2UauqFiydwOMXyA3GL6Izk96M8oiO8k6EyNHGtPxYsfa++LpXh2REjlD/lUyC5pKFOaQdO5Ht9wf444nxKviS5vyxY89lVQpMqTJiOe6By2DJzFalrZeWwEF4rJ9AQDVrXXFmio8ah74paDbzxbaU62yXE6Wh6rXwDVj9cGPyOkiG9Ede8q2oBptxxBKFii5Q4AK6O43FXdYXsK8w660lsOF3SEWPxAbvasVUW1XNLHb6ftIcWAC0RKOZ6kWct/NkyiW1LQgk2XSDS2+pvXJ3F198BEOxglTThQa3P5Sn42713+Tghsvw5HTfjOOx4rtLjyQdKV7agRsO3GOqkrezFSnnG1uuOBQeeAPv8AmO44O/PAxY3DFwyu3jf1QZ5aJKqixH8xceRBhOyFJQVpSyjUUITyTQ4of1xa7DQwl5pKip0eklwadG1ke3/bBuS5zPyuQmTlkpeXOlhxl5cNB1uNEUbs7g++BoXWbc1tFp/RbxbcOoADb1jv9MWUW02iDdLLnucekKXhjQjNUfjEHSDtYA34+2N5nOVR3ktOMzep1iR69hfufjHnebtvZfLbLKVshaEusrUaJbWLurNXjsfMJLrIbDjraFClnkk12H++cHRrh5LGmD9vz1UuIwhNTMdo1TedmEgOsxQR1mySsuprffb7Y1mQIQqO4qSm3TYtHoo6+4O577dsYaBlkwx28ycgOJhuegOaDoJHz840mRzA5NZyoxltvhC9Cybpf0+MMruijnbqOfwdU6g1peGkrUP5Ciashhhul0BRI6dGyRXJ+vvhLLyF5YkdRorSEWsnYtni67ni/a8ei+DiGEdGU6h4f+Y4KF2Bf0weiDl8mU70+j0iTutB47fpib/tqsFxb+a/hdQYOm9uVmv9XjScsnryZuM+wl7LWHnHtTZ9ccnpg2CKpdbC9yPjALPhuSZbbMR7px3numVqu20bHWrbit9tzWPYX/CzzLjq2XClp/8APoFBe53rCRvLUsw4spyIxKit3e2g1rvnuaBA9geMIo4ik0uZnkkkjrH6/qXX+H12tD4IAsenCvN89y/LXGIkXJoi1zGitl6UhS3BLXrJDiG6tHorb74TteTVl6Y6ky1Pdb8VaHQG3Gx8EWCN9/kbYe+NmZcfxM/Pg6o3WcW4jo+ks6yTQqq2PbA+QQ23l6XUIYdcASHHFmm+bBABu9ueMPfh2P8A9A3H98vtMKRrn0bb6JdlsRnzDXSQ8vqLXfsR2r+uPV/D+ZM+QZhltsJaQAhxskEH5HB9jjzXI4rTJWUMNhLi9RK96T8Y32WMpeRFGgoiLvQ822OSe47dxhGLJp0Gte2/dt5o8E0Va5OaI91tmy464PLeVfba9K169umNiAed+RhxDcQyShDfXbQQnQSQdxsdvvjMZYqNFh5jIjPBtxsUt1xAX0wSAF1wd62GLWs1/aWbxm0vdNQIDjiBQJ96Gw+nbHAOBfUDpGvXm6+lZi6DHtvpz2RudwOm0/MddC3NfUQhfoKB2H298EZPGS2+p9p6lPklsuUgkDf35w/zXJunKLLkxia0KIeRe4q/vimNAjszEJpHU7AtnY84TRysYBm0GnL9yZiqYquljdd0vz6YytZQpDy0gdTW6gIJO1jbteMZm0ltT6QyH+iv1aCSgXwT8cY9F8XmJHyqQ7IcQemglAXVg/H3x4u7msp0uzCyjpMWek8gHWuqAI7/AO6xfhC18EbLmY7D/JJBOv2T5jNY8HS2hH4SFFYBX7/P2w4ckTJXWLaXylH4pABWBQ527fOPEp8yS283qeDgPqDSG+CL3xovCHiWZEzEGM++2w63uhwbH49ub3rHadTymBqFxHVYZm2Xpbc1/W05JaeQpaA4EOAoQ4DwQT7nvxjdeBPFLcQrZlLIb1hrWTYC7rY98ZzJ5/nnWZrqUbICS4k2300D0Iqtzv8AphlLy+NMmOfsZLekBBeQg7N3zQ9r744mMr0qh+U630nu56I8EzEU4rMuR9O8LT/2jeHlZ9kj2YoQw9LhglsVZcbAvcHk3xjwZEpTMtWXurCyh78HQvqDncAjYfpj3v8As+zhQzB3K5btvIBQEfA4JOPBf7YsrlZF/aJKhxGAxEk/3qK6NgAbK0C+Nxhnwaq+i40HunSOfbop/jWFp40DF02xMg+I3+3kmDuYQpLDSDmKA5rWFtlsgUiijf3O4rt3wtGcuynWUTJLj7McDotr3QNx6LG4R9OK2wjXNlgs6lsf3ZtCx0/XYuwD83yOME545mDuYF2WY5my1F5xLZQkDXvwjZH07fGPqG02m7h1vuL7Lg06DqIhvPFeh/2ef2gq8PnMoDaW3Ey4y2yHGbAWEE0LN0fc7D2x474hlJcOpT7zhQ5qDjlIWQfp27D2GCYynNCJszpJiIcQpa1srWgrBFtlaNxsv4243wHmc1fnGs1cy5IiIetiM824ptqObKEIJ2o6l1vffHPdTp0nGqwXPWfvz3XQw9F+aDMC/wCh4oGAYbSX0OIccdkEBHVNBobHWKPfj6HFuYRWDBakQVvFQcHWCmzobBA0evgm9f6Yd5DKe8M+J2JcNnKc4YCHPKebaBBQvZC1IPrB7gL+D33Iyvw7MzbKX342VIjMtPNszpPUAAJsgFBO35CSR7dsY1z2Xi1t9Z+nX6K12Tr7FJImXMSGXcyUqH5hMnT5dskOJFXYR2RtyMO8q8pEQ71ctZlrcQdDSzSASigdiCSi7A9xicKIzQadYp4PPkuuEla7INnb47++Ln4DvlHZI6hZ0FC1lH5Pn+X64859Om0yIla2i98Hnus1mM/S6yy9ETHYaX1Y/SbDQUkrN611rXROxJ2ojFecvz2m1ZVLzJ1xlmWt8LF9PWurWEUD66BP2wVnCHpM6O0uQVhyLTIlODQgdwKPoGsEgbX9945iuJJYhpbZkWWwFhawS4QaWQR8dv5457mMvA154o+3Zx0CMYciSWprUaM+uOunG+o3ThFm/wAno3N/QAV3w4hO5dOhuKhS3oT5bWC9WtxdAbawPgDf37DGYiHM8sejyY6H2GzoUy8WdCHUAkCydlir37/bD7LnJEeMpltetjYELAsi7G4+pxryCGyJHPvKIb5SUfMzANZUhYYX+EvplwEkFdWB7DYH64uRmJzXMo8dtbEWhoLy6jgigQXCTXbv3OEklqJGQ+qStC3DJR02r/CdbJ3OscEDuNxf1wNJzOO0mYw2y22XFlBbCQ4WtB1oW24vgdvcgfOFVHlgIJSGu7Wk+cdVoclyEZrGU9EWy8oPIbDGvQStfFHgI27nuMKsxixWQ+82hlhTpWVxmb6bW/CCdyPn4POBoy1NttSEPNuJfQt5DhNk0aNoG4++GzknLZ8clyRFiSQ2gI1oWsLIF7c0Sff57YQ8hxzAyE2mwMAEXSGWYwyJtBmOImLVoWy2NYW0SbJX2OwAHtvtxhRMiycuy6JNRlr6YrkoqYlOgpK1o2KGyOa2vvdYZZoTSSoN6W2ygnQN/nbk4Mj5LmmZZXFZaZlPuIknoRzK4KwKpq7BKyiiNj84Yew0knwTCHFwMeKywzJbrb7Li1rcUA22AvhHG4rc1tfP1xoYklbLjbE1tfTac6zjXTrWRQKAR+QdvjFczJlRs/fy6cjoSG1hm3WS2UODkEfuUbu9/pgfPpTr2avNqeYkaBo1sgaFhACCUAVYNDtfc4Uyi8NOaL86LTUaTZUeIEzIwSsZq2tnMmvMqZbBJaIUtPTcJA3AHbbcd8Jc0VP9LclDiXWldMJ7oPYX3NfwrG4c8OZXK/s5zLxCz4hQ3LalhhuA8D1XGtllwH49u9E4wrKUIeebSpDjbSrKtFh1QJ0n3AN4jrU/nS1mkx5/jv0KopOc1oLkx8Pebi5y206265oUOohHJQNzRH8CNx2xpcuD87O4sl9pDJNkkUQaBF0e9dvfffCWHGZceaRBW/JSEgIWWyFt8Eigfextsd8bDK2VN5gl5nKOo2wgdZCHFuIWRySb4PsD3+mDwWGdS1UmOrvqmBp6onMISx0W7ldFptDaEukg9P8AORuTQuzWLY5elQg9HafXssuO6CugP3/oBhh4l8RwZaGf2a0GW2yAhOsmiON9r39xhXl8yS8tmA8tbbbazbLzhQ2Cs2Ssg0LJF1t3xRi2Q0gJWABzwTMcPosZ4oiPrmokx+oppw9NKiL+wrnC7NoLMViUVT0PvtvIMcMItt1Hck7V25G+NVIX5qa7Fe1tyys/itr/AMTkHfj5u/fCZ3IYzfUUia+dgstaBuBe99uQPfk45YNo3PpzxXfxjWECFS3MmR8saiOPtudRwqMcopaNwd11waB5rY4lJlzYy5WWAlCielKDhQWwgEbBe/ccj2274IhlllAkLSt9EZtA0yFgls8C/jmh9MCqjtOTepl7DLjbbY0NhZ9Br32OsH7X8YobSlsiZXFBAuVwtyo8qOhxSX0BkPKZbkWitGyyQdjR47cYrW2t0F4vBtpf/DCx6CAPm6+e+BUdYlTriacaXpSsIFEk72SN6GD8rjvZogw4cF6fKctLaEt6wjkk177E/wC6xO9wcYaNfrz6p4qObBJWjyyBk/52WXj/AHZC3iW0A/8APRPA9u59sASJDKJjzbcdx55DJcQuOOoAEckjfar+nOFuXZjmcz/2blyittxkdZps7P8ATBXZs8ir2obYBYdmO1JYTraaQdZLnTtB2KCAbo+w3+2FF0uLQLnnjt7LfnF4EnROcqekrYl5nMy92VBa0ebkNSemD1CdAWDYWLAOgA2EdtzhOnyAkSl9ZcpKG/wnHKZWXL2ITvt7jmvpg1PnEwI/99bZHWDTYLwJABCwViuATz9u2CM8iyMlzmXliJ2XS3GnFtF+MdbTgO5WCQARvzt/XAPeSclQ32tt4zqlSIkaIXKnCmMp5TiOu24NDIRzfO5Pt+uNp4o8YZ348zDJMlzeVHZS0WoDEhbZT0ASACUDn6VdYyhiLjkKU1IR11jrB1Bu6vjk7UR9caaE+vLMolMxPLuO5m3oluLjWUALBQW3F7hdg2QfjDqD67aZY0693319xKTUpse5riNFnsy8P5pBz2Xlr4W9KjPeWcaQj8QLQdFAcncbbX3xexkGYSsujy2oy0xn5S4yJDhQ22XBVg3+ShRJO2+LuqYzz81rzRkLV1PMa7I+SeQvne+4xOFmYgtCK9HRP6bgcQgkj8Qbldb6+KI42wLKNQRmPjznmsqvpz2f5+UsUz0m5EeV03CxTZPUsEA0NBHPNj498Vt6HpDbuptl0OX0m0UOb27D6fGC0dGT5iTpedfC1uzU9QNo3IAKBuABYFD37AYFWW0LCHEbEW2E7HQfnvjBM2HNtFLUdpJQzuZuNTfNIRWh7raHAFBZuySKF37YFczmXJQptK1NMOrSlKVbtijYBPsNR27YaZvLjNzWEZfokMx0t2iQwCCQgawuuRdj3oYWynmYEdeXZhlMlhwLHXH+G4CLIG4oc+1/PbB1HOa4szc7oTMO1j7kXV78eLAkzEpKJaGlFptRcqzx1EUbPcjtx2x9neaKnLgvKQtK4kRtoWsOatJPqoikbEbe4vvhRFLYiLkyGVlTiab7JCgRv899hXIwzyrzLuX5hHaejtRWWxLfQ4UBa9HoGgkWT+JwORv2wsuL2QPTbnj7J5ZkP3S2YGV6nnnluN66H/mEXf0ofHc4JhTF5FnLsxqItxxkrLbclJK2gfyLNcLFoIPvWB0zXUuKea9bxSULcC63O1nsdrGC2JmR/wDhtMN3LJMvO/2in8VqSQ25GCK6ekDcldG8G0FrQRznsmwSrYkGNmCbiuyUAs6nOsdIW5vrCOSUXR335wgcCWQ4hx1z1JpJ/dIB4x1SXmFeZ0uNhThTvtvz9sdacYEvUOshhSSHBq/KCSKvuNxvhj3NbrvHPNXAhzQ0C43QrywpS1bepXfcgfXBzCZsFtqW/lxUh1Kgyt+PbblJo1Y3oKB242OKm2VupdfASthoEOKB45r6XWJSFNKdajDMn3oiWwrWUH0LKRYCSfcAXhWVrgZ5zdBduiYTJOfDK4zc5qS7GkJdkxy6k0datLjgP7xtFWbqsDZe82GnGVIV0JDZKj5dC1laboJJ7WQTxt/ESXmL8plDL1BLf+HSzSE90gXQBO/HOLGY65iugylbvSS46tHVoJASSSCduE37nHqYmG8BmVpcdUXlbsCPEc8xAjypTzdMKLxKWSCb1tjkkcb7c4jEfy+NNW+7EfLLjCkqYaf6RCloVoo7kp4JHfjbAs56E5I/urAYbKEgIP7poXv3784J8Sq8PyM1fd8OonQoFANMTFh129Au1JAG6r/hhra3y3ggAxvtbx1lCW5m3P555oNl3pONLaZZXoUVlLm4WPlN/wAMWypEBWTR4cfL0IlB1a3ZfXVbqCBTZSdhoIO45vEiZjeVIYC47jZkLV0hpWtK0pAJIq9NHbtsfbFcmKpmRMYfZYaWykI0qd/IbG4o7/x5wuHP8J8udy2w015yUbkOVQ81azF2dn8DLHokUusNSUuKXMWOG0EAiz8kDCkNSDHLykPeX1aC4ASjVVgXxePiVFwILh0p21E2QPav6YYIcK0NxZMpxuCCpbaWmbClpFAlNj1GgL5wvXVbluh1IqLFCmRqcJVYsKWngfG1Ht374c5BnqMjbzWKvIYE+VPZMRt6YgqMds2F6EnhfFLO6K2wnbSlEZqU6p9pdfhqAvUQrcfAAxfmCoq2ZK42VSA1IWHI0mU8S4ANnANNJXaiO21fXDHOizvC42IQRBkJ54H8P5b4q8SN5avN4Xh9pyOt/wAxKC1pZKLKUbWTY071/XCFqEp5cqX1iWo6yevVIWqyavgEgGh3x9KZmNqgqajlhp9j8BKHU6lD8qySN9yDz2+MQmOMp66FxHGwlWployCdAJ/Kf823cV/TGuc4jtCw5914AQoqlyC8w6y8W3GG0oaU36SP973gzzWW/wD4CZ/+tOAo8QpWhan4pUkoIS44DaVD49u47YM/8Uzf/dcn/wD2ax/+ZhbnE3+5H0BTGGJn6A/VNxIyzL/D0iOyxCzZ7MorSvMracS9lziHCVpSdgSaFnfZQwuCQHhFLKZIUspbWl2klRTRojkAkH/ucdmrZlvuCHBjx2lfuIcOkKQj1kFZsWRq+4GEyXVttqSlygVA0Rzj6Y4oMaHkapDGRYp08iK03pBWh0KI51FND0cbUf1vHZjxloQ+XUFFL/u7RNNDb32on/fGAYeYPRApLiBa9jpQNSDYIIxJWZeaccW4451na6jjjhI1kklZ24snb5w8fEKJNz5HVaGiYU5DDjSo6n4qkNqQHAAqw537ccjbth54JzQeGvEzWdokNmVBHmI6VIDiHHR+VKwePnGdQ2pSHF9HqJAGtdH8OzzWCG3Y7QbXHOv1alocJuxde3N++DaQ60CEJAIhxTfxJ4kn53LzTMp0aNqzaWH3NLNFCwTs37DcA++BoLsrKwma5BhOtyUKcQJMdBSrZbR0j4JO3ukHtgKYGGiwiLKddDjKOqHG+nSymyK32HF9+dscDXTUlyWlYQUBbYCgSbv9OCcU0KjXZenn0QfLaBA7lOI8vQpCEpdUWy0ELTqAB22+bJP1xXGdUyh6OFvt9VBB6a6sH39x8YYZTB68CdOSYawChlMZ14IctYNOIFjUBR962vBWURssZyXMTKkvecW2gxUtKRVhVr6gO424rvimm5j5I1Bjn18ETmOtayFnsRlZVEZhudcBnWvS0QepfrC7J4HBFbYUJbLD5Si7PA0WcM1SYbLaAiU82XNnghv8qLG/yefjjfA8gqjIKmXELZcUW2+oPxCgUQa7X8H3GE1arKQGQCVvywTrK1rHj/O43g5vws09H8o1I66VBpBIo/x37YXxZElU4ZiHQdS+nY4O2+/ud8L5kWFDzRUVUpM1tGgqdhINLsXsFgcE6a+MFxsziF9UuYmTIUghxYJCQpw7Hjj+e2NoPbScS0AA69ZVVCnTqNAd99PVeg5Nny2nUdNZWnp+v/P+n1rG6iIZlZYV5euQiQ4aXvQq+xx5NluZZa61rcHpKgPLIUQscnXf8PffHovhLOctcLq2XmGCj1FClgFfah2JxLjG1HNcIsfovoMBhaDXA5tO8LcQmHURz1mgt0fzxVneXx50ZxlDrbJKANBTz/rhnkkvLZXRdilHUQbF7cD573g5eXsyFqtAboWR9cfLisWukWPVfTOwDA7tCW9F4rP8AZi44zJMttxsEndFaDvQC73Ffxx9J8JER0uiG283SNyCQO3+n3x7lDyBb0ZLDwBY7Gt8Bu+HUNSHmda+idve8dih8We0dsiy+cx3wilUfFIFfnuXk4jlT7kMabo0aqzxhn4byrMWMsczhlEhDIkhkygsEIconRXfau2PWsz8BRnwUBJ3OrWd9xhI/kIyceTfYIjoWXAsI2X72e/H2xQ/4sMQwst+lzaXwBtBwdf9rPQ4i85WI/k45eWq3lrYtaEAXrBBoe/vjZ+Lck8N5Q3Ecy55Epwt/iEjck/wrGZmTIseMl5hhBYW4EBbjgAAPJHvgXM19ZtLjC3CpfAd20Cu17o2BxyX1HOqj5ZMDbuKv/5GN/0RPVNm8wkoOsL1tn/J7/Ttjj+fgOFgrRpAFoXZIJ4OA8smxHJDKVssMDoWJCF9TX8H2IF/fCjxAGp+alEL8BtDgDhdcAr2+QPnEjmfOxGVoEDX39UVSr/z4fMTczHNk28T5g14jjSIkbWtUZsOArOgrNbivbfnHlfiCHLV+GGlg6A6tsbf98bXJP7lnEgy9qsL1r2qvbuPbGdzQkl2X5RYZABQ8LKEC9tZ97FAcn7Y7uBa2nU1kflfMfEC6tTDt9/ALEPw3nkOELdRIQrSgE8g3vY2G364ceE8rBQlDRWZRWOn7LHsRiUOa6pAjIShbi+HRyAdq+o33x6v4Q8G5bF8DxvELmaheZdRaWYyz0+kDwR35GK8bXp4YgOOtv6udRZVrNLWi4/Sp8OCfl8l1ibIL6Wh07ctols7D0HvQ47Vh3keaIjRkoQ1IDJ5JPayBt2ujgK8yzie6lTips11wtLcvWtxwj9wj77/ABhImSttx1nRRWug4j89jv8AXHMr4c1iGnQ817uqpw1apRb2f9D6c2TXwtnK0+MyuMh5bK3O6/Wge/61iz/7QjL8zNfCa2uglDry2nl1e6yNxfFcYQ+HHFwcx8+6twuvo36pBLhOxP174e+LZozfK8r6DZDcSUHHFugLIuhY9t6rFLcM44lrwbfr8qrDNBwbqca39/uvHlNzYE92NJ1tNIcW0QoejZZFVxyLA7c4m5GfEdD63m223FhDZkSB+IiyCtH/ACAg2e2N5/bF4izTNszZ8Ks5RHIy16464rJLrvVINWOSbO2PIZAnRlOdXrHy9hxAcILe9EK9tzVY7DcS9tNriIt/PX62XLdh5qOY8aE+34j8oie6hM+cuJIdWwF0hbitBWjgL0A7G6NdsUNZhm0nLUZM7MdXl6FreSyp09IOFO6qG2vYc/GAokdS5TcdglLzq6XrUEt0TsSTsB73hguS5HytMJlE1iMlQ8w0p0KQ7JRdrG21Bew3745WYvIznnd5b2VYhv8AlPcqXJjrV+MyYrjjZW02+VBdA6Pk1zfbGr8go5ImVFnMl4PU824dS3ARuRf0onGOy6KZSP2k55pjzBAYKUawtd7m+aNdt724xrIDTsaOpiUgKuzrQN9e5rnjHSOWo0SYnnN1IIcbDTnNkfKdjSGHHXpnTlaFghaNZWQgEEm+52+MKpEtEOQoyltymxr0No2QsjYXYoi+R3AxZGalTUCNEQt+Qb0KAtZ7nbvXsMfSMnzKRlgltxgiLHR0ie9WRxze5+mJXszOifKQrWZXtgA85+1l8xcfkueczTW2pDDQQhlvp9Vu/c/8l0d+PjFDcVoSrKeo3ZCKIJHerFH2v71g7M4Tkt1sxYb2ptlsaEIW4AOAb+T/ABx9DgrakvRJbK2NBIWP3wRzZPt/XE9RkO7lgyvMFASDm5baiT1TVsxKb6bzhIAFkIbB20b39zjeeD/CuYZ94bzLOcny19yPllebLxb2QRuAD++D3vj5xGPGhx8qistOvNzW3luFCwFtLQaCAEHYXvZO1bYEcTIyvL5sbKMyfchy4wL6GV6PxOd0WPRrP8NsS1hUb2qbua9dYTKFOm8w8H7/AMSia8E5gYcuP0CxbL7bQAqtj7i674odyeS5lUyMiM45HEkByQ6KK/8AIi757/bvimOiSWy7Ey8Pym0F58tskhtsCl2Bto4N/OCcvgonZWX4anyyglyc25oCGxr26feqrnvjQ1tSGuHj4KZ9FwuDzkIdiDMYy5tbcBZQv8RawKArWB6/mjjkZ1lbbLrLp6bm/rBQgC9+NyMMskenRgZcGauoj34DbbgK97r0d+PbuPcYk2jLW4D7bjnTabQHRTIK3Fk6Omg3bYo2SRyPphZYA7LPZjzHNf4jp0yL6mV9mcRQKWZDKHtg+y51A4NwPRQuzxdmxiTcR7L34eZNPDzCDrjdJXrbPv7oHYfTFcSPIabYcSsfkCB675Pt27/fk40JgRHMtSht59h6l+Z6iBoO/o0VvZHPbFj2Atg3jnklPmZCV5rN8wuW2905bkh8rfmPC33Nt9Gvg7bnve/GM47AznMZqcvyyKZD5t0Nx0XrCEH8QHnZF8cVjRy2TGRocQOqHOpZ9etG1X22IvjnGbzY9N9YgyX2XDYDq16SQTxtuDv2574FwIZLbc8kuk1ueCUkipmrfUtLclb7JX047KA6U0CdRG+187YigMz5iHXG0tMfhpKmmiENityo7qux9zdYvZmS8vckS25bkKSWOmh2MutfANlHfQTZHfnnAEFbzJWhnWpk6Qv8Q6V1x8c8Yg+cWyw6e/NvVdLIB2ltoWVuQcgOfGW+y6ZKEMtoJRrJQVk673oCqG++Jy85C3EpbebjvHQ2/wCWX6HeKNAUKA39zvhRmmevycoiwELkNw20Cg656OoixrG3YEih774ojRprrUOeqMz5d22W3XaA6l8rrtZ5N7bdsZUqj7zznckHDkjSeeULYxHYBcnLWvrNMIIjHXrY16xZsfkQfWUdzt3wrhTlTn/LErcShYQgNite2wCALvnf5xVFPRyd1Lq33Gi40gIbDjYaBNl8V+GboD1/BwwfcehZo1M0stuWC29FrZAoBwEDklF33+MRPqVSAHbc5K9S7Eu55pDnvmJMt94R/KNgkFDbmtwEDcHj53+KwnZbmnS4y4h9wEBbYNEfFfQY2bWbxjPlQPEkaesx1FcVD73TW0txYWtbtg2VgfG5BxyPLZyyHLkQ3IrL0hlbHSRrLm53Wex22HwTxzhcGq7M26ZVqy0/MPp4eXgsq66zJkOjyxW0EfgFskBslYPfc9xv7jECElwstvbCyASAL/pjQZXn6YPm3nYkKT5lny73mmA8QDQtAPCwBse2B5DkNkdCDCY1eZW81JCNBKCAAgtGwBsTydzWKCMoEX6xtP1XK+ZmBBt9/wB8lI40mK3mMdySyXoiFo6jKKQVgcj4v3w5W62/LVmbGVHL4Tj620NtrX00A2Q2V9yAeeeLwsbYQZBc0rYbBtegAkUCNr3o3vi1lPUa8syt8tiiptROhZofNbdvtiQPcBfZG8gwGm6szWBIeku5hPadYZkvLQ26GfQtwcge9fHevfEhlUhkIkOhuOeiChpwUtbawaWAeR2vm8N3GpjmRM5UzLkOMMAuuNEhbbaws2ts1aBuL4s/bAj+VNMZ70lrekIbR6w6peldDal2LB7V9ucKxFRoaMrZnu8z5egTcM0vlziBHfy6ixEi/spE16Y7LzAPdNmIggtFiiDa+y7oge2+JJgKjFl7MESFSFvIC49f4sejrp3cdtFUf4Vhjk2VtvSo7EaWy8DHcecRrLejRe3r2KyACAObrnBkyK15s06Xhq2dLZQHAO9HcfzwWcgg5Y0v1RtaKjbOn7c80uyfL1JldWS8662LWpTiwVkcDc+wr34wyky0tR0xgVvJofj690b2dAutwfp98aTJcselOw4EOAMyfccJbhlsrD5rg0Qdx7HtjIZ2ry8pxiU051mh01ighevfn3o8+9YOiBTqdo85yUvE1TlDW+qKWGnY0vNcreZSzEeCUFaF2QRsd7Asg8nb5xnXMsccYZ1rDDoWShC16BoJv85/n7Vicaclcby7iNi2QUXoBCNxz3q/+uCM5zNmdms7zaozaTJDqmsuoocNaNDR3Gwo77GvfDaz2VAQeftIa0gj88KWtpJSYBWFvF5AbcbcHTJA317WRxv7XzjWO+FM4mwMtzVpS8x6qVuEppYaAsuF0C/RrG3v7Yy0fy6W3IDja35zryA2YqwtFEWULFbnsAODd4/TH9k3i3w03/ZXIjlGXaURnXA3IXTiChBCwdvzi9hsaxmGYCLAmfTbh6eSViKjqYzL825lmC3izAKWI8Xp9VhttAJYdWR1DY9Z3Qdlna62Axns1LjufSobeY+c6r5HmpFpDn/Obs71jUZ3MW7nEzMslXGisNLccjFEgAgIItfAK9zsPr7YzGevSX31z3W3VuyG1mW65S+o4tdrWm+PzDjveMqta0Aaxv3dPVWYYy6VCKqGpuNrdMc9NfWKGfYHRW9m+CTVYhOZTSWmipZ0Nrc6iNAQojYUewvnv9MWZU2480oNNIc3WASACu+UHfjcYMzjqNy5bCkvuutFbIEh49RgD0BBrmqr2wmRlj3VL6lwAgM4czDLnXcolQ/Kv9JtiShcYdTY6wd9wfkVYrA8Jl9DzRiuodeKgG0oVpWlQNi+CN+984lGkrRPTMalLZJtCHGvzoNV9e/OHviDwm9k/g7IvEE3MssfYzUuhkRpIW42EbetugQL2/XCWllKGkiT7n+KgSQkLjjkAa09CYmRoK3VsarWNygXzvVnvi7L42WKhzX8283F1xXHcvcjNDQ68FgBC7P5OeNwaxTIR1IrOYiGptolbanBa23HbJr4pJTtv798QytlapCNYfpHqLbTVuBFElYHsBv/ALvBiHOht+e6LIS3tFVhKV5dK6EVSkILanHVpBLZ3FA+xv8AgMTbVKaymQmOGnWHVo67hZClNkE6RqI9F78HfHc4Q03mr4ZjvttFX5HXw4utrtQH+/tiSJEEQ2krhrLtLSS2oJSdvQvgmwbv3FY1zy13Y/vAtDZHaS15hxBSkM7kBWxvB85EFaUliMqGQyCQ491OqSeQQBW3Y+x3xQ+2G47Kg671hwgpoJTV2DfNk7ffvgiPIhOB45gwtxxamwl1pQSWkD8x6dUske5G/wBcAHHUCyLKLhUvOByS5IDDbDRIBQhwmu21kkjbDHIcyyuDmmXTJGTJzBqO4FzIq3ihqShJHp9xq3s/OwGEam9iprUpA3uuBff+GCFhKEuNtuNrSqhZRwVcn4qqx4kkR1/mqxjiCm+fZtlU2fIRAyaPlcBb63kISrqONa6GgOclAA2Bvue+FKZSzCMFIaDJc6uvpDWCARWrmt+Lq8W5eiS8pceG0p92SpKA22kWTdgAc9u2KXmU9FpvpLXIJrSnhQvave/jBOgkNGy9e5VmVtvSZbZaZVLd6iG+hr/xbUAEAcqs9hg13oxmZTGZ5etmayothpCQ0tDwV/xEkcDcFFDet+2BlsR2GYkky4r6t1rYAUCAFcKquRvsePnFDklT5eC0JecdVr6itRcHv33+bvjBlmWx1P4mOfZACIV+SZgqJmPnfLxZL6VHQxIZDjSiQQbSdsQOhpsBMpMgglKB0yW909tXBs+3ziDKWXDHIaK+mv8AFSp8Dqbjj/Lt33xKdHEaQIy2nm1oIUsmlVt2rkcUb3x6nu6L25/V4zoU0y2JEzJx2O8zJYeYgrLaY6FSC642Cd9/QCOSNgBdYIL/AITc8OyGmsuzZvMDNQRKcltqSiJpGtvTQtwq3B/64UyfMx8vjgKbDahrR0iglJNilEbg7cHHExkiWqE3mccR1eoq1Etmk37c7kcc/G+NL2vDdZ8df1ZYKZaT0UzLejsOQIL7iGZSklY1WtQBtsKHajvt74V63/8AzUfqMXxnOg4vQlpSnE6Uahum/wB4Udj/AK4N/Yud/wDuUv8A+mX/AKYS8ibgLcjnaBRo2vrocLZQNFrAqx6D8jAiAGnQdCHFA2O4P1GLHWy04wVpK0LpVDbbuLwbFQwtxSm2VlltglRLoRuBz9ifyjnH0rS5/Zi47kp8TogH0PukuFAGhAs8V8/XHFOL0LaR1PxKB9fbmj998NckzNzLXJbCmGJDbjSx0nlkJS5pIQ4KO6kXt9cAqdWvpsuOEx2nCUihe/J3+g5wr5bapzNOuvOdfHHdmyHXKloSsdVxKHUBDiQqgpN3RH1F/XBrpjlhpMUOdRKLLa2wSbJ3v6Vgd2no7i3XnVLQlIQFC7H1+Pb5xWyFLbGgDSkEgGrrvvzhLPm06gYLg+y0CAiVFCmmiwhYWgfiXvv2r4+MXw0uyehBW8llpTnocdPTbSV0CSa4oYqYffDbBYC9bBK7DY2Nje+fb6YJVA6WWF+QHhIc6bzaUpBbDBsayQdjqoVWOpTcJACW43XID7mXyEymk0o6m0qT7HY19rF4KiR3Hn4sP8JCJLg0F5QbSDdWVHgV/rgeJPkwJDE6Ktxh9CrZdTsUVsK/jihyU842hLylKDQKEHRdDc7/AHOK/mim7ONPc+3p6Iw6Who15wopqXLhT1vh98MsvNnqNKCk/hklIBII7WO2BEqeclIS6lLbkhSVKcdTQGo/nodt7usWCRKay6Sy6RpecAVRsbew4vjEWo8yXmi4besLdXWgEm+/fn3rHJq06jHZmOILrwdkxrszgNeilmMYIzJ5uHI6kJEktJlJsNlfvfsasXvWKkoMlZKS22lafy6DsQNgNjzsPqcRhNvoDshpttxhhSStDpsEmwLTe/8ATFkMRm4rvXZdJdaAZUldBCgsWTtvsD/vbAURUfaV42uQinw7HcRCRNQ6pNnWkaU0dybUAb7Ue4wTlUuYqUmPDcU8htXo6u23ud6HfC1ICUFyysngXRv68kVhjljiNASjppDgDZ3G/tq+43+2Om6Wm5sqcO57Xgg3XrP9nPjNxuO3HdUtCkL07na72x6dl2cPPuNgqV0zvr/648JiZPnOSOR0Z1FdhNPx0SY5cb2cG+g7e/8AXHo2T5rpMdvqA1ai1voQSO2IsVhg5udouV9rgMU54aXmQvZIsuSpgIbNt1tZoYg/5g0tHFncnj4wkyeYnyqVNP8A+IRzxtsf0w3VIWdABo3vaNscRwOpXaLGuPZhEsz5KwttCvz/AOIE9wMIf7Qk5pN8Iz4WUuFqXKHRQojgE/6YZy5MlmNoZUgb2sr3v6e2OQ859WqUyLR+cH3/ANcSV6Rq0iBaeaJLQ2m8SP2s8vwJl4yOFBbZPmGGQh5ZNhZHcDthRmnheXCWlSlkgo03dWiuMeoLWy9E6rKF6ii6A3H298ZHxR+05TbiCltCL9HwR74roPqBny2G0ALkYinSD81QGZleT+K3Y2W9SmHG220BSL2v/UYyvh6XIkS1PFCnASEU5yL+PesbXxJlL2YNSI0tpfWjBbLDQ10DZ9YI9uQPnGbayWTljBelgOOOEjXsN9tyO+1jtyMVYV7WsudVw/iNKrVdLBIVcDM2alPHy5U22WgHF7to23QL3WfnAOTPMOZXIy9T0pIkIAeQ29obcWFlY1jg/A98A53lEky5XqilorP4gNo0DjflGL/DWWRG4Z6LJMorIsgkAGuPn54x12MIaCNfttblwvnHk5shsOc8E/iZBlreXhpUZwTUOIIdC7XwTVDaje/PAwbmEg5e22w8kBkNhfoeBJscXvVXuDvh6MsWIzUptpfR2bWsGign6fTGW8V5XIdmuIcSVuLTyhYIO19sLYw1HdpyMsFKMuqNfzzLoL4dgrkKb6KDrWbWhf7+9cDCOTmoRKZQ4plBQ8VEFfUC9C97ri+NjuMDdRtjLnIjz8gAt9NkIG5OsHQsdxsfbc+2Lsk8NKdkKnPNIjxEbhnXu4Rzfce/8uMUuqxYHRZhqWZ1xr385orM/mys5zZjKcrSiI6i5bSHXG2m+k2hZJ1r318iu/1wfNzJ3paIiAsIbQvQv9+xdHCbNTDZbQryzZU6tAcdcbJDdk0b7bAj53wwzWRJnsMsZdEbZd0a1rbv8Wjus/FbbV2vFNIvflDRbfu3912KVNlNjiT0hU/21vzMu8RZXmzDsiLJkRm1o6SyFdRutCwRwRZ3x57nEZxlwOiaxMXMiiW9aV7LKjaQVjdYPJG3O5x6X/bzHcl+H/DcqlGQUuN0CAPQkEnHlrSWnywZJeWlC06Upq+nvq3PG/AqtzgKTnOpNpOuR9jCi+I4dv8A0ue0a/ccKBjOPrlFbgW66tpSOa2oi8aDJ8mkz4zyGoz7iQsOLKElf1P8Rvh7/ZZkGWSs2Ym5oy45EaQsvthZaCeyF6++5uq7Y9CnzkZhIjr8pFhGFEEfXH/DRIQi6Ws+52AGJyWUnZIM856L1LBVC0OOhlY+H4aXlmRMy2VLcmLk15fRZ0f+YDxe1V9N8Oeo55dUnyYcjrQY7bjj1G7sGhyf4b4ZO5tJiNmM8gdRcXottLKHOgg7iq2Gx/jvjO5vKgs5WEOCQuW4tC1uCgAjfit/9MepCo5xe51jFunXvS6lOmxuXLp7/b0QkeQttbq+sw35cg0btZ1/uD/P3IwatnO50BqY3k88sZol2SwA2sIWhF61gDsg/wC6xlYeZstSHmJCH3m1t03SwFtm7QQa+Prvi/KswnwVl2NMzHUGHW2VtuLAQCCXAB/kNm9sFWdVaf8AyjvkenuoHBpbLkyY8SebdXJeXOE1pDepZeAR7EEADbcULob4MQxl3kHENRg9K0BDiAstlrcb1W9osb+99sYl+Oz1CUpe6hra/wB//YOw749F/s4lZLk63n8/yhc4uxlhmpOjprXuhZ9iPbnE76hmSJ7hCSxknWO9KY7MySsRnW0BKElLDkhYQgXuQLNfTC4y5KvNI6S3GWlhDgFGyeP5E41L8Xy81Xn0lCV7sLsaNZAo7WBQIvCiY1HaW81r6bTpAedaRsAOKI5Buv8AtgwAAIVVJpglK4xkvOFoTJEVhxnpuLjItxbHcVYse4uvfFLWWvuwHOOqAAsLO+jtQ/XGghudLMHHITi1trNlwilv2L3/AExqfD8/LWS1JkxmXPxg90a6SFrFA78n8lbe2Aefl1JantoZxdYLIDAy9brr8OQ4HGyGLWAW1n8jhNX7nR3Fb40+Xw8qzJCWpSA0ptZb6iEbLH19t+/GKZjz5zOV5RCH2ZYDauqgLW0AbGg/uEVsfb64pjftDKyJbsMSY6EF15lzW2ACdlmh/wA4PyKHGAqtIbI1VOGoho7QgFPJmWycgnwcygSQggLDCzGQtsWTsQdlmvcfywyyOMh3LB1mGG1da0IIoFHtVV84Ih59lsyG2W470CWghu0MlbHFUsH9878b4aSyy+h1a5vRfDfoQtHoW5dVueKJP8MKNb5diIndC7DgulpkBZLxfCQzrXl9oZWyjqB5YWQUc70Nj7cVQx5bniXZE8KcWGU9YAuOJtFHvQ7bY9mkQHp1wXPLkP0grXwjXsNuw5vnGD8Q5RJyvxNK8OLLE9JNNTkL/AArZaDz2/Q1iXE/EWYeGu0KmbhH1HHKLhYhDTr0lpC1BURtwLcZI0tmgNWw4NJ3/XnFeYsssuJX11uNr9QVHWCAg8o37/NY0rWXIspGheglQBIABBo/X6d6wBnMZDNR4C0LD7YSSEUXd9jvwu9tq/jgX1GuENGq1rHQJShhDi4JCSryke3loUslCOBddibAv3+mG3iF6JJnpk5RIcWZ7Aelx/LUiO6SStpvm0ChvgLIksDOIbObumFCDxblyExeqsIvf8O/WRew96xVPPlZktGUuvohALQhxxstuSGgRRI7Xsa7YlNQZgD04E35ZIzImG4+zFTLWtfottbbpWW6BtCFg7EGq0d9z2rDSXDzZvw5DzaW2mPDmvueVBQfxNBAXo23QLrn9w7YzWX5nLy3M470JkF9J6iEup1oWVggeg8/n2/XGmEvNsxy3LYUmfKeahWG2Xl9RDC18kIurNcEbkbnfHmFlU2mdOc0SarHsEEWPP4oeJ81kZxnZzWUtyapwBC1zCHFmkaAV0BrocewAGE0x2e6tiNKWssNIJZQRsgE2QD8nfGghKiScsMULJfOgN0gEDb8Qknfmth81gTMD+K408ytlUamei6srWgixo37XZrsTgqFLt5AbXlSVw1tIECIQ2XQWpMlD7S5C09PW4FaNdUddf74wyLUQ5WykQ3kOR0f3lXWvrr3IWAfyACga+vtjmRsoTIC5qFtxVuAUhH4iB9f9nDCT4qQiPmGQ5YxHcjyHm1AmKguegHfUdxz/DFNFlNv+jGvquXWNVwGW90oynK5pTmKok/KkJ6Za6jz3TD6CQPwyur53+LxGK1DROVHbmSo7JWhv8b1FgX++Efnrc7fxxGZmHnVftN5cEEuBlGXNMr0FvQUdQAGgQe18m9xg+Y3ljUt85WJzEF03GQ84C+NjWsihd9xsMSmGtveOeScZJjrZQlri/sdTjbZjllTTbgNkvuevWUHRSANjoO+/ftXA1vyGGpEh9okhDnoJ0AcWPfEpD6jpZnSXH2XXA6eqr8PXWgOf0v2w3cVlsnwwtgRUN5jHf6rykHSHGq4K9e5B7Vtg8O01HWFgEmrUawRql8RuQy6mVGeebfYV1gUVba0d9vahviyFLiNOuu5q5NkK6ZdbbZWB1HCLQtZIO3c9yfrgL9qqTCMdtkR0uIQ24T6+oQb1/H2/pgBnNPIpefZeCXwgpAN2SuwaNbbEXeCe9pEFZRa4md1pGPFEqHJYmMyXgpgCjGOg3Y4PI77jAjkkzcyezZuH03n1rKWXGw4jcbAXetZvYVd74X+HvEWbQWc0jQUNgZhGDDjJjdTqoWQSRf5LIux9qx1L+fZZDy+S06uCFrM6I8EhC1rDmjW2sbiij9QcQQ35ci6sqf6vYbIWXKZm54n0RMrGsBZ0Hpx62sjc89t8LFoezPNUxl5lGZZcXs85SG2rN2ogbDc7AfQY7m0h5Tq58h1x+QpfUcc6nr1kk6z7mzued8UF5xxzW22BZJWa188mvfCRU7Uzz6+6NtmCN0W7JDMhhkQGVNxmXGS/EC0+ZULp273IsccgDbHW82KY60uUgUGw24g7DnXe3rsc13OBVOa/wDDAQvdTbusjcEnvwT9ecWIdeBcmFRcLaUNArIIAINA3uaGGB72HsclMhpb2kS62XGWnXtCg62XGXQeNAINoOxWTXf9cKwk+SRtbri7bseigPcnm8M8tzFlrS3LjJdjj/HsjqOC9YSk/wDD3FWOxN4v1Q409uY3lUSRCIccEN15bi0AlYCHFCjY2I+3vWCnO4Bx5z9dEovLQSAl0aQ2zFlRjHafMhCPxF3rQQu7FfG1G8cDyWmpBZW2VFB7URvsR84ujRUqackhJQ2HDsN9A9vfvse9YNYzWHEy/NIT0RqQqX0ktPKT/hhBPY78EcEbgdtsFlMAT/OafZYHdqUkjN9JkSnPL2rppC97Qb3G3BruQfjfE5LcyHle8mO+xJ0akNPIX7rAUObs84aZTHy5a0ts5+cvUmK65IW8wUhxaLppOgnWViqJrckfOBZLkdGTN9RtMgNPSPLqcdUFI/J+4P8A139RvWPNkRJ+/r698qyk8EwQkzjyA64kNOR2nV2gdQlDfZf1xVclJKlOKc0p0dVKjxQFX7UeMXM01HW4+wQpSAphK1FPJ/Okd+59sRYb842qMFhLwKlgvvaEk7bb7A97NXjIDTp9lWTOpVhidOHHIISt4kqVrB6Sb00Ryg/zBBwRnGX/ALKzN7KHpkKQWXCPNRfxmnCpAIpXftXtvgOK842A4rQ4iOtKtBVaDvxXe6/TDnwzLbLyYEyevLcszFQExSG0vatCtbfoNekKrk+/IFYKQRAG/ty/khjtSTaOfhZ9xkhbZUhLIoD1K5Pv9D78YreCnGydbICVkBCVe/cfGCpiEh9Lcpe4BJcbWFJX7VWwGG2eeH878LJiP51k0mFDzdlEqEHgPxmbCgoHc/8AfHrQSEZBKUBBMRbS1JjPR6C0EkdQXdn5G3129sDRULMpK22eqSr0NqbJDh7ihhi01DfRMzBqXGjuNvJ8vAeC3C62dX79V6AEjeib2wLJcIUHmG1x2QvSlsu6qVQ1b874CmYudec1WHaysjvIgy4rsliJLQgWtgOHS7Szs4UEH9DxWBlmQpCHeoSE7NnqVo/3eIyEoaW4lp3qtJcISrRpKh/TjjDGOoeWU5IYQkOaliQtBcoURQTxurbXuRtjHvIsNlrG5td19JhJ/ZzDS1tImJCntADYSWSAQS5dld2NBF8YEaRKit9UKUyHm6QpJrUD7n22OKbSt5YQpMZKjq070PYd7xcl95tD7EdepMhsB0JTQ2N9/oDeG2J3lBsuRI8wSNTLTi3W0dcaE36Bvq/rvgqMuVmUqS+Y4nSXUrW4sg/h72XCBsBvydh8Vgzw3nWd+Gly/wBl5gIqswhOQnfQhQdZWaW2rV+UWOcUeG89zjw+cwdyfMXIqpkNyJKLX7zKzS0fQ4W97msOTXvNuaomN7QnRCvMZllWgvNSIrUlJU2VAgLAVWoe9FP8MfQ32IpebDEee46hbSC8FBLZPDidxv8A/Ft7g4tixRmSyuXmkaKltTabfUsmlGiqgCTVWfrgRHSj+p1kP3x66+DfcH2/rjxMW16LbxOyKZZaS7LbM/piOStFN6itxN6RtwOd7obY1n/3Y/7R/wD9Oc0/9CP9MZENSHWCoJVHjvJAb1DptuBBob0Ao/Pvzij9jv8A/vOX/wD1jf8ArhdTJA+YAvAH/wCUVFdTHYfSlxDidFesbgHsB2PGLDLZTCmMsNNKcec/N0t0tjfYk7b/ABdd98EeG4kR8ynJU+C0mGyp4x5esebI/wCEjQLs/UYojQ4MmDKluzI8d5txtDcSlFx4LCrUnaqSQLv32x9CapDcuaNt91OBuqcxkwFKjrhZYIoREQ28FP8AW6jtHW58XfHasUuuNGWlRZLbJKVFBJO31Pvgt9DCo/S6Kn32xWtjZsWdr23N7dsUTDIZZahOqpLNuJbABKdYBNn3oD6YBpfREIi0FVzWkq1OxkPGLrKUOLTyO11tdYklcduOlkN2+lRK3UubFG2w/jiKUK8lqOsI9XJpJUCLr3NEY4pLZQQAoEqsG7BHt9f4YpnM8PbclLiBdMlpgxhHebBdUYpS+2tZ0lZKr7Cq9BHIJ79sUS/NsvutykaHG6C0FFaKFcfSsHPZQsw8ulMzIsqRLseWaKi61poal6hVHtRIxUzDgedXBky3WxrDYeS2CDzzZ23r+OOjRoloL2NtJWOtAlVJW5KcYb8ut15SwENjl0H2AGF5TodCUXfBBG14YriuxcxfbC0Jcj/hqCHLCTVEgjkX7e47Y7Ho5Z5Rpi5SX9a3FqVY2oIrgd9z9MTvqOfM/ZMEOiEO02ltbapesNJcAcbTRXXcgHb4xxbLKy6WApYLg6dj9yyPVXHb9cPvDeVQM4W1An5qzkkdCFLVKcjLd6iwaJVpJoAH+HGJZRkUmfLhQIS/MysydAbUtG6CF0KUT8i9sLzU4cXWAuZTqeHqVSMgmbK5jwbneaZHmninKMnkMZRlzwbdJdC3G7G++xPHt3xnX+nGdUyFIdI/KWwa3G/NG+3649bzLwD4t8HZ494RezmBF/bjJbfXIfCY+geuytYoE6avn9ceZZW4xlOdMSZEODmTbKtTjDoLjazvsuqvntgcDVbVBLXAjbWY0vPgU3GYd9AjMLkTtHlso5X5VZSiQailSEvrCAVhF7lNnnkYb5zNyKJnWbseHmPP5XIR0oz2YsjrtC7tNbA/PthAysNoWpDjiFWB00g0o3e/0rDRgrzFJiLcRTdvElsEkgWvcC6N3vtit7C5pcLn2XqAlwBK07cjM5OU5fmCWn2cqSRFbWXOogOIRZQAdwTz7C9saCIzmRYbzJbJ8qF9Mkiume9jCyFkMNjLWlmztY23vtseMVNzZkVz9nPNSzDeH/3s09aNjZPG5rA0cW19vK/P2vpThqmHpQ4zvbYL17wjnGSNQX2ZgcekLroErpDVc/W8aJjMGmG0KsLNED12PfHlXhqVKiTFToWTofShBWhDqBIQGyDvXJAG91tWDY3jB2MgRQi3QgAFACyvYHkbWb4xHisJL5FxrqungMaA1ejS84akPllThsEGkL9vnuMBMS1CeQGwC5vSzxvzftjHwJLKpJalsyGXV9roc412WuRC6EyFaGwiw7f2rHMq0m0XT1XZP/swZdloIHiBeXOHzrSHHG6TSNwe3PcYZDP4ry3ESWNIKN7T7+57YzLjEaSugtCAB+c98JvEC3moXSy8kqI2WBY+NsTvY1zgBZRHCuaCTcJ9nuSxM1feeMhZSd7QSaPucecZvlEtqWqNGkOPegtrQdwRz6weaq/t9sEZPnEqEtKX58hII1mt7NbV7YcueJFy3OhKgNo1rGhYRvRH6/8AfDaFOs0TYj1hcn4jiqI7DZafqsbEyBxvUZMlA1kFKCLrv/LGm8P5W3AbK3Y6CpsEIZNIKyd65x9n5aff/CirbcH5NxteKcgy2e60864ta3NGwPIN7Y6GLqFmFdUeYgE219F8vQoF2Ka1l59FvMg8pPh0iAthstjrNgbI+uEnjDJcplvtuh0oV+QgEC/a/wDXHfDc+YIEjz0Yx5DY1OMlZAPwCOSRgVoJeAe0FbwJBB4+Djk/DcR89gqtJ/Oy7eNaymfkuaJHsgvCnhyHmDf4Uhkt9RYLzQGuwSKv+HzhR4wbh5LmLseLXRcBCAv85XW1jG4yNp6FDekNMttkkK1hGxPf71WPK/EjzebvuvLfESUN6/xEOHub/wBMdLAZn1nOft4/fnjqpa1FopNDBcrGO5hLzGeWTGKW2llsONngf+X7Hkni98byRlUlmPHS2651i4hqhsAs1sf64B8NZDAeksvNSi2A4stl5WtboBAQCAPRW/2GNz4fipl+IEwHSFNsdiiwCf3/APrj6OrXbTEs5ZKwFF1QFrryVl//ALQMdTbeTZW7ZS3FLgIF8kAk+wsD9ceSxm2kyGlLltrdWtba2zaiBQpfHH+mPXv/ALRqEuzoi2NDaG2+gt0k2O/6b48UhuVO6MezYpalCt69weMBRGbDU58feVvxEhmKI6rTx5xgxpC+stDhoIAQQCfe/jmu94ceEXc48Q9XKssjIdUUF5RCRr9A3o3xX8sZrNXF9CKzP1pXotsOH0EE8jvwBijL83biAlpJSgepegnYnbbcfHfHFxwxZqZqJAaevX8K3D1cO1pZUmQtXGfTDpby0SGyQS24uga7EDcX7YXTAiS2F+ZRbaC8pDgICzyEAj3BoHufjfCZ7N2ZCOksOlIfQtDhHoYR/wAQAX6963PNDjBeRyo8qRp0r6ttob6dIQAARZHvxv8AXHTpuEABfPVyXu05suwPMuzFOynm1gIIQh0ElHo2AHIHAB4wJ1nHFtMFf4a16wgHuR2F/TfGqkjz7zpnTlvu30W1rVrGgULKz2AQP0xl8xy96CsTEtLXoX6F0NBHJ25POMrAlhUXyyHSiMoaRHmDSsNuUSl1F7jfbbi/4HG2RBktZWl3orcb6iy+enXSJXVFfcnbi/54xMWW3GzN7ykJaImtaW2ZC/xAPlY3JG2NA9OkSZilPdFaim9EchtutF7bUB8VziIPERobc6e69TpgPunUlhDcLy40BKyHEK7oB+Rz/v5xFAnrkOx23nmUvjpOGygGhXrFHXteEGa+IpDcd+G9JIDYQEL1EoXXAAP5AAs/7OA3M/X0y1GU4FNE/iWTe24G/wB/vhhbaJVbYZKPhuwmllC3QhWkhNLotrsb0Oeao/58EZvmoSG16FONMM6EBYFFZ2vtv3vfjfGebd89IbjazIlPyS44tpkdTWQKHUJ3Hf43xFTqBHjz/Mvx5bTgDNMa+ruT1NfCK2u998JpvcR/7R5XtoP2heQ0xTHN00y/OXZQTGembOrLhZctDbbvAI5BJG3HesOcuZzXMJJjQlrf8yA30Q5dUL3A52HH0xlY7UCZmcNuMmUw40wXZxkyQQ66FkuEbWAUVQ3374b+F5rOVSET3WpT7K1/jNoWUL/+ML7bb4VWcXOEXi+/D4JuHryzcShsqdeTJKC+82l0dUNFzQ0a4XR5NWBjZwnJ2a5ceollhvXpu7N9j7gUcD+LW15jk7H7HmIcyOBcvy7pB8sVlCHHCANZ5GwvvirwlKWzJZSvyk9pgGS43GC+q0i6/EJFgcbE/vj3xGRLoB30Hf8AT6dE5rspuPE8/qNzCX/4ahPys0BQGG0HpigtxCxseSbPOLs3hok5AmQ80Wnndz+Mg00tALVDkLq73IGMV/aDKGZeJWW46nn8tQ6VCCnZaCB7/vb77/THosWI1mmX5ZGjPSPNSWA087JeAR6zsjcDp1sDzjk1sT/0VC3pM/RWtwvym5jubJBlXh+B+zZD+YTND7UcBvqFZ6y9YICNAoGibv8AnWE2Z5fFM39oSoaHIgcQsx0L5bBsovkbbXjWZvlMzJXJDElTkqRHc6C20FBAIJB+pocjasJnIrlvKnJcjw5KFlmQIq3OAdCBRoWQRfavjDqTs1LIBED6oX4fKc8yCvPPFj2Xq8RypeUQTChur60GO3JK/Li7A1nc1jjCX8zYcfXmMVEltorW7JfWlxwEgdNA/fPc/F3xh27krsvMwzFaZ0vrDSFvqDYbB2vXwj5OEaITiW3mXZEVIRS0gr9iRVgH5NDc2MEIjKeFT1KeU2SqHEt9Kw8W+HGyUmzXFHG18LiItb+WzG8u8xrLoclI3CyNwXCQO10bsg8nGTlljS6xHTrW4pAQ02b6d73r9+364I8OxpbzEvMstZMpURHUkJ6Yd6bY36hQdloFb+177Y8ysyk+Q3m2kqKo15sT+PsUxzfM1tP5evQgw3L8sKGhaAsgnYIJ9ZXV71XbHYz8IdFyWtZCF0lwNgoFXyjnc139+cJMylu5giG646ovsM9GkhJJCVfhj3ujXwAOwxJCZK4ynnEAIdKPxEEUSdwhZ7cXhlNwzmDqFLWa91MDvTQSmWnP7y+gNu3Z0H0ckgVfwB9fjC6L5bN8xWzGksZek9R5apC19NpABNWATvVfUjEcqhy8zS41lENciUnW6lXS4SgFawbOj8gK6x3LGliDHZjSQubIPT6Te1IJG5c9zxooiqOPVXEkidEgUg0SRqmgahDJsrZS5JXmAS9rZSlADSy6A3Z5NjXfcGq2xZ+z1wXMyizI7vmG+LsaVoNLRRraye1gjAcnLpeXSZEPMmXI82I+WXI7locbX3K+w3oV7/rjfJVlqMhaZkJe85HbDhU64VLLgdOsXXoNEWCSdqvfFeEoNqAPO2nS+nVQ4g5CQbSsjl8ZxUQL1o6QJC9qQRV7r43o0N+Dg3J8tnZ94gjZHlll+Y50kNWPWTuNz9uTicyAnqymGUPNuha1uN6CgGrIIQBQG90ePph54RzXJ8qyfMW8zypiRPcS27lrougRdgjmzZrtde2JKmIFBzXOYTcC3edfQ37l6nhvnBzQ8NgTffu8VlswybNXc3j+Hugt7MmX1sFhgdRzXZNJq9Y5N/XC2Fk5nPyIb1FWioy0KAGuyRe24O/zxh7GlPQZwzuFNXBkpeRIQUbuMrBuk2e3Avc1vWAc4zFqdnbrQfcekSltmmEhpLmob+k97O/a7xldrc8z2TzXnmjoTlsJPt6Jfl8OPLXHC8wiZevcKXJZc0IpBIcUQDdmhQ2uu2J5FHWFOPvLbZZSht1xxSf8ME0OPyXZ/rhbmrsyJmjjL0xfXZtlVKshAFaNiRwaq62rDeJlsht9peZRnug62HW+oekXGqJDgI7EDY74nZ/6wALJjmuFyVbm70U5cERiURQApccr1HqUB1RsBR22xHOI/hWGvLFwM2kZiqRCC8wCmOkWHzsWkHewOddYQOSFth9FJWSuyTaifgH7/qMVtu9OOpnotnquAlWjfa9gfvjz6heRIWMpBptoPdaTMPDuas5dkkqXIYjw82W+qE65MRoBQQhZcH/D4rcb4QRytlanmQElpwaHAd0LskEC/i7xVJUrqItsMJCNNpO+9/8Aa/gd8WvhhthgoQ0hIRoUQu1rWDusjkWCP0xjXzGbWf56IiHRqpyX1dcsx7SJAHUUoC1g72fazvti9h9tEhKm9LhjGmz0xSkA3rI7/ff9MQS0rNFNs5fESFgABtokrWe5v7HHX2X4bpjNuR3H0bfgrBQDfdXB+2MD3NI5pdA5gNk38QTnswzN6UptHXmq6spsRQylC7sBAB2FfSsDoy1buakonwWX0DQkBYShZJCABe3G5J4F3vgqSlUOS9DlJYRMjNdFFW51F67J1g0CL2PG2AJExyJCfZbKCy+gBZW2CdfJq7oixuKsYrqMzNDp15zogonI7KRojv2JBaQZKpchyOihmJbjAGOPi10uiSANr2xl5D6ApSXWW3w4khHV2WbXzfvtyfnBi83k9eS4huKvzCGw5TOjYcgAfxrnEIMJ/NZrGXBxD4aQtaG9m9Q3WsdQ7cJO5+2FU3uf2QBzzO4VjQGHPNudwS3MXnJDSXn1l0rVqbc1epCQVWmuPY/A+uLIqJPWlyoKm5ISkhbikJIPUFHZX72549rHGKWlgaOkVoKVnpI3UQD2/wBje8OI8fMWs0zDPMtgZalqDSHY6em82hKkEbIXZXVEk0a5OAeRB9FcxxmUsWkNCO+E31WdLa2my2NfB3NaiO5G2+CFRoSsnelwjOW8EIDqaTTKiutzytJFURW+2+CpDzLIEPMM3lyGoqHTFZQyS20tyiqkr4F7EV254wtk5lOzKFAguy+smP6GGygBTYP7mrkj2G4Go8WcM7QOTnl9EIdIlBU0HSnXbQX/AIlbn5A/pg3NJ8zNJDYkzJcpiO1043WWpzptjgCzsLxMNNZpmKI+Xx21KcJBSpzpp2JNhbh50jv/ABxXHdfeW6513Go7o6Wp1wklCBYbNc8JHGGNabd6IvAsoTZLrcdqGHCPLqKgFNAalE2VA1e9DY+32wK+vTTjUfS04CQpafz79vpxthm4mCfD6ZT+ZzW8xRIQmJCLRLflyCVuBy/Sdfat7vCsy5DzbaHVOPMM2G2io6UAmyB7X8YF5zEgzA054LwMf5TZQyeX4dQ2qa5GzKKp1wtuMjouoVo0pQpIKtf5z69qArA0Jl1KWVy/MohusOFtaGguhZSCAeBr2J/+KrPNERMbUkh9xlwadDmo0k9+Bfv+mKXWX2SolXNAKH7w9/p84AEtMhERN1xtlRfVGabL/IT0wTZ+METIj0NLa3ywsvtqOlDoWtulaKVX5Ttwex+cHZCIhdYVIXIaWl61LjglYRsbG9WKO3e9ztgxx9LMKTDRHakKkudRb6k24KJ0/wDwb7mue5wQbMADXv0+pWi/kkbbbUvqBstsLCL9a/8AEqhpTQ5P6YZ5HmucwPDucwITxbhTWmkzUKaSQ4lDmtIs7p37jnjAihJW4mUlxF9ZWoopNE+9cA4qkoDTLamJjji3AQ80EqGgJVsL78X8YB9MPADmg6H3WtOXtAlUSWwhpD4eZWp0n0Nmynfv7c7YpS4jUnkJFGgdycHZTCRKMh3zbLJaaK0B5BOs2E16bo7ir2wwiGQ9lrvh+MuGt194r0o0JKS2LOp1Y3SRZAC6sfIx4yTAQC1ygUNx2obb01/rpWyvoNx3Rbbl8OAjYd9vjA/7HzH/ANyc/hgXWHVgr0/Kj3+uOaEf+ej9Ff6YB7y5eDRCZspcfK3BDXWnUdJOgNjn5PHvipp0dZL3SDhO9OD0mvv/AN8VPpWCplaOgpsWtK9jf3+vGJxmUB1lC/xA4kikKAIO9WTt7H6Y7E5oBPPr3FKzDbRX5fIeQ2+yy4+jroShSG3NKFgG/V77gH64rBYDzhdaWpC0GqI9Kv8ANQ5A9sdSOkoIbsPnajVUR/v9cVJ6ekr0qSVK9AG+3cX74se6GZW69Zshy7SoR2lKTpbOsEFRIH5QDzi0BAr8W+kLGxo/GLF+TMQJLS2n0pACgSUu7m7vgjYbbbYmlTMd8st/jOhQHUQrUhQ7iq3GPYZpy5Xxy/PRZZPsubzrJc1YjuQ0JfmMsustSGgUONu0WzvwDYxTmWTycvz+fluetPInMlxt5rqJbLL35RZOxTdX8YUokPGQiQCsvN0UUL0VwN72Ax9JGtnzKnuutYK3hZtJsbn63jsPqPNPtRAHn3HXnkgZFpue76KciBmWVPRH1RnIqpDKX2ddEKbOwX7Ud8Xp80w2JEgtuFY6ilOnq8+oWB7/AD3wIqWl4IbNICUlOlfCBxq+TWLekXJjzAeQ5pIaZcADbTiRe5uqFC99+LxyGPYSG0e0TyUwEi5VT8d+LP6b4Zf6OhS+m6lSCmrqxt/pxhnCzL9m5lBnxGErCfXTxOgrJN1VEAbfcX3x3NTkDoyww/2g2VMDzy5NFIc1kHpgcooDnveFcjpF9xmO844hDlNKVsKvmu364pZh/lFzCM06rRWMh7bQtLnfi/Ns/nSJucuebUuh+MsqUgcAIJN7f98LJsdplClQ5pXGdAvWaK3E/A7XdX2wKkrUwFPLR0211RPrV7gfA5rEJDCwqykKIKGwkbXd1Q78c4qo0WYdgpsEAC1kdbFVK5zVDJRbsthcLR0nG3hR6mtAC/sBd7ne8XRJhGYr6UottLWdJA0WQK9Q7Ag0ffAyG0Rn1NPMpSppC0vocRR6m4KB9Nv44+j5c6hiPMcjlEd13pJfJJQKHrFe+4NYQwOB7N557DT0TW1SIJ2XocfxAlGVsxnIbLxKuVL/AC6BZscX/vviydLD4YmMtDpaup0tt+2/ttyPY4xjS5sTMTCcBbQZIdQzJtIBq0Fy+DR98bFCg5lXm21B98LWHwVkG1n857bg8C+N8TVmMZkrNtPXv/a+yw2Ldi6dak7UCf8A/m/0lBxlohvtSIqhF9BQttla9wRuD8G6rjbHo/8AZDk3hKe1Im5/mSGWtYabiV+Iux+ex2xg4KIxX1jGW3Rq0I12ijZO/PH6nB7cpxmIfX00sFfTIoes9r9sXYjD/NwgpsMCFy8LX/8Aub+63EtOVMzJqI75lOSVjRIce3bQNqrjcUPti1geWbFEAji/nGTy/wAm5IivvGpcZ4OElZ0FB5Ro7m/4HB8zzU5qROjMuLisEdZdgdIk0j/tjhUsI+SyoLDQ9eFfT4XEtbotQ3LdLqWtykos1RP2+cTmvIbafDi+m4GyQAmyv2Ff1xh2M1mMyG/LB1bTg0gkDZdC/tjVTFuvZf5h1aEO0gdIAla0EfnsbVgXYAmJOv8APunO+IhshJ45a/Zb65MmpAXbaK2/X3/2cfZfPh+fMZ2PKb3HrdorXxrIrtd1eAvxo8hayjpls22utj9jhplTrmZyXZ8mQ513V/iXVOdyTfe/bGuwTqdMZnWNlwcViG4mtLBf6LZoRElI1+XLd1t2WP8AXvjRZfGbZhOIaYQhNUuxx9D74QZfIQloOLC170DVgnDdid1WwkuhaTRpH8cTYgy2U7BUGsqQdVJ9kpc6rcZLyHCA4tdU2K5A/htiQyJTUcuBkodv0jvhplkhDTSnVr0JHPf/AL4MclMqQEosJApBb7/rjnYSm6mXQbG6zH0WmoHQs1CgusufjBWlwaFgHYex+o/1x57nnhFDOfuodXIYj1aHWkXV3x98evr/AL3EKwoAoJ3OxOLEJac0qf0BxKAACAKPNn53xbQxj6Tp6pjMG11PK7ZeIw8iSxDbh6KUDZWvYk+w+fbGk8ENtxZLrriHw4hkOHayRZG2NZmeVIkSD1UoWgCyGx677b+4xexEagx3n3kFlLmgBBsgbcn5POLqvxD5tE7IqGCFGqIuOc+68L/trkvy86KAnrsIWFm0XY70P998JPCmWRFyHejlbcgu7rU8ggsGuUUQLrvwfjGk/tLZfb8WOLShtbBcHWQon0Db+H0xHw3l05M+XKiJWtltFPDkBF3v8bfyxbhsaMRRdSa0jKI6Dx/f7XOxOHFOu2o4zJ089Ej8T5Nk7bmaOZlmEprN22G2oLEdsFlzfcLX2GjHnzGVz1h9TTaFtN/grWpP4aCqzWo7Xtt9Nsel+LXJKHMxcC4jgkCm1rZ/EBFWLrv24xkJE6Y3AhxzEQw9GDjgX0wjqayaKv8APXAJ44G2KKAGJpjMLW+2nTh6LnY2m2liCCOvO9IW0pYytaXOjrBJAPKxW4J9uKHviXmmwmHHirejuFAsvrCRdkkDbg7VZ5xbJy7qlsSipthDeyje4s2R9xXfe8F5XlMWbNSHOmhvVaGSKBbsa9dC/vhD5pnKwQBb3UbwaplqbeEfIT8+dy7Oc2jsQkPIT5ptBdCxfrWEbWK3P0w+zP8AZQzF8MSjKj79Alnpmgdtjdbb12xk86yhvIocSe1NYd8w4o+WaWdbCEL2BvsSdrvYYDcmpYjeZ1MqfkocdWEAktb7BR4vnb6e4wbqr2kDX+69fLRSloaTmK2E9vLXsvZdMconIPV6oPoCAKAque94zGdSei00thEcNvr0+peoI4smtx/Qe+NBlfi7JnMlcW6t5GeR1amwhALI3Iod+49xzjHzp7CMzb82y5NS0rStCHi0XUAURr5A22NcYkrNDmGDfnPVeaACDOqi0/lK8uMiQ/LkSGpC0uNJGltbWjZfU5sr7VW3ztdna4BzSSqGlxptS21sxo4DgQLrpk9jXetyeMZ95plEdhUZaFdOuoSSlWok8C9wPcVgqHIhGcW3VSVNqcSXXFbr2Hrqvc3z8fOApV7wdSluMjL0XUvzYmp1t9ba3PSHE2DSwQfkHkV7YdIzqerK4+XGWejEirbCCP8AAJcshB9lmj9cF+OH/CTWctPeH4EsZe5FLRalTg46VgfnNcDWNh3GMrFWgBPocAUkayU7BfYj445wL6z6ToJlKyZhBRr6nVocU2qO0OppW0Ht1g+1/wBPf4xqsnW+FuvH8aG0j/iIOhxYrWgL4s3f2vCBlWWt5dFzdxxKZCn3GZTSFbHQhJSAn846lm1+/GG8DU0lTctpmMooW6yHnAhB4sD/AJ7I5qx9MFTeHk5SUYGWJTRh62lMreHUDiA3HajICOnRJJPc2QPn7Y6xEfj5myyyooakIBDrh6QYWee5obc/GOdHJHcnyxEHMFuZpPfLb8dbe0cbBunCQDrv4AHOFUtjO2oDiBASabP4rbVkN661kjg2OT271iDF1XU2Zh+OcKvoU2ucGlaSA2IsmREcUibudGyyvrmtwTRB+e+NS22tiJFe8yjqSNba462yDHKDRu/cb7cfXHlXhKXMYzhet4K1o6S1OO6avZOx9jRv2rHoubeJ5E/KoUbMozIXApkONslDi2xdIWRt70TvvveOdRph8VGtAkmYtt76+qurVSwZC6YR+Ya0ON6VAtFBSt1s6zvvRBwLmjcYoVGakvvp/PS2ygOf853Pudu2B3HyGhIgt0243ThWdupvaEfQV+uIGe28+hTygtzZO+wQAKHGx2/QjD3MAeXAKnDVw8BpXcnEaJNZXPhrkMIIqPX+PuARfY0ecZrxpk+THS9kkB7Ln0D8fqyS6h1wrNrqthVbfHzjYmJJkrcKXmSUI2WghywbPPbYYSzAGY7yluvNsobJWgJ71W9e/wCmJi5r3SUyrQhll5BmcZUJ0tF9aioatSkbk+13xjuXTURXXHfKMOpW10XC/wCutV2sDbf29sPMzDE+MJyIqy1eshaKGxo8fXCFuHJQ4VNICOpY34q8MY8EXXErU4cMuhTTNJcUvp/ZqcwUhphtTwkOWrqJRS1Ap4RxXehRxGfmE3M8vy5PUcKIzTcJvU4lStrIAArbc9j7E4KzHLIaWMuVAcaZLzXQdMlQRXu4Qj9273N8DbCRuPFTMcbddWiPq6ZW16xXcgmr+m132w9zQ11olSuBbIcfdM32Eu55HioZCIrqmA0hxag0q9tWr92ze+9WfbBeZMqy3xHJixkqZcjLWwpl5oJJ0HYCybVYIu96+cC5dCy5lKnZcttyKmS1riB1bb627JWpArRxY3ur+uD3fDclhk5w7Bnry8PmlvIPT6euz+JwTRHHvg2Uy5wc306X5rffYqZ72t1UMv6K4T78rNnm3XVuBxlCFuFZABRrPFE7XZqrrGjy16WqNELxcEPoOPRELTrbNWFkb+/8fpjPtsQlOPLZUpiIB6C6yAtbeutdA0TvufjDmS2zFmOqieUCQzqQ9HQek6gegEINkLXRJvbn6YdSrFhAnyI5yVDiKOYSB7rbeFc0RlsrL/EWdZfBzaG044yGpSrcdpFnUAbNXsTzxjJ57JjrzdxyI22lD5vptrFBBN0PavfnY4g64pEdQEdaOnVo/fXZq/oOwrv8YZZL4TmZvluYeIG4Ut/LYTJcW802V9NxdhsEWPR7kcexx45BULyQNBz9f1D3VDTazXfrzzn6JXHiJzrN4mTpmMROosDzLrmhtAsD6EA7+53wz/tI8CZP4U8QOQY3iqDmr5SXFuNMrU0gWNAJFgk8VwCN+cZsz1P9KNJflAMJ6TKENhYQCbKKO4s72Pc7YEkz40bPEL0CU2hehxp4Cjd6ygcD3B99zeEPY41RUc4ZdI79j6bKhlRopwBfWftzVDrglxgLVpcGhDq1o2Ddmqonnizi5h3U40431HnX2/LoBFblFaBR4J2/741cOVkI8OJhvwn5Slsob663jcal2eiBSCsir180TtjKZiiS/lvTQkNw2JDim4wXrEfWBr2O++gc81hT2kSGi3Ppom1BDhJmUqfTGS31TSnA4tsJSsh0EAUpWxFX7fPwcSy8xnzbzwYLUQuIS7TnmHNeyO1A2ffg4FcQ9GQuSy4VFtQ0rQdkEg0ebCxXticN9tJS/mUJx8cotwtggg129/XffC/8+PkmMpDKrpyHksw5kiYh1ZbLIZUv8RtsDY8cGzXOD1RYUWNGiupltzgFicigSdwUBr50Hf7Yi5Gciwk5VmNtNvoblMCSlTamitAPU9qWABe+24xVIGTjKoTEZ6QjMzIWiSFkeVQg101oXd3zr7bYXVIBAPOfhARIlUQ1obCyl5bfU2LihwN74/TF8VlaIwlNfuuDZJsp2s2Pgd+P1xSyL1RQthwocXRCwNxsN+/v84OefgOR3XvJyGErQyEJbe1AuIoOOLJF777DYE/QYeCYG4U5F0bm8RDbcfMo8DMI2WSXFNtyH6UhxxAHU6a6ANE8drF4SyOi5IJ2QDe16NB7fbDiN5Z6Hlhnu563kX4rZcNOIEnckNAkIAP4d3Rq8DJiRn5pkQnVNtPNFSW1o6q7NI6SdVdRz19hzxixlUVBdAykWmEkktpjNp61KcdbDjPTWNgb3X7H4/XBkp7K3ookMhcOaPSqM22S0saAAsEna/Wf0rEcvhIkSYriIS5DfXQy4wHumtxw3+HZGx/hheVpKG0FaDawVOUdYFAaPmv0xM+zgW+itayxAXyWepA1NLAJtxadhoogDfvg+I6lrLX2DmUhl9b6Xl+m2lp0LCgojcrvYDggm8F+I2oCWQvK58nNUuK6hkPMJYKSDpoNJUeRo3Nbg1fOLcnhZXGzXMf241NnQ2IrrYXCdCKeCSGidYG18ir5xQ0AHSPpze1jssLyBus7JW46w0FSluqdWr0FIG22+v6jj/XF+XOsRpiymEczSYzgbSsFstLKN3PR/kNkb1tipyG691lx4ia1hpAuiFncAb+vgjvhhm07PENt5i9NeuYz0W3W9KC40G9C0kA2BRrcb74GKbRlfvb9KoAnS6Z+I8l8NwHMvTGzB6S65CS5mUZ+MWHIb+4LSAd3K2Oo9sZKACFAaY6ln8oc72K+mLZZD7DjshypSNP4a7twG97+NuffFLLC1oJQtoJQkqJWrY1e337DvhAcBElMeJ0VhckPRQwuQHQ0rUho2bUrmvc8fphiqJnUXJHJbUdasvjuNOKfMdNJU62Q3Z53CF0Pi8UozOM5lRjOwIzbwkdfzSL10G9CWii60XvdXucUu5jIey9iEUoLERtaE+nspdlX1s7YGC642WyCboSHIW11HeoQooKEnUQdxXb4wRCWlhx9TbTDoDfTJWkkIvbWN+b74EcLXlwENqLgX6yOK7V/HDCNAbMqIorMeLIQFKdd/wAhOhatKDZAN7DcgcYawOmWm6yQLFPIEvqRnWmkrajJIe0Io0SNB17cUf5YvfitRMulSU5hGBDgY6WhaHXEGzrG35Dwb9+MBRm3pEd4NSkvqiL9QaRe3Bc43Rsjcnax74PlR4MDJXH8wnGTOfR6YbbbgLV6xqUtW1goRsLBC9jthtPLhgSRfnTnU7pZL6jgBzn8SGQiN5Np4RXkOjbZdoXVWeOef4YCkhtIjXMLoKNSgnlskmxv37/fGgy3MYbWX9CRCRNZdcKkocR0ygUKKXdVp3sdx9zssdbmZNmW7K28whvAqBAIaIPcbg9vjGuGZgeL+UeHt/OrB2XFpsh1toUlrqr0RmyUJcDVXdkA+/vzteIMw0Pw9cbzDj4X62Uo2DX+crv3+K+e2CpTU8xv2eXHA0XDI6K5ACNSk1q0XQVt9arFSpqfNMGVE0MtMhlaWlFouo3PqPvuO3AG2FFwFiJ5ZaW+XLpY4gIDaglVKFEkbX3A/hjv93/93e/9f/TDOTFheWjqgy3i6UW91QNKedwe3Fe+A/Lvf+8//kq/0xOA86fhMDd/wUMQ4XtaAokq2vc3i5fUI6mhRSSSFaaSexrFkJlK3E1JSkBfq0AkpH+cf7vEd220gNLWpNglQ2HxX8cXgFlyYBU8GJUUuCz+GgEpolW//Y4tS260hJWlxtp1Ng6a1jixfIsY4gg0ohTainWknfURf6e2JPvyXqjvOuOoYSUtgqJCBdkD2G5/XFjHNs4mSlkE6K3L4jkuYITQd0kqspbKyBRJNDnYY+y2PGfcaTMmJhtOOJHW6Zc0puiSE77c+5wItZ6SSH1dRPpCQP3d+/8AvnDDLojnSROD3SQHa1qBVpqiV1W4rDqX/tVytsfLTzWbXVbIYCHlqfUFoI6aENmnBe+97bYuWXdTa0NmQytKnA2r17pG9jb2v6Vh/wCDXIMPL85czLL4UqG9FMTrOBPXjOrtTTrTZIPKKJANA4U5zmy82fdlvoitylNoaV0WUNoWkUkBKUp2NAb88++LcSDVolmbx/X7S2uh2iUJbCAtWtJT6SFc2rmtu/ODoToU15NKGwp0aS4du4O5PyMdzF/L5TMRqHlqISmYyW3VNuLX5hwEnqG+CQQKFDbFcpiQErfcUp9vqBBeDZor02UWRyPbE3wzCnCvJJmUypVziIhNpEVp0SS2hlvy6+l0nAS4ECxqJQNOxqyPcYJybJZHifxIzl+Q5ShlS45cTHEugvQj1kOL96J/hhTHVK8s28WXg2m0l1O1r5on6Uaw2y6LMZL8pbzUcxIyJRcZVqKtZQWwSg7Ek/Y847opgkE689UH+mwDdfeFY2XpzaLFzmIuXDVIbW9HafCHC3yvSu6QSBVn+GBnssOZTnjkbC0Q1l1yK3IfTrDQP5L7mj9zgvL2os6Z05Dq2uqhZbWQaK+6zQ2Re55qsM4WVQERkLcmPIeKvwXN+m4jcGvgkc4B4pNcZM/b9pzWOcLBZ1jLZD0YeiiK2O3et/4fxw6yrw6/OhFltalvrNKZbZOtB3sE1zSAa9j9cfoT+wvwH4ZzDw/mCsye8wHToCCaQB2Wj+OMT4s8PZd4bzPMJmS+II6JkZym4/TpxbZBBXZ22xxaHxanVqmlliCdRrFvEK1tMBgkTIHPsstn3gpWSx8pnjMm0sZgjQtCrJG+6wDyNj+hxbkIk5ezMjCS6FdMlh1Pfb37WDgeTLmyQWmRIQr1h5DiLRvVdOxY/wCuPZPBWQ+C0+CSvM0JYzIkuI6a70du3c+2Mxd6RcTOq7/wrEf82IbmYe0YtrBseuy8UQ29GS46GtCF7oAGyK22wyy5l5uQh12Rbrb4BbABBBB17mxf2740c7w48iYkxGXAy+vpoRdlZ7ED598DZhkr+XzzGlwHopaX+OhQ9Y+PjAUcSf8AnY4GxnvtKqoUmfJyn/Yn2KhlTSvxFMJLDw/w3Nd0Adise/G+D0RUy/NMuMv9Z/ks79T3J52Ox23GDYX7NZYlttdZytAjLsDexZ0d9sGZZmD8TMUzIsstyEWSsDQsEmjZ7/bjGF17KnDPIBhs+KVSU5pPlgvSnC/1ApAFItdVYqgNgMERs8ZjrYYmJcLgAbQT+53BP+uDZZ62VPXGQQ44akH85XVFF+xBG2MpmL0mAt0sW2rpluz+fQdiD8b4vpNJbBUVYh9U/LbBGy1fifxH4dfhpUmGh+UKHoWCSd9x/vvjPpzmEoAboc4cbC7OvGImTpHm9UVlwBshaKX+RZ7juPfFMFxMTM1IcWiQAb6jdkH6Xvix2EpPZIEnxXOp1qrX5CQB4c+69ojZ2hyA0yCENLNNuati4N9H1rBULOi7HSGmvxQTsOSfkY8wjTXWXVPtrAacb0hCxrr/AGOKwZl0kvSyhLgbUCLWDdD2P2x8jVo5KhaTzvX1DD/5B+69ObzOaJKVyvwBY0Ag3XvXthkvxAiOw2l8MLBNBvufscYx0vONtPR3ddEI6l3RPv8ANDAGay1lxtTjoBbHK96o8gf0wWHphxyaqCvXe+7V6FE8RLktl1CyhoLtdDg8D64rczr8Usl/1k3aV3o+Pv8Ayxgsgkon5nDgNnpl9YbUC4a3rcE7fOK/FEv9hZnLgOuoXKac6Z6S9aCR355/1xQ/BsEhuwTaGNMhrtSvWIeYdZxK1uURxXAGAPEGaPNxnWW2gsIIcBAJ19tHO22+PL/A/iGel9asyeUvpruO4lZoUdwffG1l55+2ZD0qVSHFjVTSK333AwnAsfXaKpbA71TiagYcmttQvLvFOZvSZTjxQpbS1gUuwhG9CieO33+MOvCceRLyt5lt5EcoIP4g2WgbkX7/AAdsaHxXlUeehtyLG0a06jHW5YJAsrF7bm9sUsNaIbVIZb6aOmgoFcd/k9rx2XvbUp5NJXFa1zKgqG8KzOYuWxfD0iI95jzT6Kkha6IPI7c0Rv8AXHkD8EMxHZLjzAmLH4Ld3sDXH7h73843fiHrMQ5Eht5xx50CwsrWsgnfGGzN1wOJLr46WhBKAqzY4537nD8HSFGnAupcfU/6KmY2TbMMtyAJdkQlTUNNhtQEko64NALRsAPzk7D2wxgKhMzfwYbL9t2slw3Q/wA5HCBtvjMy5rLURxMkOOTC8HNKzaAKuyb3JJH2+cTy/MnFapAkON0NJIJBWCbPHO4G3GwxjqQa2HHbneoWOyRlgozxgcu/aTEGLOjRZDbwC9SdVOHcBSfax/H2xm20Zm4mVDalSKfR05LZodTQsr0H6EX/AAw2RARIkOdYhY3taGxZBXZ1nm+974mIlS/Nx4AB6aE6LWsLPvXe/btiYtcXdRzm3isdRNWXusVksvTHy+QepljD8qmwx1XPSCNl0OPXe18EXgLJxDazdbuYJddYQFhxLb4S4okEVqIN7kdt98egzMt6z78liA28UfiW24aYo3z7b13/AK4WP5AhbTGZR3B1lg9RpDIK2ndZoaDzexFXtgGYdpcS3VTVsPlgbLOxnUZdmcdwxfNMoW1rQ4RTym9FjSdjyRW93gfxDKZzbOJeaiA1DTJmuOOxmPwy1ZvpJHAQgbA1h4qFlUiPFitShHcDznmXZUUmPWi2wSj1ldhYqttvk4x7bqeqkP8AWbaK91o3cAvf2vbEGJp5HQBop4vdENNHR5lDbaA7Wga60du+5H++2GK5c6HlT2WR5rvkpBaTNjE0HHEElArkge+Aojji3zDDgbS56VLKtHoHAWOO1/JPOKelrlMIAfAKiptbi6JRewF1X684S0OBB/qxwDrJ7DgzGG1Sf2W3S3AWHOpbiEI/Ogb0eRdi/wCOKmElxpzMJ0brMlzogtrpZNEgA77Da7BsYiiPKhIYkIkojyFL6iG0OLC2h+45rrg9t8OssGfu+FcyagOq/ZcgIdmhCA4B0103rIBLdrND3xTimtotGW09/Xy9AjonM649pQi5UxDjzOdRlrGXseXZBAAacC9YQvY6xuvb5G+NLl+fZlk+T5pkcRSEQ81cQt8H/iAAgfQbnGMajJaXmMecFQZsdslMZ9levqa0fhgDg1d69tsOvDL7HSeTKWHVNqCEdPgc3R3GgbH74jqNY9ha4AgqqkS4glF5Vl/SqU084w62+NDxFobRugg7HubxvJvhPMHPAz3jYLjsw21ojFtm7BACLKO47k+5xlm5rxcdWhpDjDjZ0hCtCBwb0bjY1ttfxhhmJzKBl5SS8YqPQ4sPIW3fxRog7/XGVWupt7AsOeaKo3NElDR3/wAJKCX1DXqbb1nQhdgVR5sDnF0hpkrC2XgtJSToRa9HxZwHbUzKkvR8uYI6jcYEyjrKzZHoJuv4A4+lxZ7eduZU6gtymHzGfQ2OqGgKGu0c98QBwBPUpmeCBsE1hTnI6G0NrcLAXZH50bmrr/e4whziT5qJNjNPL8vICA4dNAkGx3xNtma46IjKHipZtIA2X3++Pp+XyYpkCSwdIsSWl1rQLqiLsb7YTXMEBpuq2Vpp3CzWTss+YVGVIYYTe5WscVuQO5wyzGJla1p8kllDi2ygJacJtwUNe42B3X8DAjkFlaC/03AnqEpQsUCaq/axQvGqyRjLi02iSWWFLBT1P8RCBoN2B67O364GnTl2bn7UFXFNaMpWZzFppyPHnDoIUs3TTFNNkUBt/En3OEchjzL6NDLjnUJGgdxuaAHHJxus0nxXMnagLhRW1EEuOFHrcB+brYDagO/OFEBtgOqhQpgZU+RHQtdgPguCt/3BsLJI2w2oQ1wClp1DVaYOiReHW4UR3MxPX0guEtpIbCFlbi6qge225G4wzjZ9L/8ADq8mE+UvLHHi8ITptBpH+JQ2tFUPrhZmGWzIOezIb0Vt96OspcMdYcQKO9EGij5HxivLouYOQH5rURwxC+I2pLZPTJ3CAfegdu++K6Fd7AcqkxFMWldQ80iQlDUxhL0f8RDirLa9tdX2quK3JxfFdb/Z8hfk3H1SbDbydY6RvWsUDR2B57XhTLWvzCvMMtsg/iMh1AAIF7kVvdV9cfZf5hSCptorA0OhtDYWKGxv22wD3QA4H1QuZmtFk8EoRkhYUuUlv/jNIIJsE7nvt78Vhp4d8VZ3BiSMtakOLhT3I5kxXnyG3wF/kXVWD8GxhFHmRprqlvSUQy2gBtmPGP4p4ob0CeTfO+LcqiLkS2Y0Z6Ix1XHGmzNfCEeuxa/3G9vnkYVLagLXi3nz0Sy0M7TUbCzONBz9/MZ+SMTYzV9aO0XENmtidV3fFn5+cAOTcsnORkwMqfi1FQia2JJcMh2z+IgHccj0C+D9rm2nYuSw3prSPJyXHXUf3smy2QhaNCD+GT6N1jeh2vCzzLEkPKlz5S1EtjpJbAtpP/MT6SBwBzioO+Y1rQ6wn7zPD3XsgDMsk6lHMZmhuG62tCEKYp0pWg7m60AXXe8cl5+mTlbcCNGERIpx5ttVB1aLKHCNgFgEi/bBGfwsuGX5fJy9D763N5zzwH4ZK1htBWhZFlsbggfArfCnLluw2n0JZZUiXGWF0hDlNnmiQdB2PFEYyqTOUkHovUmgiRKrzKDLEGI5LhuMpfb6raunoStHAWNt+4v3GG3hmJJd8Nzc08gjysKUwy9MW/qcYDgWhCA0T6vewLFDCxiV1FqvzT0daQ02HZNBsX6Qs8UL42F+2PmMy6UVyMkaYkhxsPBs6NfT3F87nn64S6mJgdyfmflkIie5E6rxiBDjCHFJa6lh/pCq1b1x2s8ntviWWz22G1ossKdiOMrd0B1atjsBtQNizudrHtiGYNokPykMxCtY0uhxtAotkXZokIFdh/DEs/8AD2Y5Bmhg5gyGZGkONtoWhwglAKLo+xBvBim4AOGg309UkOBOU77KUxiTEaVBkQSwtbYkMtuoKHA2tFhYWQNaCDf0ArHA3PWYaVw0aXKbap8AKJGxQLrtZPF84BXIcfg9J6U6tCXSS0FqUqwgUdx9Rz77YlGdlrhtl2StbEcFLDbjx/CCz69A+e+CpNc4gevN9lpDWmVF9CI8l9EeWZLKyEsFTekm/wB8N3t7b460hfU8yZr6VMAa+mn8Rv17Hcj4NjB7yctekPIi5ZFgtycuDrPmJuoMrH51pO1ldEaDda+9XhS3GliRFjLY1uOHpMICt1nXQG3ycMYGvETHPFNDYvr6qSjEXo1dZaXGi4taPzlzuKJ4BHPJ5xdmvTlPNfs6I+1GaaDSG3Xg4BQ9aupQFayTXbUBeKEwXm0up/wXoiVuONPLCCKXVJv85vsN9j7Y6mRmGYNONpD8gNtOOuIVakIBoqcAGw4Fn74JxDngRfu8FgBDSDouQeoOn1I6ZCOt1EIcVpsgAn2NV8+2Oy5inZkmO3Id8rJcC3m20lAdI3Hp97Jwcx4jz15apjuZzFvNPIdKjSqWUBvj5SNG3Iq8ICXDmA0MqbSTs2Bq29qx57myQ2SO9E1hEFyPmNISX4SMwWxFYeCum8g11KomgPjC/rOrBcdHUNb3dIPN+1nfBkQtuyVty5DEZDiCfMupWrQQCRQHP5dINfvY+82qfDVFffbQWyp3WU0HCbUdagLUomgL2GBc4OMgaKhtgg5DCUsoCnV9e1dRtTddPfaz3/pg9yOiPpW5NiNNPwkyAmM6XTzQbXXC7FkHi/tgVKlSC0wqK1TaC2lejR6tV2T+9V1v2xwyng0iOt5bQShxvQlNbHej72awkkHZEGkXBtz8qxsFqOhx0JLQcUUN6wHAKG/HBvniwcUOrS6hLpmFUhaj1ElGkBISKIPcnccdvnE1Pv5glhqVIfWhhGnUfxOmkbCh7cDFCVEKbUEt0NrUi0kjHi07FeEJxkRjoW+lVGStgIZeCgelr2UaIo+klG5FFQrjCxaenrbb0KAOlS9IN/I7nj+eJS2Jq4wzBTMgRHDobdUghBr90Hjb4xYIr0ZqM5qZdTJQFCl2GxZ2X7Ha69sODXZjFuc+qBz2kQr4TbgksGKdbkghtTLVkEEihsdze9fAxps3yx6C0YWZtvNzFLW30TZ0aB+GgCiRd8WRzdHGVU+7GffdjEx0KUS3oSQKJ5CjuPg4fx88ZR4YhxIsBxObNSlvnMi8VejYhDaCKQQsWVjc3WCo/K7QcBpbxHN0slwgjfVWZu5B/ZOTojwVxH2IuqUbQrzBW4vewARQFUd9sAZ1IiTl62WjGU22gAVRc3O/04s3hllEZh96Ww94mgNGUttLy5CnEsLJcX+Io1ayi9XH73uMZ9wSksv63m9MZFobJ07LPbue2NkNZ2TAPqipyHQZkc54I9phjqzZT8WL0lrLb8XpuJcjoC0EEHtZ/D7kAmxgacs57mqpEt5louiy66uymr/OQL34si7rHRFW7lK57XVRIQQkBtDinCbWS6s8DYVt2HHJwBDkKjZoJkJx2K6ysOMLaXugjjft9cCYywLc+w5dOJIMoYqDjSWmSsp1E9M8q/Qb8Yo1/wDP/wDlnDB1p/8AuyyGVKcRrBbcCjRJ2VW4IrjkD64s8rH98l/+pc/1xPU7ECJXmuOoQT/4f4SQ3TSzSjspe/cc/b64rSlzQVErLeoAlJ2sg9+LwYwY8dlwux0SFuNLaQHFEBpd7KSRzXztvgmRGGXiTFeZltvaigtPitGwpW3cG/tiqoCRDgTCxlOTZKGmeorR1AEWADXPbFshTLUl1MdanGQqkuaNJUPf4vE3ekGFKLjepKkgAJNr5sjsO2Iw2XXFuaGlOlCOoqk2KHJPxW+DpOLTZA5sWU4h6bjpT5VZDawSsXyatN8q9sMxGfZ81+y84bWwtsjlTS3kaNSxR+p2J3rvthYHmUKUW3Fp1NpSTpuztqG/88WSv8VJ1JLYHpCCOL9u3fFmHZmdKBxEQq21LVNCnwp1f5SFHcmv6YuhyHI8sOxHnmnW12wtBCSDxd4IVIjPZSITkdtp5t/qdRLQC1p49aye17ACsANuKZeQEoSTsUcG/a8U5g0ZShykm5R0NNPMtlTLaQsWQkK5JBFX6+MXRXMyXWWtvuOMdQP9Hq+hTlfnomiavfmsRzFKoa38uaQ4ll3plaJaAlaHNG9j9yiV18c4GmMJaUhgBII0lS1dyRZ3HbFlN7g2W2S8ubayk2px0OuBVBILhtQAsnar/wC+DIUJxbjPUU2lLm/UWCNA7n9N/nArT3Ta6ISEOEkOWlWooNHTuaoV9fnBgdQjpqvqPp/MhxJ/IOAQdhQHa+cX4cuczM5a12VwAummVMQlZuHJK3Fx22ysRmlE6xdLAJ27X84KiSW42aN+USumF6keY9fG429vjC5uMmI7EelNNOLlAKbYTJorBJHqKT6N9qNGjt74vgvPOOtLYQglCyCFjhYG5JPv9e2IHQczRe9/P8rrUibbL0fwpnkuDIcW7I8u4QWlsgklu0X1Ntq32AOJuQnc3Hk5LNTVvr63VeN1+4vj0Abi77/GM5kDEALaTrQE1o8wQtKA4vnat9FkEd+eNsbjw4JMnOE6XtaiW2wtsa9dbCgORsPrjgVqIpVs4Ed9l9P8NpUXtLahFvEIYZU47/e4zK4qnB03kNE6EH2FnggXycanI4NtFDzSG+goI6tBskfTvXv84Z5dlbQOgIF6zoWhNffGigZK7LkXIJWkCiRsTvtjm4nG1XQwO39fFfSDB4LDkVYvAjuiNEt/Y6n4jMsOkOIO1Hehx/sYEzTJkSFvPPybd3dtxz1m9q+Tvj0rK8pSIZR0yPkc4WSsmY/GPVQekR1Lo6D8/OFUq76VHITFzC5VPFYR9d0iST9V5ejK0RnWpEVIZcDmvqVxVcX9L++BpkZbzhkpQSCSRdDvv/PHoEzKEMhwdHYca/54TyorjcVx7yrFE+v02fp8isFTxEdhi+loHCkZg2+iQQm2WYhmFbDiWJKAYrp/xea25rkH2vGbzRSZb5W5Fc0knQGz6OeMN5sRwBQdKw1osAJoVt2v6b4HW10ui8yt5FH0Gt6x2sLiCRJ3XMrUKbHkTJ2/axedRlOOSZDRlNOlxauyzv8AO30JwJlTbDEllPlvMKDnrLpJC0CtArkfbG3lspDTbugLaWS2pwcg9xfOF5yFJWXmlFF2AAb0H2xd/wB7W5mnfnipX/CDUyOadOdELIjKEN15xKFqdBXRB9B3vb3xn4zsgLSsa7/L6+Vgf75xtkZWZMJSHO4rWbI+/wA4HgZPFRIaVOS84lCx+SuPj2xxKtTNWuuozDkUwImE08KZm/DgKnMkdQoKEByu/NgjvgIGTJzh2S5GjoLa1ktrFNk1wdx9cF5nmjr0Zhp5AJjjoshDIsos0Vkd98fagssPuPONpAPUXdlz/T2w+iBOeFzsXQPSDdZSZIMdgOpSXqX0ygLpCBVhfz3wubdQ+VKKVl+6CwbN3sD8fONfPytolzzCldNCAF6xZ+mKHoLfSLTLZtwEo0e18H32x3MNUAJzGQeu3NVwa1JwggXCGyXqxsslvNxmyt2m7DZAjkrO439hW/ucNoynlMMumbpCFettI30AfywpLSi0WNH4iFlTgTe4r+nP3wJIMl6G6JL3RcWDtQJKB3+NgMOexrnZWix5zRCxzqQzOOnutpludNSszZajLjttBd29eigL7b71W3v2xo83yZMXJ4uYlDhiyUDpqI0Anugd9jtjwaNnK8sWbZcW8hQcbpZvRft7Gx+mNdk/i57P3Woi5LbCW0HQhx/QgbWQL7kgUPfGV/h5tl0Gv8XNqfERJMxzqqf7QZz7chxGXzCgFZQw51N0N8Amtwv3HtjzjLPE0jK8yh5gp05q9Dkof6UlOthYbJ0BQ5WDffDbxZI6kh1DkxDaAyXKIvqG7rbvjJLbSxI1S2XAw6VKHRcClqHYH6Gv91jo5W02NaBJ/S+cq1jUqkSjVZxJkyJDyVJjqfFONN2nXZBI9qJ3rjbDrL3FOrbZaCyrRbljcLFk/XCCayx1Iy4y5AUtgLfQ63dLHIHuPrvzi+A49HBUHy2NAul0CCRt/XHIxDwH2XVwudzZdstSZTjUhLDqTejWgFvkE3YPfGsgZqk5UkMssxxDfW42S2Q+5rAv8UdhW3teLgz4be8Px3nXpsvMjFWy4zJJbbjO2OnoI/Ptdg0PnCCQ7OyqW3GLI6jSwpYdZQsWN0Ak7VRuuD9sIa/M6CF06fzMhkIvUyISXghbj7hIBuhQ5Rfvvt7k4W5rm0J+IzAMER3GC4HpIJPXoillHugEjasUIkqMd1LpIU0NatFc/wA6+B8Y+zCSy9lEiI8wyh5ySXnnDa3Ft6NkVwEWbu7334xQ1jmjsHXn18UjEtBEkJe7BYdy8ZihbLYfettAWAtYO+sI7IFG8UeLIXhtETKEZWuay6430swdecDjbi+putkDfRXF/OKYj+XRWH2pCVPpdYqK5HcroP2N1gglYCL2Fb99sLWHoQMtzzz7Sn4rgWVMjde9I5qlit+QboYAUnCMxk+y49dzCbBCpi9Jx/y7761NvkN0zsW/3DrHB34rDGKh/wDYkt4sRJrLURqIHJTpQ42Vr10yknkb3Q4JPfAeXOvxUhal9NLD2rWy4FvtnQbKQTVHaz8DHcsky46Yj7M1aEw3OqlpDn5COVi9rvAU6TWkOcEskGyKyuEgS46mELzF9bnSQyASFjYDjf3oEDBD0yWl1xTK1wgSOoholv8AIbAWBzRA2PxgrLIq22GHklHQdpxsLWOotaDRRaDY+9d6xocwyLJ0eDUZkznkFmZLlFp7LV2TH0CwvqVtft84RjC7N/8A1OnPuujhKNIsk6pJ4b8GZ94tRPzXLMtkZiGaVOcK7WCsk6725OPsngtMzHoTjzGVXGWFmUhZ3AvRsCQVkVx3wzyrxz4hySOnLMvzBcVPoC2m0UHq3BPud8D53n2ZZ94hmZrmCwjMJJ6rnV2W5ffYbCh9KxyYrh7pIjbu66rqjCUnNGUIyFkE8y8uLrTwclgSWG20a9aDsCPcHehgbMYCnZCWEz0RWyysnqWLWEH0bA88Yhlcx6FJSqLJV1dqdbcWgtn47gg98clypJiuw1pQtsOXbdFZNaK1+1b1wcHXdnuBZRYhpY3JF+vO6FORFy4hmPlzockUgGSRRdJQPRoWfRoNjX39sdydT0bNZDuWSno7jiC2yuyhZQUUtB97Fiu94W5gUOOKcTs40EettOgLXdGgNqH8ecD5VNjmU4jcugjjgb4idS+ZNguU7ECmYK9E8DT5/h/N4WYQG2y/DtTPUQFAr5rfj7YDz1GZeJfE8qSS23Nlr62ig2hZokizx9O+JZdmjaIzhlxi+CCltaFkdNzt9e233wpkyblB0S3AQsgjc377/wAMKZhYqZt9J7kypjWGllCY5zGZGRNdXN0OKko1raJshZIsgVQB249vphdlby4yFdMr1OMra6jgDh9Y3sng1x3GIzHpMXL3loecQGkLQgGlhsLIGxPvVGsfL8nIhvMoziI95SOh2OW0G5Gtyy2s3SFos+/tvjotw7c+lyuLXxBiSdOflUSBHioS440zKSQOo04stgjgkrRuKNH7YzU1h4OK1yth6AsJ2cJ2O3YHc/ONOptSoCkuPMxWXAtw9YVej9y6s7igPfbEc+nftvL8tyoQmB5ZnyrC48enHStdjWf319v4Yjr0nfMygW590NHFMa0gmDzyWShh5qQXWXXEqRYLjRqq43xGHMbiQ0xkPPIavqbbAOC+3fbvhvCYDUebDXGWXEPEWNYLRRes0P03H3GLsge/Y5azaN+xuvHc1obmMB4uhwFBtBsEI53oi7F9jFNwGVvnzhWurg7JIIacwaW+hmTIzDUHgG0BxHTGorW4fsPirJwJNS3+LKbeKFyAdbaWtBBO5IrYIPAr6Vhq4cwzOROkNtftJ1DLjjigzopoCi5tVAADbcfXfCmfJW205AQ6hxK3kanC3ZAQDoKFcgbnbvQ9hjz2h2n763TqbydUVlinI+XOsOhbTLim1OJRRU5oBO5PHNgVfvisMRg0oKdDbR1qQ50yeoRwAPa/0vvi7JswzHLy6cvk9K2XGl0sLpDiKc3+bxCR0/2eylbKVuI/IUr7H3N9q2FdzvsMC1pBcVlR+YhXR24jryYDKHX5SwgodQChdiytGneyQaB+OMJXAGndCkoWHCaQjgHtxhhD1sy23zoeShdKbJ2XXrr37YIgtxnWpPUgFXo/DdDhAYs2NgPWa2398GA+oRAuELHhneEN/fHmX3GkOhltTaSlps9NHIF1sDz9bOJZU82lT0NxiM8JKC0Fr5Q5YIWCSNBsUSdqJwyy9pcmE+y4htlbFEI1FLhRewA7kE73vWG0zwdIPh/9riRFHQebZLRv8hQtYc1k1doI0c8YaKDg0Fk9NuqIPDiT0WXjL81HjQ24DLzzGtxSSNBcbAsgn9QP9cDBLciUJEaIIofkAQYzThVSdX5QV+xoWeT98Hu5JIbYdUpnzDNfiyAr/CF6KdSL0WuqJ322xBnLIqclfW5J0SELtMcUoED577YUA95zdOeqcC09mVYUKyvMkTMqzIyZQjFUtKotBh0lYcaUDYcobk8G/jAkBsPuMhCZEl1C7KWTVtj2VuQbvtiLba280MToNOnqHprFDc8EkitHeiKxe1PQzKdkxI7SemwG1APGlitBXfNrPbjfDqQmztEt13SEImOvWksMrQhevQVD844N2ffbBzU3yvWbydxzW82uKpagLcbNXQrbg97+ccfhMwsyjohS4Oah9jqDpNlddyhaasEUfsL4OB470VmUlaELlR21nWG0aOqPjmrA3+LweT/4OnqtB/8Arf0VMrLcxbYUyqCpKgrW4jYrTYB/JyjYj+GJx3mWWUyoySw5rAQA2ChAAFmzuTdH9cFeKJcjMfEkqY5COXImFDrcdLq3QlsgaKWokrFVuTvgYh0gurXr12CVmj9/jjDgG03S0WvqsBcQJVjY/FDzfUXrok1u2b2I3+vtzixmNGWhL02S1+GlZS0pRPVrctkI3RY2B4xXIcUht1pDYb/EQaUzSwRfB7DfgbbD2xB/rrjhsuI07uGtid+/c/H1xpc14lAcwcrWs3fiO9RuIh1biDrcU8oq13aHBvstAqu224vFMeZEjuJW6JTyXOoFIB6RZ9i2v33Niq+uLFRYrrAbbX15SCurRoQgI9yf5YHeelxoyFqkLSHCFt6HBRsWDv7bg/OFvY4GdY9k6mcwvugnFPP5e23br7ERNIAGzQJJO/ybx1lkuutOBlwIW4QlSUE+utk2P5DDCVLgBQTHiKdeccLrskuHWdaBbekGiEK1G9ib3rC0vqKXkuF1xlSg7RHoviyO3OFEtiee/oqDY2VxEeU904LDmpQAcQlwqK9gTVj3Sf1AwK8kuBLaeuWTuU1ZTVgY0uWQctgSFz9EtlCVsvwnX3y1pP5y2dAtZI0DUitGoHCpC3n57kkSmIrjbwADyigq/Mb47e/axibLLZHumh/VMFjKp2TxG8v8OS2JkSOtc99MkrbdCnE6HDY9KRdVe9p39x2lQm21vtxmZTbSlOLakhYWtKiQkK0kC0c2KsqA34wE2z18wdYiqdeSk2hK1UpzbgBHJ/p7Ya+Kc5y7MEphZP4ejZTHUwypVrLrinENaFlLi9whZs6MU0CGS5zoI03QEaCDfyhRlxM+b8PQZE5nNF5G624rL3VBaWEuWOopHbZdXWFUZwvNLjMsslCQCVuE6khO6iPYHvzhnmmeZtnsFMeRIeXAgBbrGXsJpqMFp9Zbb3CEWE39bwuliGW0uuTjIc0gBtDZpI0CvVtuDe1dhvvhFVxGpn1WgZtoRmVzVR5bL8Na4xbcK3JCRqW3uQKB5IF7fOLGpTLwZjuqUtEdTiwwpZShxB37fkuhe/thZClNNsvB2K46NSChzrFGijahQ5v+HOJoS21HeqQlKwhLyU6xZJNVex47YQZLiYvZGWRAmyeqb15AmKiHCVNbmeZGZol1rb6QPS0Xo2O/F2aPNYTrZcLzUJKWUuauo2paADZHGu/yDnfbFsjM30SsulMTXgqM2EptoVHsklKBwUb7Xit4LjpMt6Ihl58LCkusjQu7FoFUP6bEYuY5l+zHnPLJQcRzm6JLZEKVMRKEJ9JQ0ywwyv8AvCd0uEH92qFjvr+uAkxB+z2X0vtt7H0lVUBe5IHcih/s4JmPrlvx0JcC3HIoaKgiiTZq/c9r+mLWYc9/Kxma4ra2GVpivpaIaK00KCgBaibG+52++ND2HwPXy0H2Tcrj49yXMMtPqUtyQiOlKCpJSLtVbJFbk1/HkjFN5X/++/UYczWoralycu84cuf6THmZUfSWnwEFwDRdAG6o2QN/bD7/AMIeFv8A9ZHhj/6KX/8AyseqMfNgsYWblY2GI37PlmUSlygWCFcqBG2njg4uhZo/EzKLKWG5BaWh3RIaDiF0bpQPI2ojuMKhor16rvf/AH74IeQS4vgJUNRperbnn398VEQRl1HPBeFQluXry6+nlTq1yVxw048suANim996A7Af6YoS42HFrSz+YGkg7D5+2C3XlvtxIWpxLKFHSguWApVWQDsL2/TEMxaejyGnDKbeWttK7bVejtR7XtiXM8uk6onUwB2dLJjGyhUjKJ0/zceEht5pgx3iS4srCjYFcDR9dxgVuMoZk3BhokLW4saAtIBUO2wvfn3xJuQg5U2lmIpuc1JLq5nmD6hXpTo4FGzfO9YsQ62wYcqGlCJcdwuJSUauFE2sk0aocgWDiiln/wBAc2Si5s89lVGmoaz1E+dDanMNyQt5hKum26L4tHANdsR8o95F/M29EZvqANpUoguWTs3/AJq2vvxji5XUUXVoO7tiiEdM3ZoDb+HtispUX0MdN5xKlhxDV7LF7cdyO+HPNy4m6wiQAEbJfzbxR4kU/LlOZhmMxylSJLgCnTVC1KIHAHfEM4ejuuNORGnCyhhA1upQHNdDXejY76qveucDdMJvWzpHq5JIJvgV+mLYTcdbi2wmQ5bZ0aEjm+a7gC/bDqdWGx1WfLJMhGIMjNQxFairW62HF6m07qbrWb2s1RNntQ2rFzKHEtqd0OJcCOvZVQ6VdrHJo45lrao81oxSiSgqpsOHph4XVGj34q8FqZjNOKYda8uEN9NYdcJWHK5o13vbgb46T8a2k2Zum0sHVe5ClyKlxchmM3uAQi+o2OxvvyQRx7Y0nhfJGl5yqBmeaR4d0l5bq/Q2Cd+Nl7b1YskDCVrK1OPJbD7DJQK1IdFkbm7Gxxr8vgw/MUHorDa9DZ6JuqFaxdkXyfricY+mASTcrsUPhGMeQG05HiArWoz0g6VpecS2pay73INBFgcDasekeEG3W224jf4LZKHHPRa0EX+lb8YVZJlkXqSEsv62wdygBNoBq67dv1xv/DggbMeukJ1/BX7V/XHDx3xii0CWk+S61P4Pj2E5qUD/AP0D63WnbiQYsCPJafLznTW4+NFe+1403htKn4bUptvRrCF+9Xvv74CyvyiFp0NAr7WNj8Y1uVNskFQT8i8cankr1M7TYbR7o8diHtpCk4Gep+llNqMK0kHfcmrrHDAYLrim2KKxa6FX8k++CJEZtzQkqWS2sOD11uPpz9MFJSlQ1CwkgGsPDpccw055LhvbplKxeeZeHGj6DpH64xecxy2goKbTo0gk/kF9++PVs0ioKFO2Ae9YxniSDGeWHX3XOkDrIbG9/TviGsPluzDdd/4Xjy3sPK8rztlbTYW2RRJQSF1db99q74ViARCde82229Z/BWaNDuR2+MarxBGTrLZoj99B229sZvMNaZBeeknqO1ZWsmxXF/Yc4twuPbGXWF3aodWe17agHUGEkYKlthg/lslA32WT39vjDjL3FF/Q5IK3XUAX7LrY1hV5yKm9BBBWCQF9+/39sXrzXL24YorCiT0V3wP9jDatbPYc/a71Gm2mLkXHXlkZPkrgQHG0strU+hYCyBex3I9vr84ysvNm2mrNLJWB1Ef8P0ce3/bFGcZ9GkIQh15sOE8kVr+Vm9sZ/NZxSkzG5VKkILTgaNWgdiKoA/0w9uUvhwuosS80WHI4aptO8RsvyAhtAiMmhqLl8ck96wb4fzSWhuTGl9T+7OBfScRRRfYg74y2WzG30S0rMdh1TOsdV3QF6Pz1f75/jvhr4Q/Zj8LNHnmXlzEsB2OUOo0Cv8Qr187HgYqz5HSJg6+v0XFr4g1B2iLL0RufETES3LQesTXrWABvuggi9xRBxSYyAgIaJQq6A/cN81/DGO6zMpoxXlvISKNAUVi9xfY1jX+HHGxDSA+HiRZo2QNx/LHQZTrtqGG9nr37WXKbWYdXXUs0gxpGSSltJQh1tGtGvYrrkD74xOcRloZdaS/10kCS40WdP4YAJo7kDc/QD7Y9MfZQIxWykgMIsbEgg87HjHlvjCV0swLERYZC17DgC/c+w9sdLAs+a7snTm653xKu2myXLHTQGXy8XS2o/kQ2q6QRfPxf1wT4eTl7bDz+mY5NVJbMYRna0CyV2Odewo/64K8Q5CzBZacgzxOT0GH3kBC2vxFgkoBr1gAA69h+mAz5l5bDi3FhSGA0emgIFIJ0ccnuSd7x1XMOrdOvNV8n80VdvJE58wue8l+I1F8w45qbS2r8MA2OnoO4IPuf9cKJUaIzlKWEJ0SGnVrd6nT0FBSgCjWskG7Fn47k7DLM2bOVGC5lUXoIooPTorr/AJ7veyThBmcZl5DKHENj8QuhYJ52Av2H/XA0qZeJiSO+3IU9St8t0bFA5DAkNLEmkLbQgPL7kN3R2P5+4rvg1vJ1S0TJoWw203rdDiyGg5zaEI9/gcY9U8ERP7LHPD8KVnk3NBmBU8l1ltu26G6SOyU6zx21Y87kxWTmDjzjMdlsrX5ZvUCT72P0+uOZWrNrEktIAO/jzxsu/h6TqTcpN4TVKRl2XQ5k7NERVyIQUwg06QRwCAbbBFfnF/0+fYmSMoM+MyXGW9Cy4sjQhZ7V3Nf1wj8VwpbUdhZzFD7c1tEhxrzIW5aAQOp/kIFgA719cTcL7caNIVAS2w4gllYoIXRo9Me1jc7ntiZzIaS8x/JVdLFO/wAG/wDUXMXJMcIQWdNAL8u3XUqzZ9ucLJLlFxTakH12PRsv/X6YbNvB2P1lR/U4PwXELIAIO4IHcj/XC6YrpyFJZeLbQ30LFFDh2Wjkgj52u8V4emGtAbcE6/fm5UuLxGc+XOdECuC2/HTNU8G5BNIDi+mF3d0aofU83WEqmXEQ1IS4WvX1FtpHsaA+e+/zh+88hvKiyWUJjuuBZcI/wzuNu/H8sUZi/wCGl+HQ+w7LRnHX0IjIZ/A6A21lazZcJ7AVXzip1FsQRdch1QgzCTiLqDDrqUNsrcDXUUKCaAsroE0L3w3zKMHYseVGiyfLr1MxZPRADhb2oBAFrA7nc2Cd8KT5wNpQliQlbyyQhQJR29YBG5+l7VicnzOXPR2fP9RnQ26tyM/qAJ3G/ZY7jsRWJm0sz8p3QOc7LA0Vi3GyjRsFBH4hJB1k+xHx+mPmy80lKVuLQhe6FK4IHfbbba8CpDsaIoKC1NP7oCwQCR3HzuD98SmllK3uv1WrLZbC7KN/zrJ5rj5/TEtcFhKqoENEq+W+20SlDaUusOEre1ag4eRQ/wB3jkqa+/MDwaWlMmzoQRSRtdD6++1YFelqhMzIL0VovrcpTi0EONfQ/P8AK8UZZl8rNHHehHQWGRqWeshBANgbrO++OTWogmedVd/3PaMgNvumeVPPM5imKplXXQ9odaW3uDdb783thqJTnTLL9x9Dxbc2FoN8/bfC9pzIGDkhiZzIS+4yRmS5MKxDcK9ymjbgCN/fesDBpLWYramKQzHUgim0la07WCE3ydjuTVnANbJAI54qd+JLmzz0TLxH0mswlDJprkxpiyHSgIW4Oy9H05A2wHGditNJU3oQoPrtpxZ11Qq627Hf5wEZb0uS68lbbBI6h6aAhA96rjt9d8XQfxZCWzIbY1kAuKsobBO+1dgf4bYe2k0ExouXVdIutTlmcogvx3CwX+grrBCzbTh1360EcUODzi+E71UEutAJolQ0EWSs0vftXbbjCzLISCpmJ5mE5IdZdvVODaG1oC9GskegiidB/PYG2AYclcXpuonynVSf8Rs0Sd+3zd/z71hZpNIbbXcJIzAkTpt4rTyMoeVH1lBeK1dQIW9QQiufk3WC4UiPkmews3idHNVxVNOqZmxwELdG69kbLQOPmxthDHfXNQ49KeUy6HA6CtZ6khayAhGu6P75s1i1GYSMvU/DnuMmLHX/AHmCXF6HFoJFAjkg9wfnfDcPhWAOz3mR5fxT13vLmlliL+at8SZsjNs4n5wvLENtOvFyQYySAizvoI2AvYXzi/xXFiozxuFC8q9EzCMiU3HZllzoBbdhDjlA9Qcn+uMbmc6S3HbhpK0dJH44QAA4i9aNdfn5Js+9DjBogtQ5yY2dt9NxwNlLZ9dNuIFLtB3IBBA+2IH03vcKVOABa/hb6I8jXHO65N0ZkUcSnFMBpCWdADklxzpNthzYOrNWUD9MAOuurjkvPId6biAhCFW4Rxt2rgf7OC83XIyzPdMeW1NcjLWtmWw4V62kUEDnZA0cdsBT5LLzrUmMojQhBOtY1697XVnbYknbnCjUyPDRt4c6fleZTkSBP1THKHlx4TyDBhPJktrSXHka1t3tY9jzXzixOSws6zyDlWTMyUyZC22QJLyK6h2u6AAvsf1wA1HLBLLyl6m11be6CPe/0xovDMoZPmrcxDMeY82yQWZLJIRdgiu+29gjc/GOg6matPsGD39e/qkir8t/aFuaK/OvBOdeFps7LZgyl96JGcbejeguLQ24N0V+/wCoGyQSB3qsZcNFsU5HDyAm7sjkUP0v9cOczTJjsNeYW/05CA7rcG66WUWTyN7G/wDHBcbMsqiLnxhl8fOWpMVyLCModJxsrIp0aDusEbA2BhXyHUqUEybeHfHndY+sHvloge+iz0RC0yo7kkvoS2s9RyPTbl8EBw2N99+MXZUYbcXMmpHUW8WQ3BDQOtDusEahdAABYJ35FfFcwstxwwHHOrZPr2G3A/neBnkJSwt5wDXtsZAWVkk7ne9qP8PfDX4doAiQUxjzE6hGZa3JdjS8wbjPvNti31nlsEgBat+LNd8XMZjmDOXPNNLDrMltEZ4Eghe97BdkLG24r274SP5qiO+4y0srZFpBbSWys1VkA/8Af74k9JTl+ZvQpEZS1KZAbdako/DdWAQskAhYAJGjbnfcYF1QAJlOkT3BMJbQjxYQYZnMofSttRc/I+6hdEN9igHRY9/tgOc/G6rrOYximaUlKy6hYLZA3WR73tgZiY6EOtqWlxiPG6Q8uOmF72TuNzY3NWaBxOKmQ15bMHncsmsdcPORJD3oKqJ0LFhZRQ5BreucKJc62g3TvlZTKUOzC6goIOxsH32rfthxmDrLuYKERxtxltlEVaglDZcQKGuqAF/rtZ74jIaalZopwJg5exIWhxXQcJZYQsa9gLIruDdEUcUSyZzXXffhqc1qShxDfrcGrYrAHfYCxxjGCCYNvTongQAh2H+mAxGSpblrSlxJ0qbCiLsgb7X+pxo4fh7N40OBm2ZoUMtmdRmK6iWhrzKWyW/wjvrAXQNDj63gnLMt8NTfDmZOTJebJz9lDYyplCAW3kJT+NrUK6aALPvXPfCHLZM/Lc4izIshhaoiOshLw1oPcgoPf3/nhDm1GEFhnu55I8zLh3qjQ47mAixJLUJt6M2CmQ22vrrCAQho1++eOLG18YI/8PvGPmk3LnhIhxng06iUA043rv8A4ZO59BBIsAd8CRoy5E2Yeu0wlZ64kuOUgC/rvZI4sg/fAgcklt4dGO5TaFrLjg1jeqPfe+B8HF3zdXVBPLc6Qpcsw1tkWYsYznkfgx2krKWVyH1lFDdaCa+3AsnvgJwJSluNbxaRbrjRKBo2uwe5ICcfQmHOkpct96O4+BodkI2VZ39XNfPffFmcwm4GZPRY0th8RyWXJDZphwi90E7mx2IBwvMDJas3hAZitvSW46y4EbsuIRRNcXvt74rkOIMDWiP0yqkWd0D3I9jYP2wwiPMtLb0Lb9CFotxGtGhYokEbnazR4xTMU6csVHCy7DS42sJ6WjiwCDzui+d/0wi5OYnVUNiwC+zNl2IzCX5V9guoRI/FZsyLvS5fZJqtN1zgErffQ22rp6w8shIZCQSd6JrfcccDDFmcZa2o0nL0yEKUlJbaWQtzckcWQveqG2/F4r8TDLWYGVx8tfkvDplctp1RAbfUfUkIIFUAlN73V7cYKpDRY28/wmscTrqglQ5IK2JCJCXm2C8hFGkCkEL+LHf6Y+jQZDs1YkuIjOIbW6hL7mguED8oPue184tUubGcaceSG5CiAdadIocBSKog183WOzZMeY1FLLKELAp9a10t1w7lZAHpSLAFdh9cJcABATgShY9NKP8AeJDchqtCk+gJASSR7g3t+uK19JUJhIoIAUpQ0gert3s7fTBEJcbzQkSozqmmkIUEpXsulJ17kdwT9CcdDsBDqpLjLkoKWmkailIQQfQoje9hx84wU26ytLiLG6qnRmI7bLJfR1C2OoAP8Mk3RI2XtR+9dsSy5Cl9RbjLawaGhRSlSify17C+SKxPMFBDw/u6VJfU2+UFy9IINN2D7e++LFIkuSfRFW209cdsJRpSvuAa5PH8MLeyQcqDNljZQy7L3pEdT8dxKvLAqdbNkHfg/BrHW2X47vVkJDbyQh5CXGhRvcbdwRZ9sN8qS9ETJZmpz2FlynmmJyGiB+Qg0u63HrIvvWFs9aOrqhrkCMgkNh1QJAN+3F1dYWzMx1/5wrH1M4VSFsvB5xwoQ9XAJBXxtXHbBjDy4Rjy2JbCXApetJGtaUkaDdgg7Xxx9xhp4eyrz+cR0NJbzXNXJzKGcvCF/wB8JWDspBrjYjbnbjBvjXwn4h8PuxHsx8My4Pm33+jGkNg9Qg6yEAesoCFo5w8SRLhY88UDSQbHRK/DmVszFPZtnkOWvIo7TmtyO80wvqUK6YOyyFuIJQATWF01OWJgAxYs5KkMIQ+p14UJOpW6RpvQUAUORR3xQ1Gc6DbrDTgtNHXRbPc7njYfP2x9mEOXAcLLjLYUEA9VO4I3qj3v377Vg8sDNv8A1ND5sAiA6+/HiwVvuKgp0oZU8pbiY3qtwhKeO5qia+cL+lF//Crf/oc/0xEl7qOr6rby1ppwuclS+a9z84Fv/wDh0focE14aJcAZ8fsvETbSEfmqIQzBwZaHERE6SgOqQ4vtdkADknttxizzyIzcmPl6XI7LyS051Fet1oqSUpI4B2uxgRlta1oYQBrcUEoJXWx7HtW4xepcSNKLLkFEjpBKXFdc0SF2SkiuRt/HFGUZb6LCbyEI4lRtWsoCfSqkGgfb74Y+HJsfL8xZlz8mYziM2hSfKulSUKKwQLKKPO4+gwM8ll99ssOst9R0gN6jpaGva1Hnnn2xfkMZDsyQoyMtQY7LrwTNJ6btDZCQOVm9hgaGZrg9q88AyCuIS/LnqagMPIZfeAQzrBKlgbWffc7/ADipLKQw8thyQp4aDpbTaQ2diFn4JSOKOKG23XD0w2ta9O6QjkC+APajvgrLlkPhExaBHfCmw46haw2DQLgA3sUMNFQuF9ecCF3crIUZD7RaI8xTTjykNLCSkC7vbsBf0xTl8iIgspkxtbSHSpfTVodWCKrVuAB9MXx48N1vyhe8tK12lx8ANaNCibNWCTVDfnFDkxT+W9FbEfUhwq1ttAKo83X8PvhlTKYzbLQ47BShQ1TXWmIQelSHlqbbjMNnUogCiPr7c7YjDdlvOlhIQVj1lZASpISPf2rHyFPsJRLCihanLbKRWrc3VbgdsMM4jtPZhJkOSox61SEiOimyFn8qR2r2PYY8AZl2gRCwsbqiSTFjZe8tCGZBRqQpCkEKRZpRA312Dz8YKzD9pTYSs2lvdZyTLWm1vhb4c2JK0H1mwRRPscCZuw6mW+gqiSVMMNlbsatI2T+p3onHXmW1ah/dArph5QS5YSmhxvese3zhlPEZmdptuXREFrrG+/4TOHKWFojy1dBi9aWy4drFFYA23074YwM0MeYpCZjjqmyA26m0Aiv8vN0arCSK88wtqQiI0jpJ0qH+Ig3ZGq9rr2+DzhpDcQVl5hQLq/zldEaK3u+/zhrwRSmNV1sBUe54AcvTvBviNGU5fMZgzHGXJiFsPOOMII6RA3QOepdn6Y2fg59CsvYeS51VH06ljdxYO/B547Y8jydxDeXF11CNWohay5x7ax2+Pejje+Es38lL1raQ48hjp6CutBO97e3t84+b+IszgPGw53c6L774dRZ8sgCS4g+K9oyB3U4kqUASd0e2N1lTw6YUa52rHmsWbJENUyS/DWGHulpQ4BR07Vp5Hzh1kniBSilsvI9ayPSdiPrjlUsS2nGYG/cpPiPw99ZuZmy9MY/EAUNxf64kv8NBXfG+EOX5u0tYabd20WL/AJ4tdzRn1JW4EbCrx0v+ikQLr5N2HqA5SCkmYJzFGeOyVTSuGtsARggUhd/nv+mEmezFFASh1Z9ei/j/AH3wfnmaMgpQXkjqGgb/ADn4xh/EGZRQ5pceC96J7j5xx6MUy5tNxuZv1X1nw3BPqBrntv3Dogs/bQWA8JJ6qyUOCxdfBxjM+hPHLHZIecWmOoIIO9Xdb/NYZZ9mzTgU9rc6ei0geumgaO+9C/fCTJs4ypeZpbzRZ/Zq3GxKbQ+UFwWSDW9nn6Y7OFfSMgjVVfEcH8uKgAJGunppr09Vj0MvSXPLdYB/qWXHF0GwR+RZugBVk4D8aNScqzmXAfmwFmNWtUZwLbIr9zsTX3xb4imQU5o8uGHmMsf6jUZRcCSADwTW/IvGTkSUSlPmPaCpwJSyopOxBH3I22r52x0aDGsPZK5WOxGVoBtO3CiMszjpSHA9CYlspdQsB1I1rQDYRt8c4ZZrPyCdHnTj/cHXnEGHFj26ywjWdYWSb7DQPY4yL6Vde0qQ+lvShFroKTdAbmxxVdsBPSEWEUSR7HjnjfgYdUMNkrgf/kHAQSjGH0pdMgpQ7aVAJN81sfsT/DDeCJMeKXn2WlKFgEuE6740J7VRN9t8ZlOhb5Ww4tKNygrFekdzWGkd7L3sqd6qS3NS8AyWjs4gka0kdgBxXNkYXgKjy/M4aKapiGR+1o83lSY01p5+GtDy6V0nSu1kGiAOavthtkeevMhyQFudQPH8Ei0IRVmvbfGFTm8xWanMFTXm323gtC1uFxxsg2DZ3JGw39saNrNnsx8VGY/NYnPyJhcXKkt0Hze6ynsPcHtj66hXa5rWuGvjr09O/wBVyX4hzHZgfovR8qzmBmraobs5+OiyG1hHrIPwD7dgefjCTxfFjMoKw4yaptCzQLnyd+ecCZoEeG86zDLZ6DFkofQGWWVh1rQd7Dt3X5CNt9+KxGRmsabljbKnoAtYDmpYNlBJHa0ElFD327HDxRc2oKlHfrp12CY3FsrUoqHRC5Z0XJEleuWhwsdNlYXQWeC0Ss/koE/0w0yPKgzljMnN2HvJzUOnL3EAaHHUGiSOdG9VtdjAzuX5k34fbzoMLXlshxbSPyA2EAXQ34XzgDJnkFBUlb7iWkAPDRfTWSeK7fJ7nDXPdVtOnPqucPltdM6lMujlUBiW5JelEtvN6GY/o67e+v1n8h9tjeMu9JL+hhtsqaQtaqQPWRXG3sB9sOfEMoSGOowtlDqF0sCytd2Rsdvv/PCBeZu61eUVokIcPUAb6RWgo9YJBuiO2No/+IJ3PXn1+imrOD6ltAiGc0Yghx1ltAZXoSttkElG+4Gve9tz84NXOfcQUJZQ5VlnWLXrWBZCx3NbcjGcWt5iW8yy8w4OoG1Fpeps72CCdzxzjUZRm+Vqajw0sxYzVLeW5rWsjWeFFQ3Wjc2LFHHLrOv2d/twLpCoXWmF86coey9mO2iV5wWXG9dgnqCiQRsdBXsg+2+NZnfhyM/l8XOSzFQy6jrLgA6lhF0Sg7nR6ODSwSfa8Zp9MEP6Y5ZCm0EL9FoXe255/TixWPsmzRcZ3ymaxgYsd8Orba/x0IAWANZ5R69754xlOl88AH07vBeNd1M22/foq80ypUXKm82jRunluYPvoiW4FkaDeiub3G9DnC2HOy+MZSJra3EObWAUV6D60Hm7FfrjTeNc0yTMsxjoyLJHokEIDT6Gl7uuXrJs7X7fQfOPPc7QliUEu+a9B9aXXB1ALuuOaP646lKmaLMpHlaw9T9VM+t845gfNfS5rj6WkB5vo6Apam99Avg+x/leIPQZUaGw+9G6YW4UIDix+JVGgO2x3s98Ww3MtkSpMWOuVBjLQvQvSXV1qFIdI7UBZA52A3xKHPS3l82HJQ48JjaUNE6LRoN16htZABI3od7xK2tcv1WSdBqj878S5r4vzFGb5tMcSWShpRbUhCGwaA0I/c9CNyAeBfOIZhHlzUvycwnQJqTLEFtYVTy9CbStKKBSgpoXp5ra7wulM5VHlQVZc7PcbLCDIC0NhwSCPUlFWCm+L7fOFzry23mHHmyrpBKiCtQ1/HxsO364XShjW5RAjTnoiJLwTN1p/EMXJ2PCeTjL81kSJrgcdlRnmSER3LoaOywQBa/g4RpQ21GfRLLa3C50104CUAb0k37884XJLbnVUWm0J5QjUb54H6/ww8yCY5kjsPMoeWZTmbUWZ5lKJTYdspG7bgNa0ULO1YTVZnJ+W2fPn56o2OIgOKVxVNrSYyozalSFttqKgOo2L/cOws9ycTitM5dOS7OiNSW3WVlpp0rCHCbQKKSODuDdejEc0U25Pkz1rZtx4l1hlBQlN70lJ/cB2wGtbfmkuaA8htCTp7bdj7e2OdVp2B0POcCMOg9yulsSYnlUP7K030v+IkXYJ278ir2w/wA0gIVnzPWRFjIzFtCmVtCmgVn0roElG12CbHtxjPvlpx5T0eSXih5KEIIJJR2Ivgdq+mC2489OWLejurUylzpvpTv0zq9AWn9wEk0SdziRxF45z0leMyF9ES55d1TJRsstLccQNHxoJ77fXBGXRn50gNMoW8/IJbLTTes8dh3P+hwXLTkMtnJF+H4+ZR5zaKml+QjpuyB++3/k/cFb3i2EcwyHxCYk6GtubDecZ066cbc2CwXB9+DtZwOHqPcCSLdFNWI21VDTfQZkNvgPSn3AgOLpwV329yapYP8AnHfBC5Jl5+1KRGjwn1rGktjpIQsHRrofk3F4kEudJx9hQSW1Fxmn6DI11QJ7WR/PEG6PiBlcNllaW09RHl0dMLDYB1kX7Bd+/wB8Vshrr86JE5oKtkJEXK3J8l5C3HXFkNo4XXK9tudvvjR+Kcx8Fx/BvhxuLk77uftqcdzBxcsGPIHI4Owvtt3GFGdsPHL2M3nQkuR8xQ61FLS0I0FsgboG9C6APN84y2VmAJjEHMg8Ii3blORmwZARwQL2NAWAa374j+L0zUqMDSQB0KLDOBDouoQyZU9IZQlJcJUShYQAOTV8CrwdmsRlvMcxeyxia5BaPVQuVoDqGyaQV1wu/bEM2y6LGER5p9U6EtA0uNt9MIJs9LXuCsAoJ+tdsQiRZTkN/pNh9S461rU2v1toRzrPt3r6YnyXLj9vvdGXNiFGAzLezJlliKw65IHUQNexRvzXHB53xdlESZmkyO3lq4sVxpXS6q30Nt736y4s96I9hXzgVMeBPzB6LGMlLziCYyW49rdeNU2QDQF3RGLnlssttxIsZkpCCFvaLdXrq0LJ2sUQCAOeTiVhJGQSPWNrJ7mNYJEet1NuQxHhtttokeabdKuprBb6ZGxquQR39xhxNz1kqjvQMrbiOMR0NuKZJV1jVFw6+5J+nxgPJn8sdzJK82YKMqrpL0Lsx9iELKtBJAWbIrcWBiuYUOQXUDMMr/u8ZK2AbHXK3AD09vzj54AOOgG5GEjaOc81IKHzCLK/NpqHIokhhbi1p/DpzZAFUAPjcb+/xizJZ0dqT/fEAx3N3GiopBOg6DdEgAngc8d8IX5urMXZjWXsMN8dNlRUEDiwFX3BP1PbHWJLz0Qrc6SIsZwFxd+v17Ch3/JhVOu57czxB0/fTWUx+F+WQG3CY5jNLS0KUhs9JOhBZc1XX74/pgeSZsyS3HQuO4gMdZu3umhKK1kWut+R9eLwEpEd9clEmaIi2WluJ/DKkOLFaG9uCb5Owx1iXJiZnDejTGHFZesKYcCbQD+ewlY3o3yN/nDn13HsN09looADOQioKUMZUH25LBWp8pDSdZcbGgesdt7oHnbFqclmOQVTmkJaaJ/w/MILobNaFlHIBJG+G8v9mPeGIyGsncZzBt98SZA4fbOhaNyfzgkigBthbMTEciQ1svTHJtFp9CmfQECg3o3vi9iBVbYAUy49rYdfosfUyiyizHRBW5KjSGXUuo6fSG5AKaWb7Vv8ge+Ap4jBx6UEMBmzo2P4m/J25P2HGHmTSeilHrW8txtDZsW2GwNfSWa2Ow+gxHMYbicqYcD8PS8+orDYp9Fj8iv+Q3tXycPNFpaINztzu/SEOcDp784UiyyLMzAOQ4ceQ84olQQw2VKoA6thvVDj64JyXOcxyQdbK5C2USWyhwKCHOoj/mBFEXVX3A9sFw0LjLkohPyCa0rQ2S31G6o7g2Pp3xyPFlDLXVyMumS4kZCEFbf4aG1uG0WQNwdJ2PyRWJnYXsw4SCEbcRGmq61lza80Vl+V5y7OIb0NuxWXPxFLT/hoBq9tjdXR52uLKGpUoxzJMaK+iyzqBBW22dBKxsbJP0vEIynXEriRW3ngtuzpQbLgsgbfnocXuLOKn5LsQBmbZS6Ap5sHc0DRvffe8ecwC45crHGbK2Ol2M8hbDcd9KkAaC2HiCsbV7WdsSzOCxlz8LMEutz2wsKUyHOmsb/kJFG7rji+2Bc0k5lOmPpaCnTKR1FJjMBtK0I3vSkbUBfHzhNJLzqyh1QJ2CaO2wr9dgMS1vmN15z8KmgxpMFOY2YXFj6l9YlzrFsvEosEilDtsdqODsmgtTYK4DcxKJ019plkOoB6iCTZJokEEI45vCvI3o6HoVpbW6tSkONqRqBJ2TYNAc9jzucehf2reCfF/gyRkkLPwxIUYNwkRSCW2r12dAuwSbv9aw2m0VQS49q0JVXsEAaLHZ1kuZZDmk3K5rL8GZC1tS2l2gDaig1/n49jeKXlviAzJRmHTL7yymMlggBAqqJ2O5WK52+cEzM9lutNxk5g4phTi5DqZLnU1yK9a1AgncUB9LxKRmUXL0sSMqmpdmCB0XESWA4GtYohsK4IvYjjcisUtpAw4m8CY/unS+q8M0GFxORpR4tchM5qcsbaStxubOQtpxBQSfxQiy2vj3o174AiF11UhqVJSxHmvBDkmQs6OojclYAKzzx7nvi/K3c8eg5knLD0WHEdWW4SFLKEEHXqO/5xe2+/sMMcn8LyM88NZ94s/bmUwkQldZ6C7JPmXCTQKAbK9773zgan+ZZI1/HPogHZd276JKzKYea8oxGW+50SEvSH6U3p1EJR2CCN9HN8HAHVeD7cliN0NG6Cn1BdEkkk7K9j2+MNUwMxi+H2pUmKEwesNEkNh1BcAJDR+1rr/XCttCHYwaeakKcDmoqb9XTbG6zo7c32GJXZ2xmkFWAgWKtcltt08Yx6hXaEhSS0k3qFAg7A0K9tsdy3y7zEh2athtspUdGojrOaSU0EXRBPNVvW2A5TcMzZTcDzDjK3D5dTiQCtFmioDg8bDDbJGY709QfQ62yhC2nAwEawCKFBfO5N87We2AeA+y0OgQoxIkidHYiwYcx+czqSpbB6iNB3QAEi62XZs/asRdBirby/M4BYdjLWgugFDgWaoOA3sKPayD9MMsvlS4Hh1X7B/aTEgFxvNpUaQsI6RWOk2eABYJ53NYVF9TrRjzF/mWjqOlsKUgiwNwbIo8dyBg2GmRbXy5Bt9Ugh03FkfmS5c5yVnC50rMHjtOlSZIC37XoBTq9ZBAHO43vbCxGX9RL5ixZClNDqP/v9Nu/zmuBugWe5+cTahqdyjrxkpedS651GwsdQI0WV6K/w673zeCsvYfkBmE00hCj1Er6jwZbXQsgknfYcXzWE5gZk/pER0TfKIjcAPSmswcjurZcRFk9NAbcdsA0tyqAFixuFgVzeFiMxzWG+iZHkvsy1pC230L9ZBBQQDewO99z/ADqzPLZOW6Icksl/phxaEua1htfbY1wL2998Dy22w0RE/HbbbOtyjQF7H4O/HvhzKrg3K+wGlzF/13rA1rnS28hDlTD0BQOhDjCr4srB7ewrtt3PthvDQrNPNx80zhuMwxFS6X1tl5ZLbdNNpAN1wn/kv2xc5kzRkTUuzMtjvMNodjtNvhxDmsIIQDxsOfnAUhtz9inMmnkNyGnil9fmKWtDiKADftQNke9GtrNrnBxBFxqmQI50SyHG6jqvNKMRpev8TTwUDXVfp+uBPOSf8w/hg6W0wk9WEFOsoQAp1QO6yOSDxvsPpeA+mz/lf/Qf64QGQTcJhJIX/9k=	1	42	\N	\N	\N	#A3D9BD	#E6A8D7	t	aprobado	\N	\N	\N	2026-10-10 23:05:09.058687
6	Viva CEDES Don Bosco	dadadaddadaaqeqessss	data:image/jpeg;base64,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	1	42	Juntos hacemos una CEDES verde	Dominancia mundial	sssssssssssssssssssssss	#A3D9BD	#E6A8D7	t	aprobado	43	2026-10-10 23:48:34.062984	\N	2026-10-10 23:47:43.624774
\.


--
-- TOC entry 5388 (class 0 OID 25834)
-- Dependencies: 277
-- Data for Name: pregunta_afinidad; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pregunta_afinidad (id_pregunta, texto, descripcion, orden, activa) FROM stdin;
1	Si pudieras cambiar UNA cosa del colegio mañana, ¿qué elegirías?	Pensá en lo que más te afecta día a día.	1	t
2	¿Qué actividad te gustaría ver más seguido en CEDES?	Imaginate un viernes por la tarde.	2	t
3	En un proyecto de clase, ¿qué rol te gustaría tomar?	No hay respuesta incorrecta.	3	t
4	¿Qué te gustaría que el gobierno estudiantil lograra este año?	Sé honesto con lo que sentís.	4	t
5	Cuando hay un problema, ¿cómo te gustaría resolverlo?	Pensá en una solución real.	5	t
6	¿Qué tipo de eventos te gustaría que hubiera?	Imaginate que ya se están organizando.	6	t
7	¿Qué te motiva más a participar?	Lo que te hace decir "sí, quiero".	7	t
8	Si tuvieras que elegir un lema para tu colegio, sería...	Lo que representa CEDES para vos.	8	t
9	¿Qué te gustaría aprender además de las materias?	Cosas para la vida real.	9	t
10	En 5 años, ¿qué te gustaría recordar del CEDES?	Cuando ya no estés aquí.	10	t
\.


--
-- TOC entry 5354 (class 0 OID 25379)
-- Dependencies: 243
-- Data for Name: propuesta; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.propuesta (id_propuesta, id_partido, titulo, descripcion, fecha_creacion) FROM stdin;
1	1	Mejora del Menú del Comedor	Incorporación de opciones más nutritivas y variedad de meriendas.	2026-10-03
2	1	Torneos Deportivos Interclases	Organización de campeonatos relámpago de fútbol, voleibol y ajedrez.	2026-10-03
3	2	Renovación de Equipos Tecnológicos	Mantenimiento preventivo de computadoras y zonas con cobertura Wi-Fi para estudiantes.	2026-10-03
4	2	Feria de Innovación y Ciencias	Espacio para exponer proyectos tecnológicos con premiaciones académicas.	2026-10-03
5	3	Talleres del Arte y Expresión	Creación de clubes vespertinos de música, teatro y pintura.	2026-10-03
6	3	Buzón de Sugerencias Activo	Canal directo para atender las inquietudes de las y los estudiantes.	2026-10-03
7	4	Campaña de Reciclaje Colegial	Colocación de puntos de clasificación de residuos en cada pabellón.	2026-10-03
8	4	Zonas Verdes y Sostenibilidad	Jornadas de embellecimiento de áreas comunales y jardines.	2026-10-03
9	5	qqqqqqqqqq	qqqqqqqqqq	\N
10	5	zzzz	zzzzzzzzzz	\N
11	6	123456	asddaddada	\N
12	6	campaña de mate	sadasdadasdad	\N
\.


--
-- TOC entry 5356 (class 0 OID 25387)
-- Dependencies: 245
-- Data for Name: quiz; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.quiz (id_quiz, modulo_id, nombre, puntaje_maximo) FROM stdin;
\.


--
-- TOC entry 5358 (class 0 OID 25393)
-- Dependencies: 247
-- Data for Name: racha; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.racha (id_racha, id_usuario, racha_actual, mejor_racha) FROM stdin;
\.


--
-- TOC entry 5360 (class 0 OID 25401)
-- Dependencies: 249
-- Data for Name: recompensa; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.recompensa (id_recompensa, nombre, descripcion, imagen_url) FROM stdin;
\.


--
-- TOC entry 5392 (class 0 OID 25873)
-- Dependencies: 281
-- Data for Name: resultado_afinidad; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resultado_afinidad (id_resultado, id_usuario, id_partido_ganador, puntajes, respuestas, fecha) FROM stdin;
\.


--
-- TOC entry 5362 (class 0 OID 25408)
-- Dependencies: 251
-- Data for Name: resultado_quiz; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resultado_quiz (id_resultado, id_estudiante, id_quiz, nota, porcentaje, intentos) FROM stdin;
\.


--
-- TOC entry 5364 (class 0 OID 25416)
-- Dependencies: 253
-- Data for Name: sesion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sesion (id_sesion, id_usuario, token, fecha_inicio, fecha_expiracion, dispositivo, ip) FROM stdin;
\.


--
-- TOC entry 5366 (class 0 OID 25426)
-- Dependencies: 255
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuario (id_usuario, nombre, apellido, correo, contrasena, proveedor, google_id, rol, avatar_id, activo, fecha_registro, ultimo_acceso, avatar_url) FROM stdin;
6	prueba4	prueba4	prueba4@gmail.com	$2b$10$c9gTSaLwAm8r87Ca0ClhA.XoJjCWrzHyNLtkLpz1yn5KwVy7q0miO	local	\N	estudiante	\N	t	2026-08-10 14:40:02.859575	\N	\N
7	Miranda	Robles	Mirandarobles@gmail.com	$2b$10$ViETikNXzPuHuaBCdG/aVOZledlJ1AG0VRYR1dh7HjMAeIQlOESI.	local	\N	estudiante	\N	t	2026-08-10 14:48:54.931649	\N	\N
8	Miranda	Robles	Mirandaestudiante@gmail.com	$2b$10$VhrozoAWJm0wUntH399X9e..1FQCebKKBlRsfKLepvvTMiJsF8dw.	local	\N	estudiante	\N	t	2026-08-10 14:51:04.958808	\N	\N
9	Daniela	Garcia Carmona	Daniela@gmail.com	$2b$10$KKnjSbX1PGyjq7rPgJ/iq.Z7JcherQ2/38UU.fToDyb0OFTAuIJKW	local	\N	estudiante	\N	t	2026-09-26 16:15:48.343774	\N	\N
12	hola	hola	hola123@gmail.com	$2b$10$HA24PJ6czOBUAmfDLCqfwuvdUKwJgfN4DvjFaxwvJAKuO8icoZcF6	local	\N	estudiante	\N	t	2026-10-03 14:33:46.777304	\N	\N
14	Juana	Sofia	garciacarmonateam85@gmail.com	$2b$10$VThiGW1cmp5/tL3FtPcvD.ypz0v8S.OvnBDobf8PK62jypvE2NiLG	local	\N	estudiante	\N	t	2026-10-03 19:34:11.614194	\N	\N
15	Admin	Sistema	admin@colegio.com	$2b$10$hashdeprueba	local	\N	administrador	\N	t	2026-10-03 21:17:19.769523	\N	\N
17	Mateo	Araya Vargas	mateo.araya@colegio.com	$2b$10$hashdeprueba	local	\N	estudiante	\N	t	2026-10-03 21:17:19.769523	\N	\N
18	Sofía	Campos Navarro	sofia.campos@colegio.com	$2b$10$hashdeprueba	local	\N	estudiante	\N	t	2026-10-03 21:17:19.769523	\N	\N
19	Gabriel	Mora Castro	gabriel.mora@colegio.com	$2b$10$hashdeprueba	local	\N	estudiante	\N	t	2026-10-03 21:17:19.769523	\N	\N
20	Daniela	Rojas Fonseca	daniela.rojas@colegio.com	$2b$10$hashdeprueba	local	\N	estudiante	\N	t	2026-10-03 21:17:19.769523	\N	\N
21	Santiago	Chaves Gutiérrez	santiago.chaves@colegio.com	$2b$10$hashdeprueba	local	\N	estudiante	\N	t	2026-10-03 21:17:19.769523	\N	\N
22	Lucía	Monge Alvarado	lucia.monge@colegio.com	$2b$10$hashdeprueba	local	\N	estudiante	\N	t	2026-10-03 21:17:19.769523	\N	\N
23	Juana	ghfdsa	garciacarmonateam86@gmail.com	$2b$10$scKHF0mCQURZ2gXToSf/3.gjLeqgJtMuiu7OHm3bxpKT.T/4Ri1s2	local	\N	estudiante	\N	t	2026-10-04 10:44:42.472377	\N	\N
24	Daniela2	ffdhsa	LASO@gmail.com	$2b$10$dCnp4ymRe8Y3pcmzqEJEouQ/WCQyW3D80r1ZNT/9iRLgv5BQIzGJy	local	\N	estudiante	\N	t	2026-10-04 12:38:02.995982	\N	\N
25	Juana	Sofia	garciacarmoeeenateam85@gmail.com	$2b$10$Na4d.ls7zrXmpSBQ7KZxqetsJhiZSBE84H8jC6GMd3fggQelyd2z6	local	\N	estudiante	\N	t	2026-10-04 12:47:47.283495	\N	\N
26	Juana	Sofia	garciasssscarmonateam85@gmail.com	$2b$10$NzzCufELAe0p8SZi1HrrCet4KKfhqswYC0rh5aV5VsL3jB8rks17a	local	\N	estudiante	\N	t	2026-10-04 13:11:12.636436	\N	\N
27	Juana	Sofia	garciacarmonateawwwwm85@gmail.com	$2b$10$yfPt3tC9U2CHkpJJkiPM..S4maJn4cPKd9zkgNUYFgUbdGl2AWjia	local	\N	profesor	\N	t	2026-10-04 15:09:45.230984	\N	\N
28	6666666666	ggggggggg	ggggg@gmail.com	$2b$10$KYQ1jKv37PZ37ZqEkyqSJeE5WaM4hQ40/nP0hmu8a18wcKIyQE0ky	local	\N	estudiante	\N	t	2026-10-04 15:30:56.775418	\N	\N
30	Esteban	Chaves	esteban.chaves@est.ed.cr	123456	local	\N	estudiante	\N	t	2026-10-04 15:58:31.300197	\N	\N
31	Sofía	Monge	sofia.monge@est.ed.cr	123456	local	\N	estudiante	\N	t	2026-10-04 15:58:31.300197	\N	\N
32	Andrés	Soto	andres.soto@est.ed.cr	123456	local	\N	estudiante	\N	t	2026-10-04 15:58:31.300197	\N	\N
33	Valeria	Solís	valeria.solis@est.ed.cr	123456	local	\N	estudiante	\N	t	2026-10-04 15:58:31.300197	\N	\N
34	Carlos	Solano	carlos.solano@est.ed.cr	123456	local	\N	estudiante	\N	t	2026-10-04 15:59:31.547527	\N	\N
35	Daniela1w	Mendez	holwwa123@gmail.com	$2b$10$Pz4ht08Bx1lzLY.8yrDGlunaFDH.ZCHuy9BDf/LFM4Yij8pB0iKLm	local	\N	estudiante	\N	t	2026-10-04 16:00:10.169284	\N	\N
36	Juana222	Sofia	garciacarmonatea2222m85@gmail.com	$2b$10$cGaqrllw5hueE8XYNJaoC.RlgssP9QFXu9RN0y3RU3a0UW8ixtrA2	local	\N	estudiante	\N	t	2026-10-05 20:02:26.204762	\N	\N
37	Juana33	Sofia	garciacarmoewewenateam85@gmail.com	$2b$10$QnRKNS.yMd62N.ULLezRj.ez/uGo9IsMUxuZXzdnuq/M6XX046Hyy	local	\N	profesor	\N	t	2026-10-05 20:41:47.921837	\N	\N
38	Juana3333	Sofia3333	juanaprueba5@gmail.com	$2b$10$QRhvayOqGmAhRiikunMLwuHkipwDU9dUxou29eQJwLL8MFISj1Drm	local	\N	estudiante	\N	t	2026-10-06 18:47:38.856817	\N	\N
39	Juanasss	Sofiasss	garciacaaaaarmonateam85@gmail.com	$2b$10$kuOFVKKycyVya7jb07h8ZOp2GGkGVXhyLNtfP3bCJIm6/cFhrDg62	local	\N	profesor	\N	t	2026-10-06 21:06:38.855452	\N	\N
40	eee	eeee	eeee@gamial.com	$2b$10$ddIG8lo4zj5o3XUy/cweK.I7zZ.EWvPzvZc3Ky38xJgBrzkhvzHOa	local	\N	estudiante	\N	t	2026-10-06 22:01:09.835392	\N	\N
41	Kevinn	Barboza	kbarbar@gmail.com	$2b$10$Mu750/v5FUocIbffyrLe.uEsdSG6DBOXldQzmgV4FYId.XRDQFZoO	local	\N	estudiante	\N	t	2026-10-10 14:16:45.509667	\N	data:image/jpeg;base64,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
42	Kevin	Barboza	kbarboza92.pro@gmail.com	\N	google	102331344439293300581	estudiante	\N	t	2026-10-10 17:37:15.173421	\N	data:image/jpeg;base64,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
43	profe	sor	profe@gmail.com	$2b$10$/GUMupy31YD7RIDpeI5PQenU/BD/LuzfHyL1tdry7vOm8kYrz9s6O	local	\N	profesor	\N	t	2026-10-10 23:07:39.904565	\N	\N
44	Kevin	Barboza	kjesusbarcas@gmail.com	\N	google	108255146931902564279	estudiante	\N	t	2026-10-17 13:40:40.93811	\N	\N
\.


--
-- TOC entry 5367 (class 0 OID 25441)
-- Dependencies: 256
-- Data for Name: usuario_curso; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuario_curso (id_usuario_curso, usuario_id, curso_id) FROM stdin;
37	17	6
38	18	4
39	19	3
40	20	2
41	21	1
42	22	5
\.


--
-- TOC entry 5370 (class 0 OID 25449)
-- Dependencies: 259
-- Data for Name: usuario_recompensa; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuario_recompensa (id_usuario, id_recompensa, fecha_obtenida) FROM stdin;
\.


--
-- TOC entry 5371 (class 0 OID 25455)
-- Dependencies: 260
-- Data for Name: voto; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.voto (id_voto, id_estudiante, id_partido, fecha_voto) FROM stdin;
3	41	3	2026-10-10 14:48:33.935919
4	42	4	2026-10-10 20:17:22.791244
\.


--
-- TOC entry 5432 (class 0 OID 0)
-- Dependencies: 282
-- Name: agora_intentos_educativos_id_intento_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.agora_intentos_educativos_id_intento_seq', 1, true);


--
-- TOC entry 5433 (class 0 OID 0)
-- Dependencies: 220
-- Name: avatar_id_avatar_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.avatar_id_avatar_seq', 1, false);


--
-- TOC entry 5434 (class 0 OID 0)
-- Dependencies: 222
-- Name: caja_ideas_id_idea_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.caja_ideas_id_idea_seq', 2, true);


--
-- TOC entry 5435 (class 0 OID 0)
-- Dependencies: 224
-- Name: clase_id_clase_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.clase_id_clase_seq', 1, false);


--
-- TOC entry 5436 (class 0 OID 0)
-- Dependencies: 270
-- Name: codigo_invitacion_id_codigo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.codigo_invitacion_id_codigo_seq', 1, true);


--
-- TOC entry 5437 (class 0 OID 0)
-- Dependencies: 264
-- Name: comentario_idea_id_comentario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.comentario_idea_id_comentario_seq', 2, true);


--
-- TOC entry 5438 (class 0 OID 0)
-- Dependencies: 226
-- Name: conversacion_chat_id_conversacion_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.conversacion_chat_id_conversacion_seq', 1, false);


--
-- TOC entry 5439 (class 0 OID 0)
-- Dependencies: 228
-- Name: curso_id_curso_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.curso_id_curso_seq', 6, true);


--
-- TOC entry 5440 (class 0 OID 0)
-- Dependencies: 272
-- Name: eje_afinidad_id_eje_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.eje_afinidad_id_eje_seq', 5, true);


--
-- TOC entry 5441 (class 0 OID 0)
-- Dependencies: 230
-- Name: eleccion_id_eleccion_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.eleccion_id_eleccion_seq', 1, true);


--
-- TOC entry 5442 (class 0 OID 0)
-- Dependencies: 232
-- Name: evento_id_evento_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.evento_id_evento_seq', 2, true);


--
-- TOC entry 5443 (class 0 OID 0)
-- Dependencies: 268
-- Name: feedback_partido_id_feedback_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.feedback_partido_id_feedback_seq', 1, false);


--
-- TOC entry 5444 (class 0 OID 0)
-- Dependencies: 234
-- Name: gobierno_estudiantil_id_gobierno_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.gobierno_estudiantil_id_gobierno_seq', 1, true);


--
-- TOC entry 5445 (class 0 OID 0)
-- Dependencies: 266
-- Name: idea_guardada_id_guardado_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.idea_guardada_id_guardado_seq', 1, false);


--
-- TOC entry 5446 (class 0 OID 0)
-- Dependencies: 262
-- Name: like_idea_id_like_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.like_idea_id_like_seq', 5, true);


--
-- TOC entry 5447 (class 0 OID 0)
-- Dependencies: 236
-- Name: mensaje_chat_id_mensaje_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.mensaje_chat_id_mensaje_seq', 1, false);


--
-- TOC entry 5448 (class 0 OID 0)
-- Dependencies: 238
-- Name: miembro_partido_id_miembro_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.miembro_partido_id_miembro_seq', 47, true);


--
-- TOC entry 5449 (class 0 OID 0)
-- Dependencies: 240
-- Name: modulo_id_modulo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.modulo_id_modulo_seq', 1, false);


--
-- TOC entry 5450 (class 0 OID 0)
-- Dependencies: 278
-- Name: opcion_afinidad_id_opcion_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.opcion_afinidad_id_opcion_seq', 40, true);


--
-- TOC entry 5451 (class 0 OID 0)
-- Dependencies: 274
-- Name: partido_eje_id_partido_eje_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.partido_eje_id_partido_eje_seq', 20, true);


--
-- TOC entry 5452 (class 0 OID 0)
-- Dependencies: 242
-- Name: partido_politico_id_partido_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.partido_politico_id_partido_seq', 6, true);


--
-- TOC entry 5453 (class 0 OID 0)
-- Dependencies: 276
-- Name: pregunta_afinidad_id_pregunta_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pregunta_afinidad_id_pregunta_seq', 10, true);


--
-- TOC entry 5454 (class 0 OID 0)
-- Dependencies: 244
-- Name: propuesta_id_propuesta_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.propuesta_id_propuesta_seq', 12, true);


--
-- TOC entry 5455 (class 0 OID 0)
-- Dependencies: 246
-- Name: quiz_id_quiz_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.quiz_id_quiz_seq', 1, false);


--
-- TOC entry 5456 (class 0 OID 0)
-- Dependencies: 248
-- Name: racha_id_racha_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.racha_id_racha_seq', 1, false);


--
-- TOC entry 5457 (class 0 OID 0)
-- Dependencies: 250
-- Name: recompensa_id_recompensa_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.recompensa_id_recompensa_seq', 1, false);


--
-- TOC entry 5458 (class 0 OID 0)
-- Dependencies: 280
-- Name: resultado_afinidad_id_resultado_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.resultado_afinidad_id_resultado_seq', 1, false);


--
-- TOC entry 5459 (class 0 OID 0)
-- Dependencies: 252
-- Name: resultado_quiz_id_resultado_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.resultado_quiz_id_resultado_seq', 1, false);


--
-- TOC entry 5460 (class 0 OID 0)
-- Dependencies: 254
-- Name: sesion_id_sesion_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sesion_id_sesion_seq', 1, false);


--
-- TOC entry 5461 (class 0 OID 0)
-- Dependencies: 257
-- Name: usuario_curso_id_usuario_curso_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usuario_curso_id_usuario_curso_seq', 42, true);


--
-- TOC entry 5462 (class 0 OID 0)
-- Dependencies: 258
-- Name: usuario_id_usuario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usuario_id_usuario_seq', 44, true);


--
-- TOC entry 5463 (class 0 OID 0)
-- Dependencies: 261
-- Name: voto_id_voto_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.voto_id_voto_seq', 4, true);


--
-- TOC entry 5139 (class 2606 OID 25923)
-- Name: agora_intentos_educativos agora_intentos_educativos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.agora_intentos_educativos
    ADD CONSTRAINT agora_intentos_educativos_pkey PRIMARY KEY (id_intento);


--
-- TOC entry 5052 (class 2606 OID 25485)
-- Name: avatar avatar_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.avatar
    ADD CONSTRAINT avatar_pkey PRIMARY KEY (id_avatar);


--
-- TOC entry 5054 (class 2606 OID 25487)
-- Name: caja_ideas caja_ideas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.caja_ideas
    ADD CONSTRAINT caja_ideas_pkey PRIMARY KEY (id_idea);


--
-- TOC entry 5056 (class 2606 OID 25489)
-- Name: clase clase_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clase
    ADD CONSTRAINT clase_pkey PRIMARY KEY (id_clase);


--
-- TOC entry 5117 (class 2606 OID 25783)
-- Name: codigo_invitacion codigo_invitacion_codigo_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.codigo_invitacion
    ADD CONSTRAINT codigo_invitacion_codigo_key UNIQUE (codigo);


--
-- TOC entry 5119 (class 2606 OID 25781)
-- Name: codigo_invitacion codigo_invitacion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.codigo_invitacion
    ADD CONSTRAINT codigo_invitacion_pkey PRIMARY KEY (id_codigo);


--
-- TOC entry 5106 (class 2606 OID 25708)
-- Name: comentario_idea comentario_idea_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comentario_idea
    ADD CONSTRAINT comentario_idea_pkey PRIMARY KEY (id_comentario);


--
-- TOC entry 5058 (class 2606 OID 25491)
-- Name: conversacion_chat conversacion_chat_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conversacion_chat
    ADD CONSTRAINT conversacion_chat_pkey PRIMARY KEY (id_conversacion);


--
-- TOC entry 5060 (class 2606 OID 25493)
-- Name: curso curso_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.curso
    ADD CONSTRAINT curso_pkey PRIMARY KEY (id_curso);


--
-- TOC entry 5122 (class 2606 OID 25808)
-- Name: eje_afinidad eje_afinidad_codigo_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eje_afinidad
    ADD CONSTRAINT eje_afinidad_codigo_key UNIQUE (codigo);


--
-- TOC entry 5124 (class 2606 OID 25806)
-- Name: eje_afinidad eje_afinidad_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eje_afinidad
    ADD CONSTRAINT eje_afinidad_pkey PRIMARY KEY (id_eje);


--
-- TOC entry 5062 (class 2606 OID 25495)
-- Name: eleccion eleccion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eleccion
    ADD CONSTRAINT eleccion_pkey PRIMARY KEY (id_eleccion);


--
-- TOC entry 5064 (class 2606 OID 25497)
-- Name: evento evento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evento
    ADD CONSTRAINT evento_pkey PRIMARY KEY (id_evento);


--
-- TOC entry 5114 (class 2606 OID 25756)
-- Name: feedback_partido feedback_partido_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.feedback_partido
    ADD CONSTRAINT feedback_partido_pkey PRIMARY KEY (id_feedback);


--
-- TOC entry 5066 (class 2606 OID 25499)
-- Name: gobierno_estudiantil gobierno_estudiantil_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gobierno_estudiantil
    ADD CONSTRAINT gobierno_estudiantil_pkey PRIMARY KEY (id_gobierno);


--
-- TOC entry 5109 (class 2606 OID 25729)
-- Name: idea_guardada idea_guardada_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.idea_guardada
    ADD CONSTRAINT idea_guardada_pkey PRIMARY KEY (id_guardado);


--
-- TOC entry 5102 (class 2606 OID 25682)
-- Name: like_idea like_idea_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.like_idea
    ADD CONSTRAINT like_idea_pkey PRIMARY KEY (id_like);


--
-- TOC entry 5068 (class 2606 OID 25501)
-- Name: mensaje_chat mensaje_chat_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mensaje_chat
    ADD CONSTRAINT mensaje_chat_pkey PRIMARY KEY (id_mensaje);


--
-- TOC entry 5070 (class 2606 OID 25503)
-- Name: miembro_partido miembro_partido_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.miembro_partido
    ADD CONSTRAINT miembro_partido_pkey PRIMARY KEY (id_miembro);


--
-- TOC entry 5072 (class 2606 OID 25505)
-- Name: modulo modulo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.modulo
    ADD CONSTRAINT modulo_pkey PRIMARY KEY (id_modulo);


--
-- TOC entry 5134 (class 2606 OID 25861)
-- Name: opcion_afinidad opcion_afinidad_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.opcion_afinidad
    ADD CONSTRAINT opcion_afinidad_pkey PRIMARY KEY (id_opcion);


--
-- TOC entry 5127 (class 2606 OID 25820)
-- Name: partido_eje partido_eje_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.partido_eje
    ADD CONSTRAINT partido_eje_pkey PRIMARY KEY (id_partido_eje);


--
-- TOC entry 5074 (class 2606 OID 25507)
-- Name: partido_politico partido_politico_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.partido_politico
    ADD CONSTRAINT partido_politico_pkey PRIMARY KEY (id_partido);


--
-- TOC entry 5131 (class 2606 OID 25845)
-- Name: pregunta_afinidad pregunta_afinidad_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pregunta_afinidad
    ADD CONSTRAINT pregunta_afinidad_pkey PRIMARY KEY (id_pregunta);


--
-- TOC entry 5076 (class 2606 OID 25509)
-- Name: propuesta propuesta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.propuesta
    ADD CONSTRAINT propuesta_pkey PRIMARY KEY (id_propuesta);


--
-- TOC entry 5078 (class 2606 OID 25511)
-- Name: quiz quiz_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quiz
    ADD CONSTRAINT quiz_pkey PRIMARY KEY (id_quiz);


--
-- TOC entry 5080 (class 2606 OID 25513)
-- Name: racha racha_id_usuario_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.racha
    ADD CONSTRAINT racha_id_usuario_key UNIQUE (id_usuario);


--
-- TOC entry 5082 (class 2606 OID 25515)
-- Name: racha racha_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.racha
    ADD CONSTRAINT racha_pkey PRIMARY KEY (id_racha);


--
-- TOC entry 5084 (class 2606 OID 25517)
-- Name: recompensa recompensa_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recompensa
    ADD CONSTRAINT recompensa_pkey PRIMARY KEY (id_recompensa);


--
-- TOC entry 5137 (class 2606 OID 25886)
-- Name: resultado_afinidad resultado_afinidad_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resultado_afinidad
    ADD CONSTRAINT resultado_afinidad_pkey PRIMARY KEY (id_resultado);


--
-- TOC entry 5086 (class 2606 OID 25519)
-- Name: resultado_quiz resultado_quiz_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resultado_quiz
    ADD CONSTRAINT resultado_quiz_pkey PRIMARY KEY (id_resultado);


--
-- TOC entry 5088 (class 2606 OID 25521)
-- Name: sesion sesion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sesion
    ADD CONSTRAINT sesion_pkey PRIMARY KEY (id_sesion);


--
-- TOC entry 5112 (class 2606 OID 25731)
-- Name: idea_guardada unique_guardado; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.idea_guardada
    ADD CONSTRAINT unique_guardado UNIQUE (id_usuario, id_idea);


--
-- TOC entry 5104 (class 2606 OID 25684)
-- Name: like_idea unique_like_usuario_idea; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.like_idea
    ADD CONSTRAINT unique_like_usuario_idea UNIQUE (id_usuario, id_idea);


--
-- TOC entry 5129 (class 2606 OID 25822)
-- Name: partido_eje unique_partido_eje; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.partido_eje
    ADD CONSTRAINT unique_partido_eje UNIQUE (id_partido, id_eje);


--
-- TOC entry 5090 (class 2606 OID 25523)
-- Name: usuario usuario_correo_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_correo_key UNIQUE (correo);


--
-- TOC entry 5094 (class 2606 OID 25525)
-- Name: usuario_curso usuario_curso_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario_curso
    ADD CONSTRAINT usuario_curso_pkey PRIMARY KEY (id_usuario_curso);


--
-- TOC entry 5092 (class 2606 OID 25527)
-- Name: usuario usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (id_usuario);


--
-- TOC entry 5096 (class 2606 OID 25529)
-- Name: usuario_recompensa usuario_recompensa_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario_recompensa
    ADD CONSTRAINT usuario_recompensa_pkey PRIMARY KEY (id_usuario, id_recompensa);


--
-- TOC entry 5098 (class 2606 OID 25531)
-- Name: voto voto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.voto
    ADD CONSTRAINT voto_pkey PRIMARY KEY (id_voto);


--
-- TOC entry 5120 (class 1259 OID 25904)
-- Name: idx_codigo; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_codigo ON public.codigo_invitacion USING btree (codigo);


--
-- TOC entry 5107 (class 1259 OID 25899)
-- Name: idx_comentario_idea; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_comentario_idea ON public.comentario_idea USING btree (id_idea);


--
-- TOC entry 5115 (class 1259 OID 25903)
-- Name: idx_feedback_partido; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_feedback_partido ON public.feedback_partido USING btree (id_partido);


--
-- TOC entry 5110 (class 1259 OID 25900)
-- Name: idx_guardado_usuario; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_guardado_usuario ON public.idea_guardada USING btree (id_usuario);


--
-- TOC entry 5099 (class 1259 OID 25897)
-- Name: idx_like_idea; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_like_idea ON public.like_idea USING btree (id_idea);


--
-- TOC entry 5100 (class 1259 OID 25898)
-- Name: idx_like_usuario; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_like_usuario ON public.like_idea USING btree (id_usuario);


--
-- TOC entry 5132 (class 1259 OID 25902)
-- Name: idx_opcion_pregunta; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_opcion_pregunta ON public.opcion_afinidad USING btree (id_pregunta);


--
-- TOC entry 5125 (class 1259 OID 25901)
-- Name: idx_partido_eje_partido; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_partido_eje_partido ON public.partido_eje USING btree (id_partido);


--
-- TOC entry 5135 (class 1259 OID 25905)
-- Name: idx_resultado_usuario; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_resultado_usuario ON public.resultado_afinidad USING btree (id_usuario);


--
-- TOC entry 5182 (class 2606 OID 25924)
-- Name: agora_intentos_educativos agora_intentos_educativos_id_estudiante_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.agora_intentos_educativos
    ADD CONSTRAINT agora_intentos_educativos_id_estudiante_fkey FOREIGN KEY (id_estudiante) REFERENCES public.usuario(id_usuario);


--
-- TOC entry 5174 (class 2606 OID 25784)
-- Name: codigo_invitacion codigo_invitacion_creado_por_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.codigo_invitacion
    ADD CONSTRAINT codigo_invitacion_creado_por_fkey FOREIGN KEY (creado_por) REFERENCES public.usuario(id_usuario) ON DELETE SET NULL;


--
-- TOC entry 5175 (class 2606 OID 25789)
-- Name: codigo_invitacion codigo_invitacion_usado_por_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.codigo_invitacion
    ADD CONSTRAINT codigo_invitacion_usado_por_fkey FOREIGN KEY (usado_por) REFERENCES public.usuario(id_usuario) ON DELETE SET NULL;


--
-- TOC entry 5140 (class 2606 OID 25532)
-- Name: caja_ideas fk_caja_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.caja_ideas
    ADD CONSTRAINT fk_caja_usuario FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario);


--
-- TOC entry 5142 (class 2606 OID 25537)
-- Name: conversacion_chat fk_chat_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conversacion_chat
    ADD CONSTRAINT fk_chat_usuario FOREIGN KEY (usuario) REFERENCES public.usuario(id_usuario);


--
-- TOC entry 5141 (class 2606 OID 25542)
-- Name: clase fk_clase_modulo; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clase
    ADD CONSTRAINT fk_clase_modulo FOREIGN KEY (modulo_id) REFERENCES public.modulo(id_modulo);


--
-- TOC entry 5168 (class 2606 OID 25709)
-- Name: comentario_idea fk_comentario_idea; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comentario_idea
    ADD CONSTRAINT fk_comentario_idea FOREIGN KEY (id_idea) REFERENCES public.caja_ideas(id_idea) ON DELETE CASCADE;


--
-- TOC entry 5169 (class 2606 OID 25714)
-- Name: comentario_idea fk_comentario_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comentario_idea
    ADD CONSTRAINT fk_comentario_usuario FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario) ON DELETE CASCADE;


--
-- TOC entry 5143 (class 2606 OID 25547)
-- Name: eleccion fk_eleccion_gobierno; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eleccion
    ADD CONSTRAINT fk_eleccion_gobierno FOREIGN KEY (id_gobierno) REFERENCES public.gobierno_estudiantil(id_gobierno);


--
-- TOC entry 5144 (class 2606 OID 25552)
-- Name: evento fk_evento_modulo; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evento
    ADD CONSTRAINT fk_evento_modulo FOREIGN KEY (id_modulo) REFERENCES public.modulo(id_modulo);


--
-- TOC entry 5172 (class 2606 OID 25757)
-- Name: feedback_partido fk_feedback_partido; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.feedback_partido
    ADD CONSTRAINT fk_feedback_partido FOREIGN KEY (id_partido) REFERENCES public.partido_politico(id_partido) ON DELETE CASCADE;


--
-- TOC entry 5173 (class 2606 OID 25762)
-- Name: feedback_partido fk_feedback_profesor; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.feedback_partido
    ADD CONSTRAINT fk_feedback_profesor FOREIGN KEY (id_profesor) REFERENCES public.usuario(id_usuario);


--
-- TOC entry 5170 (class 2606 OID 25732)
-- Name: idea_guardada fk_guardado_idea; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.idea_guardada
    ADD CONSTRAINT fk_guardado_idea FOREIGN KEY (id_idea) REFERENCES public.caja_ideas(id_idea) ON DELETE CASCADE;


--
-- TOC entry 5171 (class 2606 OID 25737)
-- Name: idea_guardada fk_guardado_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.idea_guardada
    ADD CONSTRAINT fk_guardado_usuario FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario) ON DELETE CASCADE;


--
-- TOC entry 5166 (class 2606 OID 25685)
-- Name: like_idea fk_like_idea; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.like_idea
    ADD CONSTRAINT fk_like_idea FOREIGN KEY (id_idea) REFERENCES public.caja_ideas(id_idea) ON DELETE CASCADE;


--
-- TOC entry 5167 (class 2606 OID 25690)
-- Name: like_idea fk_like_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.like_idea
    ADD CONSTRAINT fk_like_usuario FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario) ON DELETE CASCADE;


--
-- TOC entry 5145 (class 2606 OID 25557)
-- Name: mensaje_chat fk_mensaje_conversacion; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mensaje_chat
    ADD CONSTRAINT fk_mensaje_conversacion FOREIGN KEY (conversacion_id) REFERENCES public.conversacion_chat(id_conversacion);


--
-- TOC entry 5146 (class 2606 OID 25562)
-- Name: miembro_partido fk_miembro_partido; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.miembro_partido
    ADD CONSTRAINT fk_miembro_partido FOREIGN KEY (id_partido) REFERENCES public.partido_politico(id_partido);


--
-- TOC entry 5147 (class 2606 OID 25567)
-- Name: miembro_partido fk_miembro_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.miembro_partido
    ADD CONSTRAINT fk_miembro_usuario FOREIGN KEY (id_estudiante) REFERENCES public.usuario(id_usuario);


--
-- TOC entry 5148 (class 2606 OID 25572)
-- Name: modulo fk_modulo_curso; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.modulo
    ADD CONSTRAINT fk_modulo_curso FOREIGN KEY (curso_id) REFERENCES public.curso(id_curso);


--
-- TOC entry 5149 (class 2606 OID 25577)
-- Name: modulo fk_modulo_profesor; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.modulo
    ADD CONSTRAINT fk_modulo_profesor FOREIGN KEY (id_profesor) REFERENCES public.usuario(id_usuario);


--
-- TOC entry 5178 (class 2606 OID 25867)
-- Name: opcion_afinidad fk_opcion_eje; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.opcion_afinidad
    ADD CONSTRAINT fk_opcion_eje FOREIGN KEY (id_eje) REFERENCES public.eje_afinidad(id_eje) ON DELETE CASCADE;


--
-- TOC entry 5179 (class 2606 OID 25862)
-- Name: opcion_afinidad fk_opcion_pregunta; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.opcion_afinidad
    ADD CONSTRAINT fk_opcion_pregunta FOREIGN KEY (id_pregunta) REFERENCES public.pregunta_afinidad(id_pregunta) ON DELETE CASCADE;


--
-- TOC entry 5150 (class 2606 OID 25666)
-- Name: partido_politico fk_partido_aprobador; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.partido_politico
    ADD CONSTRAINT fk_partido_aprobador FOREIGN KEY (aprobado_por) REFERENCES public.usuario(id_usuario);


--
-- TOC entry 5151 (class 2606 OID 25582)
-- Name: partido_politico fk_partido_creador; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.partido_politico
    ADD CONSTRAINT fk_partido_creador FOREIGN KEY (creador_id) REFERENCES public.usuario(id_usuario);


--
-- TOC entry 5176 (class 2606 OID 25828)
-- Name: partido_eje fk_partido_eje_eje; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.partido_eje
    ADD CONSTRAINT fk_partido_eje_eje FOREIGN KEY (id_eje) REFERENCES public.eje_afinidad(id_eje) ON DELETE CASCADE;


--
-- TOC entry 5177 (class 2606 OID 25823)
-- Name: partido_eje fk_partido_eje_partido; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.partido_eje
    ADD CONSTRAINT fk_partido_eje_partido FOREIGN KEY (id_partido) REFERENCES public.partido_politico(id_partido) ON DELETE CASCADE;


--
-- TOC entry 5152 (class 2606 OID 25587)
-- Name: partido_politico fk_partido_gobierno; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.partido_politico
    ADD CONSTRAINT fk_partido_gobierno FOREIGN KEY (gobierno_id) REFERENCES public.gobierno_estudiantil(id_gobierno);


--
-- TOC entry 5153 (class 2606 OID 25592)
-- Name: propuesta fk_propuesta_partido; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.propuesta
    ADD CONSTRAINT fk_propuesta_partido FOREIGN KEY (id_partido) REFERENCES public.partido_politico(id_partido);


--
-- TOC entry 5154 (class 2606 OID 25597)
-- Name: quiz fk_quiz_modulo; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quiz
    ADD CONSTRAINT fk_quiz_modulo FOREIGN KEY (modulo_id) REFERENCES public.modulo(id_modulo);


--
-- TOC entry 5155 (class 2606 OID 25602)
-- Name: racha fk_racha_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.racha
    ADD CONSTRAINT fk_racha_usuario FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario);


--
-- TOC entry 5180 (class 2606 OID 25892)
-- Name: resultado_afinidad fk_resultado_partido; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resultado_afinidad
    ADD CONSTRAINT fk_resultado_partido FOREIGN KEY (id_partido_ganador) REFERENCES public.partido_politico(id_partido) ON DELETE CASCADE;


--
-- TOC entry 5156 (class 2606 OID 25607)
-- Name: resultado_quiz fk_resultado_quiz; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resultado_quiz
    ADD CONSTRAINT fk_resultado_quiz FOREIGN KEY (id_quiz) REFERENCES public.quiz(id_quiz);


--
-- TOC entry 5157 (class 2606 OID 25612)
-- Name: resultado_quiz fk_resultado_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resultado_quiz
    ADD CONSTRAINT fk_resultado_usuario FOREIGN KEY (id_estudiante) REFERENCES public.usuario(id_usuario);


--
-- TOC entry 5181 (class 2606 OID 25887)
-- Name: resultado_afinidad fk_resultado_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resultado_afinidad
    ADD CONSTRAINT fk_resultado_usuario FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario) ON DELETE CASCADE;


--
-- TOC entry 5158 (class 2606 OID 25617)
-- Name: sesion fk_sesion_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sesion
    ADD CONSTRAINT fk_sesion_usuario FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario);


--
-- TOC entry 5159 (class 2606 OID 25622)
-- Name: usuario fk_usuario_avatar; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT fk_usuario_avatar FOREIGN KEY (avatar_id) REFERENCES public.avatar(id_avatar);


--
-- TOC entry 5160 (class 2606 OID 25627)
-- Name: usuario_curso fk_usuario_curso_curso; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario_curso
    ADD CONSTRAINT fk_usuario_curso_curso FOREIGN KEY (curso_id) REFERENCES public.curso(id_curso);


--
-- TOC entry 5161 (class 2606 OID 25632)
-- Name: usuario_curso fk_usuario_curso_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario_curso
    ADD CONSTRAINT fk_usuario_curso_usuario FOREIGN KEY (usuario_id) REFERENCES public.usuario(id_usuario);


--
-- TOC entry 5162 (class 2606 OID 25637)
-- Name: usuario_recompensa fk_usuario_recompensa_recompensa; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario_recompensa
    ADD CONSTRAINT fk_usuario_recompensa_recompensa FOREIGN KEY (id_recompensa) REFERENCES public.recompensa(id_recompensa);


--
-- TOC entry 5163 (class 2606 OID 25642)
-- Name: usuario_recompensa fk_usuario_recompensa_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario_recompensa
    ADD CONSTRAINT fk_usuario_recompensa_usuario FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario);


--
-- TOC entry 5164 (class 2606 OID 25647)
-- Name: voto fk_voto_partido; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.voto
    ADD CONSTRAINT fk_voto_partido FOREIGN KEY (id_partido) REFERENCES public.partido_politico(id_partido);


--
-- TOC entry 5165 (class 2606 OID 25652)
-- Name: voto fk_voto_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.voto
    ADD CONSTRAINT fk_voto_usuario FOREIGN KEY (id_estudiante) REFERENCES public.usuario(id_usuario);


-- Completed on 2026-10-17 14:19:13

--
-- PostgreSQL database dump complete
--

\unrestrict DJ7LSocnIzZu6s9BLtrhhdu1c7iOAypDAaZ8G6M9br0mVMYeozRexTpNYEToxad

