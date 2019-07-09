--
-- PostgreSQL database dump
--

-- Dumped from database version 10.3 (Debian 10.3-2)
-- Dumped by pg_dump version 11.4 (Debian 11.4-1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: clinica_user
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO clinica_user;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: clinica_user
--

CREATE SEQUENCE public.auth_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO clinica_user;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: clinica_user
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: clinica_user
--

CREATE TABLE public.auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO clinica_user;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: clinica_user
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO clinica_user;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: clinica_user
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: clinica_user
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO clinica_user;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: clinica_user
--

CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO clinica_user;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: clinica_user
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: clinica_user
--

CREATE TABLE public.auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(30) NOT NULL,
    last_name character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE public.auth_user OWNER TO clinica_user;

--
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: clinica_user
--

CREATE TABLE public.auth_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.auth_user_groups OWNER TO clinica_user;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: clinica_user
--

CREATE SEQUENCE public.auth_user_groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_groups_id_seq OWNER TO clinica_user;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: clinica_user
--

ALTER SEQUENCE public.auth_user_groups_id_seq OWNED BY public.auth_user_groups.id;


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: clinica_user
--

CREATE SEQUENCE public.auth_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_id_seq OWNER TO clinica_user;

--
-- Name: auth_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: clinica_user
--

ALTER SEQUENCE public.auth_user_id_seq OWNED BY public.auth_user.id;


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: clinica_user
--

CREATE TABLE public.auth_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_user_user_permissions OWNER TO clinica_user;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: clinica_user
--

CREATE SEQUENCE public.auth_user_user_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_user_permissions_id_seq OWNER TO clinica_user;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: clinica_user
--

ALTER SEQUENCE public.auth_user_user_permissions_id_seq OWNED BY public.auth_user_user_permissions.id;


--
-- Name: axes_accessattempt; Type: TABLE; Schema: public; Owner: clinica_user
--

CREATE TABLE public.axes_accessattempt (
    id integer NOT NULL,
    user_agent character varying(255) NOT NULL,
    ip_address inet,
    username character varying(255),
    http_accept character varying(1025) NOT NULL,
    path_info character varying(255) NOT NULL,
    attempt_time timestamp with time zone NOT NULL,
    get_data text NOT NULL,
    post_data text NOT NULL,
    failures_since_start integer NOT NULL,
    CONSTRAINT axes_accessattempt_failures_since_start_check CHECK ((failures_since_start >= 0))
);


ALTER TABLE public.axes_accessattempt OWNER TO clinica_user;

--
-- Name: axes_accessattempt_id_seq; Type: SEQUENCE; Schema: public; Owner: clinica_user
--

CREATE SEQUENCE public.axes_accessattempt_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.axes_accessattempt_id_seq OWNER TO clinica_user;

--
-- Name: axes_accessattempt_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: clinica_user
--

ALTER SEQUENCE public.axes_accessattempt_id_seq OWNED BY public.axes_accessattempt.id;


--
-- Name: axes_accesslog; Type: TABLE; Schema: public; Owner: clinica_user
--

CREATE TABLE public.axes_accesslog (
    id integer NOT NULL,
    user_agent character varying(255) NOT NULL,
    ip_address inet,
    username character varying(255),
    http_accept character varying(1025) NOT NULL,
    path_info character varying(255) NOT NULL,
    attempt_time timestamp with time zone NOT NULL,
    logout_time timestamp with time zone
);


ALTER TABLE public.axes_accesslog OWNER TO clinica_user;

--
-- Name: axes_accesslog_id_seq; Type: SEQUENCE; Schema: public; Owner: clinica_user
--

CREATE SEQUENCE public.axes_accesslog_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.axes_accesslog_id_seq OWNER TO clinica_user;

--
-- Name: axes_accesslog_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: clinica_user
--

ALTER SEQUENCE public.axes_accesslog_id_seq OWNED BY public.axes_accesslog.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: clinica_user
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO clinica_user;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: clinica_user
--

CREATE SEQUENCE public.django_admin_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO clinica_user;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: clinica_user
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: clinica_user
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO clinica_user;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: clinica_user
--

CREATE SEQUENCE public.django_content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO clinica_user;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: clinica_user
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: clinica_user
--

CREATE TABLE public.django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO clinica_user;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: clinica_user
--

CREATE SEQUENCE public.django_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO clinica_user;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: clinica_user
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: clinica_user
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO clinica_user;

--
-- Name: frontend_module; Type: TABLE; Schema: public; Owner: clinica_user
--

CREATE TABLE public.frontend_module (
    id integer NOT NULL,
    label character varying(50) NOT NULL,
    installed boolean NOT NULL
);


ALTER TABLE public.frontend_module OWNER TO clinica_user;

--
-- Name: frontend_module_id_seq; Type: SEQUENCE; Schema: public; Owner: clinica_user
--

CREATE SEQUENCE public.frontend_module_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.frontend_module_id_seq OWNER TO clinica_user;

--
-- Name: frontend_module_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: clinica_user
--

ALTER SEQUENCE public.frontend_module_id_seq OWNED BY public.frontend_module.id;


--
-- Name: gerencial_bitacora; Type: TABLE; Schema: public; Owner: clinica_user
--

CREATE TABLE public.gerencial_bitacora (
    id integer NOT NULL,
    accion character varying(255) NOT NULL,
    fecha timestamp with time zone NOT NULL,
    usuario_id integer NOT NULL
);


ALTER TABLE public.gerencial_bitacora OWNER TO clinica_user;

--
-- Name: gerencial_bitacora_id_seq; Type: SEQUENCE; Schema: public; Owner: clinica_user
--

CREATE SEQUENCE public.gerencial_bitacora_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.gerencial_bitacora_id_seq OWNER TO clinica_user;

--
-- Name: gerencial_bitacora_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: clinica_user
--

ALTER SEQUENCE public.gerencial_bitacora_id_seq OWNED BY public.gerencial_bitacora.id;


--
-- Name: gerencial_cita; Type: TABLE; Schema: public; Owner: clinica_user
--

CREATE TABLE public.gerencial_cita (
    id integer NOT NULL,
    "asuntoCita" character varying(50) NOT NULL,
    "fechaCita" date NOT NULL,
    "horaCita" time without time zone NOT NULL,
    "observacionCita" text,
    doctor_id integer NOT NULL,
    paciente_id integer NOT NULL
);


ALTER TABLE public.gerencial_cita OWNER TO clinica_user;

--
-- Name: gerencial_cita_id_seq; Type: SEQUENCE; Schema: public; Owner: clinica_user
--

CREATE SEQUENCE public.gerencial_cita_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.gerencial_cita_id_seq OWNER TO clinica_user;

--
-- Name: gerencial_cita_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: clinica_user
--

ALTER SEQUENCE public.gerencial_cita_id_seq OWNED BY public.gerencial_cita.id;


--
-- Name: gerencial_consulta; Type: TABLE; Schema: public; Owner: clinica_user
--

CREATE TABLE public.gerencial_consulta (
    id integer NOT NULL,
    "fechaConsulta" date NOT NULL,
    "horaInicio" time without time zone NOT NULL,
    "horaFinal" time without time zone,
    "observacionCons" text,
    doctor_id integer NOT NULL,
    paciente_id integer NOT NULL,
    precio numeric(5,2) NOT NULL
);


ALTER TABLE public.gerencial_consulta OWNER TO clinica_user;

--
-- Name: gerencial_consulta_id_seq; Type: SEQUENCE; Schema: public; Owner: clinica_user
--

CREATE SEQUENCE public.gerencial_consulta_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.gerencial_consulta_id_seq OWNER TO clinica_user;

--
-- Name: gerencial_consulta_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: clinica_user
--

ALTER SEQUENCE public.gerencial_consulta_id_seq OWNED BY public.gerencial_consulta.id;


--
-- Name: gerencial_doctor; Type: TABLE; Schema: public; Owner: clinica_user
--

CREATE TABLE public.gerencial_doctor (
    id integer NOT NULL,
    nombre character varying(40) NOT NULL
);


ALTER TABLE public.gerencial_doctor OWNER TO clinica_user;

--
-- Name: gerencial_doctor_id_seq; Type: SEQUENCE; Schema: public; Owner: clinica_user
--

CREATE SEQUENCE public.gerencial_doctor_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.gerencial_doctor_id_seq OWNER TO clinica_user;

--
-- Name: gerencial_doctor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: clinica_user
--

ALTER SEQUENCE public.gerencial_doctor_id_seq OWNED BY public.gerencial_doctor.id;


--
-- Name: gerencial_especificacion; Type: TABLE; Schema: public; Owner: clinica_user
--

CREATE TABLE public.gerencial_especificacion (
    id integer NOT NULL,
    dosis character varying(45) NOT NULL,
    duracion character varying(45) NOT NULL,
    medicamento_id integer NOT NULL,
    receta_id integer NOT NULL
);


ALTER TABLE public.gerencial_especificacion OWNER TO clinica_user;

--
-- Name: gerencial_especificacion_id_seq; Type: SEQUENCE; Schema: public; Owner: clinica_user
--

CREATE SEQUENCE public.gerencial_especificacion_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.gerencial_especificacion_id_seq OWNER TO clinica_user;

--
-- Name: gerencial_especificacion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: clinica_user
--

ALTER SEQUENCE public.gerencial_especificacion_id_seq OWNED BY public.gerencial_especificacion.id;


--
-- Name: gerencial_expediente; Type: TABLE; Schema: public; Owner: clinica_user
--

CREATE TABLE public.gerencial_expediente (
    id integer NOT NULL,
    "fechaCreacion" timestamp with time zone NOT NULL,
    pagado numeric(5,2) NOT NULL,
    saldo numeric(5,2) NOT NULL,
    "observacionExp" text,
    odontograma_id integer,
    paciente_id integer NOT NULL
);


ALTER TABLE public.gerencial_expediente OWNER TO clinica_user;

--
-- Name: gerencial_expediente_id_seq; Type: SEQUENCE; Schema: public; Owner: clinica_user
--

CREATE SEQUENCE public.gerencial_expediente_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.gerencial_expediente_id_seq OWNER TO clinica_user;

--
-- Name: gerencial_expediente_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: clinica_user
--

ALTER SEQUENCE public.gerencial_expediente_id_seq OWNED BY public.gerencial_expediente.id;


--
-- Name: gerencial_lotemedicamento; Type: TABLE; Schema: public; Owner: clinica_user
--

CREATE TABLE public.gerencial_lotemedicamento (
    id integer NOT NULL,
    fecha_vencimiento date NOT NULL,
    cantidad integer NOT NULL,
    medicamento_id integer NOT NULL,
    fecha_entrada date NOT NULL
);


ALTER TABLE public.gerencial_lotemedicamento OWNER TO clinica_user;

--
-- Name: gerencial_lotemedicamento_id_seq; Type: SEQUENCE; Schema: public; Owner: clinica_user
--

CREATE SEQUENCE public.gerencial_lotemedicamento_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.gerencial_lotemedicamento_id_seq OWNER TO clinica_user;

--
-- Name: gerencial_lotemedicamento_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: clinica_user
--

ALTER SEQUENCE public.gerencial_lotemedicamento_id_seq OWNED BY public.gerencial_lotemedicamento.id;


--
-- Name: gerencial_medicamento; Type: TABLE; Schema: public; Owner: clinica_user
--

CREATE TABLE public.gerencial_medicamento (
    id integer NOT NULL,
    nombre_producto character varying(30) NOT NULL,
    marca_producto character varying(30) NOT NULL,
    existencia_producto integer NOT NULL,
    precio_producto numeric(5,2),
    formafarmaceutica character varying(30) NOT NULL
);


ALTER TABLE public.gerencial_medicamento OWNER TO clinica_user;

--
-- Name: gerencial_medicamento_id_seq; Type: SEQUENCE; Schema: public; Owner: clinica_user
--

CREATE SEQUENCE public.gerencial_medicamento_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.gerencial_medicamento_id_seq OWNER TO clinica_user;

--
-- Name: gerencial_medicamento_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: clinica_user
--

ALTER SEQUENCE public.gerencial_medicamento_id_seq OWNED BY public.gerencial_medicamento.id;


--
-- Name: gerencial_odontograma; Type: TABLE; Schema: public; Owner: clinica_user
--

CREATE TABLE public.gerencial_odontograma (
    id integer NOT NULL,
    "fechaCreacion" timestamp with time zone NOT NULL,
    notas text NOT NULL,
    medico_id integer,
    "fechaUltimaModificacion" timestamp with time zone NOT NULL
);


ALTER TABLE public.gerencial_odontograma OWNER TO clinica_user;

--
-- Name: gerencial_odontograma_id_seq; Type: SEQUENCE; Schema: public; Owner: clinica_user
--

CREATE SEQUENCE public.gerencial_odontograma_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.gerencial_odontograma_id_seq OWNER TO clinica_user;

--
-- Name: gerencial_odontograma_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: clinica_user
--

ALTER SEQUENCE public.gerencial_odontograma_id_seq OWNED BY public.gerencial_odontograma.id;


--
-- Name: gerencial_paciente; Type: TABLE; Schema: public; Owner: clinica_user
--

CREATE TABLE public.gerencial_paciente (
    id integer NOT NULL,
    "nombresPaciente" character varying(60) NOT NULL,
    "apellidosPaciente" character varying(60) NOT NULL,
    sexo character varying(2) NOT NULL,
    "fechaNacimiento" date NOT NULL,
    referencia character varying(60)
);


ALTER TABLE public.gerencial_paciente OWNER TO clinica_user;

--
-- Name: gerencial_paciente_id_seq; Type: SEQUENCE; Schema: public; Owner: clinica_user
--

CREATE SEQUENCE public.gerencial_paciente_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.gerencial_paciente_id_seq OWNER TO clinica_user;

--
-- Name: gerencial_paciente_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: clinica_user
--

ALTER SEQUENCE public.gerencial_paciente_id_seq OWNED BY public.gerencial_paciente.id;


--
-- Name: gerencial_pago; Type: TABLE; Schema: public; Owner: clinica_user
--

CREATE TABLE public.gerencial_pago (
    id integer NOT NULL,
    "fechaPago" timestamp with time zone NOT NULL,
    cantidad numeric(5,2) NOT NULL,
    "Expediente_id" integer,
    procedimiento_id integer
);


ALTER TABLE public.gerencial_pago OWNER TO clinica_user;

--
-- Name: gerencial_pago_id_seq; Type: SEQUENCE; Schema: public; Owner: clinica_user
--

CREATE SEQUENCE public.gerencial_pago_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.gerencial_pago_id_seq OWNER TO clinica_user;

--
-- Name: gerencial_pago_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: clinica_user
--

ALTER SEQUENCE public.gerencial_pago_id_seq OWNED BY public.gerencial_pago.id;


--
-- Name: gerencial_procedimiento; Type: TABLE; Schema: public; Owner: clinica_user
--

CREATE TABLE public.gerencial_procedimiento (
    id integer NOT NULL,
    pieza integer NOT NULL,
    cara character varying(4) NOT NULL,
    diagnostico text NOT NULL,
    notas text NOT NULL,
    status character varying(12) NOT NULL,
    odontograma_id integer NOT NULL,
    tratamiento_id integer NOT NULL,
    consulta_realizada_id integer
);


ALTER TABLE public.gerencial_procedimiento OWNER TO clinica_user;

--
-- Name: gerencial_procedimiento_id_seq; Type: SEQUENCE; Schema: public; Owner: clinica_user
--

CREATE SEQUENCE public.gerencial_procedimiento_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.gerencial_procedimiento_id_seq OWNER TO clinica_user;

--
-- Name: gerencial_procedimiento_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: clinica_user
--

ALTER SEQUENCE public.gerencial_procedimiento_id_seq OWNED BY public.gerencial_procedimiento.id;


--
-- Name: gerencial_receta; Type: TABLE; Schema: public; Owner: clinica_user
--

CREATE TABLE public.gerencial_receta (
    id integer NOT NULL,
    consulta_id integer NOT NULL,
    "nombreReceta" character varying(100) NOT NULL
);


ALTER TABLE public.gerencial_receta OWNER TO clinica_user;

--
-- Name: gerencial_receta_id_seq; Type: SEQUENCE; Schema: public; Owner: clinica_user
--

CREATE SEQUENCE public.gerencial_receta_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.gerencial_receta_id_seq OWNER TO clinica_user;

--
-- Name: gerencial_receta_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: clinica_user
--

ALTER SEQUENCE public.gerencial_receta_id_seq OWNED BY public.gerencial_receta.id;


--
-- Name: gerencial_tratamiento; Type: TABLE; Schema: public; Owner: clinica_user
--

CREATE TABLE public.gerencial_tratamiento (
    id integer NOT NULL,
    "nombreTratamiento" character varying(100) NOT NULL,
    "descripcionTratamiento" text,
    "precioBase" numeric(5,2) NOT NULL
);


ALTER TABLE public.gerencial_tratamiento OWNER TO clinica_user;

--
-- Name: gerencial_tratamiento_id_seq; Type: SEQUENCE; Schema: public; Owner: clinica_user
--

CREATE SEQUENCE public.gerencial_tratamiento_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.gerencial_tratamiento_id_seq OWNER TO clinica_user;

--
-- Name: gerencial_tratamiento_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: clinica_user
--

ALTER SEQUENCE public.gerencial_tratamiento_id_seq OWNED BY public.gerencial_tratamiento.id;


--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: clinica_user
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: clinica_user
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: clinica_user
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- Name: auth_user id; Type: DEFAULT; Schema: public; Owner: clinica_user
--

ALTER TABLE ONLY public.auth_user ALTER COLUMN id SET DEFAULT nextval('public.auth_user_id_seq'::regclass);


--
-- Name: auth_user_groups id; Type: DEFAULT; Schema: public; Owner: clinica_user
--

ALTER TABLE ONLY public.auth_user_groups ALTER COLUMN id SET DEFAULT nextval('public.auth_user_groups_id_seq'::regclass);


--
-- Name: auth_user_user_permissions id; Type: DEFAULT; Schema: public; Owner: clinica_user
--

ALTER TABLE ONLY public.auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_user_user_permissions_id_seq'::regclass);


--
-- Name: axes_accessattempt id; Type: DEFAULT; Schema: public; Owner: clinica_user
--

ALTER TABLE ONLY public.axes_accessattempt ALTER COLUMN id SET DEFAULT nextval('public.axes_accessattempt_id_seq'::regclass);


--
-- Name: axes_accesslog id; Type: DEFAULT; Schema: public; Owner: clinica_user
--

ALTER TABLE ONLY public.axes_accesslog ALTER COLUMN id SET DEFAULT nextval('public.axes_accesslog_id_seq'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: clinica_user
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: clinica_user
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: clinica_user
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- Name: frontend_module id; Type: DEFAULT; Schema: public; Owner: clinica_user
--

ALTER TABLE ONLY public.frontend_module ALTER COLUMN id SET DEFAULT nextval('public.frontend_module_id_seq'::regclass);


--
-- Name: gerencial_bitacora id; Type: DEFAULT; Schema: public; Owner: clinica_user
--

ALTER TABLE ONLY public.gerencial_bitacora ALTER COLUMN id SET DEFAULT nextval('public.gerencial_bitacora_id_seq'::regclass);


--
-- Name: gerencial_cita id; Type: DEFAULT; Schema: public; Owner: clinica_user
--

ALTER TABLE ONLY public.gerencial_cita ALTER COLUMN id SET DEFAULT nextval('public.gerencial_cita_id_seq'::regclass);


--
-- Name: gerencial_consulta id; Type: DEFAULT; Schema: public; Owner: clinica_user
--

ALTER TABLE ONLY public.gerencial_consulta ALTER COLUMN id SET DEFAULT nextval('public.gerencial_consulta_id_seq'::regclass);


--
-- Name: gerencial_doctor id; Type: DEFAULT; Schema: public; Owner: clinica_user
--

ALTER TABLE ONLY public.gerencial_doctor ALTER COLUMN id SET DEFAULT nextval('public.gerencial_doctor_id_seq'::regclass);


--
-- Name: gerencial_especificacion id; Type: DEFAULT; Schema: public; Owner: clinica_user
--

ALTER TABLE ONLY public.gerencial_especificacion ALTER COLUMN id SET DEFAULT nextval('public.gerencial_especificacion_id_seq'::regclass);


--
-- Name: gerencial_expediente id; Type: DEFAULT; Schema: public; Owner: clinica_user
--

ALTER TABLE ONLY public.gerencial_expediente ALTER COLUMN id SET DEFAULT nextval('public.gerencial_expediente_id_seq'::regclass);


--
-- Name: gerencial_lotemedicamento id; Type: DEFAULT; Schema: public; Owner: clinica_user
--

ALTER TABLE ONLY public.gerencial_lotemedicamento ALTER COLUMN id SET DEFAULT nextval('public.gerencial_lotemedicamento_id_seq'::regclass);


--
-- Name: gerencial_medicamento id; Type: DEFAULT; Schema: public; Owner: clinica_user
--

ALTER TABLE ONLY public.gerencial_medicamento ALTER COLUMN id SET DEFAULT nextval('public.gerencial_medicamento_id_seq'::regclass);


--
-- Name: gerencial_odontograma id; Type: DEFAULT; Schema: public; Owner: clinica_user
--

ALTER TABLE ONLY public.gerencial_odontograma ALTER COLUMN id SET DEFAULT nextval('public.gerencial_odontograma_id_seq'::regclass);


--
-- Name: gerencial_paciente id; Type: DEFAULT; Schema: public; Owner: clinica_user
--

ALTER TABLE ONLY public.gerencial_paciente ALTER COLUMN id SET DEFAULT nextval('public.gerencial_paciente_id_seq'::regclass);


--
-- Name: gerencial_pago id; Type: DEFAULT; Schema: public; Owner: clinica_user
--

ALTER TABLE ONLY public.gerencial_pago ALTER COLUMN id SET DEFAULT nextval('public.gerencial_pago_id_seq'::regclass);


--
-- Name: gerencial_procedimiento id; Type: DEFAULT; Schema: public; Owner: clinica_user
--

ALTER TABLE ONLY public.gerencial_procedimiento ALTER COLUMN id SET DEFAULT nextval('public.gerencial_procedimiento_id_seq'::regclass);


--
-- Name: gerencial_receta id; Type: DEFAULT; Schema: public; Owner: clinica_user
--

ALTER TABLE ONLY public.gerencial_receta ALTER COLUMN id SET DEFAULT nextval('public.gerencial_receta_id_seq'::regclass);


--
-- Name: gerencial_tratamiento id; Type: DEFAULT; Schema: public; Owner: clinica_user
--

ALTER TABLE ONLY public.gerencial_tratamiento ALTER COLUMN id SET DEFAULT nextval('public.gerencial_tratamiento_id_seq'::regclass);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: clinica_user
--

COPY public.auth_group (id, name) FROM stdin;
1	administrador
2	estrategico
3	tactico
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: clinica_user
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: clinica_user
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add module	1	add_module
2	Can change module	1	change_module
3	Can delete module	1	delete_module
4	Can view module	1	view_module
5	Can add log entry	2	add_logentry
6	Can change log entry	2	change_logentry
7	Can delete log entry	2	delete_logentry
8	Can view log entry	2	view_logentry
9	Can add permission	3	add_permission
10	Can change permission	3	change_permission
11	Can delete permission	3	delete_permission
12	Can view permission	3	view_permission
13	Can add group	4	add_group
14	Can change group	4	change_group
15	Can delete group	4	delete_group
16	Can view group	4	view_group
17	Can add user	5	add_user
18	Can change user	5	change_user
19	Can delete user	5	delete_user
20	Can view user	5	view_user
21	Can add content type	6	add_contenttype
22	Can change content type	6	change_contenttype
23	Can delete content type	6	delete_contenttype
24	Can view content type	6	view_contenttype
25	Can add session	7	add_session
26	Can change session	7	change_session
27	Can delete session	7	delete_session
28	Can view session	7	view_session
29	Can add access attempt	8	add_accessattempt
30	Can change access attempt	8	change_accessattempt
31	Can delete access attempt	8	delete_accessattempt
32	Can view access attempt	8	view_accessattempt
33	Can add access log	9	add_accesslog
34	Can change access log	9	change_accesslog
35	Can delete access log	9	delete_accesslog
36	Can view access log	9	view_accesslog
37	Can add Consulta	10	add_consulta
38	Can change Consulta	10	change_consulta
39	Can delete Consulta	10	delete_consulta
40	Can view Consulta	10	view_consulta
41	Can add Doctor	11	add_doctor
42	Can change Doctor	11	change_doctor
43	Can delete Doctor	11	delete_doctor
44	Can view Doctor	11	view_doctor
45	Can add especificacion	12	add_especificacion
46	Can change especificacion	12	change_especificacion
47	Can delete especificacion	12	delete_especificacion
48	Can view especificacion	12	view_especificacion
49	Can add Expediente	13	add_expediente
50	Can change Expediente	13	change_expediente
51	Can delete Expediente	13	delete_expediente
52	Can view Expediente	13	view_expediente
53	Can add medicamento	14	add_medicamento
54	Can change medicamento	14	change_medicamento
55	Can delete medicamento	14	delete_medicamento
56	Can view medicamento	14	view_medicamento
57	Can add odontograma	15	add_odontograma
58	Can change odontograma	15	change_odontograma
59	Can delete odontograma	15	delete_odontograma
60	Can view odontograma	15	view_odontograma
61	Can add Tratamiento	16	add_tratamiento
62	Can change Tratamiento	16	change_tratamiento
63	Can delete Tratamiento	16	delete_tratamiento
64	Can view Tratamiento	16	view_tratamiento
65	Can add receta	17	add_receta
66	Can change receta	17	change_receta
67	Can delete receta	17	delete_receta
68	Can view receta	17	view_receta
69	Can add procedimiento	18	add_procedimiento
70	Can change procedimiento	18	change_procedimiento
71	Can delete procedimiento	18	delete_procedimiento
72	Can view procedimiento	18	view_procedimiento
73	Can add pago	19	add_pago
74	Can change pago	19	change_pago
75	Can delete pago	19	delete_pago
76	Can view pago	19	view_pago
77	Can add Paciente	20	add_paciente
78	Can change Paciente	20	change_paciente
79	Can delete Paciente	20	delete_paciente
80	Can view Paciente	20	view_paciente
81	Can add lote medicamento	21	add_lotemedicamento
82	Can change lote medicamento	21	change_lotemedicamento
83	Can delete lote medicamento	21	delete_lotemedicamento
84	Can view lote medicamento	21	view_lotemedicamento
85	Can add Cita	22	add_cita
86	Can change Cita	22	change_cita
87	Can delete Cita	22	delete_cita
88	Can view Cita	22	view_cita
89	Can add bitacora	23	add_bitacora
90	Can change bitacora	23	change_bitacora
91	Can delete bitacora	23	delete_bitacora
92	Can view bitacora	23	view_bitacora
\.


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: clinica_user
--

COPY public.auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
3	argon2$argon2i$v=19$m=512,t=2,p=2$dEhIZjFOWDh0c2l3$kEVdLWbtgjwQ54NHxyO5Pw	2019-07-06 07:32:33.682631-06	f	Susacer23	Susana	Argueta Cerna	susacer12@gmail.com	f	t	2019-07-06 07:30:36.199868-06
4	argon2$argon2i$v=19$m=512,t=2,p=2$QTlGNzRBaENiWGxE$hx1AZbBdRQX0yACQu6jo8w	2019-07-06 07:37:23.222818-06	f	Rodriguez	Ana	Rodriguez	rodriguez@gmail.com	f	t	2019-07-06 07:36:48.184462-06
1	argon2$argon2i$v=19$m=512,t=2,p=2$YkpxVjhKVEJGUkU0$OLGtPjPTfY95kWu2wpizsQ	2019-07-06 07:48:56.123434-06	t	root	Carlos	Cativo	cativo23.kt@gmail.com	t	t	2019-07-05 08:22:26-06
2	!qHX9xQm4MAa08LmibwZLdlf889ZZ7ZZ37ILnNnDL	\N	f	cristian	Cris	Osegueda	dchrisviii@gmail.com	f	t	2019-07-05 18:19:25.68493-06
\.


--
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: clinica_user
--

COPY public.auth_user_groups (id, user_id, group_id) FROM stdin;
1	1	1
2	1	2
3	1	3
4	2	2
5	3	2
6	4	3
\.


--
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: clinica_user
--

COPY public.auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Data for Name: axes_accessattempt; Type: TABLE DATA; Schema: public; Owner: clinica_user
--

COPY public.axes_accessattempt (id, user_agent, ip_address, username, http_accept, path_info, attempt_time, get_data, post_data, failures_since_start) FROM stdin;
7	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.100 Safari/537.36 OPR/62.0.3331.43	127.0.0.1	administrador	text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8	/auth/login/	2019-07-06 07:07:50.289784-06	next=/	csrfmiddlewaretoken=wMHnDHEBT6PZ1eezqCXRN0lU0jSCAxor2fIDehq4BIjCR4STUYL2Nd19CY747fzA\nusername=administrador\naction=	1
13	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.100 Safari/537.36	192.168.43.129	susacer23	text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3	/auth/login/	2019-07-06 07:32:17.941241-06	next=/	csrfmiddlewaretoken=uELcDtcXqyr5z4CRMKifgWSLGBgtJe3VbTyn14KrHh4JbNTA3vnoynSUZrd37jCF\nusername=susacer23\naction=	1
\.


--
-- Data for Name: axes_accesslog; Type: TABLE DATA; Schema: public; Owner: clinica_user
--

COPY public.axes_accesslog (id, user_agent, ip_address, username, http_accept, path_info, attempt_time, logout_time) FROM stdin;
1	Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Firefox/60.0	127.0.0.1	root	text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8	/auth/login/	2019-07-05 08:25:24.497714-06	2019-07-05 08:27:36.155879-06
3	Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Firefox/60.0	127.0.0.1	root	text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8	/auth/login/	2019-07-05 08:28:42.8961-06	2019-07-05 08:29:34.633297-06
2	Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Firefox/60.0	127.0.0.1	root	text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8	/admin/login/	2019-07-05 08:28:26.797698-06	2019-07-05 08:29:34.633297-06
14	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.100 Safari/537.36	192.168.0.104	root	text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3	/auth/login/	2019-07-05 17:25:40.948071-06	2019-07-05 17:26:36.417767-06
13	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:67.0) Gecko/20100101 Firefox/67.0	192.168.0.102	root	text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8	/auth/login/	2019-07-05 17:25:19.758772-06	2019-07-05 17:26:36.417767-06
12	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:67.0) Gecko/20100101 Firefox/67.0	192.168.0.100	root	text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8	/auth/login/	2019-07-05 17:23:32.418714-06	2019-07-05 17:26:36.417767-06
11	Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Firefox/60.0	192.168.0.101	root	text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8	/auth/login/	2019-07-05 17:23:11.77319-06	2019-07-05 17:26:36.417767-06
10	Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Firefox/60.0	127.0.0.1	root	text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8	/admin/login/	2019-07-05 12:26:33.10801-06	2019-07-05 17:26:36.417767-06
9	Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Firefox/60.0	127.0.0.1	root	text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8	/admin/login/	2019-07-05 12:21:23.980526-06	2019-07-05 17:26:36.417767-06
8	Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Firefox/60.0	127.0.0.1	root	text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8	/admin/login/	2019-07-05 12:16:55.033792-06	2019-07-05 17:26:36.417767-06
7	Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Firefox/60.0	127.0.0.1	root	text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8	/admin/login/	2019-07-05 12:06:32.134154-06	2019-07-05 17:26:36.417767-06
6	Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Firefox/60.0	127.0.0.1	root	text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8	/admin/login/	2019-07-05 11:43:00.117218-06	2019-07-05 17:26:36.417767-06
5	Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Firefox/60.0	127.0.0.1	root	text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8	/admin/login/	2019-07-05 09:32:04.041023-06	2019-07-05 17:26:36.417767-06
4	Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Firefox/60.0	127.0.0.1	root	text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8	/auth/login/	2019-07-05 08:29:37.831954-06	2019-07-05 17:26:36.417767-06
16	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:67.0) Gecko/20100101 Firefox/67.0	192.168.0.102	root	text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8	/auth/login/	2019-07-05 17:26:43.550259-06	2019-07-05 17:27:14.021336-06
15	Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Firefox/60.0	192.168.0.101	root	text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8	/auth/login/	2019-07-05 17:26:38.694472-06	2019-07-05 17:27:14.021336-06
18	Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Firefox/60.0	127.0.0.1	root	text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8	/auth/login/	2019-07-05 18:06:43.850419-06	2019-07-05 18:06:56.226612-06
17	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.100 Safari/537.36	192.168.0.104	root	text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3	/admin/login/	2019-07-05 17:27:58.288257-06	2019-07-05 18:06:56.226612-06
19	Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Firefox/60.0	127.0.0.1	root	text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8	/auth/login/	2019-07-05 18:07:01.428507-06	2019-07-05 18:07:22.890459-06
21	Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Firefox/60.0	127.0.0.1	root	text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8	/auth/login/	2019-07-05 18:08:39.622478-06	2019-07-05 18:08:52.066049-06
20	Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Firefox/60.0	127.0.0.1	root	text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8	/auth/login/	2019-07-05 18:07:27.32948-06	2019-07-05 18:08:52.066049-06
22	Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Firefox/60.0	127.0.0.1	root	text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8	/auth/login/	2019-07-05 18:08:56.747052-06	2019-07-05 18:20:57.943011-06
24	Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Firefox/60.0	127.0.0.1	root	text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8	/auth/login/	2019-07-05 18:22:43.510033-06	2019-07-05 18:30:08.021282-06
23	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:67.0) Gecko/20100101 Firefox/67.0	192.168.0.102	root	text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8	/auth/login/	2019-07-05 18:21:09.961492-06	2019-07-05 18:30:08.021282-06
25	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:67.0) Gecko/20100101 Firefox/67.0	192.168.0.102	root	text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8	/auth/login/	2019-07-05 18:30:15.878798-06	2019-07-05 18:31:39.125026-06
26	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:67.0) Gecko/20100101 Firefox/67.0	192.168.0.102	root	text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8	/auth/login/	2019-07-05 18:31:45.561625-06	2019-07-05 18:32:49.988986-06
27	Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Firefox/60.0	192.168.0.101	root	text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8	/auth/login/	2019-07-05 18:32:55.674822-06	2019-07-06 02:47:57.252213-06
28	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.100 Safari/537.36	192.168.0.102	root	text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3	/auth/login/	2019-07-05 18:33:09.465634-06	2019-07-06 02:47:57.252213-06
29	Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Firefox/60.0	192.168.0.101	root	text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8	/auth/login/	2019-07-05 18:35:15.98286-06	2019-07-06 02:47:57.252213-06
30	Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Firefox/60.0	192.168.0.18	root	text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8	/auth/login/	2019-07-05 18:42:31.105888-06	2019-07-06 02:47:57.252213-06
31	Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Firefox/60.0	192.168.43.98	root	text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8	/auth/login/	2019-07-05 18:43:48.42567-06	2019-07-06 02:47:57.252213-06
32	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.100 Safari/537.36	192.168.43.238	root	text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3	/auth/login/	2019-07-05 18:44:06.299967-06	2019-07-06 02:47:57.252213-06
33	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.100 Safari/537.36 OPR/62.0.3331.43	127.0.0.1	root	text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8	/auth/login/	2019-07-06 02:46:44.051835-06	2019-07-06 02:47:57.252213-06
34	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.100 Safari/537.36 OPR/62.0.3331.43	127.0.0.1	root	text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8	/auth/login/	2019-07-06 05:28:46.417153-06	\N
35	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.100 Safari/537.36 OPR/62.0.3331.43	127.0.0.1	root	text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8	/auth/login/	2019-07-06 06:11:40.137797-06	\N
36	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.100 Safari/537.36 OPR/62.0.3331.43	127.0.0.1	root	text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8	/auth/login/	2019-07-06 07:07:56.832507-06	\N
37	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:67.0) Gecko/20100101 Firefox/67.0	192.168.43.204	root	text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8	/auth/login/	2019-07-06 07:16:08.049005-06	\N
38	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.100 Safari/537.36	192.168.43.129	root	text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3	/auth/login/	2019-07-06 07:21:09.054941-06	\N
39	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.80 Safari/537.36 OPR/62.0.3331.18	192.168.43.241	root	text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8	/auth/login/	2019-07-06 07:21:22.93642-06	\N
40	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.100 Safari/537.36 OPR/62.0.3331.43	127.0.0.1	root	text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8	/auth/login/	2019-07-06 07:23:50.841117-06	\N
41	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.100 Safari/537.36 OPR/62.0.3331.43	127.0.0.1	root	text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8	/auth/login/	2019-07-06 07:25:01.668772-06	\N
42	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.100 Safari/537.36	192.168.43.129	Susacer23	text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3	/auth/login/	2019-07-06 07:32:33.693965-06	2019-07-06 07:35:44.848155-06
43	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.100 Safari/537.36 OPR/62.0.3331.43	127.0.0.1	root	text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8	/admin/login/	2019-07-06 07:36:01.828994-06	\N
44	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.100 Safari/537.36	192.168.43.129	Rodriguez	text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3	/auth/login/	2019-07-06 07:37:23.267845-06	2019-07-06 07:48:48.46322-06
45	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.100 Safari/537.36	192.168.43.129	root	text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3	/auth/login/	2019-07-06 07:48:56.135056-06	\N
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: clinica_user
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
1	2019-07-05 08:30:58.43378-06	1	administrador	1	[{"added": {}}]	4	1
2	2019-07-05 08:32:20.797699-06	1	root	2	[{"changed": {"fields": ["groups"]}}]	5	1
3	2019-07-05 17:27:44.009159-06	2	estrategico	1	[{"added": {}}]	4	1
4	2019-07-05 17:27:59.219022-06	3	tactico	1	[{"added": {}}]	4	1
5	2019-07-05 17:30:39.914499-06	1	root	2	[{"changed": {"fields": ["groups"]}}]	5	1
6	2019-07-06 05:35:21.499224-06	1	Expediente de Cativo Argueta, Carlos Antonio	2	[{"changed": {"fields": ["pagado"]}}]	13	1
7	2019-07-06 05:37:56.9765-06	1	Expediente de Cativo Argueta, Carlos Antonio	2	[{"changed": {"fields": ["saldo"]}}]	13	1
8	2019-07-06 07:31:43.869232-06	3	Susacer23	2	[{"changed": {"fields": ["password"]}}]	5	1
9	2019-07-06 07:37:10.643072-06	4	Rodriguez	2	[{"changed": {"fields": ["password"]}}]	5	1
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: clinica_user
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	frontend	module
2	admin	logentry
3	auth	permission
4	auth	group
5	auth	user
6	contenttypes	contenttype
7	sessions	session
8	axes	accessattempt
9	axes	accesslog
10	gerencial	consulta
11	gerencial	doctor
12	gerencial	especificacion
13	gerencial	expediente
14	gerencial	medicamento
15	gerencial	odontograma
16	gerencial	tratamiento
17	gerencial	receta
18	gerencial	procedimiento
19	gerencial	pago
20	gerencial	paciente
21	gerencial	lotemedicamento
22	gerencial	cita
23	gerencial	bitacora
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: clinica_user
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2019-07-05 08:21:57.760156-06
2	auth	0001_initial	2019-07-05 08:21:58.398645-06
3	admin	0001_initial	2019-07-05 08:21:59.442556-06
4	admin	0002_logentry_remove_auto_add	2019-07-05 08:21:59.595026-06
5	admin	0003_logentry_add_action_flag_choices	2019-07-05 08:21:59.650368-06
6	contenttypes	0002_remove_content_type_name	2019-07-05 08:21:59.72249-06
7	auth	0002_alter_permission_name_max_length	2019-07-05 08:21:59.745347-06
8	auth	0003_alter_user_email_max_length	2019-07-05 08:21:59.762686-06
9	auth	0004_alter_user_username_opts	2019-07-05 08:21:59.786888-06
10	auth	0005_alter_user_last_login_null	2019-07-05 08:21:59.809063-06
11	auth	0006_require_contenttypes_0002	2019-07-05 08:21:59.817602-06
12	auth	0007_alter_validators_add_error_messages	2019-07-05 08:21:59.843931-06
13	auth	0008_alter_user_username_max_length	2019-07-05 08:21:59.919987-06
14	auth	0009_alter_user_last_name_max_length	2019-07-05 08:21:59.969974-06
15	auth	0010_alter_group_name_max_length	2019-07-05 08:22:00.014831-06
16	auth	0011_update_proxy_permissions	2019-07-05 08:22:00.045358-06
17	axes	0001_initial	2019-07-05 08:22:00.22266-06
18	axes	0002_auto_20151217_2044	2019-07-05 08:22:00.763687-06
19	axes	0003_auto_20160322_0929	2019-07-05 08:22:00.840639-06
20	axes	0004_auto_20181024_1538	2019-07-05 08:22:00.87272-06
21	axes	0005_remove_accessattempt_trusted	2019-07-05 08:22:00.887575-06
22	axes	0006_remove_accesslog_trusted	2019-07-05 08:22:00.899781-06
23	frontend	0001_initial	2019-07-05 08:22:00.953698-06
24	frontend	0002_i18n	2019-07-05 08:22:01.081677-06
25	gerencial	0001_initial	2019-07-05 08:22:02.235326-06
26	gerencial	0002_procedimiento_consulta_realizada	2019-07-05 08:22:02.867614-06
27	gerencial	0003_consulta_precio	2019-07-05 08:22:03.205382-06
28	gerencial	0004_auto_20190619_0116	2019-07-05 08:22:03.268039-06
29	gerencial	0005_pago_procedimiento	2019-07-05 08:22:03.296945-06
30	gerencial	0006_odontograma_fechaultimamodificacion	2019-07-05 08:22:03.484236-06
31	gerencial	0006_auto_20190622_0819	2019-07-05 08:22:03.791376-06
32	gerencial	0007_merge_20190704_2243	2019-07-05 08:22:03.805925-06
33	gerencial	0008_bitacora	2019-07-05 08:22:03.860563-06
34	sessions	0001_initial	2019-07-05 08:22:03.998998-06
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: clinica_user
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
1y2wzvg1k17aogwzb0y398sphb30gk39	YmY3NmNjYTMxYWY4NzI0MWQ2NDJiZTkwNzNlMzM3YTU5OTBiOTk2MDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI1ZDUyZTc1OTRiNjllZDkwM2ZkZDE3Zjg2NzMzZmM5YzE0ODYwY2YxIn0=	2019-07-19 08:29:37.849065-06
0yk2olo18m7c5cn8pvo5zrx25t3gs8y2	YmY3NmNjYTMxYWY4NzI0MWQ2NDJiZTkwNzNlMzM3YTU5OTBiOTk2MDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI1ZDUyZTc1OTRiNjllZDkwM2ZkZDE3Zjg2NzMzZmM5YzE0ODYwY2YxIn0=	2019-07-19 09:32:04.130354-06
pke4t5u3ra9gpjea1rzwmewjavhcww8c	YmY3NmNjYTMxYWY4NzI0MWQ2NDJiZTkwNzNlMzM3YTU5OTBiOTk2MDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI1ZDUyZTc1OTRiNjllZDkwM2ZkZDE3Zjg2NzMzZmM5YzE0ODYwY2YxIn0=	2019-07-19 11:43:00.19617-06
n4qdd2635vwt1p05xnhf5hc3p15mt3ra	YmY3NmNjYTMxYWY4NzI0MWQ2NDJiZTkwNzNlMzM3YTU5OTBiOTk2MDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI1ZDUyZTc1OTRiNjllZDkwM2ZkZDE3Zjg2NzMzZmM5YzE0ODYwY2YxIn0=	2019-07-19 12:06:32.180561-06
dww7pl4xj4gcm1wvbui27znw999m2l3t	YmY3NmNjYTMxYWY4NzI0MWQ2NDJiZTkwNzNlMzM3YTU5OTBiOTk2MDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI1ZDUyZTc1OTRiNjllZDkwM2ZkZDE3Zjg2NzMzZmM5YzE0ODYwY2YxIn0=	2019-07-19 12:16:55.070912-06
dob42yjocu2ajryyjgerz5ml0ztuc5ag	YmY3NmNjYTMxYWY4NzI0MWQ2NDJiZTkwNzNlMzM3YTU5OTBiOTk2MDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI1ZDUyZTc1OTRiNjllZDkwM2ZkZDE3Zjg2NzMzZmM5YzE0ODYwY2YxIn0=	2019-07-19 12:21:24.025876-06
kmubgiya89jlu02b0o3uob93kh05lg0i	YmY3NmNjYTMxYWY4NzI0MWQ2NDJiZTkwNzNlMzM3YTU5OTBiOTk2MDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI1ZDUyZTc1OTRiNjllZDkwM2ZkZDE3Zjg2NzMzZmM5YzE0ODYwY2YxIn0=	2019-07-19 12:26:33.156382-06
ih4y26uxvc8zomhsjbfm009wkptbm77y	YmY3NmNjYTMxYWY4NzI0MWQ2NDJiZTkwNzNlMzM3YTU5OTBiOTk2MDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI1ZDUyZTc1OTRiNjllZDkwM2ZkZDE3Zjg2NzMzZmM5YzE0ODYwY2YxIn0=	2019-07-19 17:27:58.302218-06
pn0egkk51gey3y6frf1pbq3bz5soczk1	YmY3NmNjYTMxYWY4NzI0MWQ2NDJiZTkwNzNlMzM3YTU5OTBiOTk2MDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI1ZDUyZTc1OTRiNjllZDkwM2ZkZDE3Zjg2NzMzZmM5YzE0ODYwY2YxIn0=	2019-07-19 18:07:27.342312-06
t6o0btpgtlckejtlvyjyc7r029fy8sxv	YmY3NmNjYTMxYWY4NzI0MWQ2NDJiZTkwNzNlMzM3YTU5OTBiOTk2MDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI1ZDUyZTc1OTRiNjllZDkwM2ZkZDE3Zjg2NzMzZmM5YzE0ODYwY2YxIn0=	2019-07-19 18:08:56.796894-06
mmpt47bm7wmbpkpawahwactgojab9h05	YmY3NmNjYTMxYWY4NzI0MWQ2NDJiZTkwNzNlMzM3YTU5OTBiOTk2MDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI1ZDUyZTc1OTRiNjllZDkwM2ZkZDE3Zjg2NzMzZmM5YzE0ODYwY2YxIn0=	2019-07-19 18:22:43.522518-06
fmw4drj5r4onccyrcw9gfpgx38dc9t5g	YmY3NmNjYTMxYWY4NzI0MWQ2NDJiZTkwNzNlMzM3YTU5OTBiOTk2MDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI1ZDUyZTc1OTRiNjllZDkwM2ZkZDE3Zjg2NzMzZmM5YzE0ODYwY2YxIn0=	2019-07-19 18:31:45.579847-06
6unhrkk0ou0iznen1rny914v838s149s	YmY3NmNjYTMxYWY4NzI0MWQ2NDJiZTkwNzNlMzM3YTU5OTBiOTk2MDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI1ZDUyZTc1OTRiNjllZDkwM2ZkZDE3Zjg2NzMzZmM5YzE0ODYwY2YxIn0=	2019-07-19 18:32:55.722762-06
3nychdk42m80jlqx6b04b5za8u0tfoz4	YmY3NmNjYTMxYWY4NzI0MWQ2NDJiZTkwNzNlMzM3YTU5OTBiOTk2MDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI1ZDUyZTc1OTRiNjllZDkwM2ZkZDE3Zjg2NzMzZmM5YzE0ODYwY2YxIn0=	2019-07-19 18:33:09.478861-06
28k5dkb222ckkxv0yy5s3hh3liwylm2n	YmY3NmNjYTMxYWY4NzI0MWQ2NDJiZTkwNzNlMzM3YTU5OTBiOTk2MDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI1ZDUyZTc1OTRiNjllZDkwM2ZkZDE3Zjg2NzMzZmM5YzE0ODYwY2YxIn0=	2019-07-19 18:35:16.000817-06
veybglmo33c1amxnyhqvu35rgjqp8381	YmY3NmNjYTMxYWY4NzI0MWQ2NDJiZTkwNzNlMzM3YTU5OTBiOTk2MDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI1ZDUyZTc1OTRiNjllZDkwM2ZkZDE3Zjg2NzMzZmM5YzE0ODYwY2YxIn0=	2019-07-19 18:42:31.166932-06
9pduq1m6sa2jk1ybg4sykxckndfwbiif	YmY3NmNjYTMxYWY4NzI0MWQ2NDJiZTkwNzNlMzM3YTU5OTBiOTk2MDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI1ZDUyZTc1OTRiNjllZDkwM2ZkZDE3Zjg2NzMzZmM5YzE0ODYwY2YxIn0=	2019-07-19 18:43:48.459676-06
aqf7koy7mcdxz25gzredlatae4hga0lk	YmY3NmNjYTMxYWY4NzI0MWQ2NDJiZTkwNzNlMzM3YTU5OTBiOTk2MDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI1ZDUyZTc1OTRiNjllZDkwM2ZkZDE3Zjg2NzMzZmM5YzE0ODYwY2YxIn0=	2019-07-19 18:44:06.315405-06
i0ztavbialy9jm969hp42ux0duuwuijz	YmY3NmNjYTMxYWY4NzI0MWQ2NDJiZTkwNzNlMzM3YTU5OTBiOTk2MDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI1ZDUyZTc1OTRiNjllZDkwM2ZkZDE3Zjg2NzMzZmM5YzE0ODYwY2YxIn0=	2019-07-20 05:28:46.453422-06
tzw0ttqpcqi4qj2rqmnubhy4qvhw3kby	YmY3NmNjYTMxYWY4NzI0MWQ2NDJiZTkwNzNlMzM3YTU5OTBiOTk2MDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI1ZDUyZTc1OTRiNjllZDkwM2ZkZDE3Zjg2NzMzZmM5YzE0ODYwY2YxIn0=	2019-07-20 06:11:40.308497-06
22ibwk0fkh4jj2z9608wygivsw4ogmau	YmY3NmNjYTMxYWY4NzI0MWQ2NDJiZTkwNzNlMzM3YTU5OTBiOTk2MDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI1ZDUyZTc1OTRiNjllZDkwM2ZkZDE3Zjg2NzMzZmM5YzE0ODYwY2YxIn0=	2019-07-20 07:07:56.846163-06
sfv8eaghmm1y0b4ezv3t862ujzyfgp2i	YmY3NmNjYTMxYWY4NzI0MWQ2NDJiZTkwNzNlMzM3YTU5OTBiOTk2MDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI1ZDUyZTc1OTRiNjllZDkwM2ZkZDE3Zjg2NzMzZmM5YzE0ODYwY2YxIn0=	2019-07-20 07:16:08.095448-06
689yhyqo235mtzq32yqgaj9ybxws3mrp	YmY3NmNjYTMxYWY4NzI0MWQ2NDJiZTkwNzNlMzM3YTU5OTBiOTk2MDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI1ZDUyZTc1OTRiNjllZDkwM2ZkZDE3Zjg2NzMzZmM5YzE0ODYwY2YxIn0=	2019-07-20 07:21:22.960864-06
fdt0vu7ao6j1g4wy0al1ftv3l6z56tor	YmY3NmNjYTMxYWY4NzI0MWQ2NDJiZTkwNzNlMzM3YTU5OTBiOTk2MDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI1ZDUyZTc1OTRiNjllZDkwM2ZkZDE3Zjg2NzMzZmM5YzE0ODYwY2YxIn0=	2019-07-20 07:23:50.857207-06
qnmxam6zgyughdz03f06fsawrcrhkgu3	YmY3NmNjYTMxYWY4NzI0MWQ2NDJiZTkwNzNlMzM3YTU5OTBiOTk2MDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI1ZDUyZTc1OTRiNjllZDkwM2ZkZDE3Zjg2NzMzZmM5YzE0ODYwY2YxIn0=	2019-07-20 07:25:01.715322-06
713ibvx3bej1hzaiuc3x7if7ehhqfnlt	YmY3NmNjYTMxYWY4NzI0MWQ2NDJiZTkwNzNlMzM3YTU5OTBiOTk2MDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI1ZDUyZTc1OTRiNjllZDkwM2ZkZDE3Zjg2NzMzZmM5YzE0ODYwY2YxIn0=	2019-07-20 07:36:01.841548-06
l7ypmo6iudwxhcj4o8p5674edke7yryq	YmY3NmNjYTMxYWY4NzI0MWQ2NDJiZTkwNzNlMzM3YTU5OTBiOTk2MDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI1ZDUyZTc1OTRiNjllZDkwM2ZkZDE3Zjg2NzMzZmM5YzE0ODYwY2YxIn0=	2019-07-20 07:37:10.703737-06
tmbcl9lmmlk35gpys2dssit1gn1xs91v	YmY3NmNjYTMxYWY4NzI0MWQ2NDJiZTkwNzNlMzM3YTU5OTBiOTk2MDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI1ZDUyZTc1OTRiNjllZDkwM2ZkZDE3Zjg2NzMzZmM5YzE0ODYwY2YxIn0=	2019-07-20 07:48:56.15294-06
\.


