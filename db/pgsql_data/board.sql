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
-- Name: board_board_id_seq; Type: SEQUENCE SET; Schema: public; Owner: godless
--

SELECT pg_catalog.setval('board_board_id_seq', 7, true);


--
-- Data for Name: board; Type: TABLE DATA; Schema: public; Owner: godless
--

COPY board (board_id, board_category_id, board_name, board_descr, board_locked, news_source, required_permission_id, order_by) FROM stdin;
\.


--
-- PostgreSQL database dump complete
--

