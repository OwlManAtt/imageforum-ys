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
-- Name: jump_page_jump_page_id_seq; Type: SEQUENCE SET; Schema: public; Owner: godless
--

SELECT pg_catalog.setval('jump_page_jump_page_id_seq', 71, true);


--
-- Data for Name: jump_page; Type: TABLE DATA; Schema: public; Owner: godless
--

COPY jump_page (jump_page_id, page_title, page_html_title, layout_type, page_slug, access_level, restricted_permission_api_name, php_script, include_tinymce, active) FROM stdin;
1	Home	Home	deep	home	public		meta/home.php	N	Y
2	Register	Register	deep	register	public		user/register.php	N	Y
3	Logoff	Logoff	deep	logoff	user		user/logout.php	N	Y
4	Login	Login	deep	login	public		user/login.php	N	Y
14	Profile	Profile	deep	profile	user		user/profile.php	N	Y
29	Notices	Notices	deep	notice	user		user/notices.php	N	Y
32	Boards	Boards	deep	boards	user		boards/board_list.php	N	Y
33	Boards	Boards	deep	threads	user		boards/thread_list.php	N	Y
34	Boards	Boards	deep	thread	user		boards/post_list.php	Y	Y
35	Boards - Reply	Boards - Reply	deep	thread-reply	user		boards/reply.php	N	Y
36	Create Thread	Create Thread	deep	new-thread	user		boards/create_thread.php	Y	Y
37	Forum Moderation	Forum Moderation	deep	forum-admin	restricted	moderate	boards/moderation.php	N	Y
38	Edit Post	Edit Post	deep	edit-post	user		boards/edit_post.php	Y	Y
39	Edit Thread	Edit Thread	deep	edit-thread	user		boards/edit_thread.php	N	Y
40	Preferences	Preferences	deep	preferences	user		user/preferences.php	Y	Y
43	News	News	deep	news	public		news/list.php	N	Y
44	Messages	Messages	deep	messages	user		messages/list.php	N	Y
45	Compose Message	Compose Message	deep	write-message	user		messages/write.php	Y	Y
46	Send Message	Send Message	deep	send-message	user		messages/send.php	N	Y
47	Read Message	Read Message	deep	message	user		messages/view.php	N	Y
48	Admin Overview	Admin Overview	deep	admin	restricted	admin_panel	admin/links.php	N	Y
49	Permission Editor	Permission Editor	deep	admin-permissions	restricted	manage_permissions	admin/permissions/home.php	N	Y
52	User Admin	User Admin	deep	admin-users	restricted	manage_users	admin/user/home.php	Y	Y
53	Board Admin	Board Admin	deep	admin-boards	restricted	manage_boards	admin/boards/home.php	N	Y
56	Permission Editor	Permission Editor	deep	admin-permissions-edit	restricted	manage_permissions	admin/permissions/edit.php	Y	Y
57	Board Creator	Board Creator	deep	admin-boards-create	restricted	manage_boards	admin/boards/create.php	N	N
61	Board Editor	Board Editor	deep	admin-boards-edit	restricted	manage_boards	admin/boards/edit.php	Y	Y
67	Staff	Staff	deep	staff	public		meta/staff.php	N	Y
68	Reset Password	Reset Password	deep	reset-password	public		user/forgot_password.php	N	Y
69	Terms and Conditions	Terms and Conditions	deep	terms-and-conditions	public		meta/terms.php	N	Y
70	Online Users	Online Users	deep	online	public		meta/online.php	N	Y
71	Search	Search	deep	search	user		meta/search.php	N	Y
\.


--
-- PostgreSQL database dump complete
--