--
-- Data for Name: frontend_module; Type: TABLE DATA; Schema: public; Owner: clinica_user
--

COPY public.frontend_module (id, label, installed) FROM stdin;
\.


--
-- Data for Name: gerencial_bitacora; Type: TABLE DATA; Schema: public; Owner: clinica_user
--

COPY public.gerencial_bitacora (id, accion, fecha, usuario_id) FROM stdin;
1	Ejecucion de ETL a las 2019-07-05 08:32:32.949743	2019-07-05 08:32:33.006977-06	1
2	Ejecucion de ETL a las 2019-07-05 08:37:12.144104	2019-07-05 08:37:12.148715-06	1
3	Ejecucion de ETL a las 2019-07-05 08:37:52.695031	2019-07-05 08:37:52.699678-06	1
4	Ejecucion de ETL a las 2019-07-05 08:39:57.526998	2019-07-05 08:39:57.535821-06	1
5	Ejecucion de ETL a las 2019-07-05 08:40:18.655006	2019-07-05 08:40:18.660257-06	1
6	Ejecucion de ETL a las 2019-07-05 08:40:26.892262	2019-07-05 08:40:26.897779-06	1
7	Ejecucion de ETL a las 2019-07-05 08:40:58.484270	2019-07-05 08:40:58.495909-06	1
8	Ejecucion de ETL a las 2019-07-05 08:42:16.133730	2019-07-05 08:42:16.14235-06	1
9	Ejecucion de ETL a las 2019-07-05 08:42:31.948484	2019-07-05 08:42:31.955197-06	1
10	Ejecucion incorrecta de ETL a las 2019-07-05 08:42:47.575540	2019-07-05 08:42:47.583338-06	1
11	Ejecucion incorrecta de ETL a las 2019-07-05 08:43:12.395456	2019-07-05 08:43:12.399773-06	1
12	Ejecucion incorrecta de ETL a las 2019-07-05 08:43:24.873823	2019-07-05 08:43:24.877583-06	1
13	Ejecucion incorrecta de ETL a las 2019-07-05 08:43:31.277873	2019-07-05 08:43:31.28193-06	1
14	Ejecucion incorrecta de ETL a las 2019-07-05 08:43:37.144583	2019-07-05 08:43:37.157794-06	1
15	Ejecucion incorrecta de ETL a las 2019-07-05 08:43:53.993290	2019-07-05 08:43:54.002825-06	1
16	Ejecucion incorrecta de ETL a las 2019-07-05 08:44:09.657079	2019-07-05 08:44:09.660974-06	1
17	Ejecucion incorrecta de ETL a las 2019-07-05 08:44:11.382067	2019-07-05 08:44:11.387666-06	1
18	Ejecucion incorrecta de ETL a las 2019-07-05 08:45:10.142383	2019-07-05 08:45:10.151164-06	1
19	Ejecucion incorrecta de ETL a las 2019-07-05 08:51:19.062820	2019-07-05 08:51:19.284769-06	1
20	Ejecucion incorrecta de ETL a las 2019-07-05 08:51:37.998807	2019-07-05 08:51:38.01895-06	1
21	Ejecucion incorrecta de ETL a las 2019-07-05 08:51:45.360701	2019-07-05 08:51:45.387022-06	1
22	Ejecucion incorrecta de ETL a las 2019-07-05 08:52:42.009057	2019-07-05 08:52:42.026322-06	1
23	Ejecucion incorrecta de ETL a las 2019-07-05 08:52:49.643065	2019-07-05 08:52:49.661881-06	1
24	Ejecucion incorrecta de ETL a las 2019-07-05 08:53:01.477856	2019-07-05 08:53:01.597709-06	1
25	Ejecucion incorrecta de ETL a las 2019-07-05 08:55:12.140689	2019-07-05 08:55:12.193295-06	1
26	Ejecucion incorrecta de ETL a las 2019-07-05 08:56:11.984317	2019-07-05 08:56:12.017858-06	1
27	Ejecucion incorrecta de ETL a las 2019-07-05 09:32:11.437906	2019-07-05 09:32:11.471943-06	1
28	Ejecucion correcta de ETL a las 2019-07-05 09:57:20.961548	2019-07-05 09:57:21.018704-06	1
29	Ejecucion correcta de ETL a las 2019-07-05 10:15:55.456527	2019-07-05 10:15:55.652651-06	1
30	Ejecucion correcta de ETL a las 2019-07-05 10:16:40.237823	2019-07-05 10:16:40.41092-06	1
31	Ejecucion incorrecta de ETL a las 2019-07-05 10:20:38.110612	2019-07-05 10:20:38.128803-06	1
32	Ejecucion incorrecta de ETL a las 2019-07-05 10:22:22.682346	2019-07-05 10:22:22.720512-06	1
33	Ejecucion incorrecta de ETL a las 2019-07-05 10:23:06.226320	2019-07-05 10:23:06.294259-06	1
34	Ejecucion incorrecta de ETL a las 2019-07-05 10:23:09.330853	2019-07-05 10:23:09.361943-06	1
35	Ejecucion incorrecta de ETL a las 2019-07-05 10:23:11.610691	2019-07-05 10:23:11.630221-06	1
36	Ejecucion incorrecta de ETL a las 2019-07-05 10:27:22.921263	2019-07-05 10:27:22.962858-06	1
37	Ejecucion incorrecta de ETL a las 2019-07-05 10:27:54.149573	2019-07-05 10:27:54.194305-06	1
38	Ejecucion correcta de ETL a las 2019-07-05 10:30:06.047034	2019-07-05 10:30:06.151604-06	1
39	Ejecucion correcta de ETL a las 2019-07-05 10:35:38.557391	2019-07-05 10:35:38.612414-06	1
40	Ejecucion incorrecta de ETL a las 2019-07-05 10:36:18.814476	2019-07-05 10:36:18.869164-06	1
41	Ejecucion incorrecta de ETL a las 2019-07-05 10:41:01.715925	2019-07-05 10:41:01.735421-06	1
42	Ejecucion incorrecta de ETL a las 2019-07-05 10:44:28.333942	2019-07-05 10:44:28.399028-06	1
43	Ejecucion correcta de ETL a las 2019-07-05 10:53:55.534443	2019-07-05 10:53:55.601043-06	1
44	Ejecucion correcta de ETL a las 2019-07-05 10:59:15.670688	2019-07-05 10:59:15.950858-06	1
45	Ejecucion correcta de ETL a las 2019-07-05 11:05:34.135285	2019-07-05 11:05:34.226615-06	1
46	Ejecucion incorrecta de ETL a las 2019-07-05 11:16:35.230040	2019-07-05 11:16:35.259959-06	1
47	Ejecucion correcta de ETL a las 2019-07-05 11:16:52.221506	2019-07-05 11:16:52.326259-06	1
48	Ejecucion incorrecta de ETL a las 2019-07-05 11:40:56.385560	2019-07-05 11:40:56.454206-06	1
49	Ejecucion correcta de ETL a las 2019-07-05 11:41:32.345407	2019-07-05 11:41:32.479977-06	1
50	Ejecucion correcta de ETL a las 2019-07-05 11:43:11.805957	2019-07-05 11:43:11.884547-06	1
51	Ejecucion incorrecta de ETL a las 2019-07-05 11:49:29.873229	2019-07-05 11:49:29.893132-06	1
52	Ejecucion incorrecta de ETL a las 2019-07-05 11:49:49.995625	2019-07-05 11:49:50.132045-06	1
53	Ejecucion correcta de ETL a las 2019-07-05 11:59:22.944462	2019-07-05 11:59:23.056374-06	1
54	Ejecucion incorrecta de ETL a las 2019-07-05 12:04:44.299074	2019-07-05 12:04:44.330699-06	1
55	Ejecucion correcta de ETL a las 2019-07-05 12:05:42.680983	2019-07-05 12:05:42.787742-06	1
56	Ejecucion incorrecta de ETL a las 2019-07-05 12:06:38.409709	2019-07-05 12:06:38.449591-06	1
57	Ejecucion correcta de ETL a las 2019-07-05 12:08:18.016429	2019-07-05 12:08:18.096815-06	1
58	Ejecucion correcta de ETL a las 2019-07-05 12:16:21.383573	2019-07-05 12:16:21.49751-06	1
59	Ejecucion correcta de ETL a las 2019-07-05 12:16:59.457661	2019-07-05 12:16:59.534438-06	1
60	Ejecucion correcta de ETL a las 2019-07-05 12:17:18.174263	2019-07-05 12:17:18.27998-06	1
61	Ejecucion correcta de ETL a las 2019-07-05 12:21:28.430530	2019-07-05 12:21:28.594462-06	1
62	Ejecucion correcta de ETL a las 2019-07-05 12:26:39.135878	2019-07-05 12:26:39.230287-06	1
63	Ejecucion correcta de ETL a las 2019-07-05 12:36:01.559294	2019-07-05 12:36:01.649285-06	1
64	Ejecucion correcta de ETL a las 2019-07-05 14:14:33.110579	2019-07-05 14:14:33.941276-06	1
65	Generacion de resumen de Expedientes Creados	2019-07-05 17:32:20.086257-06	1
66	Generacion de resumen de Expedientes Creados	2019-07-05 17:40:17.862045-06	1
67	Generacion de resumen de Expedientes Creados	2019-07-05 17:41:18.127915-06	1
68	Generacion de resumen de Expedientes Creados	2019-07-05 17:42:00.438733-06	1
69	Ejecucion correcta de ETL a las 2019-07-05 17:43:16.696393	2019-07-05 17:43:16.989701-06	1
70	Ejecucion correcta de ETL a las 2019-07-06 02:47:20.840504	2019-07-06 02:47:21.221433-06	1
71	Backup BD del 2019-07-06 02:47:38.121890	2019-07-06 02:47:38.121974-06	1
72	Ejecucion correcta de ETL a las 2019-07-06 06:12:05.060904	2019-07-06 06:12:05.238328-06	1
73	Generacion de resumen de Expedientes Creados	2019-07-06 06:24:23.91388-06	1
74	Generacion del Resumen Vencimiento de Medicamentos	2019-07-06 06:26:22.527486-06	1
75	Ejecucion incorrecta de ETL a las 2019-07-06 07:08:03.459766	2019-07-06 07:08:03.681153-06	1
76	Ejecucion incorrecta de ETL a las 2019-07-06 07:14:16.654918	2019-07-06 07:14:16.670702-06	1
77	Ejecucion incorrecta de ETL a las 2019-07-06 07:14:46.173977	2019-07-06 07:14:46.45116-06	1
78	Ejecucion incorrecta de ETL a las 2019-07-06 07:14:49.684705	2019-07-06 07:14:49.745865-06	1
79	Generacion de resumen de Expedientes Creados	2019-07-06 07:21:43.389105-06	1
80	Ejecucion correcta de ETL a las 2019-07-06 07:22:15.529646	2019-07-06 07:22:15.647095-06	1
81	Generacion de resumen de Expedientes Creados	2019-07-06 07:22:38.731251-06	1
82	Generacion de resumen de Expedientes Con Deudas	2019-07-06 07:23:22.660704-06	1
83	Generacion de resumen de Expedientes Creados	2019-07-06 07:23:31.927657-06	1
84	Ejecucion correcta de ETL a las 2019-07-06 07:23:52.274317	2019-07-06 07:23:52.386566-06	1
85	Generacion de Resumen de Ingresos Obtenidos por Consulta	2019-07-06 07:24:00.803282-06	1
86	Generacion de resumen de Expedientes Creados	2019-07-06 07:24:06.6573-06	1
87	Generacion de Reporte de Costo de Medicamentos	2019-07-06 07:24:33.197571-06	1
88	Ejecucion correcta de ETL a las 2019-07-06 07:25:03.163950	2019-07-06 07:25:03.392426-06	1
89	Generacion del Resumen de Tratamientos Recurrentes	2019-07-06 07:25:16.864467-06	1
90	Generacion de resumen de Expedientes Creados	2019-07-06 07:25:30.937813-06	1
91	Generacion de resumen de Expedientes Con Deudas	2019-07-06 07:25:56.781237-06	1
92	Generacion del Resumen de Medicamentos Mas usados en Recetas	2019-07-06 07:27:13.008336-06	1
93	Generacion de resumen de Expedientes Con Deudas	2019-07-06 07:30:44.487297-06	1
94	Generacion de resumen de Expedientes Con Deudas	2019-07-06 07:31:04.934347-06	1
95	Generacion de Reporte de Costo de Medicamentos	2019-07-06 07:31:38.671766-06	1
96	Generacion de resumen de Expedientes Creados	2019-07-06 07:33:04.784011-06	3
97	Generacion de Reporte de Costo de Medicamentos	2019-07-06 07:33:22.664697-06	1
98	Generacion de resumen de Expedientes Con Deudas	2019-07-06 07:33:45.000248-06	3
99	Generacion de Resumen de Ingresos Obtenidos por Consulta	2019-07-06 07:34:26.338801-06	3
100	Generacion del Resumen de Tratamientos Recurrentes	2019-07-06 07:34:56.802296-06	3
101	Generacion de Reporte de Costo de Medicamentos	2019-07-06 07:35:30.110652-06	1
102	Generacion de Reporte de Costo de Medicamentos	2019-07-06 07:35:48.806057-06	1
103	Generacion de Reporte de Costo de Medicamentos	2019-07-06 07:36:16.362242-06	1
104	Generacion de Reporte de Costo de Medicamentos	2019-07-06 07:37:12.001522-06	1
105	Generacion del resumen sobre uso de odontogramas	2019-07-06 07:38:09.587664-06	4
106	Generacion de Reporte de Costo de Medicamentos	2019-07-06 07:38:16.426128-06	1
107	Generacion de Reporte de Costo de Medicamentos	2019-07-06 07:38:35.537986-06	1
108	Generacion del Resumen Vencimiento de Medicamentos	2019-07-06 07:38:54.068622-06	4
109	Generacion del Resumen de Expedientes Nuevos y Recurrentes	2019-07-06 07:39:39.353707-06	4
110	Generacion de Resumen de Ingresos Obtenidos por Consulta	2019-07-06 07:40:09.083544-06	1
111	Generacion de Resumen de Ingresos Obtenidos por Consulta	2019-07-06 07:40:58.745341-06	1
112	Generacion del Resumen de Tratamientos Recurrentes	2019-07-06 07:41:27.33681-06	1
113	Generacion del Resumen de Tratamientos Recurrentes	2019-07-06 07:43:51.050496-06	1
114	Generacion del Resumen de Medicamentos Mas usados en Recetas	2019-07-06 07:45:12.889726-06	1
115	Generacion del Resumen de Tratamientos Recurrentes	2019-07-06 07:46:42.68858-06	1
116	Generacion del Resumen de Tratamientos Recurrentes	2019-07-06 07:47:17.592873-06	1
117	Ejecucion correcta de ETL a las 2019-07-06 07:49:41.513895	2019-07-06 07:49:41.670419-06	1
118	Backup BD del 2019-07-06 07:50:17.238160	2019-07-06 07:50:17.238463-06	1
119	Ejecucion correcta de ETL a las 2019-07-06 07:50:25.319220	2019-07-06 07:50:25.559257-06	1
\.


