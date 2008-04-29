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
-- Name: staff_group_staff_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: godless
--

SELECT pg_catalog.setval('staff_group_staff_group_id_seq', 19, true);


--
-- Data for Name: staff_group; Type: TABLE DATA; Schema: public; Owner: godless
--

COPY staff_group (staff_group_id, group_name, group_descr, show_staff_group, order_by) FROM stdin;
1	Bossu		Y	-1
\.


--
-- PostgreSQL database dump complete
--

