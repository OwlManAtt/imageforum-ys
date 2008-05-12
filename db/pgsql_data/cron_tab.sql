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
-- Name: cron_tab_cron_tab_id_seq; Type: SEQUENCE SET; Schema: public; Owner: godless
--

SELECT pg_catalog.setval('cron_tab_cron_tab_id_seq', 2, true);


--
-- Data for Name: cron_tab; Type: TABLE DATA; Schema: public; Owner: godless
--

COPY cron_tab (cron_tab_id, cron_class, cron_frequency_seconds, unixtime_next_run, enabled) FROM stdin;
1	Job_RestockShops	3600	1208734668	Y
2	Job_UserOnline	300	1210554705	Y
\.


--
-- PostgreSQL database dump complete
--