--
-- Data for Name: gerencial_cita; Type: TABLE DATA; Schema: public; Owner: clinica_user
--

COPY public.gerencial_cita (id, "asuntoCita", "fechaCita", "horaCita", "observacionCita", doctor_id, paciente_id) FROM stdin;
1	Control	2019-07-05	15:24:55		1	1
2	Control	2019-02-06	12:42:29		3	2
\.


--
-- Data for Name: gerencial_consulta; Type: TABLE DATA; Schema: public; Owner: clinica_user
--

COPY public.gerencial_consulta (id, "fechaConsulta", "horaInicio", "horaFinal", "observacionCons", doctor_id, paciente_id, precio) FROM stdin;
1	2019-07-05	15:25:19.0517	15:25:16		1	1	10.00
2	2019-04-06	12:43:36.800049	12:43:27		3	2	15.00
3	2019-05-06	13:03:02.760582	13:02:58		4	4	10.00
4	2019-02-14	13:03:12.29496	14:02:44		4	8	10.00
5	2019-06-16	13:03:25.775671	13:03:09		3	7	10.00
6	2019-04-26	13:03:47.68307	13:03:44		1	3	10.00
7	2019-06-21	13:04:08.160163	13:04:05		3	8	10.00
8	2019-04-07	13:04:35.63097	13:04:32		4	6	10.00
9	2019-05-15	13:07:30.869329	14:07:19		3	3	25.00
10	2019-01-17	13:08:26.942634	14:08:13		1	7	25.00
\.


