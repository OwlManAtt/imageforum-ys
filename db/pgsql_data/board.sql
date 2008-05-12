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

SELECT pg_catalog.setval('board_board_id_seq', 13, true);


--
-- Data for Name: board; Type: TABLE DATA; Schema: public; Owner: godless
--

COPY board (board_id, board_category_id, board_name, board_rules, board_locked, news_source, required_permission_id, order_by, board_short_name, hidden_board) FROM stdin;
13	5	TGI News		Y	Y	0	0	news	Y
12	7	General/Offtopic	* Anything can be posted/discussed here.\n* The global site rules still apply.	N	N	0	0	gen	N
11	7	Hentai/Ecchi	* Discussion and posting of hentai/ecchi images may occur here.\n* Requests are allowed.\n* No furries are allowed.	N	N	0	1	h	N
8	5	Animu/Mangay	* Discussion of animu, mangay, and other weeaboo things may take place here.\n* Trolling is encouraged.\n* **This board is worksafe**. Hentai and ecchi images will be moved to the appropriate board or deleted outright.	N	N	0	1	a	N
10	5	Computer Science III	* Software, programming, hardware, and vaporware may be discussed here. \n* Vi is better than emacs.\n* KDE is better than GNOME.\n* **This board is worksafe**.	N	N	0	3	g	N
9	5	News & Politics	* Politics (not limited to the US!), current events, and history may be discussed here.\n* Where possible, cite sources.\n* Nobody gives a shit about Brittney Spears.\n* **This board is worksafe**. However, gore/etc may be posted if it is relevant to the topic at hand.	N	N	0	5	poli	N
\.


--
-- PostgreSQL database dump complete
--

