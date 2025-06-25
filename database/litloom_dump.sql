--
-- PostgreSQL database dump
--

-- Dumped from database version 16.9 (Ubuntu 16.9-0ubuntu0.24.04.1)
-- Dumped by pg_dump version 16.9 (Ubuntu 16.9-0ubuntu0.24.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
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
-- Name: authors; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authors (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    bio text,
    date_of_birth date NOT NULL,
    country character varying(100) NOT NULL
);


ALTER TABLE public.authors OWNER TO postgres;

--
-- Name: authors_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.authors_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.authors_id_seq OWNER TO postgres;

--
-- Name: authors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.authors_id_seq OWNED BY public.authors.id;


--
-- Name: book_authors; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.book_authors (
    book_id integer NOT NULL,
    author_id integer NOT NULL
);


ALTER TABLE public.book_authors OWNER TO postgres;

--
-- Name: book_character_appearances; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.book_character_appearances (
    book_id integer NOT NULL,
    character_id integer NOT NULL
);


ALTER TABLE public.book_character_appearances OWNER TO postgres;

--
-- Name: book_characters; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.book_characters (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    role character varying(100) NOT NULL,
    date_of_birth date,
    description text NOT NULL,
    fictional_age integer NOT NULL,
    gender character varying(20) NOT NULL
);


ALTER TABLE public.book_characters OWNER TO postgres;

--
-- Name: book_characters_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.book_characters_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.book_characters_id_seq OWNER TO postgres;

--
-- Name: book_characters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.book_characters_id_seq OWNED BY public.book_characters.id;


--
-- Name: book_suggestions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.book_suggestions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    title character varying(255) NOT NULL,
    author_name character varying(255) NOT NULL,
    description text,
    language character varying(100) NOT NULL,
    genre character varying(100) NOT NULL,
    submitted_at timestamp without time zone NOT NULL,
    approved character(1) DEFAULT '0'::bpchar NOT NULL,
    approved_at timestamp without time zone,
    approved_by integer,
    CONSTRAINT book_suggestions_approved_check CHECK ((approved = ANY (ARRAY['0'::bpchar, '1'::bpchar])))
);


ALTER TABLE public.book_suggestions OWNER TO postgres;

--
-- Name: book_suggestions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.book_suggestions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.book_suggestions_id_seq OWNER TO postgres;

--
-- Name: book_suggestions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.book_suggestions_id_seq OWNED BY public.book_suggestions.id;


--
-- Name: books; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.books (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    description text,
    publication_date date,
    cover_image character varying(500),
    original_country character varying(100),
    language_id integer,
    genre_id integer,
    publication_house_id integer,
    pdf_url character varying(500),
    average_rating numeric(3,2) DEFAULT 0,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    added_by integer
);


ALTER TABLE public.books OWNER TO postgres;

--
-- Name: books_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.books_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.books_id_seq OWNER TO postgres;

--
-- Name: books_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.books_id_seq OWNED BY public.books.id;


--
-- Name: comments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.comments (
    id integer NOT NULL,
    review_id integer NOT NULL,
    user_id integer NOT NULL,
    body text NOT NULL,
    parent_comment_id integer,
    created_at timestamp without time zone NOT NULL
);


ALTER TABLE public.comments OWNER TO postgres;

--
-- Name: comments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.comments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.comments_id_seq OWNER TO postgres;

--
-- Name: comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.comments_id_seq OWNED BY public.comments.id;