--
-- Data for Name: gerencial_doctor; Type: TABLE DATA; Schema: public; Owner: clinica_user
--

COPY public.gerencial_doctor (id, nombre) FROM stdin;
1	Juan Perez
3	Amilcar Figueroa
4	Susana Argueta
\.


--
-- Data for Name: gerencial_especificacion; Type: TABLE DATA; Schema: public; Owner: clinica_user
--

COPY public.gerencial_especificacion (id, dosis, duracion, medicamento_id, receta_id) FROM stdin;
1	10 al dia	1 semana	1	1
2	10 ml	4 dias	1	1
3	10 ml	2 semanas	2	1
4	15 ml	1 semana	3	2
\.


--
-- Data for Name: gerencial_expediente; Type: TABLE DATA; Schema: public; Owner: clinica_user
--

COPY public.gerencial_expediente (id, "fechaCreacion", pagado, saldo, "observacionExp", odontograma_id, paciente_id) FROM stdin;
9	2019-06-06 07:02:21-06	10.00	1.00		8	6
6	2019-06-06 07:01:12-06	1.00	100.00		6	9
1	2019-07-05 09:23:58-06	220.00	50.00		1	1
4	2019-06-06 06:45:32-06	50.00	50.00		4	4
5	2019-04-06 06:46:50-06	60.00	10.00		5	2
2	2019-03-12 06:40:18-06	100.00	200.00		2	3
7	2019-03-06 07:01:31-06	10.00	50.00		7	10
8	2019-02-14 07:00:56-06	15.00	15.00		9	11
3	2019-07-06 06:42:36-06	50.00	15.00	El paciente es alergico a la aspirina	3	5
\.


