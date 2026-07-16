--
-- PostgreSQL database dump
--

\restrict s1lymqLOeS14Eb9Qjcc43uIR3T2ML4M0MEqJYbPdGtIoteWmJxJD9vAQTddHZmf

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: bookings; Type: TABLE; Schema: public; Owner: stayaddis_user
--

CREATE TABLE public.bookings (
    id integer NOT NULL,
    user_id integer NOT NULL,
    room_id integer NOT NULL,
    booking_reference character varying(10) NOT NULL,
    check_in date NOT NULL,
    check_out date NOT NULL,
    guests integer DEFAULT 1,
    total_price numeric(10,2) NOT NULL,
    status character varying(20) DEFAULT 'pending'::character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT bookings_check CHECK ((check_out > check_in))
);


ALTER TABLE public.bookings OWNER TO stayaddis_user;

--
-- Name: bookings_id_seq; Type: SEQUENCE; Schema: public; Owner: stayaddis_user
--

CREATE SEQUENCE public.bookings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.bookings_id_seq OWNER TO stayaddis_user;

--
-- Name: bookings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: stayaddis_user
--

ALTER SEQUENCE public.bookings_id_seq OWNED BY public.bookings.id;


--
-- Name: hotel_images; Type: TABLE; Schema: public; Owner: stayaddis_user
--

CREATE TABLE public.hotel_images (
    id integer NOT NULL,
    hotel_id integer NOT NULL,
    image_path character varying(255) NOT NULL,
    caption character varying(255),
    sort_order integer DEFAULT 0
);


ALTER TABLE public.hotel_images OWNER TO stayaddis_user;

--
-- Name: hotel_images_id_seq; Type: SEQUENCE; Schema: public; Owner: stayaddis_user
--

CREATE SEQUENCE public.hotel_images_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.hotel_images_id_seq OWNER TO stayaddis_user;

--
-- Name: hotel_images_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: stayaddis_user
--

ALTER SEQUENCE public.hotel_images_id_seq OWNED BY public.hotel_images.id;


--
-- Name: hotels; Type: TABLE; Schema: public; Owner: stayaddis_user
--

CREATE TABLE public.hotels (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    description text,
    star_rating integer DEFAULT 3,
    address text,
    city character varying(100) DEFAULT 'Addis Ababa'::character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    cover_image character varying(255)
);


ALTER TABLE public.hotels OWNER TO stayaddis_user;

--
-- Name: hotels_id_seq; Type: SEQUENCE; Schema: public; Owner: stayaddis_user
--

CREATE SEQUENCE public.hotels_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.hotels_id_seq OWNER TO stayaddis_user;

--
-- Name: hotels_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: stayaddis_user
--

ALTER SEQUENCE public.hotels_id_seq OWNED BY public.hotels.id;


--
-- Name: room_images; Type: TABLE; Schema: public; Owner: stayaddis_user
--

CREATE TABLE public.room_images (
    id integer NOT NULL,
    room_id integer NOT NULL,
    image_path character varying(255) NOT NULL,
    caption character varying(255),
    sort_order integer DEFAULT 0
);


ALTER TABLE public.room_images OWNER TO stayaddis_user;

--
-- Name: room_images_id_seq; Type: SEQUENCE; Schema: public; Owner: stayaddis_user
--

CREATE SEQUENCE public.room_images_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.room_images_id_seq OWNER TO stayaddis_user;

--
-- Name: room_images_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: stayaddis_user
--

ALTER SEQUENCE public.room_images_id_seq OWNED BY public.room_images.id;


--
-- Name: rooms; Type: TABLE; Schema: public; Owner: stayaddis_user
--

CREATE TABLE public.rooms (
    id integer NOT NULL,
    hotel_id integer NOT NULL,
    room_type character varying(100) NOT NULL,
    description text,
    price_per_night numeric(10,2) NOT NULL,
    capacity integer DEFAULT 2,
    available_count integer DEFAULT 1,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    image character varying(255)
);


ALTER TABLE public.rooms OWNER TO stayaddis_user;

--
-- Name: rooms_id_seq; Type: SEQUENCE; Schema: public; Owner: stayaddis_user
--

CREATE SEQUENCE public.rooms_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.rooms_id_seq OWNER TO stayaddis_user;

--
-- Name: rooms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: stayaddis_user
--

