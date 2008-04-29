--
-- PostgreSQL database dump
--

SET client_encoding = 'SQL_ASCII';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

SET search_path = public, pg_catalog;

--
-- Name: avatar_avatar_id_seq; Type: SEQUENCE SET; Schema: public; Owner: godless
--

SELECT pg_catalog.setval('avatar_avatar_id_seq', 2, true);


--
-- Data for Name: avatar; Type: TABLE DATA; Schema: public; Owner: godless
--

COPY avatar (avatar_id, avatar_name, avatar_image, active) FROM stdin;
\.


--
-- PostgreSQL database dump complete
--