--
-- Data for Name: gerencial_lotemedicamento; Type: TABLE DATA; Schema: public; Owner: clinica_user
--

COPY public.gerencial_lotemedicamento (id, fecha_vencimiento, cantidad, medicamento_id, fecha_entrada) FROM stdin;
1	2019-07-25	20	1	2019-07-25
2	2019-06-06	60	4	2019-06-06
3	2020-06-06	50	6	2020-06-06
4	2019-05-06	60	2	2019-05-06
5	2019-05-23	32	6	2019-05-23
6	2019-05-12	36	8	2019-05-12
\.


--
-- Data for Name: gerencial_medicamento; Type: TABLE DATA; Schema: public; Owner: clinica_user
--

COPY public.gerencial_medicamento (id, nombre_producto, marca_producto, existencia_producto, precio_producto, formafarmaceutica) FROM stdin;
1	Paracetamol	MK	10	10.00	Pastilla
5	Diclofenaco	Merk	50	10.00	pastillas
4	Metamizol	Phizer	100	5.00	pastillas
3	Morfina	Graten	15	15.00	Frasco
2	Ibuprofeno	MK	25	2.50	Tabletas
6	Naproxeno	Aleve	50	5.00	Pastillas
7	Ketoprofeno	Bayern	7	20.00	liquido
8	Meloxicam	Bayern	50	23.00	pastillas
\.


