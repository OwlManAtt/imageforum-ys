--
-- PostgreSQL database dump
--

SET client_encoding = 'SQL_ASCII';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- Name: plpgsql; Type: PROCEDURAL LANGUAGE; Schema: -; Owner: postgres
--

CREATE PROCEDURAL LANGUAGE plpgsql;


ALTER PROCEDURAL LANGUAGE plpgsql OWNER TO postgres;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: avatar; Type: TABLE; Schema: public; Owner: godless; Tablespace: 
--

CREATE TABLE avatar (
    avatar_id integer NOT NULL,
    avatar_name character varying(50) NOT NULL,
    avatar_image character varying(50) NOT NULL,
    active character(1) DEFAULT 'Y'::bpchar NOT NULL,
    CONSTRAINT avatar_active_check CHECK ((active = ANY (ARRAY['Y'::bpchar, 'N'::bpchar])))
);


ALTER TABLE public.avatar OWNER TO godless;

--
-- Name: board; Type: TABLE; Schema: public; Owner: godless; Tablespace: 
--

CREATE TABLE board (
    board_id integer NOT NULL,
    board_category_id integer NOT NULL,
    board_name character varying(100) NOT NULL,
    board_rules text NOT NULL,
    board_locked character(1) DEFAULT 'N'::bpchar NOT NULL,
    news_source character(1) DEFAULT 'N'::bpchar NOT NULL,
    required_permission_id integer NOT NULL,
    order_by integer NOT NULL,
    board_short_name character varying(6) NOT NULL,
    hidden_board character(1) DEFAULT 'N'::bpchar NOT NULL,
    CONSTRAINT board_board_locked_check CHECK ((board_locked = ANY (ARRAY['Y'::bpchar, 'N'::bpchar]))),
    CONSTRAINT board_hidden_board_check CHECK ((hidden_board = ANY (ARRAY['N'::bpchar, 'Y'::bpchar]))),
    CONSTRAINT board_news_source_check CHECK ((news_source = ANY (ARRAY['Y'::bpchar, 'N'::bpchar])))
);


ALTER TABLE public.board OWNER TO godless;

--
-- Name: board_category; Type: TABLE; Schema: public; Owner: godless; Tablespace: 
--

CREATE TABLE board_category (
    board_category_id integer NOT NULL,
    category_name character varying(50) NOT NULL,
    order_by integer DEFAULT 0 NOT NULL,
    required_permission_id integer NOT NULL
);


ALTER TABLE public.board_category OWNER TO godless;

--
-- Name: board_thread; Type: TABLE; Schema: public; Owner: godless; Tablespace: 
--

CREATE TABLE board_thread (
    board_thread_id integer NOT NULL,
    board_id integer NOT NULL,
    thread_name character varying(80) NOT NULL,
    user_id integer NOT NULL,
    thread_created_datetime timestamp without time zone NOT NULL,
    thread_last_posted_datetime timestamp without time zone NOT NULL,
    stickied integer DEFAULT 0 NOT NULL,
    locked character(1) DEFAULT 'N'::bpchar NOT NULL,
    poster_type character varying(10) DEFAULT 'user'::character varying NOT NULL,
    CONSTRAINT board_thread_locked_check CHECK ((locked = ANY (ARRAY['N'::bpchar, 'Y'::bpchar]))),
    CONSTRAINT board_thread_stickied_check CHECK ((stickied = ANY (ARRAY[0, 1]))),
    CONSTRAINT poster_type_check CHECK (((poster_type)::text = ANY ((ARRAY['user'::character varying, 'anonymous'::character varying])::text[])))
);


ALTER TABLE public.board_thread OWNER TO godless;

--
-- Name: board_thread_post; Type: TABLE; Schema: public; Owner: godless; Tablespace: 
--

CREATE TABLE board_thread_post (
    board_thread_post_id integer NOT NULL,
    board_thread_id integer NOT NULL,
    user_id integer NOT NULL,
    posted_datetime timestamp without time zone NOT NULL,
    post_text text NOT NULL,
    poster_type character varying(10) DEFAULT 'user'::character varying NOT NULL,
    board_thread_post_image_id integer DEFAULT 0 NOT NULL,
    CONSTRAINT poster_type_check CHECK (((poster_type)::text = ANY ((ARRAY['user'::character varying, 'anonymous'::character varying])::text[])))
);