ALTER SEQUENCE public.rooms_id_seq OWNED BY public.rooms.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: stayaddis_user
--

CREATE TABLE public.users (
    id integer NOT NULL,
    full_name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    phone character varying(20),
    password_hash character varying(255),
    is_guest boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.users OWNER TO stayaddis_user;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: stayaddis_user
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO stayaddis_user;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: stayaddis_user
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: bookings id; Type: DEFAULT; Schema: public; Owner: stayaddis_user
--

ALTER TABLE ONLY public.bookings ALTER COLUMN id SET DEFAULT nextval('public.bookings_id_seq'::regclass);


--
-- Name: hotel_images id; Type: DEFAULT; Schema: public; Owner: stayaddis_user
--

ALTER TABLE ONLY public.hotel_images ALTER COLUMN id SET DEFAULT nextval('public.hotel_images_id_seq'::regclass);


--
-- Name: hotels id; Type: DEFAULT; Schema: public; Owner: stayaddis_user
--

ALTER TABLE ONLY public.hotels ALTER COLUMN id SET DEFAULT nextval('public.hotels_id_seq'::regclass);


--
-- Name: room_images id; Type: DEFAULT; Schema: public; Owner: stayaddis_user
--

ALTER TABLE ONLY public.room_images ALTER COLUMN id SET DEFAULT nextval('public.room_images_id_seq'::regclass);


--
-- Name: rooms id; Type: DEFAULT; Schema: public; Owner: stayaddis_user
--

ALTER TABLE ONLY public.rooms ALTER COLUMN id SET DEFAULT nextval('public.rooms_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: stayaddis_user
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: bookings bookings_booking_reference_key; Type: CONSTRAINT; Schema: public; Owner: stayaddis_user
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_booking_reference_key UNIQUE (booking_reference);


--
-- Name: bookings bookings_pkey; Type: CONSTRAINT; Schema: public; Owner: stayaddis_user
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_pkey PRIMARY KEY (id);


--
-- Name: hotel_images hotel_images_pkey; Type: CONSTRAINT; Schema: public; Owner: stayaddis_user
--

ALTER TABLE ONLY public.hotel_images
    ADD CONSTRAINT hotel_images_pkey PRIMARY KEY (id);


--
-- Name: hotels hotels_pkey; Type: CONSTRAINT; Schema: public; Owner: stayaddis_user
--

ALTER TABLE ONLY public.hotels
    ADD CONSTRAINT hotels_pkey PRIMARY KEY (id);


--
-- Name: room_images room_images_pkey; Type: CONSTRAINT; Schema: public; Owner: stayaddis_user
--

ALTER TABLE ONLY public.room_images
    ADD CONSTRAINT room_images_pkey PRIMARY KEY (id);


--
-- Name: rooms rooms_pkey; Type: CONSTRAINT; Schema: public; Owner: stayaddis_user
--

ALTER TABLE ONLY public.rooms
    ADD CONSTRAINT rooms_pkey PRIMARY KEY (id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: stayaddis_user
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: stayaddis_user
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: bookings bookings_room_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: stayaddis_user
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_room_id_fkey FOREIGN KEY (room_id) REFERENCES public.rooms(id) ON DELETE CASCADE;


--
-- Name: bookings bookings_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: stayaddis_user
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: hotel_images hotel_images_hotel_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: stayaddis_user
--

ALTER TABLE ONLY public.hotel_images
    ADD CONSTRAINT hotel_images_hotel_id_fkey FOREIGN KEY (hotel_id) REFERENCES public.hotels(id) ON DELETE CASCADE;


--
-- Name: room_images room_images_room_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: stayaddis_user
--

ALTER TABLE ONLY public.room_images
    ADD CONSTRAINT room_images_room_id_fkey FOREIGN KEY (room_id) REFERENCES public.rooms(id) ON DELETE CASCADE;


--
-- Name: rooms rooms_hotel_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: stayaddis_user
--

ALTER TABLE ONLY public.rooms
    ADD CONSTRAINT rooms_hotel_id_fkey FOREIGN KEY (hotel_id) REFERENCES public.hotels(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict s1lymqLOeS14Eb9Qjcc43uIR3T2ML4M0MEqJYbPdGtIoteWmJxJD9vAQTddHZmf