--
-- Data for Name: gerencial_odontograma; Type: TABLE DATA; Schema: public; Owner: clinica_user
--

COPY public.gerencial_odontograma (id, "fechaCreacion", notas, medico_id, "fechaUltimaModificacion") FROM stdin;
1	2019-07-05 09:24:25.406896-06	Paciente Saludable	1	2019-07-05 09:24:25.406922-06
2	2019-07-06 06:41:02.602484-06	Paciente Saludable	\N	2019-07-06 06:41:02.602519-06
3	2019-07-06 06:43:35.739058-06	El paciente presenta buena higiene dental	1	2019-07-06 06:43:35.739084-06
4	2019-07-06 06:44:56.256991-06	No se realizo ningun procedimiento que afectara el odontograma	1	2019-07-06 06:44:56.257018-06
5	2019-07-06 06:45:17.087528-06	Se le realizo una extraccion en la primera consulta	3	2019-07-06 06:45:17.087586-06
6	2019-07-06 06:59:40.682129-06	No hubo ninguna complicacion en los procedimientos	4	2019-07-06 06:59:40.682242-06
7	2019-07-06 07:00:14.211181-06	No se realizo ningun procedimiento en la primera consulta	4	2019-07-06 07:00:14.211238-06
8	2019-07-06 07:00:57.103939-06	Se realizo una limpieza	4	2019-07-06 07:00:57.104003-06
9	2019-07-06 07:02:03.631178-06	Se ha realizado un relleno de porcelana	4	2019-07-06 07:02:03.631232-06
\.


--
-- Data for Name: gerencial_paciente; Type: TABLE DATA; Schema: public; Owner: clinica_user
--

COPY public.gerencial_paciente (id, "nombresPaciente", "apellidosPaciente", sexo, "fechaNacimiento", referencia) FROM stdin;
1	Carlos Antonio	Cativo Argueta	M	2019-07-05	\N
2	Juan Carlos	Perez Aguilar	M	1995-07-02	\N
3	Juan Antonio	Perez Melaza	M	1998-07-02	\N
4	Luis Ernesto	Cruz Orellana	M	1992-05-06	\N
5	Christian Ariel	Zelaya Tejada	M	1994-01-01	\N
6	Sandra	Aguilar Diaz	F	1969-02-10	\N
7	Andrea	Cañas	F	1998-09-09	\N
8	Rene	Suarez	M	2017-07-06	\N
9	Ronaldo Cristiano	Castillo Villa	M	2003-01-13	Carlos Antonio Diaz
10	Juana Gladys	Rivas Martinez	F	2003-10-11	Maria Rivas Martinez
11	José Ricardo	Sosa Hernández	M	1994-11-18	\N
\.


--
-- Data for Name: gerencial_pago; Type: TABLE DATA; Schema: public; Owner: clinica_user
--

COPY public.gerencial_pago (id, "fechaPago", cantidad, "Expediente_id", procedimiento_id) FROM stdin;
1	2019-07-05 12:16:46.242266-06	10.00	1	1
\.


--
-- Data for Name: gerencial_procedimiento; Type: TABLE DATA; Schema: public; Owner: clinica_user
--

COPY public.gerencial_procedimiento (id, pieza, cara, diagnostico, notas, status, odontograma_id, tratamiento_id, consulta_realizada_id) FROM stdin;
1	1	C	dfdfdf		recomendado	1	1	1
2	6	X	Se le cayo el diente		recomendado	2	5	2
3	5	Z	dffffffffff		recomendado	7	7	5
4	7	D	rtyyyyyyyyyy		recomendado	9	6	7
5	7	S	Primer relleno realizado, segundo relleno pendiente		completado	9	3	4
\.


--
-- Data for Name: gerencial_receta; Type: TABLE DATA; Schema: public; Owner: clinica_user
--

COPY public.gerencial_receta (id, consulta_id, "nombreReceta") FROM stdin;
1	1	Receta 1
2	10	Receta 2
3	5	Receta 3
4	2	Receta 4
5	7	Receta 5
\.


--
-- Data for Name: gerencial_tratamiento; Type: TABLE DATA; Schema: public; Owner: clinica_user
--

COPY public.gerencial_tratamiento (id, "nombreTratamiento", "descripcionTratamiento", "precioBase") FROM stdin;
1	Endodoncia		10.00
2	Extracciòn		10.00
3	Relleno		5.00
4	Limpieza Dental		15.00
5	Implate		100.00
6	Protesis Dental		150.00
7	Blanqueamiento		50.00
\.


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: clinica_user
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 3, true);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: clinica_user
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: clinica_user
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 92, true);


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: clinica_user
--

SELECT pg_catalog.setval('public.auth_user_groups_id_seq', 6, true);


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: clinica_user
--

SELECT pg_catalog.setval('public.auth_user_id_seq', 4, true);


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: clinica_user
--

SELECT pg_catalog.setval('public.auth_user_user_permissions_id_seq', 1, false);


--
-- Name: axes_accessattempt_id_seq; Type: SEQUENCE SET; Schema: public; Owner: clinica_user
--