--
-- Name: genres; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.genres (
    id integer NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE public.genres OWNER TO postgres;

--
-- Name: genres_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.genres_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.genres_id_seq OWNER TO postgres;

--
-- Name: genres_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.genres_id_seq OWNED BY public.genres.id;


--
-- Name: languages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.languages (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    iso_code character varying(10) NOT NULL
);


ALTER TABLE public.languages OWNER TO postgres;

--
-- Name: languages_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.languages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.languages_id_seq OWNER TO postgres;

--
-- Name: languages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.languages_id_seq OWNED BY public.languages.id;


--
-- Name: login_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.login_history (
    id integer NOT NULL,
    user_id integer NOT NULL,
    login_time timestamp without time zone NOT NULL,
    ip_address character varying(45) NOT NULL
);


ALTER TABLE public.login_history OWNER TO postgres;

--
-- Name: login_history_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.login_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.login_history_id_seq OWNER TO postgres;

--
-- Name: login_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.login_history_id_seq OWNED BY public.login_history.id;


--
-- Name: moderator_accounts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.moderator_accounts (
    user_id integer NOT NULL
);


ALTER TABLE public.moderator_accounts OWNER TO postgres;

--
-- Name: publication_houses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.publication_houses (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    address character varying(500) NOT NULL,
    country character varying(100) NOT NULL,
    contact_email character varying(255) NOT NULL
);


ALTER TABLE public.publication_houses OWNER TO postgres;

--
-- Name: publication_houses_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.publication_houses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.publication_houses_id_seq OWNER TO postgres;

--
-- Name: publication_houses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.publication_houses_id_seq OWNED BY public.publication_houses.id;


--
-- Name: ratings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ratings (
    id integer NOT NULL,
    user_id integer NOT NULL,
    book_id integer NOT NULL,
    value integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    CONSTRAINT ratings_value_check CHECK (((value >= 1) AND (value <= 5)))
);


ALTER TABLE public.ratings OWNER TO postgres;

--
-- Name: ratings_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ratings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.ratings_id_seq OWNER TO postgres;

--
-- Name: ratings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ratings_id_seq OWNED BY public.ratings.id;


--
-- Name: reviews; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reviews (
    id integer NOT NULL,
    book_id integer NOT NULL,
    user_id integer NOT NULL,
    title character varying(255) NOT NULL,
    body text,
    rating integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    CONSTRAINT reviews_rating_check CHECK (((rating >= 1) AND (rating <= 5)))
);


ALTER TABLE public.reviews OWNER TO postgres;

--
-- Name: reviews_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.reviews_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.reviews_id_seq OWNER TO postgres;

--
-- Name: reviews_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.reviews_id_seq OWNED BY public.reviews.id;


--
-- Name: user_accounts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_accounts (
    user_id integer NOT NULL
);


ALTER TABLE public.user_accounts OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    username character varying(100) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    profile_picture_url character varying(500) NOT NULL,
    bio text,
    first_name character varying(100),
    last_name character varying(100),
    active_status boolean DEFAULT false NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: votes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.votes (
    id integer NOT NULL,
    user_id integer NOT NULL,
    review_id integer,
    comment_id integer,
    vote_type character varying(10) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    CONSTRAINT vote_target_ck CHECK ((((review_id IS NOT NULL) AND (comment_id IS NULL)) OR ((review_id IS NULL) AND (comment_id IS NOT NULL)))),
    CONSTRAINT votes_vote_type_check CHECK (((vote_type)::text = ANY ((ARRAY['up'::character varying, 'down'::character varying])::text[])))
);


ALTER TABLE public.votes OWNER TO postgres;

--
-- Name: votes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.votes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.votes_id_seq OWNER TO postgres;

--
-- Name: votes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.votes_id_seq OWNED BY public.votes.id;


--
-- Name: wished_books; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.wished_books (
    user_id integer NOT NULL,
    book_id integer NOT NULL
);


ALTER TABLE public.wished_books OWNER TO postgres;

--
-- Name: wishlists; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.wishlists (
    id integer NOT NULL,
    user_id integer NOT NULL,
    status character varying(50) NOT NULL,
    added_at timestamp without time zone NOT NULL
);


ALTER TABLE public.wishlists OWNER TO postgres;

--
-- Name: wishlists_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.wishlists_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.wishlists_id_seq OWNER TO postgres;

--
-- Name: wishlists_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.wishlists_id_seq OWNED BY public.wishlists.id;


--
-- Name: authors id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authors ALTER COLUMN id SET DEFAULT nextval('public.authors_id_seq'::regclass);


--
-- Name: book_characters id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book_characters ALTER COLUMN id SET DEFAULT nextval('public.book_characters_id_seq'::regclass);


--
-- Name: book_suggestions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book_suggestions ALTER COLUMN id SET DEFAULT nextval('public.book_suggestions_id_seq'::regclass);


--
-- Name: books id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.books ALTER COLUMN id SET DEFAULT nextval('public.books_id_seq'::regclass);


--
-- Name: comments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comments ALTER COLUMN id SET DEFAULT nextval('public.comments_id_seq'::regclass);


--
-- Name: genres id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genres ALTER COLUMN id SET DEFAULT nextval('public.genres_id_seq'::regclass);


--
-- Name: languages id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.languages ALTER COLUMN id SET DEFAULT nextval('public.languages_id_seq'::regclass);


--
-- Name: login_history id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.login_history ALTER COLUMN id SET DEFAULT nextval('public.login_history_id_seq'::regclass);


--
-- Name: publication_houses id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.publication_houses ALTER COLUMN id SET DEFAULT nextval('public.publication_houses_id_seq'::regclass);


--
-- Name: ratings id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ratings ALTER COLUMN id SET DEFAULT nextval('public.ratings_id_seq'::regclass);


--
-- Name: reviews id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews ALTER COLUMN id SET DEFAULT nextval('public.reviews_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: votes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.votes ALTER COLUMN id SET DEFAULT nextval('public.votes_id_seq'::regclass);


--
-- Name: wishlists id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wishlists ALTER COLUMN id SET DEFAULT nextval('public.wishlists_id_seq'::regclass);


--
-- Data for Name: authors; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authors (id, name, bio, date_of_birth, country) FROM stdin;
1	Gabriel García Márquez	Colombian novelist and Nobel laureate known for magical realism, especially in "One Hundred Years of Solitude".	1927-03-06	Colombia
2	Rabindranath Tagore	Bengali polymath, poet, and the first non-European to win the Nobel Prize in Literature.	1861-05-07	India
3	Haruki Murakami	Japanese author known for blending pop culture, surrealism, and melancholy in works like "Norwegian Wood" and "Kafka on the Shore".	1949-01-12	Japan
4	Chinua Achebe	Nigerian writer best known for his novel "Things Fall Apart", a cornerstone of African literature.	1930-11-16	Nigeria
6	Humayun Ahmed	Bangladeshi author and filmmaker, famous for his fiction and characters like Himu and Misir Ali.	1948-11-13	Bangladesh
5	Virginia Woolf	English writer and modernist pioneer, known for "Mrs Dalloway" and "To the Lighthouse".	1882-01-25	United Kingdom
7	Sylvia Plath	American poet and novelist, known for her confessional style and "The Bell Jar".	1932-10-27	United States
8	Leo Tolstoy	Russian writer famous for epic novels like "War and Peace" and "Anna Karenina".	1828-09-09	Russia
9	Kazi Nazrul Islam	Revolutionary Bengali poet, writer, and musician, known as the "Rebel Poet" of Bengal.	1899-05-24	Bangladesh
10	George Orwell	British author known for dystopian classics like "1984" and "Animal Farm".	1903-06-25	United Kingdom
12	V.E. Schwab	Victoria Schwab is known for fantasy novels blending dark magic and human emotion.	1987-07-07	United States
13	T.J. Klune	American author of fantasy and romance with LGBTQ+ representation.	1982-05-20	United States
14	Andy Weir	Former software engineer and author of science fiction bestsellers.	1972-06-16	United States
15	Matt Haig	British author of fiction and nonfiction exploring mental health and the human experience.	1975-07-03	United Kingdom
16	Jennette McCurdy	Actress and author, known for her memoir on childhood trauma and healing.	1992-06-26	United States
17	Rebecca Yarros	American writer best known for emotionally charged romance and fantasy.	1981-12-14	United States
18	Suzanne Collins	Creator of *The Hunger Games* series, known for dystopian fiction.	1962-08-10	United States
19	Susanna Clarke	British author whose work blends historical fiction and fantasy.	1959-11-01	United Kingdom
20	Kate Elizabeth Russell	American author of controversial and introspective psychological fiction.	1984-07-16	United States
21	Sarah J. Maas	Bestselling fantasy author known for high-stakes romance and action.	1986-03-05	United States
\.


--
-- Data for Name: book_authors; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.book_authors (book_id, author_id) FROM stdin;
4110	12
4111	13
4114	14
4115	15
4116	16
4117	17
4118	18
4119	19
4120	20
4121	21
1	1
2	2
3	3
4	4
5	6
6	7
7	8
8	5
9	9
10	10
\.


--
-- Data for Name: book_character_appearances; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.book_character_appearances (book_id, character_id) FROM stdin;
\.


--
-- Data for Name: book_characters; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.book_characters (id, name, role, date_of_birth, description, fictional_age, gender) FROM stdin;
\.


--
-- Data for Name: book_suggestions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.book_suggestions (id, user_id, title, author_name, description, language, genre, submitted_at, approved, approved_at, approved_by) FROM stdin;
\.


--
-- Data for Name: books; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.books (id, title, description, publication_date, cover_image, original_country, language_id, genre_id, publication_house_id, pdf_url, average_rating, created_at, added_by) FROM stdin;
4110	The Invisible Life of Addie LaRue	A young woman makes a Faustian bargain to live forever but is cursed to be forgotten by everyone she meets.	2020-10-06	https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1584633432i/50623864.jpg	United States	1	3	19	https://example.com/pdfs/invisible_life_addie_larue.pdf	4.20	2025-06-25 00:02:31.071762	1
4111	The House in the Cerulean Sea	A charming tale of a caseworker sent to a magical orphanage, discovering love and acceptance.	2020-03-17	https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1569514209i/45047384.jpg	United States	1	3	19	https://example.com/pdfs/house_cerulean_sea.pdf	4.40	2025-06-25 00:02:31.071762	1
4114	Project Hail Mary	A lone astronaut wakes up on a spaceship with no memory and must save Earth from disaster.	2021-05-04	https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1597695864i/54493401.jpg	United States	1	4	20	https://example.com/pdfs/project_hail_mary.pdf	4.50	2025-06-25 00:05:48.888889	1
4115	The Midnight Library	Between life and death lies a library where every book represents a different path life could have taken.	2020-08-13	https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1602190253i/52578297.jpg	United Kingdom	1	3	21	https://example.com/pdfs/midnight_library.pdf	4.10	2025-06-25 00:05:48.888889	1
4116	I’m Glad My Mom Died	A raw and honest memoir by Jennette McCurdy about her complicated relationship with her mother and healing.	2022-08-09	https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1649286799i/59364173.jpg	United States	1	26	3	https://example.com/pdfs/im_glad_my_mom_died.pdf	4.70	2025-06-25 00:09:02.151792	1
4117	Fourth Wing	A fierce young woman trains in a deadly military academy in a world of dragons and political intrigue.	2023-05-02	https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1701980900i/61431922.jpg	United States	1	3	23	https://example.com/pdfs/fourth_wing.pdf	4.30	2025-06-25 00:09:02.151792	1
4118	The Ballad of Songbirds and Snakes	A prequel to The Hunger Games, following the rise of a young Coriolanus Snow.	2020-05-19	https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1593892032i/51901147.jpg	United States	1	27	24	https://example.com/pdfs/ballad_songbirds_snakes.pdf	4.00	2025-06-25 00:09:51.435282	1
4119	Piranesi	A surreal and mysterious tale of a man living in a strange, labyrinthine house filled with statues.	2020-09-15	https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1609095173i/50202953.jpg	United Kingdom	1	3	6	https://example.com/pdfs/piranesi.pdf	4.10	2025-06-25 00:09:51.435282	1
4120	My Dark Vanessa	A gripping psychological thriller exploring a complex and controversial relationship.	2020-06-02	https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1583447793i/44890081.jpg	United States	1	6	26	https://example.com/pdfs/my_dark_vanessa.pdf	4.00	2025-06-25 00:09:51.435282	1
4121	House of Earth and Blood	The first book in a fantasy series about a woman caught between gods, demons, and mortal politics.	2020-03-03	https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1559142847i/44778083.jpg	United States	1	3	6	https://example.com/pdfs/house_earth_blood.pdf	4.20	2025-06-25 00:09:51.435282	1
1	One Hundred Years of Solitude	A multi-generational tale of the Buendía family, blending magical realism with political and social commentary.	1967-05-30	https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1327881361i/320.jpg	Colombia	4	1	17	https://example.com/pdfs/solitude.pdf	4.70	2025-06-22 21:19:18.608485	1
2	Gitanjali	A collection of poems reflecting devotion, love, and spirituality that earned Tagore the Nobel Prize.	1910-08-14	https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1348514071i/66414.jpg	India	2	11	8	https://example.com/pdfs/gitanjali.pdf	4.50	2025-06-22 21:19:18.608485	2
3	Kafka on the Shore	A metaphysical and surreal novel following a runaway teenager and a man who can talk to cats.	2002-09-12	https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1429638085i/4929.jpg	Japan	11	3	14	https://example.com/pdfs/kafka.pdf	4.30	2025-06-22 21:19:18.608485	3
4	Things Fall Apart	A powerful novel about pre-colonial life in Nigeria and the impact of European colonialism.	1958-06-17	https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1645022990i/60316758.jpg	Nigeria	1	1	15	https://example.com/pdfs/thingsfallapart.pdf	4.60	2025-06-22 21:19:18.608485	4
5	Himu	The story of a free-spirited young man who walks barefoot and questions society through his simplicity.	1990-03-01	https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1627028538i/58612471.jpg	Bangladesh	2	1	11	https://example.com/pdfs/himu.pdf	4.40	2025-06-22 21:19:18.608485	5
6	The Bell Jar	A semi-autobiographical novel exploring mental illness, identity, and societal expectations.	1963-01-14	https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1668645154i/56616095.jpg	United States	1	1	16	https://example.com/pdfs/belljar.pdf	4.20	2025-06-22 21:19:18.608485	6
8	Mrs Dalloway	A modernist novel capturing one day in the life of Clarissa Dalloway, rich with inner thought and stream-of-consciousness.	1925-05-14	https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1646148221i/14942.jpg	United Kingdom	1	1	16	https://example.com/pdfs/mrsdalloway.pdf	4.10	2025-06-22 21:19:18.608485	8
9	Shonchita	A collection of revolutionary poems challenging oppression and injustice in colonial Bengal.	1922-08-01	https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1505814718i/17201996.jpg	Bangladesh	2	11	12	https://example.com/pdfs/rebelpoetry.pdf	4.60	2025-06-22 21:19:18.608485	9
10	1984	A dystopian novel depicting a totalitarian regime that surveils, manipulates, and erases truth.	1949-06-08	https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1657781256i/61439040.jpg	United Kingdom	1	6	1	https://example.com/pdfs/1984.pdf	4.90	2025-06-22 21:19:18.608485	10
7	War and Peace	A historical epic interweaving personal lives and military campaigns during the Napoleonic era.	1869-01-01	https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1413215930i/656.jpg	Russia	1	8	5	https://example.com/pdfs/warpeace.pdf	4.80	2025-06-22 21:19:18.608485	7
\.


--
-- Data for Name: comments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.comments (id, review_id, user_id, body, parent_comment_id, created_at) FROM stdin;
\.


--
-- Data for Name: genres; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.genres (id, name) FROM stdin;
1	Fiction
2	Non-Fiction
3	Fantasy
4	Science Fiction
5	Mystery
6	Thriller
7	Romance
8	Historical
9	Biography
10	Self-Help
11	Poetry
12	Horror
13	Young Adult
14	Classics
15	Graphic Novel
16	Philosophy
17	Science
18	Travel
19	Religion
20	Drama
26	Memoir
27	Historical Fiction
\.


--
-- Data for Name: languages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.languages (id, name, iso_code) FROM stdin;
1	English	en
2	Bengali	bn
3	Hindi	hi
4	Spanish	es
5	French	fr
6	Chinese	zh
7	Arabic	ar
8	Russian	ru
9	German	de
10	Portuguese	pt
11	Japanese	ja
12	Italian	it
13	Urdu	ur
14	Persian	fa
15	Turkish	tr
16	Korean	ko
17	Dutch	nl
18	Swedish	sv
19	Greek	el
20	Polish	pl
21	Tamil	ta
22	Malayalam	ml
\.


--
-- Data for Name: login_history; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.login_history (id, user_id, login_time, ip_address) FROM stdin;
\.


--
-- Data for Name: moderator_accounts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.moderator_accounts (user_id) FROM stdin;
18
20
\.


--
-- Data for Name: publication_houses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.publication_houses (id, name, address, country, contact_email) FROM stdin;
1	Penguin Random House	1745 Broadway, New York, NY 10019	United States	contact@penguinrandomhouse.com
2	HarperCollins	195 Broadway, New York, NY 10007	United States	info@harpercollins.com
3	Simon & Schuster	1230 Avenue of the Americas, New York, NY 10020	United States	info@simonandschuster.com
4	Houghton Mifflin Harcourt	125 High Street, Boston, MA 02110	United States	contact@hmhco.com
5	Vintage Books	20 Vauxhall Bridge Road, London SW1V 2SA	United Kingdom	info@vintage-books.co.uk
6	Bloomsbury Publishing	50 Bedford Square, London WC1B 3DP	United Kingdom	info@bloomsbury.com
7	Gallimard	5 Rue Gaston Gallimard, 75007 Paris	France	contact@gallimard.fr
8	Ananda Publishers	13/1A Ballygunge Place, Kolkata, West Bengal 700019	India	contact@anandapub.in
9	Seagull Books	36C S. P. Mukherjee Road, Kolkata 700025	India	info@seagullbooks.org
10	Rokomari Publications	380 Tejgaon Industrial Area, Dhaka 1208	Bangladesh	support@rokomari.com
11	Agamee Prakashani	36 Banglabazar, Dhaka-1100	Bangladesh	agamee.bd@gmail.com
12	Sheba Prokashoni	38 Banglabazar, Dhaka-1100	Bangladesh	info@sheba.com.bd
13	Al Mahmud Library	Shahbagh, Dhaka 1000	Bangladesh	contact@al-mahmudlib.org
14	Shinchosha Publishing	71 Yaraicho, Shinjuku City, Tokyo 162-8711	Japan	info@shinchosha.co.jp
15	Heinemann	Halley Court, Jordan Hill, Oxford OX2 8EJ	United Kingdom	info@heinemann.com
16	Faber and Faber	Bloomsbury House, 74-77 Great Russell St, London WC1B 3DA	United Kingdom	enquiries@faber.co.uk
17	Alianza Editorial	Calle Juan Ignacio Luca de Tena, 17, Madrid	Spain	contacto@alianzaeditorial.es
19	Tor Books	175 Fifth Avenue, New York, NY 10010	United States	info@tor.com
20	Crown Publishing Group	1745 Broadway, New York, NY 10019	United States	contact@crownpublishing.com
21	Canongate Books	14 High Street, Edinburgh EH1 1TE	United Kingdom	info@canongate.co.uk
23	Entangled Publishing	New York, NY	United States	info@entangledpublishing.com
24	Scholastic Press	557 Broadway, New York, NY 10012	United States	contact@scholastic.com
26	Dutton	1290 Avenue of the Americas, New York, NY 10104	United States	contact@duttonbooks.com
\.


--
-- Data for Name: ratings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ratings (id, user_id, book_id, value, created_at) FROM stdin;
\.


--
-- Data for Name: reviews; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reviews (id, book_id, user_id, title, body, rating, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: user_accounts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_accounts (user_id) FROM stdin;
1
2
3
4
5
6
7
8
9
10
11
12
13
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, email, password, username, created_at, profile_picture_url, bio, first_name, last_name, active_status) FROM stdin;
1	john.doe@example.com	hashed_password	johndoe	2025-06-05 13:27:18.805936	https://example.com/profile.jpg	Just a reader.	John	Doe	f
2	alice@example.com	hashed_pass_1	alice123	2025-06-05 13:29:53.56362	http://example.com/alice.jpg	Alice is a passionate reader.	Alice	Allen	f
3	bob@example.com	hashed_pass_2	bobby99	2025-06-05 13:29:53.56362	http://example.com/bob.jpg	Bob likes sci-fi books.	Bob	Allen	f
4	anika.rahman@example.com	password123	anika_rahman	2025-06-22 19:36:44.18794	https://example.com/images/anika.jpg	Bookworm from Dhaka, loves poetry and rain.	Anika	Rahman	f
5	arjun.patel@example.com	securepass456	arjun_p	2025-06-22 19:36:44.18794	https://example.com/images/arjun.jpg	Tech enthusiast from Gujarat. Coffee is life.	Arjun	Patel	f
6	emily.thompson@example.com	mypass789	emilyt	2025-06-22 19:36:44.18794	https://example.com/images/emily.jpg	NYC-based journalist with a love for mystery novels.	Emily	Thompson	f
7	jakub.nowak@example.com	jakub321	jakub_nowak	2025-06-22 19:36:44.18794	https://example.com/images/jakub.jpg	Traveller from Krakow, into history and photography.	Jakub	Nowak	f
8	mahmudul.karim@example.com	karim007	mahmudul_k	2025-06-22 19:36:44.18794	https://example.com/images/karim.jpg	Aspiring author from Chittagong. Writes fiction.	Mahmudul	Karim	f
9	sofia.rossi@example.com	italylove	sofia_r	2025-06-22 19:36:44.18794	https://example.com/images/sofia.jpg	Book reviewer from Florence. Big fan of romance.	Sofia	Rossi	f
10	liam.murphy@example.com	liamirish	liam_murphy	2025-06-22 19:36:44.18794	https://example.com/images/liam.jpg	From Dublin. Fantasy nerd. Tea over coffee always.	Liam	Murphy	f
11	sneha.iyer@example.com	sneha098	sneha_iyer	2025-06-22 19:36:44.18794	https://example.com/images/sneha.jpg	Literature student from Chennai. Bibliophile forever.	Sneha	Iyer	f
12	noah.bennett@example.com	bennett_pass	noahbennett	2025-06-22 19:36:44.18794	https://example.com/images/noah.jpg	Seattle-based coder. Enjoys thriller books.	Noah	Bennet	f
13	aline.dupont@example.com	bonjour123	aline_dupont	2025-06-22 19:36:44.18794	https://example.com/images/aline.jpg	Parisian book lover with a soft spot for classics.	Aline	Dupont	f
15	test@example.com	$2b$10$PU6U4ATQIusDgUokc6qPPuGS3.V9/zoPCmZPGw5apJNz/KB5Tu7Uy	testuser	2025-06-24 21:01:15.277777		I love reading books!	Jalil	Uddin	f
16	tesdjhkjfhat@example.com	$2b$10$PoEGI6JhNyI6DqApZuWtI.4ybaTCtO4iL57eVinNJ1zgQLe6/nyoa	ksjddffhkja	2025-06-24 21:25:14.050238		I love reading books!	Khalil	Uddin	f
17	tesdjhkdfdjfhat@example.com	$2b$10$ejCZRITmt.DFv3VyADIOoe.qK.7JpxoTCBCqkfFU0Ol5QeulZgHw2	ksjdddfdffhkja	2025-06-24 22:42:34.300337		I love reading books!	Khalil	Uddin	f
18	anabildas2003@gmail.com	$2b$10$IgqFThVy5.OmSSE2YEhtO.ilqy0rnRvZWunh7UQLsewIXyyRZ6dVS	anabil	2025-06-24 22:48:40.487592	https://scontent.fdac181-1.fna.fbcdn.net/v/t39.30808-6/504157351_1215671550285575_3822665019208153508_n.jpg?_nc_cat=103&ccb=1-7&_nc_sid=6ee11a&_nc_eui2=AeFLVoW9WhDdoksWFDhdaGiAC5XXNLdXcewLldc0t1dx7Jibma3JJoIpQRPKyd9-ZNOEKZitSVstGJJ7BamcUCFq&_nc_ohc=tZEug1wQv0AQ7kNvwHDO9L5&_nc_oc=AdmdXeLo9LjIJP3SZPF8ql9orTiKi37smLHTT_52vjSmMa0k-CNiZt8_we48qyy4lgw&_nc_zt=23&_nc_ht=scontent.fdac181-1.fna&_nc_gid=MqjVbI1adf6z4-A2k3m2zg&oh=00_AfM8ztVgymcQPOh0UMnvt_DMbsG8biuTmLXGebcpksKLVg&oe=6860F28C	Bookworm from Dhaka	Anabil	Das	t
19	anabilratno@gmail.com	$2b$10$ZHOMMH6qDrya9p3gA.SX4.zMXa7TU.ot/invZkhPccFr2m46t3rzC	qdeqed	2025-06-25 10:49:10.839111			ASDF	aa	f
20	diprairham3223@gmail.com	$2b$10$O4EiPu9Kog.72vbbXariSOSyPKiUrPV1ok6EsCez/fscVljoil9B2	dipra3223	2025-06-25 11:25:43.996847			Irham	Dipra	t
\.


--
-- Data for Name: votes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.votes (id, user_id, review_id, comment_id, vote_type, created_at) FROM stdin;
\.


--
-- Data for Name: wished_books; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.wished_books (user_id, book_id) FROM stdin;
18	4114
18	4117
18	4116
18	1
18	10
\.


--
-- Data for Name: wishlists; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.wishlists (id, user_id, status, added_at) FROM stdin;
\.


--
-- Name: authors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.authors_id_seq', 21, true);


--
-- Name: book_characters_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.book_characters_id_seq', 1, false);


--
-- Name: book_suggestions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.book_suggestions_id_seq', 1, false);


--
-- Name: books_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.books_id_seq', 4121, true);


--
-- Name: comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.comments_id_seq', 1, false);


--
-- Name: genres_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.genres_id_seq', 27, true);


--
-- Name: languages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.languages_id_seq', 23, true);


--
-- Name: login_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.login_history_id_seq', 1, false);


--
-- Name: publication_houses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.publication_houses_id_seq', 26, true);


--
-- Name: ratings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ratings_id_seq', 1, true);


--
-- Name: reviews_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.reviews_id_seq', 1, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 20, true);


--
-- Name: votes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.votes_id_seq', 1, false);


--
-- Name: wishlists_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.wishlists_id_seq', 1, true);


--
-- Name: authors authors_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authors
    ADD CONSTRAINT authors_pkey PRIMARY KEY (id);


--
-- Name: book_authors book_authors_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book_authors
    ADD CONSTRAINT book_authors_pkey PRIMARY KEY (book_id, author_id);


--
-- Name: book_character_appearances book_character_appearances_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book_character_appearances
    ADD CONSTRAINT book_character_appearances_pkey PRIMARY KEY (book_id, character_id);


--
-- Name: book_characters book_characters_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book_characters
    ADD CONSTRAINT book_characters_pkey PRIMARY KEY (id);


--
-- Name: book_suggestions book_suggestions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book_suggestions
    ADD CONSTRAINT book_suggestions_pkey PRIMARY KEY (id);


--
-- Name: books books_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.books
    ADD CONSTRAINT books_pkey PRIMARY KEY (id);


--
-- Name: comments comments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- Name: genres genres_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genres
    ADD CONSTRAINT genres_name_key UNIQUE (name);


--
-- Name: genres genres_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genres
    ADD CONSTRAINT genres_pkey PRIMARY KEY (id);


--
-- Name: languages languages_iso_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.languages
    ADD CONSTRAINT languages_iso_code_key UNIQUE (iso_code);


--
-- Name: languages languages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.languages
    ADD CONSTRAINT languages_pkey PRIMARY KEY (id);


--
-- Name: login_history login_history_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.login_history
    ADD CONSTRAINT login_history_pkey PRIMARY KEY (id);


--
-- Name: moderator_accounts moderator_accounts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.moderator_accounts
    ADD CONSTRAINT moderator_accounts_pkey PRIMARY KEY (user_id);


--
-- Name: publication_houses publication_houses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.publication_houses
    ADD CONSTRAINT publication_houses_pkey PRIMARY KEY (id);


--
-- Name: ratings ratings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ratings
    ADD CONSTRAINT ratings_pkey PRIMARY KEY (id);


--
-- Name: reviews reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_pkey PRIMARY KEY (id);


--
-- Name: user_accounts user_accounts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_accounts
    ADD CONSTRAINT user_accounts_pkey PRIMARY KEY (user_id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: votes votes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.votes
    ADD CONSTRAINT votes_pkey PRIMARY KEY (id);


--
-- Name: wished_books wished_books_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wished_books
    ADD CONSTRAINT wished_books_pkey PRIMARY KEY (user_id, book_id);


--
-- Name: wishlists wishlists_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wishlists
    ADD CONSTRAINT wishlists_pkey PRIMARY KEY (id);


--
-- Name: idx_books_creator; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_books_creator ON public.books USING btree (added_by);


--
-- Name: idx_comments_review_created; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_comments_review_created ON public.comments USING btree (review_id, created_at);


--
-- Name: idx_login_history_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_login_history_user ON public.login_history USING btree (user_id);


--
-- Name: idx_ratings_book; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_ratings_book ON public.ratings USING btree (book_id);


--
-- Name: idx_reviews_book; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_reviews_book ON public.reviews USING btree (book_id);


--
-- Name: idx_votes_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_votes_user ON public.votes USING btree (user_id);


--
-- Name: book_authors book_authors_author_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book_authors
    ADD CONSTRAINT book_authors_author_id_fkey FOREIGN KEY (author_id) REFERENCES public.authors(id) ON DELETE CASCADE;


--
-- Name: book_authors book_authors_book_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book_authors
    ADD CONSTRAINT book_authors_book_id_fkey FOREIGN KEY (book_id) REFERENCES public.books(id) ON DELETE CASCADE;


--
-- Name: book_character_appearances book_character_appearances_book_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book_character_appearances
    ADD CONSTRAINT book_character_appearances_book_id_fkey FOREIGN KEY (book_id) REFERENCES public.books(id) ON DELETE CASCADE;


--
-- Name: book_character_appearances book_character_appearances_character_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book_character_appearances
    ADD CONSTRAINT book_character_appearances_character_id_fkey FOREIGN KEY (character_id) REFERENCES public.book_characters(id) ON DELETE CASCADE;


--
-- Name: book_suggestions book_suggestions_approved_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book_suggestions
    ADD CONSTRAINT book_suggestions_approved_by_fkey FOREIGN KEY (approved_by) REFERENCES public.moderator_accounts(user_id);


--
-- Name: book_suggestions book_suggestions_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book_suggestions
    ADD CONSTRAINT book_suggestions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.user_accounts(user_id) ON DELETE CASCADE;


--
-- Name: books books_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.books
    ADD CONSTRAINT books_created_by_fkey FOREIGN KEY (added_by) REFERENCES public.users(id);


--
-- Name: books books_genre_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.books
    ADD CONSTRAINT books_genre_id_fkey FOREIGN KEY (genre_id) REFERENCES public.genres(id) ON DELETE CASCADE;


--
-- Name: books books_language_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.books
    ADD CONSTRAINT books_language_id_fkey FOREIGN KEY (language_id) REFERENCES public.languages(id) ON DELETE CASCADE;


--
-- Name: books books_publication_house_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.books
    ADD CONSTRAINT books_publication_house_id_fkey FOREIGN KEY (publication_house_id) REFERENCES public.publication_houses(id) ON DELETE CASCADE;


--
-- Name: comments comments_parent_comment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_parent_comment_id_fkey FOREIGN KEY (parent_comment_id) REFERENCES public.comments(id) ON DELETE CASCADE;


--
-- Name: comments comments_review_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_review_id_fkey FOREIGN KEY (review_id) REFERENCES public.reviews(id) ON DELETE CASCADE;


--
-- Name: comments comments_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: login_history login_history_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.login_history
    ADD CONSTRAINT login_history_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: moderator_accounts moderator_accounts_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.moderator_accounts
    ADD CONSTRAINT moderator_accounts_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: ratings ratings_book_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ratings
    ADD CONSTRAINT ratings_book_id_fkey FOREIGN KEY (book_id) REFERENCES public.books(id) ON DELETE CASCADE;


--
-- Name: ratings ratings_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ratings
    ADD CONSTRAINT ratings_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: reviews reviews_book_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_book_id_fkey FOREIGN KEY (book_id) REFERENCES public.books(id) ON DELETE CASCADE;


--
-- Name: reviews reviews_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: user_accounts user_accounts_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_accounts
    ADD CONSTRAINT user_accounts_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: votes votes_comment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.votes
    ADD CONSTRAINT votes_comment_id_fkey FOREIGN KEY (comment_id) REFERENCES public.comments(id) ON DELETE CASCADE;


--
-- Name: votes votes_review_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.votes
    ADD CONSTRAINT votes_review_id_fkey FOREIGN KEY (review_id) REFERENCES public.reviews(id) ON DELETE CASCADE;


--
-- Name: votes votes_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.votes
    ADD CONSTRAINT votes_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: wished_books wished_books_book_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wished_books
    ADD CONSTRAINT wished_books_book_id_fkey FOREIGN KEY (book_id) REFERENCES public.books(id) ON DELETE CASCADE;


--
-- Name: wished_books wished_books_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wished_books
    ADD CONSTRAINT wished_books_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: wishlists wishlists_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wishlists
    ADD CONSTRAINT wishlists_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.user_accounts(user_id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

