--
-- PostgreSQL database dump
--

\restrict oK67Rh4YT2nAE3zdYmnh3dkKMYDd9PwvkD6cEfL5kZQctK1r1QcX12HjWvPjKXr

-- Dumped from database version 18.3
-- Dumped by pg_dump version 18.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Data for Name: hotels; Type: TABLE DATA; Schema: public; Owner: stayaddis_user
--

COPY public.hotels (id, name, description, star_rating, address, city, created_at, cover_image) FROM stdin;
1	Ethiopian Skylight Hotel	Premium airport hotel with modern amenities	5	Bole International Airport	Addis Ababa	2026-07-16 10:27:16.44881	hotels/skylight/cover.jpg
2	Hyatt Regency Addis Ababa	Luxury business hotel in Kazanchis	5	Kazanchis	Addis Ababa	2026-07-16 10:27:16.44881	hotels/hyatt/cover.jpg
3	Radisson Blu Addis Ababa	Premium business hotel with city views	4	Kazanchis	Addis Ababa	2026-07-16 10:27:16.44881	hotels/radisson/cover.jpg
4	Hilton Addis Ababa	Historic hotel with lush gardens, multiple restaurants, pool, and conference facilities near the city center.	4	Menelik II Avenue	Addis Ababa	2026-07-16 11:39:00.690997	hotels/hilton/cover.jpg
5	Capital Hotel & Spa	Modern hotel with spa facilities, rooftop restaurant, and business center in the Bole district.	4	Bole	Addis Ababa	2026-07-16 11:39:00.690997	hotels/capital/cover.jpg
6	Golden Tulip Addis Ababa	Contemporary hotel with modern amenities, restaurant, fitness center, and convenient airport access.	4	Bole	Addis Ababa	2026-07-16 11:39:00.690997	hotels/golden_tulip/cover.jpg
7	Best Western Plus Addis Ababa	Reliable mid-range hotel with comfortable rooms, restaurant, and business facilities near the airport.	3	Bole	Addis Ababa	2026-07-16 11:39:00.690997	hotels/best_western/cover.jpg
\.


--
-- Data for Name: rooms; Type: TABLE DATA; Schema: public; Owner: stayaddis_user
--

COPY public.rooms (id, hotel_id, room_type, description, price_per_night, capacity, available_count, created_at, image) FROM stdin;
1	1	Standard Room	Comfortable room	3500.00	2	20	2026-07-16 10:27:28.331408	rooms/skylight/standard_room.jpg
2	1	Executive Suite	Luxury suite	12000.00	3	5	2026-07-16 10:27:28.331408	rooms/skylight/executive_suite.jpg
3	2	Standard Room	Modern room with workspace	4500.00	2	25	2026-07-16 10:27:28.331408	rooms/hyatt/standard_room.jpg
4	2	Presidential Suite	Ultimate luxury	30000.00	4	2	2026-07-16 10:27:28.331408	rooms/hyatt/presidential_suite.jpg
5	3	Business Class Room	Room with ergonomic workspace	6500.00	2	12	2026-07-16 10:27:28.331408	rooms/radisson/business_class_room.jpg
6	3	Family Suite	Large suite with multiple beds	18000.00	5	3	2026-07-16 10:27:28.331408	rooms/radisson/family_suite.jpg
7	4	Standard Room	Comfortable room with garden view	3800.00	2	15	2026-07-16 11:39:00.714731	rooms/hilton/standard_room.jpg
8	4	Deluxe Room	Spacious room with premium amenities	6000.00	2	10	2026-07-16 11:39:00.714731	rooms/hilton/deluxe_room.jpg
9	4	Executive Suite	Suite with separate living area	13000.00	3	5	2026-07-16 11:39:00.714731	rooms/hilton/executive_suite.jpg
10	5	Standard Room	Modern room with city view	3200.00	2	20	2026-07-16 11:39:00.714731	rooms/capital/standard_room.jpg
11	5	Deluxe Room	Upgraded room with spa access	5500.00	2	12	2026-07-16 11:39:00.714731	rooms/capital/deluxe_room.jpg
12	5	Executive Suite	Suite with business lounge access	11000.00	3	4	2026-07-16 11:39:00.714731	rooms/capital/suite.jpg
13	6	Standard Room	Contemporary room with workspace	3500.00	2	18	2026-07-16 11:39:00.714731	rooms/golden_tulip/standard_room.jpg
14	6	Superior Room	Larger room with premium bedding	5000.00	2	10	2026-07-16 11:39:00.714731	rooms/golden_tulip/deluxe_room.jpg
15	6	Executive Suite	Suite with lounge access	10000.00	3	5	2026-07-16 11:39:00.714731	rooms/golden_tulip/suite.jpg
16	7	Standard Room	Comfortable room with basic amenities	2800.00	2	25	2026-07-16 11:39:00.714731	rooms/best_western/standard_room.jpg
17	7	Deluxe Room	Upgraded room with sitting area	4500.00	2	15	2026-07-16 11:39:00.714731	rooms/best_western/deluxe_room.jpg
18	7	Family Room	Large room with multiple beds	6000.00	4	8	2026-07-16 11:39:00.714731	rooms/best_western/suite.jpg
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: stayaddis_user
--