SELECT pg_catalog.setval('public.axes_accessattempt_id_seq', 13, true);


--
-- Name: axes_accesslog_id_seq; Type: SEQUENCE SET; Schema: public; Owner: clinica_user
--

SELECT pg_catalog.setval('public.axes_accesslog_id_seq', 45, true);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: clinica_user
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 9, true);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: clinica_user
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 23, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: clinica_user
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 34, true);


--
-- Name: frontend_module_id_seq; Type: SEQUENCE SET; Schema: public; Owner: clinica_user
--

SELECT pg_catalog.setval('public.frontend_module_id_seq', 1, false);


--
-- Name: gerencial_bitacora_id_seq; Type: SEQUENCE SET; Schema: public; Owner: clinica_user
--

SELECT pg_catalog.setval('public.gerencial_bitacora_id_seq', 119, true);


--
-- Name: gerencial_cita_id_seq; Type: SEQUENCE SET; Schema: public; Owner: clinica_user
--

SELECT pg_catalog.setval('public.gerencial_cita_id_seq', 1, false);


--
-- Name: gerencial_consulta_id_seq; Type: SEQUENCE SET; Schema: public; Owner: clinica_user
--

SELECT pg_catalog.setval('public.gerencial_consulta_id_seq', 1, false);


--
-- Name: gerencial_doctor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: clinica_user
--

SELECT pg_catalog.setval('public.gerencial_doctor_id_seq', 1, false);


--
-- Name: gerencial_especificacion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: clinica_user
--

SELECT pg_catalog.setval('public.gerencial_especificacion_id_seq', 1, false);


--
-- Name: gerencial_expediente_id_seq; Type: SEQUENCE SET; Schema: public; Owner: clinica_user
--

SELECT pg_catalog.setval('public.gerencial_expediente_id_seq', 1, false);


--
-- Name: gerencial_lotemedicamento_id_seq; Type: SEQUENCE SET; Schema: public; Owner: clinica_user
--

SELECT pg_catalog.setval('public.gerencial_lotemedicamento_id_seq', 1, false);


--
-- Name: gerencial_medicamento_id_seq; Type: SEQUENCE SET; Schema: public; Owner: clinica_user
--

SELECT pg_catalog.setval('public.gerencial_medicamento_id_seq', 1, false);


--
-- Name: gerencial_odontograma_id_seq; Type: SEQUENCE SET; Schema: public; Owner: clinica_user
--

SELECT pg_catalog.setval('public.gerencial_odontograma_id_seq', 1, false);


--
-- Name: gerencial_paciente_id_seq; Type: SEQUENCE SET; Schema: public; Owner: clinica_user
--

SELECT pg_catalog.setval('public.gerencial_paciente_id_seq', 1, false);


--
-- Name: gerencial_pago_id_seq; Type: SEQUENCE SET; Schema: public; Owner: clinica_user
--

SELECT pg_catalog.setval('public.gerencial_pago_id_seq', 1, false);


--
-- Name: gerencial_procedimiento_id_seq; Type: SEQUENCE SET; Schema: public; Owner: clinica_user
--

SELECT pg_catalog.setval('public.gerencial_procedimiento_id_seq', 1, false);


--
-- Name: gerencial_receta_id_seq; Type: SEQUENCE SET; Schema: public; Owner: clinica_user
--

SELECT pg_catalog.setval('public.gerencial_receta_id_seq', 1, false);


--
-- Name: gerencial_tratamiento_id_seq; Type: SEQUENCE SET; Schema: public; Owner: clinica_user
--

SELECT pg_catalog.setval('public.gerencial_tratamiento_id_seq', 1, false);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: clinica_user
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: clinica_user
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: clinica_user
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: clinica_user
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: clinica_user
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: clinica_user
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: clinica_user
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_user_id_group_id_94350c0c_uniq; Type: CONSTRAINT; Schema: public; Owner: clinica_user
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq UNIQUE (user_id, group_id);


--
-- Name: auth_user auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: clinica_user
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: clinica_user
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_permission_id_14a6b632_uniq; Type: CONSTRAINT; Schema: public; Owner: clinica_user
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq UNIQUE (user_id, permission_id);


--
-- Name: auth_user auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: clinica_user
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: axes_accessattempt axes_accessattempt_pkey; Type: CONSTRAINT; Schema: public; Owner: clinica_user
--

ALTER TABLE ONLY public.axes_accessattempt
    ADD CONSTRAINT axes_accessattempt_pkey PRIMARY KEY (id);


--
-- Name: axes_accesslog axes_accesslog_pkey; Type: CONSTRAINT; Schema: public; Owner: clinica_user
--

ALTER TABLE ONLY public.axes_accesslog
    ADD CONSTRAINT axes_accesslog_pkey PRIMARY KEY (id);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: clinica_user
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: clinica_user
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: clinica_user
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: clinica_user
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: clinica_user
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: frontend_module frontend_module_pkey; Type: CONSTRAINT; Schema: public; Owner: clinica_user
--

ALTER TABLE ONLY public.frontend_module
    ADD CONSTRAINT frontend_module_pkey PRIMARY KEY (id);


--
-- Name: gerencial_bitacora gerencial_bitacora_pkey; Type: CONSTRAINT; Schema: public; Owner: clinica_user
--

ALTER TABLE ONLY public.gerencial_bitacora
    ADD CONSTRAINT gerencial_bitacora_pkey PRIMARY KEY (id);


--
-- Name: gerencial_cita gerencial_cita_pkey; Type: CONSTRAINT; Schema: public; Owner: clinica_user
--

ALTER TABLE ONLY public.gerencial_cita
    ADD CONSTRAINT gerencial_cita_pkey PRIMARY KEY (id);


--
-- Name: gerencial_consulta gerencial_consulta_pkey; Type: CONSTRAINT; Schema: public; Owner: clinica_user
--

ALTER TABLE ONLY public.gerencial_consulta
    ADD CONSTRAINT gerencial_consulta_pkey PRIMARY KEY (id);


--
-- Name: gerencial_doctor gerencial_doctor_pkey; Type: CONSTRAINT; Schema: public; Owner: clinica_user
--

ALTER TABLE ONLY public.gerencial_doctor
    ADD CONSTRAINT gerencial_doctor_pkey PRIMARY KEY (id);


--
-- Name: gerencial_especificacion gerencial_especificacion_pkey; Type: CONSTRAINT; Schema: public; Owner: clinica_user
--

ALTER TABLE ONLY public.gerencial_especificacion
    ADD CONSTRAINT gerencial_especificacion_pkey PRIMARY KEY (id);


--
-- Name: gerencial_expediente gerencial_expediente_odontograma_id_key; Type: CONSTRAINT; Schema: public; Owner: clinica_user
--

ALTER TABLE ONLY public.gerencial_expediente
    ADD CONSTRAINT gerencial_expediente_odontograma_id_key UNIQUE (odontograma_id);


--
-- Name: gerencial_expediente gerencial_expediente_paciente_id_key; Type: CONSTRAINT; Schema: public; Owner: clinica_user
--

ALTER TABLE ONLY public.gerencial_expediente
    ADD CONSTRAINT gerencial_expediente_paciente_id_key UNIQUE (paciente_id);


--
-- Name: gerencial_expediente gerencial_expediente_pkey; Type: CONSTRAINT; Schema: public; Owner: clinica_user
--

ALTER TABLE ONLY public.gerencial_expediente
    ADD CONSTRAINT gerencial_expediente_pkey PRIMARY KEY (id);


--
-- Name: gerencial_lotemedicamento gerencial_lotemedicamento_pkey; Type: CONSTRAINT; Schema: public; Owner: clinica_user
--

ALTER TABLE ONLY public.gerencial_lotemedicamento
    ADD CONSTRAINT gerencial_lotemedicamento_pkey PRIMARY KEY (id);


--
-- Name: gerencial_medicamento gerencial_medicamento_pkey; Type: CONSTRAINT; Schema: public; Owner: clinica_user
--

ALTER TABLE ONLY public.gerencial_medicamento
    ADD CONSTRAINT gerencial_medicamento_pkey PRIMARY KEY (id);


--
-- Name: gerencial_odontograma gerencial_odontograma_pkey; Type: CONSTRAINT; Schema: public; Owner: clinica_user
--

ALTER TABLE ONLY public.gerencial_odontograma
    ADD CONSTRAINT gerencial_odontograma_pkey PRIMARY KEY (id);


--
-- Name: gerencial_paciente gerencial_paciente_nombresPaciente_apellido_a9f6b063_uniq; Type: CONSTRAINT; Schema: public; Owner: clinica_user
--

ALTER TABLE ONLY public.gerencial_paciente
    ADD CONSTRAINT "gerencial_paciente_nombresPaciente_apellido_a9f6b063_uniq" UNIQUE ("nombresPaciente", "apellidosPaciente");


--
-- Name: gerencial_paciente gerencial_paciente_pkey; Type: CONSTRAINT; Schema: public; Owner: clinica_user
--

ALTER TABLE ONLY public.gerencial_paciente
    ADD CONSTRAINT gerencial_paciente_pkey PRIMARY KEY (id);


--
-- Name: gerencial_pago gerencial_pago_pkey; Type: CONSTRAINT; Schema: public; Owner: clinica_user
--

ALTER TABLE ONLY public.gerencial_pago
    ADD CONSTRAINT gerencial_pago_pkey PRIMARY KEY (id);


--
-- Name: gerencial_procedimiento gerencial_procedimiento_pkey; Type: CONSTRAINT; Schema: public; Owner: clinica_user
--

ALTER TABLE ONLY public.gerencial_procedimiento
    ADD CONSTRAINT gerencial_procedimiento_pkey PRIMARY KEY (id);


--
-- Name: gerencial_receta gerencial_receta_pkey; Type: CONSTRAINT; Schema: public; Owner: clinica_user
--

ALTER TABLE ONLY public.gerencial_receta
    ADD CONSTRAINT gerencial_receta_pkey PRIMARY KEY (id);


--
-- Name: gerencial_tratamiento gerencial_tratamiento_pkey; Type: CONSTRAINT; Schema: public; Owner: clinica_user
--

ALTER TABLE ONLY public.gerencial_tratamiento
    ADD CONSTRAINT gerencial_tratamiento_pkey PRIMARY KEY (id);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: clinica_user
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: clinica_user
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: clinica_user
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: clinica_user
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: auth_user_groups_group_id_97559544; Type: INDEX; Schema: public; Owner: clinica_user
--

CREATE INDEX auth_user_groups_group_id_97559544 ON public.auth_user_groups USING btree (group_id);


--
-- Name: auth_user_groups_user_id_6a12ed8b; Type: INDEX; Schema: public; Owner: clinica_user
--

CREATE INDEX auth_user_groups_user_id_6a12ed8b ON public.auth_user_groups USING btree (user_id);


--
-- Name: auth_user_user_permissions_permission_id_1fbb5f2c; Type: INDEX; Schema: public; Owner: clinica_user
--

CREATE INDEX auth_user_user_permissions_permission_id_1fbb5f2c ON public.auth_user_user_permissions USING btree (permission_id);


--
-- Name: auth_user_user_permissions_user_id_a95ead1b; Type: INDEX; Schema: public; Owner: clinica_user
--

CREATE INDEX auth_user_user_permissions_user_id_a95ead1b ON public.auth_user_user_permissions USING btree (user_id);


--
-- Name: auth_user_username_6821ab7c_like; Type: INDEX; Schema: public; Owner: clinica_user
--

CREATE INDEX auth_user_username_6821ab7c_like ON public.auth_user USING btree (username varchar_pattern_ops);


--
-- Name: axes_accessattempt_ip_address_10922d9c; Type: INDEX; Schema: public; Owner: clinica_user
--

CREATE INDEX axes_accessattempt_ip_address_10922d9c ON public.axes_accessattempt USING btree (ip_address);


--
-- Name: axes_accessattempt_user_agent_ad89678b; Type: INDEX; Schema: public; Owner: clinica_user
--

CREATE INDEX axes_accessattempt_user_agent_ad89678b ON public.axes_accessattempt USING btree (user_agent);


--
-- Name: axes_accessattempt_user_agent_ad89678b_like; Type: INDEX; Schema: public; Owner: clinica_user
--

CREATE INDEX axes_accessattempt_user_agent_ad89678b_like ON public.axes_accessattempt USING btree (user_agent varchar_pattern_ops);


--
-- Name: axes_accessattempt_username_3f2d4ca0; Type: INDEX; Schema: public; Owner: clinica_user
--

CREATE INDEX axes_accessattempt_username_3f2d4ca0 ON public.axes_accessattempt USING btree (username);


--
-- Name: axes_accessattempt_username_3f2d4ca0_like; Type: INDEX; Schema: public; Owner: clinica_user
--

CREATE INDEX axes_accessattempt_username_3f2d4ca0_like ON public.axes_accessattempt USING btree (username varchar_pattern_ops);


--
-- Name: axes_accesslog_ip_address_86b417e5; Type: INDEX; Schema: public; Owner: clinica_user
--

CREATE INDEX axes_accesslog_ip_address_86b417e5 ON public.axes_accesslog USING btree (ip_address);


