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

COPY jump_page (jump_page_id, page_title, page_html_title, layout_type, page_slug, access_level, restricted_permission_api_name, php_script, active) FROM stdin;
1	Home	Home	deep	home	public		meta/home.php	Y
2	Register	Register	deep	register	public		user/register.php	Y
3	Logoff	Logoff	deep	logoff	user		user/logout.php	Y
4	Login	Login	deep	login	public		user/login.php	Y
14	Profile	Profile	deep	profile	user		user/profile.php	Y
29	Notices	Notices	deep	notice	user		user/notices.php	Y
35	Boards - Reply	Boards - Reply	deep	thread-reply	user		boards/reply.php	Y
36	Create Thread	Create Thread	deep	new-thread	user		boards/create_thread.php	Y
37	Forum Moderation	Forum Moderation	deep	forum-admin	restricted	moderate	boards/moderation.php	Y
38	Edit Post	Edit Post	deep	edit-post	user		boards/edit_post.php	Y
39	Edit Thread	Edit Thread	deep	edit-thread	user		boards/edit_thread.php	Y
40	Preferences	Preferences	deep	preferences	user		user/preferences.php	Y
43	News	News	deep	news	public		news/list.php	Y
44	Messages	Messages	deep	messages	user		messages/list.php	Y
45	Compose Message	Compose Message	deep	write-message	user		messages/write.php	Y
46	Send Message	Send Message	deep	send-message	user		messages/send.php	Y
47	Read Message	Read Message	deep	message	user		messages/view.php	Y
48	Admin Overview	Admin Overview	deep	admin	restricted	admin_panel	admin/links.php	Y
49	Permission Editor	Permission Editor	deep	admin-permissions	restricted	manage_permissions	admin/permissions/home.php	Y
52	User Admin	User Admin	deep	admin-users	restricted	manage_users	admin/user/home.php	Y
53	Board Admin	Board Admin	deep	admin-boards	restricted	manage_boards	admin/boards/home.php	Y
56	Permission Editor	Permission Editor	deep	admin-permissions-edit	restricted	manage_permissions	admin/permissions/edit.php	Y
57	Board Creator	Board Creator	deep	admin-boards-create	restricted	manage_boards	admin/boards/create.php	N
61	Board Editor	Board Editor	deep	admin-boards-edit	restricted	manage_boards	admin/boards/edit.php	Y
67	Staff	Staff	deep	staff	public		meta/staff.php	Y
68	Reset Password	Reset Password	deep	reset-password	public		user/forgot_password.php	Y
69	Terms and Conditions	Terms and Conditions	deep	terms-and-conditions	public		meta/terms.php	Y
70	Online Users	Online Users	deep	online	public		meta/online.php	Y
71	Search	Search	deep	search	user		meta/search.php	Y
34	Boards	Boards	deep	thread	public		boards/post_list.php	Y
33	Boards	Boards	deep	board	public		boards/thread_list.php	Y
\.


--
-- PostgreSQL database dump complete
--