COPY public.users (id, full_name, email, phone, password_hash, is_guest, created_at) FROM stdin;
1	Abebe Kebede	abebe@example.com	+251911234567	hashed_password_123	f	2026-07-16 10:27:22.167149
2	Sara Tadesse	sara@example.com	+251922345678	hashed_password_456	f	2026-07-16 10:27:22.167149
3	Guest User One	guest1@example.com	+251933456789	\N	t	2026-07-16 10:27:22.167149
4	Guest User Two	guest2@example.com	+251944567890	\N	t	2026-07-16 10:27:22.167149
\.


--
-- Data for Name: bookings; Type: TABLE DATA; Schema: public; Owner: stayaddis_user
--

COPY public.bookings (id, user_id, room_id, booking_reference, check_in, check_out, guests, total_price, status, created_at) FROM stdin;
1	1	1	SAD-1001	2026-07-20	2026-07-23	2	10500.00	confirmed	2026-07-16 10:27:33.394283
2	2	4	SAD-1002	2026-07-25	2026-07-27	3	60000.00	confirmed	2026-07-16 10:27:33.394283
3	3	3	SAD-1003	2026-08-01	2026-08-03	1	9000.00	pending	2026-07-16 10:27:33.394283
4	4	6	SAD-1004	2026-08-10	2026-08-14	5	72000.00	pending	2026-07-16 10:27:33.394283
\.


--
-- Data for Name: hotel_images; Type: TABLE DATA; Schema: public; Owner: stayaddis_user
--

COPY public.hotel_images (id, hotel_id, image_path, caption, sort_order) FROM stdin;
19	1	hotels/skylight/cover.jpg	Hotel Exterior	1
20	1	hotels/skylight/exterior_day.jpg	Day View	2
21	1	hotels/skylight/exterior_night.jpg	Night View	3
22	1	hotels/skylight/lobby.jpg	Grand Lobby	4
23	1	hotels/skylight/pool.jpg	Swimming Pool	5
24	1	hotels/skylight/restaurant.jpg	Restaurant	6
25	1	hotels/skylight/view.jpg	City View	7
26	2	hotels/hyatt/cover.jpg	Hotel Exterior	1
27	2	hotels/hyatt/exterior_day.jpg	Day View	2
28	2	hotels/hyatt/exterior_night.jpg	Night View	3
29	2	hotels/hyatt/lobby.jpg	Grand Lobby	4
30	2	hotels/hyatt/pool.jpg	Swimming Pool	5
31	2	hotels/hyatt/restaurant.jpg	Restaurant	6
32	2	hotels/hyatt/view.jpg	City View	7
33	3	hotels/radisson/cover.jpg	Hotel Exterior	1
34	3	hotels/radisson/exterior_day.jpg	Day View	2
35	3	hotels/radisson/exterior_night.jpg	Night View	3
36	3	hotels/radisson/lobby.jpg	Grand Lobby	4
37	3	hotels/radisson/pool.jpg	Swimming Pool	5
38	3	hotels/radisson/restaurant.jpg	Restaurant	6
39	3	hotels/radisson/view.jpg	City View	7
40	4	hotels/hilton/cover.jpg	Hotel Exterior	1
41	4	hotels/hilton/exterior.jpg	Exterior View	2
42	4	hotels/hilton/lobby.jpg	Lobby	3
43	4	hotels/hilton/pool.jpg	Swimming Pool	4
44	5	hotels/capital/cover.jpg	Hotel Exterior	1
45	5	hotels/capital/exterior.jpg	Exterior View	2
46	5	hotels/capital/lobby.jpg	Lobby	3
47	5	hotels/capital/restaurant.jpg	Restaurant	4
48	6	hotels/golden_tulip/cover.jpg	Hotel Exterior	1
49	6	hotels/golden_tulip/exterior.jpg	Exterior View	2
50	6	hotels/golden_tulip/lobby.jpg	Lobby	3
51	6	hotels/golden_tulip/restaurant.jpg	Restaurant	4
52	7	hotels/best_western/cover.jpg	Hotel Exterior	1
53	7	hotels/best_western/exterior.jpg	Exterior View	2
54	7	hotels/best_western/lobby.jpg	Lobby	3
55	7	hotels/best_western/restaurant.jpg	Restaurant	4
\.


--
-- Data for Name: room_images; Type: TABLE DATA; Schema: public; Owner: stayaddis_user
--

COPY public.room_images (id, room_id, image_path, caption, sort_order) FROM stdin;
\.


--
-- Name: bookings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: stayaddis_user
--

SELECT pg_catalog.setval('public.bookings_id_seq', 4, true);


--
-- Name: hotel_images_id_seq; Type: SEQUENCE SET; Schema: public; Owner: stayaddis_user
--

SELECT pg_catalog.setval('public.hotel_images_id_seq', 55, true);


--
-- Name: hotels_id_seq; Type: SEQUENCE SET; Schema: public; Owner: stayaddis_user
--

SELECT pg_catalog.setval('public.hotels_id_seq', 7, true);


--
-- Name: room_images_id_seq; Type: SEQUENCE SET; Schema: public; Owner: stayaddis_user
--

SELECT pg_catalog.setval('public.room_images_id_seq', 1, false);


--
-- Name: rooms_id_seq; Type: SEQUENCE SET; Schema: public; Owner: stayaddis_user
--

SELECT pg_catalog.setval('public.rooms_id_seq', 18, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: stayaddis_user
--

SELECT pg_catalog.setval('public.users_id_seq', 4, true);


--
-- PostgreSQL database dump complete
--

\unrestrict oK67Rh4YT2nAE3zdYmnh3dkKMYDd9PwvkD6cEfL5kZQctK1r1QcX12HjWvPjKXr

