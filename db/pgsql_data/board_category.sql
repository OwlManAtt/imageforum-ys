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
-- Name: board_category_board_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: godless
--

SELECT pg_catalog.setval('board_category_board_category_id_seq', 3, true);


--
-- Data for Name: board_category; Type: TABLE DATA; Schema: public; Owner: godless
--

COPY board_category (board_category_id, category_name, order_by, required_permission_id) FROM stdin;
\.


--
-- PostgreSQL database dump complete
--