ALTER TABLE public.board_thread_post OWNER TO godless;

--
-- Name: board_thread_post_image; Type: TABLE; Schema: public; Owner: godless; Tablespace: 
--

CREATE TABLE board_thread_post_image (
    board_thread_post_image_id integer NOT NULL,
    image_hash character(32) NOT NULL,
    image_height integer DEFAULT 0 NOT NULL,
    image_width integer DEFAULT 0 NOT NULL,
    image_original_name character varying(200) NOT NULL,
    image_size_bytes bigint DEFAULT 0 NOT NULL,
    image_extension character(3) NOT NULL,
    CONSTRAINT board_thread_post_image_image_extension_check CHECK ((image_extension = ANY (ARRAY['png'::bpchar, 'gif'::bpchar, 'jpg'::bpchar])))
);


ALTER TABLE public.board_thread_post_image OWNER TO godless;

--
-- Name: cron_tab; Type: TABLE; Schema: public; Owner: godless; Tablespace: 
--

CREATE TABLE cron_tab (
    cron_tab_id integer NOT NULL,
    cron_class character varying(50) NOT NULL,
    cron_frequency_seconds integer NOT NULL,
    unixtime_next_run integer NOT NULL,
    enabled character(1) DEFAULT 'Y'::bpchar NOT NULL,
    CONSTRAINT cron_tab_enabled_check CHECK ((enabled = ANY (ARRAY['Y'::bpchar, 'N'::bpchar])))
);


ALTER TABLE public.cron_tab OWNER TO godless;

--
-- Name: datetime_format; Type: TABLE; Schema: public; Owner: godless; Tablespace: 
--

CREATE TABLE datetime_format (
    datetime_format_id integer NOT NULL,
    datetime_format_name character varying(30) NOT NULL,
    datetime_format text NOT NULL
);


ALTER TABLE public.datetime_format OWNER TO godless;

--
-- Name: jump_page; Type: TABLE; Schema: public; Owner: godless; Tablespace: 
--

CREATE TABLE jump_page (
    jump_page_id integer NOT NULL,
    page_title character varying(50) DEFAULT ''::character varying NOT NULL,
    page_html_title character varying(255) DEFAULT ''::character varying NOT NULL,
    layout_type character varying(5) DEFAULT 'deep'::bpchar NOT NULL,
    page_slug character varying(25) DEFAULT ''::character varying NOT NULL,
    access_level character varying(10) DEFAULT 'user'::bpchar NOT NULL,
    restricted_permission_api_name character varying(35) NOT NULL,
    php_script character varying(100) DEFAULT ''::character varying NOT NULL,
    active character(1) DEFAULT 'Y'::bpchar NOT NULL,
    CONSTRAINT jump_page_access_level_check CHECK (((access_level)::bpchar = ANY (ARRAY['restricted'::bpchar, 'user'::bpchar, 'public'::bpchar]))),
    CONSTRAINT jump_page_active_check CHECK ((active = ANY (ARRAY['Y'::bpchar, 'N'::bpchar]))),
    CONSTRAINT jump_page_layout_type_check CHECK (((layout_type)::bpchar = ANY (ARRAY['basic'::bpchar, 'deep'::bpchar])))
);


ALTER TABLE public.jump_page OWNER TO godless;

--
-- Name: staff_group; Type: TABLE; Schema: public; Owner: godless; Tablespace: 
--

CREATE TABLE staff_group (
    staff_group_id integer NOT NULL,
    group_name character varying(50) NOT NULL,
    group_descr text NOT NULL,
    show_staff_group character(1) DEFAULT 'Y'::bpchar NOT NULL,
    order_by integer DEFAULT 0 NOT NULL,
    CONSTRAINT staff_group_show_staff_group_check CHECK ((show_staff_group = ANY (ARRAY['Y'::bpchar, 'N'::bpchar])))
);


ALTER TABLE public.staff_group OWNER TO godless;

--
-- Name: staff_group_staff_permission; Type: TABLE; Schema: public; Owner: godless; Tablespace: 
--