--
-- Name: axes_accesslog_user_agent_0e659004; Type: INDEX; Schema: public; Owner: clinica_user
--

CREATE INDEX axes_accesslog_user_agent_0e659004 ON public.axes_accesslog USING btree (user_agent);


--
-- Name: axes_accesslog_user_agent_0e659004_like; Type: INDEX; Schema: public; Owner: clinica_user
--

CREATE INDEX axes_accesslog_user_agent_0e659004_like ON public.axes_accesslog USING btree (user_agent varchar_pattern_ops);


--
-- Name: axes_accesslog_username_df93064b; Type: INDEX; Schema: public; Owner: clinica_user
--

CREATE INDEX axes_accesslog_username_df93064b ON public.axes_accesslog USING btree (username);


--
-- Name: axes_accesslog_username_df93064b_like; Type: INDEX; Schema: public; Owner: clinica_user
--

CREATE INDEX axes_accesslog_username_df93064b_like ON public.axes_accesslog USING btree (username varchar_pattern_ops);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: clinica_user
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: clinica_user
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: clinica_user
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: clinica_user
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: frontend_module_label_58c52d82; Type: INDEX; Schema: public; Owner: clinica_user
--

CREATE INDEX frontend_module_label_58c52d82 ON public.frontend_module USING btree (label);


--
-- Name: frontend_module_label_58c52d82_like; Type: INDEX; Schema: public; Owner: clinica_user
--

CREATE INDEX frontend_module_label_58c52d82_like ON public.frontend_module USING btree (label varchar_pattern_ops);


--
-- Name: gerencial_bitacora_usuario_id_560a5368; Type: INDEX; Schema: public; Owner: clinica_user
--

CREATE INDEX gerencial_bitacora_usuario_id_560a5368 ON public.gerencial_bitacora USING btree (usuario_id);


--
-- Name: gerencial_cita_doctor_id_e94c6c22; Type: INDEX; Schema: public; Owner: clinica_user
--

CREATE INDEX gerencial_cita_doctor_id_e94c6c22 ON public.gerencial_cita USING btree (doctor_id);


--
-- Name: gerencial_cita_paciente_id_49e94ed3; Type: INDEX; Schema: public; Owner: clinica_user
--

CREATE INDEX gerencial_cita_paciente_id_49e94ed3 ON public.gerencial_cita USING btree (paciente_id);


--
-- Name: gerencial_consulta_doctor_id_719c1970; Type: INDEX; Schema: public; Owner: clinica_user
--

CREATE INDEX gerencial_consulta_doctor_id_719c1970 ON public.gerencial_consulta USING btree (doctor_id);


--
-- Name: gerencial_consulta_paciente_id_d5d45739; Type: INDEX; Schema: public; Owner: clinica_user
--

CREATE INDEX gerencial_consulta_paciente_id_d5d45739 ON public.gerencial_consulta USING btree (paciente_id);


--
-- Name: gerencial_especificacion_medicamento_id_e1ab2289; Type: INDEX; Schema: public; Owner: clinica_user
--

CREATE INDEX gerencial_especificacion_medicamento_id_e1ab2289 ON public.gerencial_especificacion USING btree (medicamento_id);


--
-- Name: gerencial_especificacion_receta_id_40b95f53; Type: INDEX; Schema: public; Owner: clinica_user
--

CREATE INDEX gerencial_especificacion_receta_id_40b95f53 ON public.gerencial_especificacion USING btree (receta_id);


--
-- Name: gerencial_lotemedicamento_medicamento_id_ac56d9cd; Type: INDEX; Schema: public; Owner: clinica_user
--

CREATE INDEX gerencial_lotemedicamento_medicamento_id_ac56d9cd ON public.gerencial_lotemedicamento USING btree (medicamento_id);


--
-- Name: gerencial_odontograma_medico_id_f3aced1e; Type: INDEX; Schema: public; Owner: clinica_user
--

CREATE INDEX gerencial_odontograma_medico_id_f3aced1e ON public.gerencial_odontograma USING btree (medico_id);


--
-- Name: gerencial_pago_Expediente_id_827a3fdc; Type: INDEX; Schema: public; Owner: clinica_user
--

CREATE INDEX "gerencial_pago_Expediente_id_827a3fdc" ON public.gerencial_pago USING btree ("Expediente_id");


--
-- Name: gerencial_pago_procedimiento_id_0ddd5226; Type: INDEX; Schema: public; Owner: clinica_user
--

CREATE INDEX gerencial_pago_procedimiento_id_0ddd5226 ON public.gerencial_pago USING btree (procedimiento_id);


--
-- Name: gerencial_procedimiento_consulta_realizada_id_30ddf17a; Type: INDEX; Schema: public; Owner: clinica_user
--

CREATE INDEX gerencial_procedimiento_consulta_realizada_id_30ddf17a ON public.gerencial_procedimiento USING btree (consulta_realizada_id);


--
-- Name: gerencial_procedimiento_odontograma_id_f3631b05; Type: INDEX; Schema: public; Owner: clinica_user
--

CREATE INDEX gerencial_procedimiento_odontograma_id_f3631b05 ON public.gerencial_procedimiento USING btree (odontograma_id);


--
-- Name: gerencial_procedimiento_tratamiento_id_bcd29fb1; Type: INDEX; Schema: public; Owner: clinica_user
--

CREATE INDEX gerencial_procedimiento_tratamiento_id_bcd29fb1 ON public.gerencial_procedimiento USING btree (tratamiento_id);


--
-- Name: gerencial_receta_consulta_id_13399f92; Type: INDEX; Schema: public; Owner: clinica_user
--

CREATE INDEX gerencial_receta_consulta_id_13399f92 ON public.gerencial_receta USING btree (consulta_id);


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: clinica_user
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: clinica_user
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: clinica_user
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_group_id_97559544_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: clinica_user
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_user_id_6a12ed8b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: clinica_user
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: clinica_user
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: clinica_user
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: clinica_user
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: clinica_user
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gerencial_bitacora gerencial_bitacora_usuario_id_560a5368_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: clinica_user
--

ALTER TABLE ONLY public.gerencial_bitacora
    ADD CONSTRAINT gerencial_bitacora_usuario_id_560a5368_fk_auth_user_id FOREIGN KEY (usuario_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gerencial_cita gerencial_cita_doctor_id_e94c6c22_fk_gerencial_doctor_id; Type: FK CONSTRAINT; Schema: public; Owner: clinica_user
--

ALTER TABLE ONLY public.gerencial_cita
    ADD CONSTRAINT gerencial_cita_doctor_id_e94c6c22_fk_gerencial_doctor_id FOREIGN KEY (doctor_id) REFERENCES public.gerencial_doctor(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gerencial_cita gerencial_cita_paciente_id_49e94ed3_fk_gerencial_expediente_id; Type: FK CONSTRAINT; Schema: public; Owner: clinica_user
--

ALTER TABLE ONLY public.gerencial_cita
    ADD CONSTRAINT gerencial_cita_paciente_id_49e94ed3_fk_gerencial_expediente_id FOREIGN KEY (paciente_id) REFERENCES public.gerencial_expediente(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gerencial_consulta gerencial_consulta_doctor_id_719c1970_fk_gerencial_doctor_id; Type: FK CONSTRAINT; Schema: public; Owner: clinica_user
--

ALTER TABLE ONLY public.gerencial_consulta
    ADD CONSTRAINT gerencial_consulta_doctor_id_719c1970_fk_gerencial_doctor_id FOREIGN KEY (doctor_id) REFERENCES public.gerencial_doctor(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gerencial_consulta gerencial_consulta_paciente_id_d5d45739_fk_gerencial; Type: FK CONSTRAINT; Schema: public; Owner: clinica_user
--

ALTER TABLE ONLY public.gerencial_consulta
    ADD CONSTRAINT gerencial_consulta_paciente_id_d5d45739_fk_gerencial FOREIGN KEY (paciente_id) REFERENCES public.gerencial_expediente(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gerencial_especificacion gerencial_especifica_medicamento_id_e1ab2289_fk_gerencial; Type: FK CONSTRAINT; Schema: public; Owner: clinica_user
--

ALTER TABLE ONLY public.gerencial_especificacion
    ADD CONSTRAINT gerencial_especifica_medicamento_id_e1ab2289_fk_gerencial FOREIGN KEY (medicamento_id) REFERENCES public.gerencial_medicamento(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gerencial_especificacion gerencial_especifica_receta_id_40b95f53_fk_gerencial; Type: FK CONSTRAINT; Schema: public; Owner: clinica_user
--

ALTER TABLE ONLY public.gerencial_especificacion
    ADD CONSTRAINT gerencial_especifica_receta_id_40b95f53_fk_gerencial FOREIGN KEY (receta_id) REFERENCES public.gerencial_receta(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gerencial_expediente gerencial_expediente_odontograma_id_bdc35f42_fk_gerencial; Type: FK CONSTRAINT; Schema: public; Owner: clinica_user
--

ALTER TABLE ONLY public.gerencial_expediente
    ADD CONSTRAINT gerencial_expediente_odontograma_id_bdc35f42_fk_gerencial FOREIGN KEY (odontograma_id) REFERENCES public.gerencial_odontograma(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gerencial_expediente gerencial_expediente_paciente_id_3cf6970b_fk_gerencial; Type: FK CONSTRAINT; Schema: public; Owner: clinica_user
--

ALTER TABLE ONLY public.gerencial_expediente
    ADD CONSTRAINT gerencial_expediente_paciente_id_3cf6970b_fk_gerencial FOREIGN KEY (paciente_id) REFERENCES public.gerencial_paciente(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gerencial_lotemedicamento gerencial_lotemedica_medicamento_id_ac56d9cd_fk_gerencial; Type: FK CONSTRAINT; Schema: public; Owner: clinica_user
--

ALTER TABLE ONLY public.gerencial_lotemedicamento
    ADD CONSTRAINT gerencial_lotemedica_medicamento_id_ac56d9cd_fk_gerencial FOREIGN KEY (medicamento_id) REFERENCES public.gerencial_medicamento(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gerencial_odontograma gerencial_odontograma_medico_id_f3aced1e_fk_gerencial_doctor_id; Type: FK CONSTRAINT; Schema: public; Owner: clinica_user
--

ALTER TABLE ONLY public.gerencial_odontograma
    ADD CONSTRAINT gerencial_odontograma_medico_id_f3aced1e_fk_gerencial_doctor_id FOREIGN KEY (medico_id) REFERENCES public.gerencial_doctor(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gerencial_pago gerencial_pago_Expediente_id_827a3fdc_fk_gerencial; Type: FK CONSTRAINT; Schema: public; Owner: clinica_user
--

ALTER TABLE ONLY public.gerencial_pago
    ADD CONSTRAINT "gerencial_pago_Expediente_id_827a3fdc_fk_gerencial" FOREIGN KEY ("Expediente_id") REFERENCES public.gerencial_expediente(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gerencial_pago gerencial_pago_procedimiento_id_0ddd5226_fk_gerencial; Type: FK CONSTRAINT; Schema: public; Owner: clinica_user
--

ALTER TABLE ONLY public.gerencial_pago
    ADD CONSTRAINT gerencial_pago_procedimiento_id_0ddd5226_fk_gerencial FOREIGN KEY (procedimiento_id) REFERENCES public.gerencial_procedimiento(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gerencial_procedimiento gerencial_procedimie_consulta_realizada_i_30ddf17a_fk_gerencial; Type: FK CONSTRAINT; Schema: public; Owner: clinica_user
--

ALTER TABLE ONLY public.gerencial_procedimiento
    ADD CONSTRAINT gerencial_procedimie_consulta_realizada_i_30ddf17a_fk_gerencial FOREIGN KEY (consulta_realizada_id) REFERENCES public.gerencial_consulta(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gerencial_procedimiento gerencial_procedimie_odontograma_id_f3631b05_fk_gerencial; Type: FK CONSTRAINT; Schema: public; Owner: clinica_user
--

ALTER TABLE ONLY public.gerencial_procedimiento
    ADD CONSTRAINT gerencial_procedimie_odontograma_id_f3631b05_fk_gerencial FOREIGN KEY (odontograma_id) REFERENCES public.gerencial_odontograma(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gerencial_procedimiento gerencial_procedimie_tratamiento_id_bcd29fb1_fk_gerencial; Type: FK CONSTRAINT; Schema: public; Owner: clinica_user
--

ALTER TABLE ONLY public.gerencial_procedimiento
    ADD CONSTRAINT gerencial_procedimie_tratamiento_id_bcd29fb1_fk_gerencial FOREIGN KEY (tratamiento_id) REFERENCES public.gerencial_tratamiento(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gerencial_receta gerencial_receta_consulta_id_13399f92_fk_gerencial_consulta_id; Type: FK CONSTRAINT; Schema: public; Owner: clinica_user
--

ALTER TABLE ONLY public.gerencial_receta
    ADD CONSTRAINT gerencial_receta_consulta_id_13399f92_fk_gerencial_consulta_id FOREIGN KEY (consulta_id) REFERENCES public.gerencial_consulta(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

