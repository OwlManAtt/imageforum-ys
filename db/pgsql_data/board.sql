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

SELECT pg_catalog.setval('board_board_id_seq', 12, true);


--
-- Data for Name: board; Type: TABLE DATA; Schema: public; Owner: godless
--

COPY board (board_id, board_category_id, board_name, board_descr, board_locked, news_source, required_permission_id, order_by, board_short_name) FROM stdin;
8	5	Animu/Mangay		N	N	0	1	a
9	5	News & Politics		N	N	0	5	poli
10	5	Computer Science III		N	N	0	3	g
11	7	Hentai/Ecchi/XTREME		N	N	0	1	h
12	7	General/Offtopic		N	N	0	0	gen
\.


--
-- PostgreSQL database dump complete
--