CREATE TABLE staff_group_staff_permission (
    staff_group_staff_permission integer NOT NULL,
    staff_group_id integer NOT NULL,
    staff_permission_id integer NOT NULL
);


ALTER TABLE public.staff_group_staff_permission OWNER TO godless;

--
-- Name: staff_permission; Type: TABLE; Schema: public; Owner: godless; Tablespace: 
--

CREATE TABLE staff_permission (
    staff_permission_id integer NOT NULL,
    api_name character varying(50) NOT NULL,
    permission_name character varying(50) NOT NULL
);


ALTER TABLE public.staff_permission OWNER TO godless;

--
-- Name: timezone; Type: TABLE; Schema: public; Owner: godless; Tablespace: 
--

CREATE TABLE timezone (
    timezone_id integer NOT NULL,
    timezone_short_name character varying(4) NOT NULL,
    timezone_long_name character varying(32) NOT NULL,
    timezone_continent character varying(13) NOT NULL,
    timezone_offset real NOT NULL,
    order_by integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.timezone OWNER TO godless;

--
-- Name: user; Type: TABLE; Schema: public; Owner: godless; Tablespace: 
--

CREATE TABLE "user" (
    user_id integer NOT NULL,
    user_name character varying(25) NOT NULL,
    password_hash character(32) DEFAULT NULL::bpchar,
    password_hash_salt character(32) NOT NULL,
    current_salt character(32) NOT NULL,
    current_salt_expiration timestamp without time zone NOT NULL,
    registered_ip_addr character varying(16) DEFAULT NULL::character varying,
    last_ip_addr character varying(16) NOT NULL,
    last_activity timestamp without time zone NOT NULL,
    access_level character varying(4) DEFAULT 'user'::character varying NOT NULL,
    email text NOT NULL,
    profile text NOT NULL,
    signature text NOT NULL,
    avatar_id integer NOT NULL,
    user_title character varying(20) DEFAULT 'User'::character varying NOT NULL,
    datetime_created timestamp without time zone NOT NULL,
    post_count integer NOT NULL,
    datetime_last_post timestamp without time zone NOT NULL,
    timezone_id integer NOT NULL,
    datetime_format_id integer NOT NULL,
    password_reset_requested timestamp without time zone NOT NULL,
    password_reset_confirm character varying(32) NOT NULL,
    show_online_status character(1) DEFAULT 'Y'::bpchar NOT NULL,
    default_post_as character varying(10) DEFAULT 'user'::character varying NOT NULL,
    CONSTRAINT default_post_as_check CHECK (((default_post_as)::text = ANY ((ARRAY['user'::character varying, 'anonymous'::character varying])::text[]))),
    CONSTRAINT user_access_level_check CHECK (((access_level)::text = ANY ((ARRAY['banned'::character varying, 'user'::character varying])::text[]))),
    CONSTRAINT user_show_online_status_check CHECK ((show_online_status = ANY (ARRAY['Y'::bpchar, 'N'::bpchar])))
);


ALTER TABLE public."user" OWNER TO godless;

--
-- Name: user_message; Type: TABLE; Schema: public; Owner: godless; Tablespace: 
--

CREATE TABLE user_message (
    user_message_id integer NOT NULL,
    sender_user_id integer NOT NULL,
    recipient_user_id integer NOT NULL,
    recipient_list text NOT NULL,
    message_title character varying(255) NOT NULL,
    message_body text NOT NULL,
    sent_at timestamp without time zone NOT NULL,
    message_read character(1) DEFAULT 'N'::bpchar NOT NULL,
    CONSTRAINT user_message_message_read_check CHECK ((message_read = ANY (ARRAY['N'::bpchar, 'Y'::bpchar])))
);


ALTER TABLE public.user_message OWNER TO godless;

--
-- Name: user_online; Type: TABLE; Schema: public; Owner: godless; Tablespace: 
--

CREATE TABLE user_online (
    user_online_id integer NOT NULL,
    user_type character varying(5) DEFAULT 'guest'::character varying NOT NULL,
    user_id integer NOT NULL,
    client_ip character varying(15) NOT NULL,
    client_user_agent character varying(255) NOT NULL,
    datetime_last_active timestamp without time zone NOT NULL,
    CONSTRAINT user_online_user_type_check CHECK (((user_type)::text = ANY ((ARRAY['user'::character varying, 'guest'::character varying])::text[])))
);


ALTER TABLE public.user_online OWNER TO godless;

--
-- Name: user_staff_group; Type: TABLE; Schema: public; Owner: godless; Tablespace: 
--

CREATE TABLE user_staff_group (
    user_staff_group_id integer NOT NULL,
    user_id integer NOT NULL,
    staff_group_id integer NOT NULL
);


ALTER TABLE public.user_staff_group OWNER TO godless;

--
-- Name: avatar_avatar_id_seq; Type: SEQUENCE; Schema: public; Owner: godless
--

CREATE SEQUENCE avatar_avatar_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.avatar_avatar_id_seq OWNER TO godless;

--
-- Name: avatar_avatar_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: godless
--

ALTER SEQUENCE avatar_avatar_id_seq OWNED BY avatar.avatar_id;


--
-- Name: board_board_id_seq; Type: SEQUENCE; Schema: public; Owner: godless
--

CREATE SEQUENCE board_board_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.board_board_id_seq OWNER TO godless;

--
-- Name: board_board_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: godless
--

ALTER SEQUENCE board_board_id_seq OWNED BY board.board_id;


--
-- Name: board_category_board_category_id_seq; Type: SEQUENCE; Schema: public; Owner: godless
--

CREATE SEQUENCE board_category_board_category_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.board_category_board_category_id_seq OWNER TO godless;

--
-- Name: board_category_board_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: godless
--

ALTER SEQUENCE board_category_board_category_id_seq OWNED BY board_category.board_category_id;


--
-- Name: board_thread_board_thread_id_seq; Type: SEQUENCE; Schema: public; Owner: godless
--

CREATE SEQUENCE board_thread_board_thread_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.board_thread_board_thread_id_seq OWNER TO godless;

--
-- Name: board_thread_board_thread_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: godless
--

ALTER SEQUENCE board_thread_board_thread_id_seq OWNED BY board_thread.board_thread_id;


--
-- Name: board_thread_post_board_thread_post_id_seq; Type: SEQUENCE; Schema: public; Owner: godless
--

CREATE SEQUENCE board_thread_post_board_thread_post_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.board_thread_post_board_thread_post_id_seq OWNER TO godless;

--
-- Name: board_thread_post_board_thread_post_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: godless
--

ALTER SEQUENCE board_thread_post_board_thread_post_id_seq OWNED BY board_thread_post.board_thread_post_id;


--
-- Name: board_thread_post_image_board_thread_post_image_id_seq; Type: SEQUENCE; Schema: public; Owner: godless
--

CREATE SEQUENCE board_thread_post_image_board_thread_post_image_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.board_thread_post_image_board_thread_post_image_id_seq OWNER TO godless;

--
-- Name: board_thread_post_image_board_thread_post_image_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: godless
--

ALTER SEQUENCE board_thread_post_image_board_thread_post_image_id_seq OWNED BY board_thread_post_image.board_thread_post_image_id;


--
-- Name: cron_tab_cron_tab_id_seq; Type: SEQUENCE; Schema: public; Owner: godless
--

CREATE SEQUENCE cron_tab_cron_tab_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.cron_tab_cron_tab_id_seq OWNER TO godless;

--
-- Name: cron_tab_cron_tab_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: godless
--

ALTER SEQUENCE cron_tab_cron_tab_id_seq OWNED BY cron_tab.cron_tab_id;


--
-- Name: datetime_format_datetime_format_id_seq; Type: SEQUENCE; Schema: public; Owner: godless
--

CREATE SEQUENCE datetime_format_datetime_format_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.datetime_format_datetime_format_id_seq OWNER TO godless;

--
-- Name: datetime_format_datetime_format_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: godless
--

ALTER SEQUENCE datetime_format_datetime_format_id_seq OWNED BY datetime_format.datetime_format_id;


--
-- Name: jump_page_jump_page_id_seq; Type: SEQUENCE; Schema: public; Owner: godless
--

CREATE SEQUENCE jump_page_jump_page_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.jump_page_jump_page_id_seq OWNER TO godless;

--
-- Name: jump_page_jump_page_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: godless
--

ALTER SEQUENCE jump_page_jump_page_id_seq OWNED BY jump_page.jump_page_id;


--
-- Name: staff_group_staff_group_id_seq; Type: SEQUENCE; Schema: public; Owner: godless
--

CREATE SEQUENCE staff_group_staff_group_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.staff_group_staff_group_id_seq OWNER TO godless;

--
-- Name: staff_group_staff_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: godless
--

ALTER SEQUENCE staff_group_staff_group_id_seq OWNED BY staff_group.staff_group_id;


--
-- Name: staff_group_staff_permission_staff_group_staff_permission_seq; Type: SEQUENCE; Schema: public; Owner: godless
--

CREATE SEQUENCE staff_group_staff_permission_staff_group_staff_permission_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.staff_group_staff_permission_staff_group_staff_permission_seq OWNER TO godless;

--
-- Name: staff_group_staff_permission_staff_group_staff_permission_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: godless
--

ALTER SEQUENCE staff_group_staff_permission_staff_group_staff_permission_seq OWNED BY staff_group_staff_permission.staff_group_staff_permission;


--
-- Name: staff_permission_staff_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: godless
--

CREATE SEQUENCE staff_permission_staff_permission_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.staff_permission_staff_permission_id_seq OWNER TO godless;

--
-- Name: staff_permission_staff_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: godless
--

ALTER SEQUENCE staff_permission_staff_permission_id_seq OWNED BY staff_permission.staff_permission_id;


--
-- Name: timezone_timezone_id_seq; Type: SEQUENCE; Schema: public; Owner: godless
--

CREATE SEQUENCE timezone_timezone_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.timezone_timezone_id_seq OWNER TO godless;

--
-- Name: timezone_timezone_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: godless
--

ALTER SEQUENCE timezone_timezone_id_seq OWNED BY timezone.timezone_id;


--
-- Name: user_message_user_message_id_seq; Type: SEQUENCE; Schema: public; Owner: godless
--

CREATE SEQUENCE user_message_user_message_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.user_message_user_message_id_seq OWNER TO godless;

--
-- Name: user_message_user_message_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: godless
--

ALTER SEQUENCE user_message_user_message_id_seq OWNED BY user_message.user_message_id;


--
-- Name: user_online_user_online_id_seq; Type: SEQUENCE; Schema: public; Owner: godless
--

CREATE SEQUENCE user_online_user_online_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.user_online_user_online_id_seq OWNER TO godless;

--
-- Name: user_online_user_online_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: godless
--

ALTER SEQUENCE user_online_user_online_id_seq OWNED BY user_online.user_online_id;


--
-- Name: user_staff_group_user_staff_group_id_seq; Type: SEQUENCE; Schema: public; Owner: godless
--

CREATE SEQUENCE user_staff_group_user_staff_group_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.user_staff_group_user_staff_group_id_seq OWNER TO godless;

--
-- Name: user_staff_group_user_staff_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: godless
--

ALTER SEQUENCE user_staff_group_user_staff_group_id_seq OWNED BY user_staff_group.user_staff_group_id;


--
-- Name: user_user_id_seq; Type: SEQUENCE; Schema: public; Owner: godless
--

CREATE SEQUENCE user_user_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.user_user_id_seq OWNER TO godless;

--
-- Name: user_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: godless
--

ALTER SEQUENCE user_user_id_seq OWNED BY "user".user_id;


--
-- Name: avatar_id; Type: DEFAULT; Schema: public; Owner: godless
--

ALTER TABLE avatar ALTER COLUMN avatar_id SET DEFAULT nextval('avatar_avatar_id_seq'::regclass);


--
-- Name: board_id; Type: DEFAULT; Schema: public; Owner: godless
--

ALTER TABLE board ALTER COLUMN board_id SET DEFAULT nextval('board_board_id_seq'::regclass);


--
-- Name: board_category_id; Type: DEFAULT; Schema: public; Owner: godless
--

ALTER TABLE board_category ALTER COLUMN board_category_id SET DEFAULT nextval('board_category_board_category_id_seq'::regclass);


--
-- Name: board_thread_id; Type: DEFAULT; Schema: public; Owner: godless
--

ALTER TABLE board_thread ALTER COLUMN board_thread_id SET DEFAULT nextval('board_thread_board_thread_id_seq'::regclass);


--
-- Name: board_thread_post_id; Type: DEFAULT; Schema: public; Owner: godless
--

ALTER TABLE board_thread_post ALTER COLUMN board_thread_post_id SET DEFAULT nextval('board_thread_post_board_thread_post_id_seq'::regclass);


--
-- Name: board_thread_post_image_id; Type: DEFAULT; Schema: public; Owner: godless
--

ALTER TABLE board_thread_post_image ALTER COLUMN board_thread_post_image_id SET DEFAULT nextval('board_thread_post_image_board_thread_post_image_id_seq'::regclass);


--
-- Name: cron_tab_id; Type: DEFAULT; Schema: public; Owner: godless
--

ALTER TABLE cron_tab ALTER COLUMN cron_tab_id SET DEFAULT nextval('cron_tab_cron_tab_id_seq'::regclass);


--
-- Name: datetime_format_id; Type: DEFAULT; Schema: public; Owner: godless
--

ALTER TABLE datetime_format ALTER COLUMN datetime_format_id SET DEFAULT nextval('datetime_format_datetime_format_id_seq'::regclass);


--
-- Name: jump_page_id; Type: DEFAULT; Schema: public; Owner: godless
--

ALTER TABLE jump_page ALTER COLUMN jump_page_id SET DEFAULT nextval('jump_page_jump_page_id_seq'::regclass);


--
-- Name: staff_group_id; Type: DEFAULT; Schema: public; Owner: godless
--

ALTER TABLE staff_group ALTER COLUMN staff_group_id SET DEFAULT nextval('staff_group_staff_group_id_seq'::regclass);


--
-- Name: staff_group_staff_permission; Type: DEFAULT; Schema: public; Owner: godless
--

ALTER TABLE staff_group_staff_permission ALTER COLUMN staff_group_staff_permission SET DEFAULT nextval('staff_group_staff_permission_staff_group_staff_permission_seq'::regclass);


--
-- Name: staff_permission_id; Type: DEFAULT; Schema: public; Owner: godless
--

ALTER TABLE staff_permission ALTER COLUMN staff_permission_id SET DEFAULT nextval('staff_permission_staff_permission_id_seq'::regclass);


--
-- Name: timezone_id; Type: DEFAULT; Schema: public; Owner: godless
--

ALTER TABLE timezone ALTER COLUMN timezone_id SET DEFAULT nextval('timezone_timezone_id_seq'::regclass);


--
-- Name: user_id; Type: DEFAULT; Schema: public; Owner: godless
--

ALTER TABLE "user" ALTER COLUMN user_id SET DEFAULT nextval('user_user_id_seq'::regclass);


--
-- Name: user_message_id; Type: DEFAULT; Schema: public; Owner: godless
--

ALTER TABLE user_message ALTER COLUMN user_message_id SET DEFAULT nextval('user_message_user_message_id_seq'::regclass);


--
-- Name: user_online_id; Type: DEFAULT; Schema: public; Owner: godless
--

ALTER TABLE user_online ALTER COLUMN user_online_id SET DEFAULT nextval('user_online_user_online_id_seq'::regclass);


--
-- Name: user_staff_group_id; Type: DEFAULT; Schema: public; Owner: godless
--

ALTER TABLE user_staff_group ALTER COLUMN user_staff_group_id SET DEFAULT nextval('user_staff_group_user_staff_group_id_seq'::regclass);


--
-- Name: avatar_avatar_image_key; Type: CONSTRAINT; Schema: public; Owner: godless; Tablespace: 
--

ALTER TABLE ONLY avatar
    ADD CONSTRAINT avatar_avatar_image_key UNIQUE (avatar_image);


--
-- Name: avatar_pkey; Type: CONSTRAINT; Schema: public; Owner: godless; Tablespace: 
--

ALTER TABLE ONLY avatar
    ADD CONSTRAINT avatar_pkey PRIMARY KEY (avatar_id);


--
-- Name: board_board_short_name_key; Type: CONSTRAINT; Schema: public; Owner: godless; Tablespace: 
--

ALTER TABLE ONLY board
    ADD CONSTRAINT board_board_short_name_key UNIQUE (board_short_name);


--
-- Name: board_category_pkey; Type: CONSTRAINT; Schema: public; Owner: godless; Tablespace: 
--

ALTER TABLE ONLY board_category
    ADD CONSTRAINT board_category_pkey PRIMARY KEY (board_category_id);


--
-- Name: board_pkey; Type: CONSTRAINT; Schema: public; Owner: godless; Tablespace: 
--

ALTER TABLE ONLY board
    ADD CONSTRAINT board_pkey PRIMARY KEY (board_id);


--
-- Name: board_thread_pkey; Type: CONSTRAINT; Schema: public; Owner: godless; Tablespace: 
--

ALTER TABLE ONLY board_thread
    ADD CONSTRAINT board_thread_pkey PRIMARY KEY (board_thread_id);


--
-- Name: board_thread_post_image_image_hash_key; Type: CONSTRAINT; Schema: public; Owner: godless; Tablespace: 
--

ALTER TABLE ONLY board_thread_post_image
    ADD CONSTRAINT board_thread_post_image_image_hash_key UNIQUE (image_hash);


--
-- Name: board_thread_post_image_pkey; Type: CONSTRAINT; Schema: public; Owner: godless; Tablespace: 
--

ALTER TABLE ONLY board_thread_post_image
    ADD CONSTRAINT board_thread_post_image_pkey PRIMARY KEY (board_thread_post_image_id);


--
-- Name: board_thread_post_pkey; Type: CONSTRAINT; Schema: public; Owner: godless; Tablespace: 
--

ALTER TABLE ONLY board_thread_post
    ADD CONSTRAINT board_thread_post_pkey PRIMARY KEY (board_thread_post_id);


--
-- Name: cron_tab_pkey; Type: CONSTRAINT; Schema: public; Owner: godless; Tablespace: 
--

ALTER TABLE ONLY cron_tab
    ADD CONSTRAINT cron_tab_pkey PRIMARY KEY (cron_tab_id);


--
-- Name: datetime_format_pkey; Type: CONSTRAINT; Schema: public; Owner: godless; Tablespace: 
--

ALTER TABLE ONLY datetime_format
    ADD CONSTRAINT datetime_format_pkey PRIMARY KEY (datetime_format_id);


--
-- Name: jump_page_page_slug_key; Type: CONSTRAINT; Schema: public; Owner: godless; Tablespace: 
--

ALTER TABLE ONLY jump_page
    ADD CONSTRAINT jump_page_page_slug_key UNIQUE (page_slug);


--
-- Name: jump_page_pkey; Type: CONSTRAINT; Schema: public; Owner: godless; Tablespace: 
--

ALTER TABLE ONLY jump_page
    ADD CONSTRAINT jump_page_pkey PRIMARY KEY (jump_page_id);


--
-- Name: staff_group_pkey; Type: CONSTRAINT; Schema: public; Owner: godless; Tablespace: 
--

ALTER TABLE ONLY staff_group
    ADD CONSTRAINT staff_group_pkey PRIMARY KEY (staff_group_id);


--
-- Name: staff_group_staff_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: godless; Tablespace: 
--

ALTER TABLE ONLY staff_group_staff_permission
    ADD CONSTRAINT staff_group_staff_permission_pkey PRIMARY KEY (staff_group_staff_permission);


--
-- Name: staff_group_staff_permission_staff_group_id_key; Type: CONSTRAINT; Schema: public; Owner: godless; Tablespace: 
--

ALTER TABLE ONLY staff_group_staff_permission
    ADD CONSTRAINT staff_group_staff_permission_staff_group_id_key UNIQUE (staff_group_id, staff_permission_id);


--
-- Name: staff_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: godless; Tablespace: 
--

ALTER TABLE ONLY staff_permission
    ADD CONSTRAINT staff_permission_pkey PRIMARY KEY (staff_permission_id);


--
-- Name: timezone_pkey; Type: CONSTRAINT; Schema: public; Owner: godless; Tablespace: 
--

ALTER TABLE ONLY timezone
    ADD CONSTRAINT timezone_pkey PRIMARY KEY (timezone_id);


--
-- Name: user_message_pkey; Type: CONSTRAINT; Schema: public; Owner: godless; Tablespace: 
--

ALTER TABLE ONLY user_message
    ADD CONSTRAINT user_message_pkey PRIMARY KEY (user_message_id);


--
-- Name: user_online_pkey; Type: CONSTRAINT; Schema: public; Owner: godless; Tablespace: 
--

ALTER TABLE ONLY user_online
    ADD CONSTRAINT user_online_pkey PRIMARY KEY (user_online_id);


--
-- Name: user_pkey; Type: CONSTRAINT; Schema: public; Owner: godless; Tablespace: 
--

ALTER TABLE ONLY "user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (user_id);


--
-- Name: user_staff_group_pkey; Type: CONSTRAINT; Schema: public; Owner: godless; Tablespace: 
--

ALTER TABLE ONLY user_staff_group
    ADD CONSTRAINT user_staff_group_pkey PRIMARY KEY (user_staff_group_id);


--
-- Name: user_staff_group_user_id_key; Type: CONSTRAINT; Schema: public; Owner: godless; Tablespace: 
--

ALTER TABLE ONLY user_staff_group
    ADD CONSTRAINT user_staff_group_user_id_key UNIQUE (user_id, staff_group_id);


--
-- Name: user_user_name_key; Type: CONSTRAINT; Schema: public; Owner: godless; Tablespace: 
--

ALTER TABLE ONLY "user"
    ADD CONSTRAINT user_user_name_key UNIQUE (user_name);


--
-- Name: board_category_id_index; Type: INDEX; Schema: public; Owner: godless; Tablespace: 
--

CREATE INDEX board_category_id_index ON board USING btree (board_category_id);


--
-- Name: board_thread__board_id; Type: INDEX; Schema: public; Owner: godless; Tablespace: 
--

CREATE INDEX board_thread__board_id ON board_thread USING btree (board_id);


--
-- Name: board_thread__user_id; Type: INDEX; Schema: public; Owner: godless; Tablespace: 
--

CREATE INDEX board_thread__user_id ON board_thread USING btree (user_id);


--
-- Name: board_thread_post__board_thread_id; Type: INDEX; Schema: public; Owner: godless; Tablespace: 
--

CREATE INDEX board_thread_post__board_thread_id ON board_thread_post USING btree (board_thread_id);


--
-- Name: board_thread_post__user_id; Type: INDEX; Schema: public; Owner: godless; Tablespace: 
--

CREATE INDEX board_thread_post__user_id ON board_thread_post USING btree (user_id);


--
-- Name: required_permission_id_category_index; Type: INDEX; Schema: public; Owner: godless; Tablespace: 
--

CREATE INDEX required_permission_id_category_index ON board_category USING btree (required_permission_id);


--
-- Name: required_permission_id_index; Type: INDEX; Schema: public; Owner: godless; Tablespace: 
--

CREATE INDEX required_permission_id_index ON board USING btree (required_permission_id);


--
-- Name: user__avatar_id; Type: INDEX; Schema: public; Owner: godless; Tablespace: 
--

CREATE INDEX user__avatar_id ON "user" USING btree (avatar_id);


--
-- Name: user__datetime_format_id; Type: INDEX; Schema: public; Owner: godless; Tablespace: 
--

CREATE INDEX user__datetime_format_id ON "user" USING btree (datetime_format_id);


--
-- Name: user__timezone_id; Type: INDEX; Schema: public; Owner: godless; Tablespace: 
--

CREATE INDEX user__timezone_id ON "user" USING btree (timezone_id);


--
-- Name: user_message__recipient_user_id; Type: INDEX; Schema: public; Owner: godless; Tablespace: 
--

CREATE INDEX user_message__recipient_user_id ON user_message USING btree (recipient_user_id);


--
-- Name: user_message__sender_user_id; Type: INDEX; Schema: public; Owner: godless; Tablespace: 
--

CREATE INDEX user_message__sender_user_id ON user_message USING btree (sender_user_id);


--
-- Name: user_online__client_ip; Type: INDEX; Schema: public; Owner: godless; Tablespace: 
--

CREATE INDEX user_online__client_ip ON user_online USING btree (client_ip);


--
-- Name: user_online__user_id; Type: INDEX; Schema: public; Owner: godless; Tablespace: 
--

CREATE INDEX user_online__user_id ON user_online USING btree (user_id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

