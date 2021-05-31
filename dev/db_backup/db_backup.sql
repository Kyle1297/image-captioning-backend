--
-- PostgreSQL database dump
--

-- Dumped from database version 12.5
-- Dumped by pg_dump version 13.2

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

--
-- Name: captionai; Type: DATABASE; Schema: -; Owner: captionai
--

CREATE DATABASE captionai WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_US.UTF-8';


ALTER DATABASE captionai OWNER TO captionai;

\connect captionai

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

SET default_table_access_method = heap;

--
-- Name: accounts_profile; Type: TABLE; Schema: public; Owner: captionai
--

CREATE TABLE public.accounts_profile (
    id integer NOT NULL,
    bio text NOT NULL,
    location character varying(240) NOT NULL,
    image_id uuid,
    user_id integer NOT NULL
);


ALTER TABLE public.accounts_profile OWNER TO captionai;

--
-- Name: accounts_profile_following; Type: TABLE; Schema: public; Owner: captionai
--

CREATE TABLE public.accounts_profile_following (
    id integer NOT NULL,
    profile_id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.accounts_profile_following OWNER TO captionai;

--
-- Name: accounts_profile_following_id_seq; Type: SEQUENCE; Schema: public; Owner: captionai
--

CREATE SEQUENCE public.accounts_profile_following_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accounts_profile_following_id_seq OWNER TO captionai;

--
-- Name: accounts_profile_following_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: captionai
--

ALTER SEQUENCE public.accounts_profile_following_id_seq OWNED BY public.accounts_profile_following.id;


--
-- Name: accounts_profile_id_seq; Type: SEQUENCE; Schema: public; Owner: captionai
--

CREATE SEQUENCE public.accounts_profile_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accounts_profile_id_seq OWNER TO captionai;

--
-- Name: accounts_profile_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: captionai
--

ALTER SEQUENCE public.accounts_profile_id_seq OWNED BY public.accounts_profile.id;


--
-- Name: accounts_profile_interests; Type: TABLE; Schema: public; Owner: captionai
--

CREATE TABLE public.accounts_profile_interests (
    id integer NOT NULL,
    profile_id integer NOT NULL,
    collection_id integer NOT NULL
);


ALTER TABLE public.accounts_profile_interests OWNER TO captionai;

--
-- Name: accounts_profile_interests_id_seq; Type: SEQUENCE; Schema: public; Owner: captionai
--

CREATE SEQUENCE public.accounts_profile_interests_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accounts_profile_interests_id_seq OWNER TO captionai;

--
-- Name: accounts_profile_interests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: captionai
--

ALTER SEQUENCE public.accounts_profile_interests_id_seq OWNED BY public.accounts_profile_interests.id;


--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: captionai
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO captionai;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: captionai
--

CREATE SEQUENCE public.auth_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO captionai;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: captionai
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: captionai
--

CREATE TABLE public.auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO captionai;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: captionai
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO captionai;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: captionai
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: captionai
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO captionai;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: captionai
--

CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO captionai;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: captionai
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: captionai
--

CREATE TABLE public.auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(150) NOT NULL,
    last_name character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE public.auth_user OWNER TO captionai;

--
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: captionai
--

CREATE TABLE public.auth_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.auth_user_groups OWNER TO captionai;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: captionai
--

CREATE SEQUENCE public.auth_user_groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_groups_id_seq OWNER TO captionai;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: captionai
--

ALTER SEQUENCE public.auth_user_groups_id_seq OWNED BY public.auth_user_groups.id;


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: captionai
--

CREATE SEQUENCE public.auth_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_id_seq OWNER TO captionai;

--
-- Name: auth_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: captionai
--

ALTER SEQUENCE public.auth_user_id_seq OWNED BY public.auth_user.id;


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: captionai
--

CREATE TABLE public.auth_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_user_user_permissions OWNER TO captionai;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: captionai
--

CREATE SEQUENCE public.auth_user_user_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_user_permissions_id_seq OWNER TO captionai;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: captionai
--

ALTER SEQUENCE public.auth_user_user_permissions_id_seq OWNED BY public.auth_user_user_permissions.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: captionai
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


ALTER TABLE public.django_admin_log OWNER TO captionai;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: captionai
--

CREATE SEQUENCE public.django_admin_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO captionai;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: captionai
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: captionai
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO captionai;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: captionai
--

CREATE SEQUENCE public.django_content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO captionai;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: captionai
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: captionai
--

CREATE TABLE public.django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO captionai;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: captionai
--

CREATE SEQUENCE public.django_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO captionai;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: captionai
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: captionai
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO captionai;

--
-- Name: images_caption; Type: TABLE; Schema: public; Owner: captionai
--

CREATE TABLE public.images_caption (
    id integer NOT NULL,
    text character varying(500) NOT NULL,
    satisfactory boolean,
    corrected_text character varying(240) NOT NULL,
    last_updated timestamp with time zone,
    image_id uuid NOT NULL
);


ALTER TABLE public.images_caption OWNER TO captionai;

--
-- Name: images_caption_id_seq; Type: SEQUENCE; Schema: public; Owner: captionai
--

CREATE SEQUENCE public.images_caption_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.images_caption_id_seq OWNER TO captionai;

--
-- Name: images_caption_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: captionai
--

ALTER SEQUENCE public.images_caption_id_seq OWNED BY public.images_caption.id;


--
-- Name: images_collection; Type: TABLE; Schema: public; Owner: captionai
--

CREATE TABLE public.images_collection (
    id integer NOT NULL,
    category character varying(100) NOT NULL,
    is_main boolean NOT NULL,
    creator_id integer
);


ALTER TABLE public.images_collection OWNER TO captionai;

--
-- Name: images_collection_id_seq; Type: SEQUENCE; Schema: public; Owner: captionai
--

CREATE SEQUENCE public.images_collection_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.images_collection_id_seq OWNER TO captionai;

--
-- Name: images_collection_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: captionai
--

ALTER SEQUENCE public.images_collection_id_seq OWNED BY public.images_collection.id;


--
-- Name: images_comment; Type: TABLE; Schema: public; Owner: captionai
--

CREATE TABLE public.images_comment (
    id integer NOT NULL,
    comment text NOT NULL,
    commented_at timestamp with time zone NOT NULL,
    last_edited timestamp with time zone,
    commenter_id integer NOT NULL,
    image_id uuid NOT NULL
);


ALTER TABLE public.images_comment OWNER TO captionai;

--
-- Name: images_comment_dislikes; Type: TABLE; Schema: public; Owner: captionai
--

CREATE TABLE public.images_comment_dislikes (
    id integer NOT NULL,
    comment_id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.images_comment_dislikes OWNER TO captionai;

--
-- Name: images_comment_dislikes_id_seq; Type: SEQUENCE; Schema: public; Owner: captionai
--

CREATE SEQUENCE public.images_comment_dislikes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.images_comment_dislikes_id_seq OWNER TO captionai;

--
-- Name: images_comment_dislikes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: captionai
--

ALTER SEQUENCE public.images_comment_dislikes_id_seq OWNED BY public.images_comment_dislikes.id;


--
-- Name: images_comment_id_seq; Type: SEQUENCE; Schema: public; Owner: captionai
--

CREATE SEQUENCE public.images_comment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.images_comment_id_seq OWNER TO captionai;

--
-- Name: images_comment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: captionai
--

ALTER SEQUENCE public.images_comment_id_seq OWNED BY public.images_comment.id;


--
-- Name: images_comment_likes; Type: TABLE; Schema: public; Owner: captionai
--

CREATE TABLE public.images_comment_likes (
    id integer NOT NULL,
    comment_id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.images_comment_likes OWNER TO captionai;

--
-- Name: images_comment_likes_id_seq; Type: SEQUENCE; Schema: public; Owner: captionai
--

CREATE SEQUENCE public.images_comment_likes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.images_comment_likes_id_seq OWNER TO captionai;

--
-- Name: images_comment_likes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: captionai
--

ALTER SEQUENCE public.images_comment_likes_id_seq OWNED BY public.images_comment_likes.id;


--
-- Name: images_image; Type: TABLE; Schema: public; Owner: captionai
--

CREATE TABLE public.images_image (
    uuid uuid NOT NULL,
    s3_key character varying(240) NOT NULL,
    type character varying(100) NOT NULL,
    width integer NOT NULL,
    height integer NOT NULL,
    title character varying(240) NOT NULL,
    uploaded_at timestamp with time zone NOT NULL,
    is_profile_image boolean NOT NULL,
    is_private boolean NOT NULL,
    views integer NOT NULL,
    downloads integer NOT NULL,
    uploader_id integer,
    CONSTRAINT images_image_downloads_check CHECK ((downloads >= 0)),
    CONSTRAINT images_image_height_check CHECK ((height >= 0)),
    CONSTRAINT images_image_views_check CHECK ((views >= 0)),
    CONSTRAINT images_image_width_check CHECK ((width >= 0))
);


ALTER TABLE public.images_image OWNER TO captionai;

--
-- Name: images_image_collections; Type: TABLE; Schema: public; Owner: captionai
--

CREATE TABLE public.images_image_collections (
    id integer NOT NULL,
    image_id uuid NOT NULL,
    collection_id integer NOT NULL
);


ALTER TABLE public.images_image_collections OWNER TO captionai;

--
-- Name: images_image_collections_id_seq; Type: SEQUENCE; Schema: public; Owner: captionai
--

CREATE SEQUENCE public.images_image_collections_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.images_image_collections_id_seq OWNER TO captionai;

--
-- Name: images_image_collections_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: captionai
--

ALTER SEQUENCE public.images_image_collections_id_seq OWNED BY public.images_image_collections.id;


--
-- Name: images_image_dislikes; Type: TABLE; Schema: public; Owner: captionai
--

CREATE TABLE public.images_image_dislikes (
    id integer NOT NULL,
    image_id uuid NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.images_image_dislikes OWNER TO captionai;

--
-- Name: images_image_dislikes_id_seq; Type: SEQUENCE; Schema: public; Owner: captionai
--

CREATE SEQUENCE public.images_image_dislikes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.images_image_dislikes_id_seq OWNER TO captionai;

--
-- Name: images_image_dislikes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: captionai
--

ALTER SEQUENCE public.images_image_dislikes_id_seq OWNED BY public.images_image_dislikes.id;


--
-- Name: images_image_likes; Type: TABLE; Schema: public; Owner: captionai
--

CREATE TABLE public.images_image_likes (
    id integer NOT NULL,
    image_id uuid NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.images_image_likes OWNER TO captionai;

--
-- Name: images_image_likes_id_seq; Type: SEQUENCE; Schema: public; Owner: captionai
--

CREATE SEQUENCE public.images_image_likes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.images_image_likes_id_seq OWNER TO captionai;

--
-- Name: images_image_likes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: captionai
--

ALTER SEQUENCE public.images_image_likes_id_seq OWNED BY public.images_image_likes.id;


--
-- Name: knox_authtoken; Type: TABLE; Schema: public; Owner: captionai
--

CREATE TABLE public.knox_authtoken (
    digest character varying(128) NOT NULL,
    salt character varying(16) NOT NULL,
    created timestamp with time zone NOT NULL,
    user_id integer NOT NULL,
    expiry timestamp with time zone,
    token_key character varying(8) NOT NULL
);


ALTER TABLE public.knox_authtoken OWNER TO captionai;

--
-- Name: reports_commentreport; Type: TABLE; Schema: public; Owner: captionai
--

CREATE TABLE public.reports_commentreport (
    id integer NOT NULL,
    comments text NOT NULL,
    reviewed boolean NOT NULL,
    solved boolean NOT NULL,
    reported_at timestamp with time zone NOT NULL,
    reviewed_at timestamp with time zone,
    solved_at timestamp with time zone,
    type character varying(20) NOT NULL,
    comment_id integer NOT NULL,
    reviewer_id integer,
    user_id integer NOT NULL
);


ALTER TABLE public.reports_commentreport OWNER TO captionai;

--
-- Name: reports_commentreport_id_seq; Type: SEQUENCE; Schema: public; Owner: captionai
--

CREATE SEQUENCE public.reports_commentreport_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.reports_commentreport_id_seq OWNER TO captionai;

--
-- Name: reports_commentreport_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: captionai
--

ALTER SEQUENCE public.reports_commentreport_id_seq OWNED BY public.reports_commentreport.id;


--
-- Name: reports_imagereport; Type: TABLE; Schema: public; Owner: captionai
--

CREATE TABLE public.reports_imagereport (
    id integer NOT NULL,
    comments text NOT NULL,
    reviewed boolean NOT NULL,
    solved boolean NOT NULL,
    reported_at timestamp with time zone NOT NULL,
    reviewed_at timestamp with time zone,
    solved_at timestamp with time zone,
    type character varying(20) NOT NULL,
    image_id uuid NOT NULL,
    reviewer_id integer,
    user_id integer NOT NULL
);


ALTER TABLE public.reports_imagereport OWNER TO captionai;

--
-- Name: reports_imagereport_id_seq; Type: SEQUENCE; Schema: public; Owner: captionai
--

CREATE SEQUENCE public.reports_imagereport_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.reports_imagereport_id_seq OWNER TO captionai;

--
-- Name: reports_imagereport_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: captionai
--

ALTER SEQUENCE public.reports_imagereport_id_seq OWNED BY public.reports_imagereport.id;


--
-- Name: accounts_profile id; Type: DEFAULT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.accounts_profile ALTER COLUMN id SET DEFAULT nextval('public.accounts_profile_id_seq'::regclass);


--
-- Name: accounts_profile_following id; Type: DEFAULT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.accounts_profile_following ALTER COLUMN id SET DEFAULT nextval('public.accounts_profile_following_id_seq'::regclass);


--
-- Name: accounts_profile_interests id; Type: DEFAULT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.accounts_profile_interests ALTER COLUMN id SET DEFAULT nextval('public.accounts_profile_interests_id_seq'::regclass);


--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- Name: auth_user id; Type: DEFAULT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.auth_user ALTER COLUMN id SET DEFAULT nextval('public.auth_user_id_seq'::regclass);


--
-- Name: auth_user_groups id; Type: DEFAULT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.auth_user_groups ALTER COLUMN id SET DEFAULT nextval('public.auth_user_groups_id_seq'::regclass);


--
-- Name: auth_user_user_permissions id; Type: DEFAULT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_user_user_permissions_id_seq'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- Name: images_caption id; Type: DEFAULT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.images_caption ALTER COLUMN id SET DEFAULT nextval('public.images_caption_id_seq'::regclass);


--
-- Name: images_collection id; Type: DEFAULT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.images_collection ALTER COLUMN id SET DEFAULT nextval('public.images_collection_id_seq'::regclass);


--
-- Name: images_comment id; Type: DEFAULT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.images_comment ALTER COLUMN id SET DEFAULT nextval('public.images_comment_id_seq'::regclass);


--
-- Name: images_comment_dislikes id; Type: DEFAULT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.images_comment_dislikes ALTER COLUMN id SET DEFAULT nextval('public.images_comment_dislikes_id_seq'::regclass);


--
-- Name: images_comment_likes id; Type: DEFAULT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.images_comment_likes ALTER COLUMN id SET DEFAULT nextval('public.images_comment_likes_id_seq'::regclass);


--
-- Name: images_image_collections id; Type: DEFAULT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.images_image_collections ALTER COLUMN id SET DEFAULT nextval('public.images_image_collections_id_seq'::regclass);


--
-- Name: images_image_dislikes id; Type: DEFAULT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.images_image_dislikes ALTER COLUMN id SET DEFAULT nextval('public.images_image_dislikes_id_seq'::regclass);


--
-- Name: images_image_likes id; Type: DEFAULT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.images_image_likes ALTER COLUMN id SET DEFAULT nextval('public.images_image_likes_id_seq'::regclass);


--
-- Name: reports_commentreport id; Type: DEFAULT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.reports_commentreport ALTER COLUMN id SET DEFAULT nextval('public.reports_commentreport_id_seq'::regclass);


--
-- Name: reports_imagereport id; Type: DEFAULT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.reports_imagereport ALTER COLUMN id SET DEFAULT nextval('public.reports_imagereport_id_seq'::regclass);


--
-- Data for Name: accounts_profile; Type: TABLE DATA; Schema: public; Owner: captionai
--

COPY public.accounts_profile (id, bio, location, image_id, user_id) FROM stdin;
1		World	\N	1
2	Welcome!	World	a227c54f-9d40-450f-aa90-eb95168cd0ee	2
3		World	\N	3
4		World	\N	4
5		World	\N	5
\.


--
-- Data for Name: accounts_profile_following; Type: TABLE DATA; Schema: public; Owner: captionai
--

COPY public.accounts_profile_following (id, profile_id, user_id) FROM stdin;
1	5	2
\.


--
-- Data for Name: accounts_profile_interests; Type: TABLE DATA; Schema: public; Owner: captionai
--

COPY public.accounts_profile_interests (id, profile_id, collection_id) FROM stdin;
1	2	8
2	2	2
3	2	11
4	2	4
5	5	25
6	5	1
\.


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: captionai
--

COPY public.auth_group (id, name) FROM stdin;
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: captionai
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: captionai
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can view log entry	1	view_logentry
5	Can add permission	2	add_permission
6	Can change permission	2	change_permission
7	Can delete permission	2	delete_permission
8	Can view permission	2	view_permission
9	Can add group	3	add_group
10	Can change group	3	change_group
11	Can delete group	3	delete_group
12	Can view group	3	view_group
13	Can add user	4	add_user
14	Can change user	4	change_user
15	Can delete user	4	delete_user
16	Can view user	4	view_user
17	Can add content type	5	add_contenttype
18	Can change content type	5	change_contenttype
19	Can delete content type	5	delete_contenttype
20	Can view content type	5	view_contenttype
21	Can add session	6	add_session
22	Can change session	6	change_session
23	Can delete session	6	delete_session
24	Can view session	6	view_session
25	Can add collection	7	add_collection
26	Can change collection	7	change_collection
27	Can delete collection	7	delete_collection
28	Can view collection	7	view_collection
29	Can add image	8	add_image
30	Can change image	8	change_image
31	Can delete image	8	delete_image
32	Can view image	8	view_image
33	Can add comment	9	add_comment
34	Can change comment	9	change_comment
35	Can delete comment	9	delete_comment
36	Can view comment	9	view_comment
37	Can add caption	10	add_caption
38	Can change caption	10	change_caption
39	Can delete caption	10	delete_caption
40	Can view caption	10	view_caption
41	Can add auth token	11	add_authtoken
42	Can change auth token	11	change_authtoken
43	Can delete auth token	11	delete_authtoken
44	Can view auth token	11	view_authtoken
45	Can add profile	12	add_profile
46	Can change profile	12	change_profile
47	Can delete profile	12	delete_profile
48	Can view profile	12	view_profile
49	Can add Image	13	add_imagereport
50	Can change Image	13	change_imagereport
51	Can delete Image	13	delete_imagereport
52	Can view Image	13	view_imagereport
53	Can add Comment	14	add_commentreport
54	Can change Comment	14	change_commentreport
55	Can delete Comment	14	delete_commentreport
56	Can view Comment	14	view_commentreport
\.


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: captionai
--

COPY public.auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
1	pbkdf2_sha256$216000$diqzJdiJqsRZ$v26XFuXm2O4IkfsxX5u9FCoJFfmMgBlag8Dbw0lQHxs=	2021-05-23 07:02:12.526017+00	t	admin			admin@admin.com	t	t	2021-05-20 19:31:04.149407+00
2	pbkdf2_sha256$216000$JJsSyi7SzEOH$fFlT6JCGFSxDJxtY7QkWcM+OQJuQkXjV9m4UmcbMlGw=	2021-05-24 01:23:26.827004+00	t	Kyle1297	Kyle	Griffin	kyle_griffin97@hotmail.com	t	t	2021-05-23 07:05:39+00
3	pbkdf2_sha256$216000$j1SynWdcXn2I$8gHKdRupKRsa2bPqAJq/w19ZFdoZI9mc9yEOGNY74YA=	\N	f	crazy8				f	t	2021-05-26 01:09:20.548106+00
4	pbkdf2_sha256$216000$8mDsdKmAajuZ$cxdcmq+C1T0w4+SwoQksbTQ9s407GiWH/9i/qZyMtEM=	\N	f	Anonymous				f	t	2021-05-26 01:12:01.999455+00
5	stephanie12	\N	f	stephanie12	Stephanie		stephanie_12@hotmail.com	f	t	2021-05-27 04:36:52.744872+00
\.


--
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: captionai
--

COPY public.auth_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: captionai
--

COPY public.auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: captionai
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
1	2021-05-22 23:48:19.559358+00	1	Sports	1	[{"added": {}}]	7	1
2	2021-05-22 23:48:27.259081+00	2	Animals	1	[{"added": {}}]	7	1
3	2021-05-22 23:48:33.933863+00	3	Family	1	[{"added": {}}]	7	1
4	2021-05-22 23:48:42.28508+00	4	Backgrounds	1	[{"added": {}}]	7	1
5	2021-05-22 23:48:55.0757+00	5	Travel	1	[{"added": {}}]	7	1
6	2021-05-22 23:49:03.132751+00	6	Outdoors	1	[{"added": {}}]	7	1
7	2021-05-22 23:49:12.690977+00	7	America	1	[{"added": {}}]	7	1
8	2021-05-22 23:49:19.675464+00	8	Australia	1	[{"added": {}}]	7	1
9	2021-05-23 07:02:33.677488+00	9	Asia	1	[{"added": {}}]	7	1
10	2021-05-23 07:10:54.956841+00	2	Kyle1297	2	[{"changed": {"fields": ["First name", "Last name", "Email address"]}}]	4	1
11	2021-05-23 07:11:15.259841+00	2	Kyle1297	2	[{"changed": {"fields": ["Staff status", "Superuser status"]}}]	4	1
12	2021-05-25 23:07:47.469929+00	d842c124-eca5-4690-aa5c-6dec8079bb6e	Rubbish	3		8	1
13	2021-05-26 01:07:25.9196+00	b3b2f2fe-d04c-4b54-9ff8-efa2818159b2	Wedding	3		8	1
14	2021-05-26 02:00:18.973072+00	02f5c87e-f96b-4961-897e-a95b34ebde34	Basketball	3		8	1
15	2021-05-26 09:37:48.612464+00	a9d9c5b8-c571-40aa-877d-9a8db4cceba7	Basketball	3		8	1
16	2021-05-26 09:38:08.748973+00	fc697025-498f-47a1-b19b-103782ef621e	Wedding	3		8	1
17	2021-05-26 09:41:51.340498+00	ad55e96f-8b0f-4492-8218-f0e2e5256e60	Fire	3		8	1
18	2021-05-27 06:31:43.990316+00	30	BasketB	3		7	1
19	2021-05-27 06:31:43.99306+00	24	Husb	3		7	1
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: captionai
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	permission
3	auth	group
4	auth	user
5	contenttypes	contenttype
6	sessions	session
7	images	collection
8	images	image
9	images	comment
10	images	caption
11	knox	authtoken
12	accounts	profile
13	reports	imagereport
14	reports	commentreport
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: captionai
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2021-05-20 19:28:52.636895+00
2	auth	0001_initial	2021-05-20 19:28:52.687548+00
3	images	0001_initial	2021-05-20 19:28:52.842859+00
4	accounts	0001_initial	2021-05-20 19:28:52.988391+00
5	admin	0001_initial	2021-05-20 19:28:53.043447+00
6	admin	0002_logentry_remove_auto_add	2021-05-20 19:28:53.07261+00
7	admin	0003_logentry_add_action_flag_choices	2021-05-20 19:28:53.091282+00
8	contenttypes	0002_remove_content_type_name	2021-05-20 19:28:53.125285+00
9	auth	0002_alter_permission_name_max_length	2021-05-20 19:28:53.147458+00
10	auth	0003_alter_user_email_max_length	2021-05-20 19:28:53.169027+00
11	auth	0004_alter_user_username_opts	2021-05-20 19:28:53.190145+00
12	auth	0005_alter_user_last_login_null	2021-05-20 19:28:53.2118+00
13	auth	0006_require_contenttypes_0002	2021-05-20 19:28:53.216049+00
14	auth	0007_alter_validators_add_error_messages	2021-05-20 19:28:53.236295+00
15	auth	0008_alter_user_username_max_length	2021-05-20 19:28:53.26255+00
16	auth	0009_alter_user_last_name_max_length	2021-05-20 19:28:53.282604+00
17	auth	0010_alter_group_name_max_length	2021-05-20 19:28:53.303674+00
18	auth	0011_update_proxy_permissions	2021-05-20 19:28:53.324485+00
19	auth	0012_alter_user_first_name_max_length	2021-05-20 19:28:53.344548+00
20	knox	0001_initial	2021-05-20 19:28:53.368447+00
21	knox	0002_auto_20150916_1425	2021-05-20 19:28:53.459608+00
22	knox	0003_auto_20150916_1526	2021-05-20 19:28:53.506647+00
23	knox	0004_authtoken_expires	2021-05-20 19:28:53.527962+00
24	knox	0005_authtoken_token_key	2021-05-20 19:28:53.547696+00
25	knox	0006_auto_20160818_0932	2021-05-20 19:28:53.594552+00
26	knox	0007_auto_20190111_0542	2021-05-20 19:28:53.613824+00
27	reports	0001_initial	2021-05-20 19:28:53.673756+00
28	sessions	0001_initial	2021-05-20 19:28:53.711819+00
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: captionai
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
kdihka79ci0ljx6lidm13563q2ap1joo	.eJxVjE0OwiAYBe_C2pACLYhL9z0D-f6QqqFJaVfGu2uTLnT7Zua9VIJtLWlrsqSJ1UUZdfrdEOghdQd8h3qbNc11XSbUu6IP2vQ4szyvh_t3UKCVb43goyWbKZwFIvWIIWaDiNnlgQJ2nXFsYgTkAa0XG1hAHLgQemM8qvcHFos45g:1ljoNz:s5PzIG_vZCcvM9TCXq3E6Mgar8q32fQWgwfz9LqEiYE	2021-06-03 19:31:11.971931+00
7cynzlv2u9wa9g7tk0baqy7x5fcawpxh	.eJxVjE0OwiAYBe_C2pACLYhL9z0D-f6QqqFJaVfGu2uTLnT7Zua9VIJtLWlrsqSJ1UUZdfrdEOghdQd8h3qbNc11XSbUu6IP2vQ4szyvh_t3UKCVb43goyWbKZwFIvWIIWaDiNnlgQJ2nXFsYgTkAa0XG1hAHLgQemM8qvcHFos45g:1lkdWH:N6ioM4XFun9NxLfEzGBQDO2skj7p0xN5ZlkIfpOIpd8	2021-06-06 02:07:09.639971+00
imz9onkw15l7h6h4wwv917kgbbbxi1el	.eJxVjE0OwiAYBe_C2pACLYhL9z0D-f6QqqFJaVfGu2uTLnT7Zua9VIJtLWlrsqSJ1UUZdfrdEOghdQd8h3qbNc11XSbUu6IP2vQ4szyvh_t3UKCVb43goyWbKZwFIvWIIWaDiNnlgQJ2nXFsYgTkAa0XG1hAHLgQemM8qvcHFos45g:1lki7o:ZpDl0HOPh9PTsdcZWcnfcAnubisawynIW5rDvmWhb_k	2021-06-06 07:02:12.542633+00
o7u04vgt85sr5mllnw0yuyob3phd0lom	.eJxVjDsOwjAQRO_iGlk2-EtJnzNYu941DiBHipMKcXcSKQVounlv5i0SrEtNa-c5jSSu4ixOvx1CfnLbAT2g3SeZp7bMI8pdkQftcpiIX7fD_Tuo0Ou2NqQ45KApKo9xi4eQC3utDGq6eAJbFDhLpTAx2uJy8NGB1Q7QGC0-XwWlOM0:1lkzJW:hfxJ2HbZ1VgehyO0BW5Whtn6CHFN5Y3_pHGe4h4C550	2021-06-07 01:23:26.840064+00
\.


--
-- Data for Name: images_caption; Type: TABLE DATA; Schema: public; Owner: captionai
--

COPY public.images_caption (id, text, satisfactory, corrected_text, last_updated, image_id) FROM stdin;
1	The little girl is carrying black umbrella	t		2021-05-25 23:16:22.866521+00	55d2b1c3-385a-4658-b15c-1b27d4068206
2	Man is climbing up mountain	f		2021-05-26 00:35:58.981764+00	242bca79-6ef7-477e-b86b-70c6b22fdd65
8	Girl in pink and black suit is jumping from <unk> of fountain	f	Two singers on stage	2021-05-27 04:33:42.190387+00	8a228877-9db4-4f6e-a42a-c24807744c96
9	Group of people are playing soccer in the woods	f	Group of people playing basketball	2021-05-27 04:39:59.103283+00	ff6ddce6-0317-4c61-a29f-062662376f34
10	Man and woman in white shirts and jeans are standing on rock with blue sky	f	Wedding couple on cliff	2021-05-27 04:44:15.679748+00	488e31c4-4983-4d42-8f61-273897f93bc3
11	Man and woman in apron are standing in front of red christmas tree	f	Women hanging up picture on wall	2021-05-27 05:39:30.592983+00	e4c36ff7-fa98-4a84-a4a6-228992d9045f
12	Two people stand in the mountains looking at mountain	\N	View of the mountains	2021-05-27 06:21:56.096461+00	ada209fa-2eae-4ac4-b9ea-a0c770932dcc
13	Group of people are standing on the edge of <unk> mountain at sunset	\N	Group of people are standing on the edge of mountain at sunset	2021-05-27 07:16:15.048751+00	96daa528-eefb-48c9-aef3-dba2a4d01b71
14	People are standing on the side of the road at night	t		2021-05-27 09:00:40.301283+00	9a3c07cf-e356-47f2-ad92-2b9383bc7b12
15	The little girl is carrying black umbrella	\N		2021-05-27 09:04:58.921805+00	b5307ead-7df8-4c10-8a62-fa065166825b
\.


--
-- Data for Name: images_collection; Type: TABLE DATA; Schema: public; Owner: captionai
--

COPY public.images_collection (id, category, is_main, creator_id) FROM stdin;
1	Sports	t	\N
2	Animals	t	\N
3	Family	t	\N
4	Backgrounds	t	\N
5	Travel	t	\N
6	Outdoors	t	\N
7	America	f	\N
8	Australia	f	\N
9	Asia	f	\N
10	Trash	f	2
11	City	f	2
12	Umbrella	f	2
13	Girl	f	2
14	Road	f	2
15	Rubbish	f	2
16	Wedding	f	2
17	Cliff	f	2
18	Celebration	f	2
19	Happy	f	2
20	Photography	f	2
21	Husband	f	4
22	Wife	f	4
23	Love	f	4
25	Basketball	f	4
26	Tall	f	4
27	Men	f	4
28	Kids	f	4
29	Friends	f	4
31	Children	f	4
32	Fire	f	2
33	Anger	f	2
34	Street	f	2
35	Protest	f	2
36	Women	f	\N
37	Stars	f	\N
38	Stage	f	\N
39	Show	f	\N
40	Dresses	f	\N
41	Singers	f	\N
42	Boys	f	5
43	Court	f	5
44	Fun	f	5
45	Portait	f	\N
46	Picture	f	\N
47	Home	f	\N
48	Wall	f	\N
49	House	f	\N
50	New	f	\N
51	Mountain	f	\N
52	Snow	f	\N
53	Sun	f	\N
54	Dusk	f	\N
55	Sunset	f	\N
56	Water	f	\N
57	Ocean	f	\N
58	View	f	\N
59	Black lives matter	f	\N
60	USA	f	\N
61	BLM	f	\N
62	Road\\	f	\N
\.


--
-- Data for Name: images_comment; Type: TABLE DATA; Schema: public; Owner: captionai
--

COPY public.images_comment (id, comment, commented_at, last_edited, commenter_id, image_id) FROM stdin;
1	Very interesting	2021-05-25 23:17:35.279475+00	2021-05-25 23:17:35.279475+00	2	55d2b1c3-385a-4658-b15c-1b27d4068206
\.


--
-- Data for Name: images_comment_dislikes; Type: TABLE DATA; Schema: public; Owner: captionai
--

COPY public.images_comment_dislikes (id, comment_id, user_id) FROM stdin;
\.


--
-- Data for Name: images_comment_likes; Type: TABLE DATA; Schema: public; Owner: captionai
--

COPY public.images_comment_likes (id, comment_id, user_id) FROM stdin;
1	1	2
\.


--
-- Data for Name: images_image; Type: TABLE DATA; Schema: public; Owner: captionai
--

COPY public.images_image (uuid, s3_key, type, width, height, title, uploaded_at, is_profile_image, is_private, views, downloads, uploader_id) FROM stdin;
a227c54f-9d40-450f-aa90-eb95168cd0ee	user-profiles/a227c54f-9d40-450f-aa90-eb95168cd0ee.jpeg	JPEG	467	700	How-to-take-good-pictures-waterlilly	2021-05-25 23:20:40.06432+00	t	t	0	0	2
55d2b1c3-385a-4658-b15c-1b27d4068206	captioned-images/public/55d2b1c3-385a-4658-b15c-1b27d4068206.jpeg	JPEG	1200	800	Rubbish	2021-05-25 23:16:22.854217+00	f	f	1	1	2
242bca79-6ef7-477e-b86b-70c6b22fdd65	captioned-images/public/242bca79-6ef7-477e-b86b-70c6b22fdd65.jpeg	JPEG	1920	1080	Road	2021-05-26 00:35:58.966905+00	f	f	0	0	2
8a228877-9db4-4f6e-a42a-c24807744c96	captioned-images/public/8a228877-9db4-4f6e-a42a-c24807744c96.jpeg	JPEG	1600	1128	Stars	2021-05-27 04:32:53.56468+00	f	f	0	0	4
ff6ddce6-0317-4c61-a29f-062662376f34	captioned-images/public/ff6ddce6-0317-4c61-a29f-062662376f34.jpeg	JPEG	1200	850	Basketball	2021-05-27 04:39:33.832795+00	f	f	0	0	5
488e31c4-4983-4d42-8f61-273897f93bc3	captioned-images/public/488e31c4-4983-4d42-8f61-273897f93bc3.jpeg	JPEG	1920	1080	Wedding	2021-05-27 04:43:29.667039+00	f	f	0	0	2
e4c36ff7-fa98-4a84-a4a6-228992d9045f	captioned-images/public/e4c36ff7-fa98-4a84-a4a6-228992d9045f.jpeg	JPEG	1000	609	Hanging up picture	2021-05-27 05:38:51.459488+00	f	f	0	0	4
ada209fa-2eae-4ac4-b9ea-a0c770932dcc	captioned-images/public/ada209fa-2eae-4ac4-b9ea-a0c770932dcc.jpeg	JPEG	10109	4542	Mountains	2021-05-27 06:21:09.336498+00	f	f	0	0	4
96daa528-eefb-48c9-aef3-dba2a4d01b71	captioned-images/public/96daa528-eefb-48c9-aef3-dba2a4d01b71.jpeg	JPEG	4152	2335	Dusk	2021-05-27 06:31:49.966768+00	f	f	0	0	4
9a3c07cf-e356-47f2-ad92-2b9383bc7b12	captioned-images/public/9a3c07cf-e356-47f2-ad92-2b9383bc7b12.jpeg	JPEG	1600	1066	Fire	2021-05-27 09:00:40.287523+00	f	f	0	0	4
b5307ead-7df8-4c10-8a62-fa065166825b	captioned-images/private/b5307ead-7df8-4c10-8a62-fa065166825b.jpeg	JPEG	1200	800	Rubbish	2021-05-27 09:04:58.912248+00	f	t	0	0	2
\.


--
-- Data for Name: images_image_collections; Type: TABLE DATA; Schema: public; Owner: captionai
--

COPY public.images_image_collections (id, image_id, collection_id) FROM stdin;
1	55d2b1c3-385a-4658-b15c-1b27d4068206	4
2	55d2b1c3-385a-4658-b15c-1b27d4068206	9
3	55d2b1c3-385a-4658-b15c-1b27d4068206	10
4	55d2b1c3-385a-4658-b15c-1b27d4068206	11
5	55d2b1c3-385a-4658-b15c-1b27d4068206	12
6	55d2b1c3-385a-4658-b15c-1b27d4068206	13
7	55d2b1c3-385a-4658-b15c-1b27d4068206	14
8	55d2b1c3-385a-4658-b15c-1b27d4068206	15
9	242bca79-6ef7-477e-b86b-70c6b22fdd65	8
10	242bca79-6ef7-477e-b86b-70c6b22fdd65	4
11	242bca79-6ef7-477e-b86b-70c6b22fdd65	6
12	242bca79-6ef7-477e-b86b-70c6b22fdd65	14
51	8a228877-9db4-4f6e-a42a-c24807744c96	36
52	8a228877-9db4-4f6e-a42a-c24807744c96	37
53	8a228877-9db4-4f6e-a42a-c24807744c96	38
54	8a228877-9db4-4f6e-a42a-c24807744c96	39
55	8a228877-9db4-4f6e-a42a-c24807744c96	40
56	8a228877-9db4-4f6e-a42a-c24807744c96	41
57	8a228877-9db4-4f6e-a42a-c24807744c96	7
58	ff6ddce6-0317-4c61-a29f-062662376f34	1
59	ff6ddce6-0317-4c61-a29f-062662376f34	7
60	ff6ddce6-0317-4c61-a29f-062662376f34	42
61	ff6ddce6-0317-4c61-a29f-062662376f34	43
62	ff6ddce6-0317-4c61-a29f-062662376f34	44
63	ff6ddce6-0317-4c61-a29f-062662376f34	25
64	ff6ddce6-0317-4c61-a29f-062662376f34	27
65	ff6ddce6-0317-4c61-a29f-062662376f34	28
66	ff6ddce6-0317-4c61-a29f-062662376f34	31
67	488e31c4-4983-4d42-8f61-273897f93bc3	16
68	488e31c4-4983-4d42-8f61-273897f93bc3	17
69	488e31c4-4983-4d42-8f61-273897f93bc3	18
70	488e31c4-4983-4d42-8f61-273897f93bc3	19
71	488e31c4-4983-4d42-8f61-273897f93bc3	20
72	488e31c4-4983-4d42-8f61-273897f93bc3	21
73	488e31c4-4983-4d42-8f61-273897f93bc3	22
74	e4c36ff7-fa98-4a84-a4a6-228992d9045f	36
75	e4c36ff7-fa98-4a84-a4a6-228992d9045f	45
76	e4c36ff7-fa98-4a84-a4a6-228992d9045f	46
77	e4c36ff7-fa98-4a84-a4a6-228992d9045f	47
78	e4c36ff7-fa98-4a84-a4a6-228992d9045f	48
79	e4c36ff7-fa98-4a84-a4a6-228992d9045f	49
80	e4c36ff7-fa98-4a84-a4a6-228992d9045f	50
81	ada209fa-2eae-4ac4-b9ea-a0c770932dcc	51
82	ada209fa-2eae-4ac4-b9ea-a0c770932dcc	52
83	ada209fa-2eae-4ac4-b9ea-a0c770932dcc	5
84	ada209fa-2eae-4ac4-b9ea-a0c770932dcc	6
85	96daa528-eefb-48c9-aef3-dba2a4d01b71	4
86	96daa528-eefb-48c9-aef3-dba2a4d01b71	53
87	96daa528-eefb-48c9-aef3-dba2a4d01b71	54
88	96daa528-eefb-48c9-aef3-dba2a4d01b71	55
89	96daa528-eefb-48c9-aef3-dba2a4d01b71	56
90	96daa528-eefb-48c9-aef3-dba2a4d01b71	57
91	96daa528-eefb-48c9-aef3-dba2a4d01b71	58
92	9a3c07cf-e356-47f2-ad92-2b9383bc7b12	32
93	9a3c07cf-e356-47f2-ad92-2b9383bc7b12	34
94	9a3c07cf-e356-47f2-ad92-2b9383bc7b12	35
95	9a3c07cf-e356-47f2-ad92-2b9383bc7b12	60
96	9a3c07cf-e356-47f2-ad92-2b9383bc7b12	62
97	b5307ead-7df8-4c10-8a62-fa065166825b	9
98	b5307ead-7df8-4c10-8a62-fa065166825b	13
99	b5307ead-7df8-4c10-8a62-fa065166825b	14
\.


--
-- Data for Name: images_image_dislikes; Type: TABLE DATA; Schema: public; Owner: captionai
--

COPY public.images_image_dislikes (id, image_id, user_id) FROM stdin;
1	55d2b1c3-385a-4658-b15c-1b27d4068206	2
\.


--
-- Data for Name: images_image_likes; Type: TABLE DATA; Schema: public; Owner: captionai
--

COPY public.images_image_likes (id, image_id, user_id) FROM stdin;
\.


--
-- Data for Name: knox_authtoken; Type: TABLE DATA; Schema: public; Owner: captionai
--

COPY public.knox_authtoken (digest, salt, created, user_id, expiry, token_key) FROM stdin;
b45232db74225ed11ec206eb39da20565cf64526facc6bb01feb113e942a4bb4b78571104aaba41291bb48239db8388f7a93e0429d10295974d1ca0e9a70a8e7	4a4c7343f95dcff1	2021-05-27 09:01:32.728758+00	2	2021-05-27 19:01:32.728409+00	94600b84
\.


--
-- Data for Name: reports_commentreport; Type: TABLE DATA; Schema: public; Owner: captionai
--

COPY public.reports_commentreport (id, comments, reviewed, solved, reported_at, reviewed_at, solved_at, type, comment_id, reviewer_id, user_id) FROM stdin;
\.


--
-- Data for Name: reports_imagereport; Type: TABLE DATA; Schema: public; Owner: captionai
--

COPY public.reports_imagereport (id, comments, reviewed, solved, reported_at, reviewed_at, solved_at, type, image_id, reviewer_id, user_id) FROM stdin;
\.


--
-- Name: accounts_profile_following_id_seq; Type: SEQUENCE SET; Schema: public; Owner: captionai
--

SELECT pg_catalog.setval('public.accounts_profile_following_id_seq', 1, true);


--
-- Name: accounts_profile_id_seq; Type: SEQUENCE SET; Schema: public; Owner: captionai
--

SELECT pg_catalog.setval('public.accounts_profile_id_seq', 5, true);


--
-- Name: accounts_profile_interests_id_seq; Type: SEQUENCE SET; Schema: public; Owner: captionai
--

SELECT pg_catalog.setval('public.accounts_profile_interests_id_seq', 6, true);


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: captionai
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: captionai
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: captionai
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 56, true);


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: captionai
--

SELECT pg_catalog.setval('public.auth_user_groups_id_seq', 1, false);


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: captionai
--

SELECT pg_catalog.setval('public.auth_user_id_seq', 5, true);


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: captionai
--

SELECT pg_catalog.setval('public.auth_user_user_permissions_id_seq', 1, false);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: captionai
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 19, true);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: captionai
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 14, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: captionai
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 28, true);


--
-- Name: images_caption_id_seq; Type: SEQUENCE SET; Schema: public; Owner: captionai
--

SELECT pg_catalog.setval('public.images_caption_id_seq', 15, true);


--
-- Name: images_collection_id_seq; Type: SEQUENCE SET; Schema: public; Owner: captionai
--

SELECT pg_catalog.setval('public.images_collection_id_seq', 62, true);


--
-- Name: images_comment_dislikes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: captionai
--

SELECT pg_catalog.setval('public.images_comment_dislikes_id_seq', 1, false);


--
-- Name: images_comment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: captionai
--

SELECT pg_catalog.setval('public.images_comment_id_seq', 1, true);


--
-- Name: images_comment_likes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: captionai
--

SELECT pg_catalog.setval('public.images_comment_likes_id_seq', 1, true);


--
-- Name: images_image_collections_id_seq; Type: SEQUENCE SET; Schema: public; Owner: captionai
--

SELECT pg_catalog.setval('public.images_image_collections_id_seq', 99, true);


--
-- Name: images_image_dislikes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: captionai
--

SELECT pg_catalog.setval('public.images_image_dislikes_id_seq', 1, true);


--
-- Name: images_image_likes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: captionai
--

SELECT pg_catalog.setval('public.images_image_likes_id_seq', 2, true);


--
-- Name: reports_commentreport_id_seq; Type: SEQUENCE SET; Schema: public; Owner: captionai
--

SELECT pg_catalog.setval('public.reports_commentreport_id_seq', 1, false);


--
-- Name: reports_imagereport_id_seq; Type: SEQUENCE SET; Schema: public; Owner: captionai
--

SELECT pg_catalog.setval('public.reports_imagereport_id_seq', 1, false);


--
-- Name: accounts_profile_following accounts_profile_following_pkey; Type: CONSTRAINT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.accounts_profile_following
    ADD CONSTRAINT accounts_profile_following_pkey PRIMARY KEY (id);


--
-- Name: accounts_profile_following accounts_profile_following_profile_id_user_id_c4457ec2_uniq; Type: CONSTRAINT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.accounts_profile_following
    ADD CONSTRAINT accounts_profile_following_profile_id_user_id_c4457ec2_uniq UNIQUE (profile_id, user_id);


--
-- Name: accounts_profile accounts_profile_image_id_key; Type: CONSTRAINT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.accounts_profile
    ADD CONSTRAINT accounts_profile_image_id_key UNIQUE (image_id);


--
-- Name: accounts_profile_interests accounts_profile_interes_profile_id_collection_id_ff9b7b98_uniq; Type: CONSTRAINT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.accounts_profile_interests
    ADD CONSTRAINT accounts_profile_interes_profile_id_collection_id_ff9b7b98_uniq UNIQUE (profile_id, collection_id);


--
-- Name: accounts_profile_interests accounts_profile_interests_pkey; Type: CONSTRAINT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.accounts_profile_interests
    ADD CONSTRAINT accounts_profile_interests_pkey PRIMARY KEY (id);


--
-- Name: accounts_profile accounts_profile_pkey; Type: CONSTRAINT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.accounts_profile
    ADD CONSTRAINT accounts_profile_pkey PRIMARY KEY (id);


--
-- Name: accounts_profile accounts_profile_user_id_key; Type: CONSTRAINT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.accounts_profile
    ADD CONSTRAINT accounts_profile_user_id_key UNIQUE (user_id);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_user_id_group_id_94350c0c_uniq; Type: CONSTRAINT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq UNIQUE (user_id, group_id);


--
-- Name: auth_user auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_permission_id_14a6b632_uniq; Type: CONSTRAINT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq UNIQUE (user_id, permission_id);


--
-- Name: auth_user auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: images_caption images_caption_image_id_key; Type: CONSTRAINT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.images_caption
    ADD CONSTRAINT images_caption_image_id_key UNIQUE (image_id);


--
-- Name: images_caption images_caption_pkey; Type: CONSTRAINT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.images_caption
    ADD CONSTRAINT images_caption_pkey PRIMARY KEY (id);


--
-- Name: images_collection images_collection_category_key; Type: CONSTRAINT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.images_collection
    ADD CONSTRAINT images_collection_category_key UNIQUE (category);


--
-- Name: images_collection images_collection_pkey; Type: CONSTRAINT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.images_collection
    ADD CONSTRAINT images_collection_pkey PRIMARY KEY (id);


--
-- Name: images_comment_dislikes images_comment_dislikes_comment_id_user_id_ed477626_uniq; Type: CONSTRAINT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.images_comment_dislikes
    ADD CONSTRAINT images_comment_dislikes_comment_id_user_id_ed477626_uniq UNIQUE (comment_id, user_id);


--
-- Name: images_comment_dislikes images_comment_dislikes_pkey; Type: CONSTRAINT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.images_comment_dislikes
    ADD CONSTRAINT images_comment_dislikes_pkey PRIMARY KEY (id);


--
-- Name: images_comment_likes images_comment_likes_comment_id_user_id_26091683_uniq; Type: CONSTRAINT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.images_comment_likes
    ADD CONSTRAINT images_comment_likes_comment_id_user_id_26091683_uniq UNIQUE (comment_id, user_id);


--
-- Name: images_comment_likes images_comment_likes_pkey; Type: CONSTRAINT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.images_comment_likes
    ADD CONSTRAINT images_comment_likes_pkey PRIMARY KEY (id);


--
-- Name: images_comment images_comment_pkey; Type: CONSTRAINT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.images_comment
    ADD CONSTRAINT images_comment_pkey PRIMARY KEY (id);


--
-- Name: images_image_collections images_image_collections_image_id_collection_id_6edf1ab5_uniq; Type: CONSTRAINT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.images_image_collections
    ADD CONSTRAINT images_image_collections_image_id_collection_id_6edf1ab5_uniq UNIQUE (image_id, collection_id);


--
-- Name: images_image_collections images_image_collections_pkey; Type: CONSTRAINT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.images_image_collections
    ADD CONSTRAINT images_image_collections_pkey PRIMARY KEY (id);


--
-- Name: images_image_dislikes images_image_dislikes_image_id_user_id_ea5ff97f_uniq; Type: CONSTRAINT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.images_image_dislikes
    ADD CONSTRAINT images_image_dislikes_image_id_user_id_ea5ff97f_uniq UNIQUE (image_id, user_id);


--
-- Name: images_image_dislikes images_image_dislikes_pkey; Type: CONSTRAINT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.images_image_dislikes
    ADD CONSTRAINT images_image_dislikes_pkey PRIMARY KEY (id);


--
-- Name: images_image_likes images_image_likes_image_id_user_id_272647fc_uniq; Type: CONSTRAINT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.images_image_likes
    ADD CONSTRAINT images_image_likes_image_id_user_id_272647fc_uniq UNIQUE (image_id, user_id);


--
-- Name: images_image_likes images_image_likes_pkey; Type: CONSTRAINT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.images_image_likes
    ADD CONSTRAINT images_image_likes_pkey PRIMARY KEY (id);


--
-- Name: images_image images_image_pkey; Type: CONSTRAINT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.images_image
    ADD CONSTRAINT images_image_pkey PRIMARY KEY (uuid);


--
-- Name: knox_authtoken knox_authtoken_pkey; Type: CONSTRAINT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.knox_authtoken
    ADD CONSTRAINT knox_authtoken_pkey PRIMARY KEY (digest);


--
-- Name: knox_authtoken knox_authtoken_salt_key; Type: CONSTRAINT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.knox_authtoken
    ADD CONSTRAINT knox_authtoken_salt_key UNIQUE (salt);


--
-- Name: reports_commentreport reports_commentreport_pkey; Type: CONSTRAINT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.reports_commentreport
    ADD CONSTRAINT reports_commentreport_pkey PRIMARY KEY (id);


--
-- Name: reports_imagereport reports_imagereport_pkey; Type: CONSTRAINT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.reports_imagereport
    ADD CONSTRAINT reports_imagereport_pkey PRIMARY KEY (id);


--
-- Name: accounts_profile_following_profile_id_8b8b18f9; Type: INDEX; Schema: public; Owner: captionai
--

CREATE INDEX accounts_profile_following_profile_id_8b8b18f9 ON public.accounts_profile_following USING btree (profile_id);


--
-- Name: accounts_profile_following_user_id_64d3b561; Type: INDEX; Schema: public; Owner: captionai
--

CREATE INDEX accounts_profile_following_user_id_64d3b561 ON public.accounts_profile_following USING btree (user_id);


--
-- Name: accounts_profile_interests_collection_id_719c95a9; Type: INDEX; Schema: public; Owner: captionai
--

CREATE INDEX accounts_profile_interests_collection_id_719c95a9 ON public.accounts_profile_interests USING btree (collection_id);


--
-- Name: accounts_profile_interests_profile_id_e30c47b7; Type: INDEX; Schema: public; Owner: captionai
--

CREATE INDEX accounts_profile_interests_profile_id_e30c47b7 ON public.accounts_profile_interests USING btree (profile_id);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: captionai
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: captionai
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: captionai
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: captionai
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: auth_user_groups_group_id_97559544; Type: INDEX; Schema: public; Owner: captionai
--

CREATE INDEX auth_user_groups_group_id_97559544 ON public.auth_user_groups USING btree (group_id);


--
-- Name: auth_user_groups_user_id_6a12ed8b; Type: INDEX; Schema: public; Owner: captionai
--

CREATE INDEX auth_user_groups_user_id_6a12ed8b ON public.auth_user_groups USING btree (user_id);


--
-- Name: auth_user_user_permissions_permission_id_1fbb5f2c; Type: INDEX; Schema: public; Owner: captionai
--

CREATE INDEX auth_user_user_permissions_permission_id_1fbb5f2c ON public.auth_user_user_permissions USING btree (permission_id);


--
-- Name: auth_user_user_permissions_user_id_a95ead1b; Type: INDEX; Schema: public; Owner: captionai
--

CREATE INDEX auth_user_user_permissions_user_id_a95ead1b ON public.auth_user_user_permissions USING btree (user_id);


--
-- Name: auth_user_username_6821ab7c_like; Type: INDEX; Schema: public; Owner: captionai
--

CREATE INDEX auth_user_username_6821ab7c_like ON public.auth_user USING btree (username varchar_pattern_ops);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: captionai
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: captionai
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: captionai
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: captionai
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: images_caption_corrected_text_aabf3ab8; Type: INDEX; Schema: public; Owner: captionai
--

CREATE INDEX images_caption_corrected_text_aabf3ab8 ON public.images_caption USING btree (corrected_text);


--
-- Name: images_caption_corrected_text_aabf3ab8_like; Type: INDEX; Schema: public; Owner: captionai
--

CREATE INDEX images_caption_corrected_text_aabf3ab8_like ON public.images_caption USING btree (corrected_text varchar_pattern_ops);


--
-- Name: images_caption_text_4e38fc30; Type: INDEX; Schema: public; Owner: captionai
--

CREATE INDEX images_caption_text_4e38fc30 ON public.images_caption USING btree (text);


--
-- Name: images_caption_text_4e38fc30_like; Type: INDEX; Schema: public; Owner: captionai
--

CREATE INDEX images_caption_text_4e38fc30_like ON public.images_caption USING btree (text varchar_pattern_ops);


--
-- Name: images_collection_category_606f8eab_like; Type: INDEX; Schema: public; Owner: captionai
--

CREATE INDEX images_collection_category_606f8eab_like ON public.images_collection USING btree (category varchar_pattern_ops);


--
-- Name: images_collection_creator_id_cf5345d8; Type: INDEX; Schema: public; Owner: captionai
--

CREATE INDEX images_collection_creator_id_cf5345d8 ON public.images_collection USING btree (creator_id);


--
-- Name: images_comment_commenter_id_cc454f1f; Type: INDEX; Schema: public; Owner: captionai
--

CREATE INDEX images_comment_commenter_id_cc454f1f ON public.images_comment USING btree (commenter_id);


--
-- Name: images_comment_dislikes_comment_id_c1d39ad3; Type: INDEX; Schema: public; Owner: captionai
--

CREATE INDEX images_comment_dislikes_comment_id_c1d39ad3 ON public.images_comment_dislikes USING btree (comment_id);


--
-- Name: images_comment_dislikes_user_id_2b903b1a; Type: INDEX; Schema: public; Owner: captionai
--

CREATE INDEX images_comment_dislikes_user_id_2b903b1a ON public.images_comment_dislikes USING btree (user_id);


--
-- Name: images_comment_image_id_be8a671b; Type: INDEX; Schema: public; Owner: captionai
--

CREATE INDEX images_comment_image_id_be8a671b ON public.images_comment USING btree (image_id);


--
-- Name: images_comment_likes_comment_id_0103705e; Type: INDEX; Schema: public; Owner: captionai
--

CREATE INDEX images_comment_likes_comment_id_0103705e ON public.images_comment_likes USING btree (comment_id);


--
-- Name: images_comment_likes_user_id_0770bc97; Type: INDEX; Schema: public; Owner: captionai
--

CREATE INDEX images_comment_likes_user_id_0770bc97 ON public.images_comment_likes USING btree (user_id);


--
-- Name: images_image_collections_collection_id_ed3dfc79; Type: INDEX; Schema: public; Owner: captionai
--

CREATE INDEX images_image_collections_collection_id_ed3dfc79 ON public.images_image_collections USING btree (collection_id);


--
-- Name: images_image_collections_image_id_b4013e9e; Type: INDEX; Schema: public; Owner: captionai
--

CREATE INDEX images_image_collections_image_id_b4013e9e ON public.images_image_collections USING btree (image_id);


--
-- Name: images_image_dislikes_image_id_5d681cde; Type: INDEX; Schema: public; Owner: captionai
--

CREATE INDEX images_image_dislikes_image_id_5d681cde ON public.images_image_dislikes USING btree (image_id);


--
-- Name: images_image_dislikes_user_id_6b4f7834; Type: INDEX; Schema: public; Owner: captionai
--

CREATE INDEX images_image_dislikes_user_id_6b4f7834 ON public.images_image_dislikes USING btree (user_id);


--
-- Name: images_image_likes_image_id_fef2fdea; Type: INDEX; Schema: public; Owner: captionai
--

CREATE INDEX images_image_likes_image_id_fef2fdea ON public.images_image_likes USING btree (image_id);


--
-- Name: images_image_likes_user_id_24c46dc2; Type: INDEX; Schema: public; Owner: captionai
--

CREATE INDEX images_image_likes_user_id_24c46dc2 ON public.images_image_likes USING btree (user_id);


--
-- Name: images_image_title_73416e8c; Type: INDEX; Schema: public; Owner: captionai
--

CREATE INDEX images_image_title_73416e8c ON public.images_image USING btree (title);


--
-- Name: images_image_title_73416e8c_like; Type: INDEX; Schema: public; Owner: captionai
--

CREATE INDEX images_image_title_73416e8c_like ON public.images_image USING btree (title varchar_pattern_ops);


--
-- Name: images_image_uploader_id_9c914939; Type: INDEX; Schema: public; Owner: captionai
--

CREATE INDEX images_image_uploader_id_9c914939 ON public.images_image USING btree (uploader_id);


--
-- Name: knox_authtoken_digest_188c7e77_like; Type: INDEX; Schema: public; Owner: captionai
--

CREATE INDEX knox_authtoken_digest_188c7e77_like ON public.knox_authtoken USING btree (digest varchar_pattern_ops);


--
-- Name: knox_authtoken_salt_3d9f48ac_like; Type: INDEX; Schema: public; Owner: captionai
--

CREATE INDEX knox_authtoken_salt_3d9f48ac_like ON public.knox_authtoken USING btree (salt varchar_pattern_ops);


--
-- Name: knox_authtoken_token_key_8f4f7d47; Type: INDEX; Schema: public; Owner: captionai
--

CREATE INDEX knox_authtoken_token_key_8f4f7d47 ON public.knox_authtoken USING btree (token_key);


--
-- Name: knox_authtoken_token_key_8f4f7d47_like; Type: INDEX; Schema: public; Owner: captionai
--

CREATE INDEX knox_authtoken_token_key_8f4f7d47_like ON public.knox_authtoken USING btree (token_key varchar_pattern_ops);


--
-- Name: knox_authtoken_user_id_e5a5d899; Type: INDEX; Schema: public; Owner: captionai
--

CREATE INDEX knox_authtoken_user_id_e5a5d899 ON public.knox_authtoken USING btree (user_id);


--
-- Name: reports_commentreport_comment_id_2977d957; Type: INDEX; Schema: public; Owner: captionai
--

CREATE INDEX reports_commentreport_comment_id_2977d957 ON public.reports_commentreport USING btree (comment_id);


--
-- Name: reports_commentreport_reviewer_id_2809fa71; Type: INDEX; Schema: public; Owner: captionai
--

CREATE INDEX reports_commentreport_reviewer_id_2809fa71 ON public.reports_commentreport USING btree (reviewer_id);


--
-- Name: reports_commentreport_user_id_71bd9c4f; Type: INDEX; Schema: public; Owner: captionai
--

CREATE INDEX reports_commentreport_user_id_71bd9c4f ON public.reports_commentreport USING btree (user_id);


--
-- Name: reports_imagereport_image_id_f22d7751; Type: INDEX; Schema: public; Owner: captionai
--

CREATE INDEX reports_imagereport_image_id_f22d7751 ON public.reports_imagereport USING btree (image_id);


--
-- Name: reports_imagereport_reviewer_id_49c79ff6; Type: INDEX; Schema: public; Owner: captionai
--

CREATE INDEX reports_imagereport_reviewer_id_49c79ff6 ON public.reports_imagereport USING btree (reviewer_id);


--
-- Name: reports_imagereport_user_id_e2814a20; Type: INDEX; Schema: public; Owner: captionai
--

CREATE INDEX reports_imagereport_user_id_e2814a20 ON public.reports_imagereport USING btree (user_id);


--
-- Name: accounts_profile_following accounts_profile_fol_profile_id_8b8b18f9_fk_accounts_; Type: FK CONSTRAINT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.accounts_profile_following
    ADD CONSTRAINT accounts_profile_fol_profile_id_8b8b18f9_fk_accounts_ FOREIGN KEY (profile_id) REFERENCES public.accounts_profile(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_profile_following accounts_profile_following_user_id_64d3b561_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.accounts_profile_following
    ADD CONSTRAINT accounts_profile_following_user_id_64d3b561_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_profile accounts_profile_image_id_798b65f5_fk_images_image_uuid; Type: FK CONSTRAINT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.accounts_profile
    ADD CONSTRAINT accounts_profile_image_id_798b65f5_fk_images_image_uuid FOREIGN KEY (image_id) REFERENCES public.images_image(uuid) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_profile_interests accounts_profile_int_collection_id_719c95a9_fk_images_co; Type: FK CONSTRAINT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.accounts_profile_interests
    ADD CONSTRAINT accounts_profile_int_collection_id_719c95a9_fk_images_co FOREIGN KEY (collection_id) REFERENCES public.images_collection(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_profile_interests accounts_profile_int_profile_id_e30c47b7_fk_accounts_; Type: FK CONSTRAINT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.accounts_profile_interests
    ADD CONSTRAINT accounts_profile_int_profile_id_e30c47b7_fk_accounts_ FOREIGN KEY (profile_id) REFERENCES public.accounts_profile(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_profile accounts_profile_user_id_49a85d32_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.accounts_profile
    ADD CONSTRAINT accounts_profile_user_id_49a85d32_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_group_id_97559544_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_user_id_6a12ed8b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: images_caption images_caption_image_id_1f658727_fk_images_image_uuid; Type: FK CONSTRAINT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.images_caption
    ADD CONSTRAINT images_caption_image_id_1f658727_fk_images_image_uuid FOREIGN KEY (image_id) REFERENCES public.images_image(uuid) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: images_collection images_collection_creator_id_cf5345d8_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.images_collection
    ADD CONSTRAINT images_collection_creator_id_cf5345d8_fk_auth_user_id FOREIGN KEY (creator_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: images_comment images_comment_commenter_id_cc454f1f_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.images_comment
    ADD CONSTRAINT images_comment_commenter_id_cc454f1f_fk_auth_user_id FOREIGN KEY (commenter_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: images_comment_dislikes images_comment_disli_comment_id_c1d39ad3_fk_images_co; Type: FK CONSTRAINT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.images_comment_dislikes
    ADD CONSTRAINT images_comment_disli_comment_id_c1d39ad3_fk_images_co FOREIGN KEY (comment_id) REFERENCES public.images_comment(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: images_comment_dislikes images_comment_dislikes_user_id_2b903b1a_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.images_comment_dislikes
    ADD CONSTRAINT images_comment_dislikes_user_id_2b903b1a_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: images_comment images_comment_image_id_be8a671b_fk_images_image_uuid; Type: FK CONSTRAINT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.images_comment
    ADD CONSTRAINT images_comment_image_id_be8a671b_fk_images_image_uuid FOREIGN KEY (image_id) REFERENCES public.images_image(uuid) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: images_comment_likes images_comment_likes_comment_id_0103705e_fk_images_comment_id; Type: FK CONSTRAINT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.images_comment_likes
    ADD CONSTRAINT images_comment_likes_comment_id_0103705e_fk_images_comment_id FOREIGN KEY (comment_id) REFERENCES public.images_comment(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: images_comment_likes images_comment_likes_user_id_0770bc97_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.images_comment_likes
    ADD CONSTRAINT images_comment_likes_user_id_0770bc97_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: images_image_collections images_image_collect_collection_id_ed3dfc79_fk_images_co; Type: FK CONSTRAINT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.images_image_collections
    ADD CONSTRAINT images_image_collect_collection_id_ed3dfc79_fk_images_co FOREIGN KEY (collection_id) REFERENCES public.images_collection(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: images_image_collections images_image_collections_image_id_b4013e9e_fk_images_image_uuid; Type: FK CONSTRAINT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.images_image_collections
    ADD CONSTRAINT images_image_collections_image_id_b4013e9e_fk_images_image_uuid FOREIGN KEY (image_id) REFERENCES public.images_image(uuid) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: images_image_dislikes images_image_dislikes_image_id_5d681cde_fk_images_image_uuid; Type: FK CONSTRAINT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.images_image_dislikes
    ADD CONSTRAINT images_image_dislikes_image_id_5d681cde_fk_images_image_uuid FOREIGN KEY (image_id) REFERENCES public.images_image(uuid) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: images_image_dislikes images_image_dislikes_user_id_6b4f7834_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.images_image_dislikes
    ADD CONSTRAINT images_image_dislikes_user_id_6b4f7834_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: images_image_likes images_image_likes_image_id_fef2fdea_fk_images_image_uuid; Type: FK CONSTRAINT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.images_image_likes
    ADD CONSTRAINT images_image_likes_image_id_fef2fdea_fk_images_image_uuid FOREIGN KEY (image_id) REFERENCES public.images_image(uuid) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: images_image_likes images_image_likes_user_id_24c46dc2_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.images_image_likes
    ADD CONSTRAINT images_image_likes_user_id_24c46dc2_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: images_image images_image_uploader_id_9c914939_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.images_image
    ADD CONSTRAINT images_image_uploader_id_9c914939_fk_auth_user_id FOREIGN KEY (uploader_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: knox_authtoken knox_authtoken_user_id_e5a5d899_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.knox_authtoken
    ADD CONSTRAINT knox_authtoken_user_id_e5a5d899_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: reports_commentreport reports_commentreport_comment_id_2977d957_fk_images_comment_id; Type: FK CONSTRAINT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.reports_commentreport
    ADD CONSTRAINT reports_commentreport_comment_id_2977d957_fk_images_comment_id FOREIGN KEY (comment_id) REFERENCES public.images_comment(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: reports_commentreport reports_commentreport_reviewer_id_2809fa71_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.reports_commentreport
    ADD CONSTRAINT reports_commentreport_reviewer_id_2809fa71_fk_auth_user_id FOREIGN KEY (reviewer_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: reports_commentreport reports_commentreport_user_id_71bd9c4f_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.reports_commentreport
    ADD CONSTRAINT reports_commentreport_user_id_71bd9c4f_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: reports_imagereport reports_imagereport_image_id_f22d7751_fk_images_image_uuid; Type: FK CONSTRAINT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.reports_imagereport
    ADD CONSTRAINT reports_imagereport_image_id_f22d7751_fk_images_image_uuid FOREIGN KEY (image_id) REFERENCES public.images_image(uuid) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: reports_imagereport reports_imagereport_reviewer_id_49c79ff6_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.reports_imagereport
    ADD CONSTRAINT reports_imagereport_reviewer_id_49c79ff6_fk_auth_user_id FOREIGN KEY (reviewer_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: reports_imagereport reports_imagereport_user_id_e2814a20_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: captionai
--

ALTER TABLE ONLY public.reports_imagereport
    ADD CONSTRAINT reports_imagereport_user_id_e2814a20_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: captionai
--

REVOKE ALL ON SCHEMA public FROM rdsadmin;
REVOKE ALL ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO captionai;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

