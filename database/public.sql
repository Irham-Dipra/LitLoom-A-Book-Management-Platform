/*
 Navicat Premium Dump SQL

 Source Server         : litloom
 Source Server Type    : PostgreSQL
 Source Server Version : 160009 (160009)
 Source Host           : localhost:5432
 Source Catalog        : litloom
 Source Schema         : public

 Target Server Type    : PostgreSQL
 Target Server Version : 160009 (160009)
 File Encoding         : 65001

 Date: 11/07/2025 15:55:03
*/


-- ----------------------------
-- Sequence structure for authors_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."authors_id_seq";
CREATE SEQUENCE "public"."authors_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;
ALTER SEQUENCE "public"."authors_id_seq" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for book_characters_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."book_characters_id_seq";
CREATE SEQUENCE "public"."book_characters_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;
ALTER SEQUENCE "public"."book_characters_id_seq" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for book_suggestions_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."book_suggestions_id_seq";
CREATE SEQUENCE "public"."book_suggestions_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;
ALTER SEQUENCE "public"."book_suggestions_id_seq" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for books_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."books_id_seq";
CREATE SEQUENCE "public"."books_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;
ALTER SEQUENCE "public"."books_id_seq" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for comments_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."comments_id_seq";
CREATE SEQUENCE "public"."comments_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;
ALTER SEQUENCE "public"."comments_id_seq" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for genres_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."genres_id_seq";
CREATE SEQUENCE "public"."genres_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;
ALTER SEQUENCE "public"."genres_id_seq" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for languages_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."languages_id_seq";
CREATE SEQUENCE "public"."languages_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;
ALTER SEQUENCE "public"."languages_id_seq" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for login_history_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."login_history_id_seq";
CREATE SEQUENCE "public"."login_history_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;
ALTER SEQUENCE "public"."login_history_id_seq" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for publication_houses_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."publication_houses_id_seq";
CREATE SEQUENCE "public"."publication_houses_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;
ALTER SEQUENCE "public"."publication_houses_id_seq" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for ratings_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."ratings_id_seq";
CREATE SEQUENCE "public"."ratings_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;
ALTER SEQUENCE "public"."ratings_id_seq" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for reviews_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."reviews_id_seq";
CREATE SEQUENCE "public"."reviews_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;
ALTER SEQUENCE "public"."reviews_id_seq" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for user_books_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."user_books_id_seq";
CREATE SEQUENCE "public"."user_books_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;
ALTER SEQUENCE "public"."user_books_id_seq" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for users_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."users_id_seq";
CREATE SEQUENCE "public"."users_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;
ALTER SEQUENCE "public"."users_id_seq" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for votes_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."votes_id_seq";
CREATE SEQUENCE "public"."votes_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;
ALTER SEQUENCE "public"."votes_id_seq" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for wishlists_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."wishlists_id_seq";
CREATE SEQUENCE "public"."wishlists_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;
ALTER SEQUENCE "public"."wishlists_id_seq" OWNER TO "postgres";

-- ----------------------------
-- Table structure for authors
-- ----------------------------
DROP TABLE IF EXISTS "public"."authors";
CREATE TABLE "public"."authors" (
  "id" int4 NOT NULL DEFAULT nextval('authors_id_seq'::regclass),
  "name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "bio" text COLLATE "pg_catalog"."default",
  "date_of_birth" date NOT NULL,
  "country" varchar(100) COLLATE "pg_catalog"."default" NOT NULL
)
;
ALTER TABLE "public"."authors" OWNER TO "postgres";

-- ----------------------------
-- Records of authors
-- ----------------------------
BEGIN;
INSERT INTO "public"."authors" ("id", "name", "bio", "date_of_birth", "country") VALUES (1, 'Gabriel García Márquez', 'Colombian novelist and Nobel laureate known for magical realism, especially in "One Hundred Years of Solitude".', '1927-03-06', 'Colombia');
INSERT INTO "public"."authors" ("id", "name", "bio", "date_of_birth", "country") VALUES (2, 'Rabindranath Tagore', 'Bengali polymath, poet, and the first non-European to win the Nobel Prize in Literature.', '1861-05-07', 'India');
INSERT INTO "public"."authors" ("id", "name", "bio", "date_of_birth", "country") VALUES (3, 'Haruki Murakami', 'Japanese author known for blending pop culture, surrealism, and melancholy in works like "Norwegian Wood" and "Kafka on the Shore".', '1949-01-12', 'Japan');
INSERT INTO "public"."authors" ("id", "name", "bio", "date_of_birth", "country") VALUES (4, 'Chinua Achebe', 'Nigerian writer best known for his novel "Things Fall Apart", a cornerstone of African literature.', '1930-11-16', 'Nigeria');
INSERT INTO "public"."authors" ("id", "name", "bio", "date_of_birth", "country") VALUES (6, 'Humayun Ahmed', 'Bangladeshi author and filmmaker, famous for his fiction and characters like Himu and Misir Ali.', '1948-11-13', 'Bangladesh');
INSERT INTO "public"."authors" ("id", "name", "bio", "date_of_birth", "country") VALUES (5, 'Virginia Woolf', 'English writer and modernist pioneer, known for "Mrs Dalloway" and "To the Lighthouse".', '1882-01-25', 'United Kingdom');
INSERT INTO "public"."authors" ("id", "name", "bio", "date_of_birth", "country") VALUES (7, 'Sylvia Plath', 'American poet and novelist, known for her confessional style and "The Bell Jar".', '1932-10-27', 'United States');
INSERT INTO "public"."authors" ("id", "name", "bio", "date_of_birth", "country") VALUES (8, 'Leo Tolstoy', 'Russian writer famous for epic novels like "War and Peace" and "Anna Karenina".', '1828-09-09', 'Russia');
INSERT INTO "public"."authors" ("id", "name", "bio", "date_of_birth", "country") VALUES (9, 'Kazi Nazrul Islam', 'Revolutionary Bengali poet, writer, and musician, known as the "Rebel Poet" of Bengal.', '1899-05-24', 'Bangladesh');
INSERT INTO "public"."authors" ("id", "name", "bio", "date_of_birth", "country") VALUES (10, 'George Orwell', 'British author known for dystopian classics like "1984" and "Animal Farm".', '1903-06-25', 'United Kingdom');
INSERT INTO "public"."authors" ("id", "name", "bio", "date_of_birth", "country") VALUES (12, 'V.E. Schwab', 'Victoria Schwab is known for fantasy novels blending dark magic and human emotion.', '1987-07-07', 'United States');
INSERT INTO "public"."authors" ("id", "name", "bio", "date_of_birth", "country") VALUES (13, 'T.J. Klune', 'American author of fantasy and romance with LGBTQ+ representation.', '1982-05-20', 'United States');
INSERT INTO "public"."authors" ("id", "name", "bio", "date_of_birth", "country") VALUES (14, 'Andy Weir', 'Former software engineer and author of science fiction bestsellers.', '1972-06-16', 'United States');
INSERT INTO "public"."authors" ("id", "name", "bio", "date_of_birth", "country") VALUES (15, 'Matt Haig', 'British author of fiction and nonfiction exploring mental health and the human experience.', '1975-07-03', 'United Kingdom');
INSERT INTO "public"."authors" ("id", "name", "bio", "date_of_birth", "country") VALUES (16, 'Jennette McCurdy', 'Actress and author, known for her memoir on childhood trauma and healing.', '1992-06-26', 'United States');
INSERT INTO "public"."authors" ("id", "name", "bio", "date_of_birth", "country") VALUES (17, 'Rebecca Yarros', 'American writer best known for emotionally charged romance and fantasy.', '1981-12-14', 'United States');
INSERT INTO "public"."authors" ("id", "name", "bio", "date_of_birth", "country") VALUES (18, 'Suzanne Collins', 'Creator of *The Hunger Games* series, known for dystopian fiction.', '1962-08-10', 'United States');
INSERT INTO "public"."authors" ("id", "name", "bio", "date_of_birth", "country") VALUES (19, 'Susanna Clarke', 'British author whose work blends historical fiction and fantasy.', '1959-11-01', 'United Kingdom');
INSERT INTO "public"."authors" ("id", "name", "bio", "date_of_birth", "country") VALUES (20, 'Kate Elizabeth Russell', 'American author of controversial and introspective psychological fiction.', '1984-07-16', 'United States');
INSERT INTO "public"."authors" ("id", "name", "bio", "date_of_birth", "country") VALUES (21, 'Sarah J. Maas', 'Bestselling fantasy author known for high-stakes romance and action.', '1986-03-05', 'United States');
COMMIT;

-- ----------------------------
-- Table structure for book_authors
-- ----------------------------
DROP TABLE IF EXISTS "public"."book_authors";
CREATE TABLE "public"."book_authors" (
  "book_id" int4 NOT NULL,
  "author_id" int4 NOT NULL
)
;
ALTER TABLE "public"."book_authors" OWNER TO "postgres";

-- ----------------------------
-- Records of book_authors
-- ----------------------------
BEGIN;
INSERT INTO "public"."book_authors" ("book_id", "author_id") VALUES (4110, 12);
INSERT INTO "public"."book_authors" ("book_id", "author_id") VALUES (4111, 13);
INSERT INTO "public"."book_authors" ("book_id", "author_id") VALUES (4114, 14);
INSERT INTO "public"."book_authors" ("book_id", "author_id") VALUES (4115, 15);
INSERT INTO "public"."book_authors" ("book_id", "author_id") VALUES (4116, 16);
INSERT INTO "public"."book_authors" ("book_id", "author_id") VALUES (4117, 17);
INSERT INTO "public"."book_authors" ("book_id", "author_id") VALUES (4118, 18);
INSERT INTO "public"."book_authors" ("book_id", "author_id") VALUES (4119, 19);
INSERT INTO "public"."book_authors" ("book_id", "author_id") VALUES (4120, 20);
INSERT INTO "public"."book_authors" ("book_id", "author_id") VALUES (4121, 21);
INSERT INTO "public"."book_authors" ("book_id", "author_id") VALUES (1, 1);
INSERT INTO "public"."book_authors" ("book_id", "author_id") VALUES (2, 2);
INSERT INTO "public"."book_authors" ("book_id", "author_id") VALUES (3, 3);
INSERT INTO "public"."book_authors" ("book_id", "author_id") VALUES (4, 4);
INSERT INTO "public"."book_authors" ("book_id", "author_id") VALUES (5, 6);
INSERT INTO "public"."book_authors" ("book_id", "author_id") VALUES (6, 7);
INSERT INTO "public"."book_authors" ("book_id", "author_id") VALUES (7, 8);
INSERT INTO "public"."book_authors" ("book_id", "author_id") VALUES (8, 5);
INSERT INTO "public"."book_authors" ("book_id", "author_id") VALUES (9, 9);
INSERT INTO "public"."book_authors" ("book_id", "author_id") VALUES (10, 10);
INSERT INTO "public"."book_authors" ("book_id", "author_id") VALUES (4122, 1);
COMMIT;

-- ----------------------------
-- Table structure for book_character_appearances
-- ----------------------------
DROP TABLE IF EXISTS "public"."book_character_appearances";
CREATE TABLE "public"."book_character_appearances" (
  "book_id" int4 NOT NULL,
  "character_id" int4 NOT NULL
)
;
ALTER TABLE "public"."book_character_appearances" OWNER TO "postgres";

-- ----------------------------
-- Records of book_character_appearances
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for book_characters
-- ----------------------------
DROP TABLE IF EXISTS "public"."book_characters";
CREATE TABLE "public"."book_characters" (
  "id" int4 NOT NULL DEFAULT nextval('book_characters_id_seq'::regclass),
  "name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "role" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "date_of_birth" date,
  "description" text COLLATE "pg_catalog"."default" NOT NULL,
  "fictional_age" int4 NOT NULL,
  "gender" varchar(20) COLLATE "pg_catalog"."default" NOT NULL
)
;
ALTER TABLE "public"."book_characters" OWNER TO "postgres";

-- ----------------------------
-- Records of book_characters
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for book_suggestions
-- ----------------------------
DROP TABLE IF EXISTS "public"."book_suggestions";
CREATE TABLE "public"."book_suggestions" (
  "id" int4 NOT NULL DEFAULT nextval('book_suggestions_id_seq'::regclass),
  "user_id" int4 NOT NULL,
  "title" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "author_name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "description" text COLLATE "pg_catalog"."default",
  "language" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "genre" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "submitted_at" timestamp(6) NOT NULL,
  "approved" char(1) COLLATE "pg_catalog"."default" NOT NULL DEFAULT '0'::bpchar,
  "approved_at" timestamp(6),
  "approved_by" int4
)
;
ALTER TABLE "public"."book_suggestions" OWNER TO "postgres";

-- ----------------------------
-- Records of book_suggestions
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for books
-- ----------------------------
DROP TABLE IF EXISTS "public"."books";
CREATE TABLE "public"."books" (
  "id" int4 NOT NULL DEFAULT nextval('books_id_seq'::regclass),
  "title" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "description" text COLLATE "pg_catalog"."default",
  "publication_date" date,
  "cover_image" varchar(500) COLLATE "pg_catalog"."default",
  "original_country" varchar(100) COLLATE "pg_catalog"."default",
  "language_id" int4,
  "genre_id" int4,
  "publication_house_id" int4,
  "pdf_url" varchar(500) COLLATE "pg_catalog"."default",
  "average_rating" numeric(3,2) DEFAULT 0,
  "created_at" timestamp(6) DEFAULT CURRENT_TIMESTAMP,
  "added_by" int4
)
;
ALTER TABLE "public"."books" OWNER TO "postgres";

-- ----------------------------
-- Records of books
-- ----------------------------
BEGIN;
INSERT INTO "public"."books" ("id", "title", "description", "publication_date", "cover_image", "original_country", "language_id", "genre_id", "publication_house_id", "pdf_url", "average_rating", "created_at", "added_by") VALUES (4110, 'The Invisible Life of Addie LaRue', 'A young woman makes a Faustian bargain to live forever but is cursed to be forgotten by everyone she meets.', '2020-10-06', 'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1584633432i/50623864.jpg', 'United States', 1, 3, 19, 'https://example.com/pdfs/invisible_life_addie_larue.pdf', 4.20, '2025-06-25 00:02:31.071762', 1);
INSERT INTO "public"."books" ("id", "title", "description", "publication_date", "cover_image", "original_country", "language_id", "genre_id", "publication_house_id", "pdf_url", "average_rating", "created_at", "added_by") VALUES (4111, 'The House in the Cerulean Sea', 'A charming tale of a caseworker sent to a magical orphanage, discovering love and acceptance.', '2020-03-17', 'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1569514209i/45047384.jpg', 'United States', 1, 3, 19, 'https://example.com/pdfs/house_cerulean_sea.pdf', 4.40, '2025-06-25 00:02:31.071762', 1);
INSERT INTO "public"."books" ("id", "title", "description", "publication_date", "cover_image", "original_country", "language_id", "genre_id", "publication_house_id", "pdf_url", "average_rating", "created_at", "added_by") VALUES (4114, 'Project Hail Mary', 'A lone astronaut wakes up on a spaceship with no memory and must save Earth from disaster.', '2021-05-04', 'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1597695864i/54493401.jpg', 'United States', 1, 4, 20, 'https://example.com/pdfs/project_hail_mary.pdf', 4.50, '2025-06-25 00:05:48.888889', 1);
INSERT INTO "public"."books" ("id", "title", "description", "publication_date", "cover_image", "original_country", "language_id", "genre_id", "publication_house_id", "pdf_url", "average_rating", "created_at", "added_by") VALUES (4115, 'The Midnight Library', 'Between life and death lies a library where every book represents a different path life could have taken.', '2020-08-13', 'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1602190253i/52578297.jpg', 'United Kingdom', 1, 3, 21, 'https://example.com/pdfs/midnight_library.pdf', 4.10, '2025-06-25 00:05:48.888889', 1);
INSERT INTO "public"."books" ("id", "title", "description", "publication_date", "cover_image", "original_country", "language_id", "genre_id", "publication_house_id", "pdf_url", "average_rating", "created_at", "added_by") VALUES (4116, 'I’m Glad My Mom Died', 'A raw and honest memoir by Jennette McCurdy about her complicated relationship with her mother and healing.', '2022-08-09', 'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1649286799i/59364173.jpg', 'United States', 1, 26, 3, 'https://example.com/pdfs/im_glad_my_mom_died.pdf', 4.70, '2025-06-25 00:09:02.151792', 1);
INSERT INTO "public"."books" ("id", "title", "description", "publication_date", "cover_image", "original_country", "language_id", "genre_id", "publication_house_id", "pdf_url", "average_rating", "created_at", "added_by") VALUES (4117, 'Fourth Wing', 'A fierce young woman trains in a deadly military academy in a world of dragons and political intrigue.', '2023-05-02', 'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1701980900i/61431922.jpg', 'United States', 1, 3, 23, 'https://example.com/pdfs/fourth_wing.pdf', 4.30, '2025-06-25 00:09:02.151792', 1);
INSERT INTO "public"."books" ("id", "title", "description", "publication_date", "cover_image", "original_country", "language_id", "genre_id", "publication_house_id", "pdf_url", "average_rating", "created_at", "added_by") VALUES (4118, 'The Ballad of Songbirds and Snakes', 'A prequel to The Hunger Games, following the rise of a young Coriolanus Snow.', '2020-05-19', 'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1593892032i/51901147.jpg', 'United States', 1, 27, 24, 'https://example.com/pdfs/ballad_songbirds_snakes.pdf', 4.00, '2025-06-25 00:09:51.435282', 1);
INSERT INTO "public"."books" ("id", "title", "description", "publication_date", "cover_image", "original_country", "language_id", "genre_id", "publication_house_id", "pdf_url", "average_rating", "created_at", "added_by") VALUES (4119, 'Piranesi', 'A surreal and mysterious tale of a man living in a strange, labyrinthine house filled with statues.', '2020-09-15', 'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1609095173i/50202953.jpg', 'United Kingdom', 1, 3, 6, 'https://example.com/pdfs/piranesi.pdf', 4.10, '2025-06-25 00:09:51.435282', 1);
INSERT INTO "public"."books" ("id", "title", "description", "publication_date", "cover_image", "original_country", "language_id", "genre_id", "publication_house_id", "pdf_url", "average_rating", "created_at", "added_by") VALUES (4120, 'My Dark Vanessa', 'A gripping psychological thriller exploring a complex and controversial relationship.', '2020-06-02', 'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1583447793i/44890081.jpg', 'United States', 1, 6, 26, 'https://example.com/pdfs/my_dark_vanessa.pdf', 4.00, '2025-06-25 00:09:51.435282', 1);
INSERT INTO "public"."books" ("id", "title", "description", "publication_date", "cover_image", "original_country", "language_id", "genre_id", "publication_house_id", "pdf_url", "average_rating", "created_at", "added_by") VALUES (4121, 'House of Earth and Blood', 'The first book in a fantasy series about a woman caught between gods, demons, and mortal politics.', '2020-03-03', 'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1559142847i/44778083.jpg', 'United States', 1, 3, 6, 'https://example.com/pdfs/house_earth_blood.pdf', 4.20, '2025-06-25 00:09:51.435282', 1);
INSERT INTO "public"."books" ("id", "title", "description", "publication_date", "cover_image", "original_country", "language_id", "genre_id", "publication_house_id", "pdf_url", "average_rating", "created_at", "added_by") VALUES (4122, 'fkldsj', 'dskfhkjsadh', '2025-07-09', 'jhskjfka', 'ds,fnkl', 7, 2, 8, 'dskljfklsjdf', 0.00, '2025-07-09 07:10:12.286151', 1);
INSERT INTO "public"."books" ("id", "title", "description", "publication_date", "cover_image", "original_country", "language_id", "genre_id", "publication_house_id", "pdf_url", "average_rating", "created_at", "added_by") VALUES (1, 'One Hundred Years of Solitude', 'A multi-generational tale of the Buendía family, blending magical realism with political and social commentary.', '1967-05-30', 'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1327881361i/320.jpg', 'Colombia', 4, 1, 17, 'https://example.com/pdfs/solitude.pdf', 4.70, '2025-06-22 21:19:18.608485', 1);
INSERT INTO "public"."books" ("id", "title", "description", "publication_date", "cover_image", "original_country", "language_id", "genre_id", "publication_house_id", "pdf_url", "average_rating", "created_at", "added_by") VALUES (2, 'Gitanjali', 'A collection of poems reflecting devotion, love, and spirituality that earned Tagore the Nobel Prize.', '1910-08-14', 'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1348514071i/66414.jpg', 'India', 2, 11, 8, 'https://example.com/pdfs/gitanjali.pdf', 4.50, '2025-06-22 21:19:18.608485', 2);
INSERT INTO "public"."books" ("id", "title", "description", "publication_date", "cover_image", "original_country", "language_id", "genre_id", "publication_house_id", "pdf_url", "average_rating", "created_at", "added_by") VALUES (3, 'Kafka on the Shore', 'A metaphysical and surreal novel following a runaway teenager and a man who can talk to cats.', '2002-09-12', 'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1429638085i/4929.jpg', 'Japan', 11, 3, 14, 'https://example.com/pdfs/kafka.pdf', 4.30, '2025-06-22 21:19:18.608485', 3);
INSERT INTO "public"."books" ("id", "title", "description", "publication_date", "cover_image", "original_country", "language_id", "genre_id", "publication_house_id", "pdf_url", "average_rating", "created_at", "added_by") VALUES (4, 'Things Fall Apart', 'A powerful novel about pre-colonial life in Nigeria and the impact of European colonialism.', '1958-06-17', 'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1645022990i/60316758.jpg', 'Nigeria', 1, 1, 15, 'https://example.com/pdfs/thingsfallapart.pdf', 4.60, '2025-06-22 21:19:18.608485', 4);
INSERT INTO "public"."books" ("id", "title", "description", "publication_date", "cover_image", "original_country", "language_id", "genre_id", "publication_house_id", "pdf_url", "average_rating", "created_at", "added_by") VALUES (5, 'Himu', 'The story of a free-spirited young man who walks barefoot and questions society through his simplicity.', '1990-03-01', 'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1627028538i/58612471.jpg', 'Bangladesh', 2, 1, 11, 'https://example.com/pdfs/himu.pdf', 4.40, '2025-06-22 21:19:18.608485', 5);
INSERT INTO "public"."books" ("id", "title", "description", "publication_date", "cover_image", "original_country", "language_id", "genre_id", "publication_house_id", "pdf_url", "average_rating", "created_at", "added_by") VALUES (6, 'The Bell Jar', 'A semi-autobiographical novel exploring mental illness, identity, and societal expectations.', '1963-01-14', 'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1668645154i/56616095.jpg', 'United States', 1, 1, 16, 'https://example.com/pdfs/belljar.pdf', 4.20, '2025-06-22 21:19:18.608485', 6);
INSERT INTO "public"."books" ("id", "title", "description", "publication_date", "cover_image", "original_country", "language_id", "genre_id", "publication_house_id", "pdf_url", "average_rating", "created_at", "added_by") VALUES (8, 'Mrs Dalloway', 'A modernist novel capturing one day in the life of Clarissa Dalloway, rich with inner thought and stream-of-consciousness.', '1925-05-14', 'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1646148221i/14942.jpg', 'United Kingdom', 1, 1, 16, 'https://example.com/pdfs/mrsdalloway.pdf', 4.10, '2025-06-22 21:19:18.608485', 8);
INSERT INTO "public"."books" ("id", "title", "description", "publication_date", "cover_image", "original_country", "language_id", "genre_id", "publication_house_id", "pdf_url", "average_rating", "created_at", "added_by") VALUES (9, 'Shonchita', 'A collection of revolutionary poems challenging oppression and injustice in colonial Bengal.', '1922-08-01', 'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1505814718i/17201996.jpg', 'Bangladesh', 2, 11, 12, 'https://example.com/pdfs/rebelpoetry.pdf', 4.60, '2025-06-22 21:19:18.608485', 9);
INSERT INTO "public"."books" ("id", "title", "description", "publication_date", "cover_image", "original_country", "language_id", "genre_id", "publication_house_id", "pdf_url", "average_rating", "created_at", "added_by") VALUES (10, '1984', 'A dystopian novel depicting a totalitarian regime that surveils, manipulates, and erases truth.', '1949-06-08', 'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1657781256i/61439040.jpg', 'United Kingdom', 1, 6, 1, 'https://example.com/pdfs/1984.pdf', 4.90, '2025-06-22 21:19:18.608485', 10);
INSERT INTO "public"."books" ("id", "title", "description", "publication_date", "cover_image", "original_country", "language_id", "genre_id", "publication_house_id", "pdf_url", "average_rating", "created_at", "added_by") VALUES (7, 'War and Peace', 'A historical epic interweaving personal lives and military campaigns during the Napoleonic era.', '1869-01-01', 'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1413215930i/656.jpg', 'Russia', 1, 8, 5, 'https://example.com/pdfs/warpeace.pdf', 4.80, '2025-06-22 21:19:18.608485', 7);
COMMIT;

-- ----------------------------
-- Table structure for comments
-- ----------------------------
DROP TABLE IF EXISTS "public"."comments";
CREATE TABLE "public"."comments" (
  "id" int4 NOT NULL DEFAULT nextval('comments_id_seq'::regclass),
  "review_id" int4 NOT NULL,
  "user_id" int4 NOT NULL,
  "body" text COLLATE "pg_catalog"."default" NOT NULL,
  "parent_comment_id" int4,
  "created_at" timestamp(6) NOT NULL
)
;
ALTER TABLE "public"."comments" OWNER TO "postgres";

-- ----------------------------
-- Records of comments
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for genres
-- ----------------------------
DROP TABLE IF EXISTS "public"."genres";
CREATE TABLE "public"."genres" (
  "id" int4 NOT NULL DEFAULT nextval('genres_id_seq'::regclass),
  "name" varchar(100) COLLATE "pg_catalog"."default" NOT NULL
)
;
ALTER TABLE "public"."genres" OWNER TO "postgres";

-- ----------------------------
-- Records of genres
-- ----------------------------
BEGIN;
INSERT INTO "public"."genres" ("id", "name") VALUES (1, 'Fiction');
INSERT INTO "public"."genres" ("id", "name") VALUES (2, 'Non-Fiction');
INSERT INTO "public"."genres" ("id", "name") VALUES (3, 'Fantasy');
INSERT INTO "public"."genres" ("id", "name") VALUES (4, 'Science Fiction');
INSERT INTO "public"."genres" ("id", "name") VALUES (5, 'Mystery');
INSERT INTO "public"."genres" ("id", "name") VALUES (6, 'Thriller');
INSERT INTO "public"."genres" ("id", "name") VALUES (7, 'Romance');
INSERT INTO "public"."genres" ("id", "name") VALUES (8, 'Historical');
INSERT INTO "public"."genres" ("id", "name") VALUES (9, 'Biography');
INSERT INTO "public"."genres" ("id", "name") VALUES (10, 'Self-Help');
INSERT INTO "public"."genres" ("id", "name") VALUES (11, 'Poetry');
INSERT INTO "public"."genres" ("id", "name") VALUES (12, 'Horror');
INSERT INTO "public"."genres" ("id", "name") VALUES (13, 'Young Adult');
INSERT INTO "public"."genres" ("id", "name") VALUES (14, 'Classics');
INSERT INTO "public"."genres" ("id", "name") VALUES (15, 'Graphic Novel');
INSERT INTO "public"."genres" ("id", "name") VALUES (16, 'Philosophy');
INSERT INTO "public"."genres" ("id", "name") VALUES (17, 'Science');
INSERT INTO "public"."genres" ("id", "name") VALUES (18, 'Travel');
INSERT INTO "public"."genres" ("id", "name") VALUES (19, 'Religion');
INSERT INTO "public"."genres" ("id", "name") VALUES (20, 'Drama');
INSERT INTO "public"."genres" ("id", "name") VALUES (26, 'Memoir');
INSERT INTO "public"."genres" ("id", "name") VALUES (27, 'Historical Fiction');
INSERT INTO "public"."genres" ("id", "name") VALUES (28, 'new genre');
COMMIT;

-- ----------------------------
-- Table structure for languages
-- ----------------------------
DROP TABLE IF EXISTS "public"."languages";
CREATE TABLE "public"."languages" (
  "id" int4 NOT NULL DEFAULT nextval('languages_id_seq'::regclass),
  "name" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "iso_code" varchar(10) COLLATE "pg_catalog"."default" NOT NULL
)
;
ALTER TABLE "public"."languages" OWNER TO "postgres";

-- ----------------------------
-- Records of languages
-- ----------------------------
BEGIN;
INSERT INTO "public"."languages" ("id", "name", "iso_code") VALUES (1, 'English', 'en');
INSERT INTO "public"."languages" ("id", "name", "iso_code") VALUES (2, 'Bengali', 'bn');
INSERT INTO "public"."languages" ("id", "name", "iso_code") VALUES (3, 'Hindi', 'hi');
INSERT INTO "public"."languages" ("id", "name", "iso_code") VALUES (4, 'Spanish', 'es');
INSERT INTO "public"."languages" ("id", "name", "iso_code") VALUES (5, 'French', 'fr');
INSERT INTO "public"."languages" ("id", "name", "iso_code") VALUES (6, 'Chinese', 'zh');
INSERT INTO "public"."languages" ("id", "name", "iso_code") VALUES (7, 'Arabic', 'ar');
INSERT INTO "public"."languages" ("id", "name", "iso_code") VALUES (8, 'Russian', 'ru');
INSERT INTO "public"."languages" ("id", "name", "iso_code") VALUES (9, 'German', 'de');
INSERT INTO "public"."languages" ("id", "name", "iso_code") VALUES (10, 'Portuguese', 'pt');
INSERT INTO "public"."languages" ("id", "name", "iso_code") VALUES (11, 'Japanese', 'ja');
INSERT INTO "public"."languages" ("id", "name", "iso_code") VALUES (12, 'Italian', 'it');
INSERT INTO "public"."languages" ("id", "name", "iso_code") VALUES (13, 'Urdu', 'ur');
INSERT INTO "public"."languages" ("id", "name", "iso_code") VALUES (14, 'Persian', 'fa');
INSERT INTO "public"."languages" ("id", "name", "iso_code") VALUES (15, 'Turkish', 'tr');
INSERT INTO "public"."languages" ("id", "name", "iso_code") VALUES (16, 'Korean', 'ko');
INSERT INTO "public"."languages" ("id", "name", "iso_code") VALUES (17, 'Dutch', 'nl');
INSERT INTO "public"."languages" ("id", "name", "iso_code") VALUES (18, 'Swedish', 'sv');
INSERT INTO "public"."languages" ("id", "name", "iso_code") VALUES (19, 'Greek', 'el');
INSERT INTO "public"."languages" ("id", "name", "iso_code") VALUES (20, 'Polish', 'pl');
INSERT INTO "public"."languages" ("id", "name", "iso_code") VALUES (21, 'Tamil', 'ta');
INSERT INTO "public"."languages" ("id", "name", "iso_code") VALUES (22, 'Malayalam', 'ml');
COMMIT;

-- ----------------------------
-- Table structure for login_history
-- ----------------------------
DROP TABLE IF EXISTS "public"."login_history";
CREATE TABLE "public"."login_history" (
  "id" int4 NOT NULL DEFAULT nextval('login_history_id_seq'::regclass),
  "user_id" int4 NOT NULL,
  "login_time" timestamp(6) NOT NULL,
  "ip_address" varchar(45) COLLATE "pg_catalog"."default" NOT NULL
)
;
ALTER TABLE "public"."login_history" OWNER TO "postgres";

-- ----------------------------
-- Records of login_history
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for moderator_accounts
-- ----------------------------
DROP TABLE IF EXISTS "public"."moderator_accounts";
CREATE TABLE "public"."moderator_accounts" (
  "user_id" int4 NOT NULL
)
;
ALTER TABLE "public"."moderator_accounts" OWNER TO "postgres";

-- ----------------------------
-- Records of moderator_accounts
-- ----------------------------
BEGIN;
INSERT INTO "public"."moderator_accounts" ("user_id") VALUES (18);
INSERT INTO "public"."moderator_accounts" ("user_id") VALUES (20);
COMMIT;

-- ----------------------------
-- Table structure for publication_houses
-- ----------------------------
DROP TABLE IF EXISTS "public"."publication_houses";
CREATE TABLE "public"."publication_houses" (
  "id" int4 NOT NULL DEFAULT nextval('publication_houses_id_seq'::regclass),
  "name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "address" varchar(500) COLLATE "pg_catalog"."default" NOT NULL,
  "country" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "contact_email" varchar(255) COLLATE "pg_catalog"."default" NOT NULL
)
;
ALTER TABLE "public"."publication_houses" OWNER TO "postgres";

-- ----------------------------
-- Records of publication_houses
-- ----------------------------
BEGIN;
INSERT INTO "public"."publication_houses" ("id", "name", "address", "country", "contact_email") VALUES (1, 'Penguin Random House', '1745 Broadway, New York, NY 10019', 'United States', 'contact@penguinrandomhouse.com');
INSERT INTO "public"."publication_houses" ("id", "name", "address", "country", "contact_email") VALUES (2, 'HarperCollins', '195 Broadway, New York, NY 10007', 'United States', 'info@harpercollins.com');
INSERT INTO "public"."publication_houses" ("id", "name", "address", "country", "contact_email") VALUES (3, 'Simon & Schuster', '1230 Avenue of the Americas, New York, NY 10020', 'United States', 'info@simonandschuster.com');
INSERT INTO "public"."publication_houses" ("id", "name", "address", "country", "contact_email") VALUES (4, 'Houghton Mifflin Harcourt', '125 High Street, Boston, MA 02110', 'United States', 'contact@hmhco.com');
INSERT INTO "public"."publication_houses" ("id", "name", "address", "country", "contact_email") VALUES (5, 'Vintage Books', '20 Vauxhall Bridge Road, London SW1V 2SA', 'United Kingdom', 'info@vintage-books.co.uk');
INSERT INTO "public"."publication_houses" ("id", "name", "address", "country", "contact_email") VALUES (6, 'Bloomsbury Publishing', '50 Bedford Square, London WC1B 3DP', 'United Kingdom', 'info@bloomsbury.com');
INSERT INTO "public"."publication_houses" ("id", "name", "address", "country", "contact_email") VALUES (7, 'Gallimard', '5 Rue Gaston Gallimard, 75007 Paris', 'France', 'contact@gallimard.fr');
INSERT INTO "public"."publication_houses" ("id", "name", "address", "country", "contact_email") VALUES (8, 'Ananda Publishers', '13/1A Ballygunge Place, Kolkata, West Bengal 700019', 'India', 'contact@anandapub.in');
INSERT INTO "public"."publication_houses" ("id", "name", "address", "country", "contact_email") VALUES (9, 'Seagull Books', '36C S. P. Mukherjee Road, Kolkata 700025', 'India', 'info@seagullbooks.org');
INSERT INTO "public"."publication_houses" ("id", "name", "address", "country", "contact_email") VALUES (10, 'Rokomari Publications', '380 Tejgaon Industrial Area, Dhaka 1208', 'Bangladesh', 'support@rokomari.com');
INSERT INTO "public"."publication_houses" ("id", "name", "address", "country", "contact_email") VALUES (11, 'Agamee Prakashani', '36 Banglabazar, Dhaka-1100', 'Bangladesh', 'agamee.bd@gmail.com');
INSERT INTO "public"."publication_houses" ("id", "name", "address", "country", "contact_email") VALUES (12, 'Sheba Prokashoni', '38 Banglabazar, Dhaka-1100', 'Bangladesh', 'info@sheba.com.bd');
INSERT INTO "public"."publication_houses" ("id", "name", "address", "country", "contact_email") VALUES (13, 'Al Mahmud Library', 'Shahbagh, Dhaka 1000', 'Bangladesh', 'contact@al-mahmudlib.org');
INSERT INTO "public"."publication_houses" ("id", "name", "address", "country", "contact_email") VALUES (14, 'Shinchosha Publishing', '71 Yaraicho, Shinjuku City, Tokyo 162-8711', 'Japan', 'info@shinchosha.co.jp');
INSERT INTO "public"."publication_houses" ("id", "name", "address", "country", "contact_email") VALUES (15, 'Heinemann', 'Halley Court, Jordan Hill, Oxford OX2 8EJ', 'United Kingdom', 'info@heinemann.com');
INSERT INTO "public"."publication_houses" ("id", "name", "address", "country", "contact_email") VALUES (16, 'Faber and Faber', 'Bloomsbury House, 74-77 Great Russell St, London WC1B 3DA', 'United Kingdom', 'enquiries@faber.co.uk');
INSERT INTO "public"."publication_houses" ("id", "name", "address", "country", "contact_email") VALUES (17, 'Alianza Editorial', 'Calle Juan Ignacio Luca de Tena, 17, Madrid', 'Spain', 'contacto@alianzaeditorial.es');
INSERT INTO "public"."publication_houses" ("id", "name", "address", "country", "contact_email") VALUES (19, 'Tor Books', '175 Fifth Avenue, New York, NY 10010', 'United States', 'info@tor.com');
INSERT INTO "public"."publication_houses" ("id", "name", "address", "country", "contact_email") VALUES (20, 'Crown Publishing Group', '1745 Broadway, New York, NY 10019', 'United States', 'contact@crownpublishing.com');
INSERT INTO "public"."publication_houses" ("id", "name", "address", "country", "contact_email") VALUES (21, 'Canongate Books', '14 High Street, Edinburgh EH1 1TE', 'United Kingdom', 'info@canongate.co.uk');
INSERT INTO "public"."publication_houses" ("id", "name", "address", "country", "contact_email") VALUES (23, 'Entangled Publishing', 'New York, NY', 'United States', 'info@entangledpublishing.com');
INSERT INTO "public"."publication_houses" ("id", "name", "address", "country", "contact_email") VALUES (24, 'Scholastic Press', '557 Broadway, New York, NY 10012', 'United States', 'contact@scholastic.com');
INSERT INTO "public"."publication_houses" ("id", "name", "address", "country", "contact_email") VALUES (26, 'Dutton', '1290 Avenue of the Americas, New York, NY 10104', 'United States', 'contact@duttonbooks.com');
COMMIT;

-- ----------------------------
-- Table structure for ratings
-- ----------------------------
DROP TABLE IF EXISTS "public"."ratings";
CREATE TABLE "public"."ratings" (
  "id" int4 NOT NULL DEFAULT nextval('ratings_id_seq'::regclass),
  "user_id" int4 NOT NULL,
  "book_id" int4 NOT NULL,
  "value" int4 NOT NULL,
  "created_at" timestamp(6) NOT NULL
)
;
ALTER TABLE "public"."ratings" OWNER TO "postgres";

-- ----------------------------
-- Records of ratings
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for reviews
-- ----------------------------
DROP TABLE IF EXISTS "public"."reviews";
CREATE TABLE "public"."reviews" (
  "id" int4 NOT NULL DEFAULT nextval('reviews_id_seq'::regclass),
  "book_id" int4 NOT NULL,
  "user_id" int4 NOT NULL,
  "title" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "body" text COLLATE "pg_catalog"."default",
  "rating" int4 NOT NULL,
  "created_at" timestamp(6) NOT NULL,
  "updated_at" timestamp(6) NOT NULL
)
;
ALTER TABLE "public"."reviews" OWNER TO "postgres";

-- ----------------------------
-- Records of reviews
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for user_accounts
-- ----------------------------
DROP TABLE IF EXISTS "public"."user_accounts";
CREATE TABLE "public"."user_accounts" (
  "user_id" int4 NOT NULL
)
;
ALTER TABLE "public"."user_accounts" OWNER TO "postgres";

-- ----------------------------
-- Records of user_accounts
-- ----------------------------
BEGIN;
INSERT INTO "public"."user_accounts" ("user_id") VALUES (1);
INSERT INTO "public"."user_accounts" ("user_id") VALUES (2);
INSERT INTO "public"."user_accounts" ("user_id") VALUES (3);
INSERT INTO "public"."user_accounts" ("user_id") VALUES (4);
INSERT INTO "public"."user_accounts" ("user_id") VALUES (5);
INSERT INTO "public"."user_accounts" ("user_id") VALUES (6);
INSERT INTO "public"."user_accounts" ("user_id") VALUES (7);
INSERT INTO "public"."user_accounts" ("user_id") VALUES (8);
INSERT INTO "public"."user_accounts" ("user_id") VALUES (9);
INSERT INTO "public"."user_accounts" ("user_id") VALUES (10);
INSERT INTO "public"."user_accounts" ("user_id") VALUES (11);
INSERT INTO "public"."user_accounts" ("user_id") VALUES (12);
INSERT INTO "public"."user_accounts" ("user_id") VALUES (13);
COMMIT;

-- ----------------------------
-- Table structure for user_books
-- ----------------------------
DROP TABLE IF EXISTS "public"."user_books";
CREATE TABLE "public"."user_books" (
  "id" int4 NOT NULL DEFAULT nextval('user_books_id_seq'::regclass),
  "user_id" int4 NOT NULL,
  "book_id" int4 NOT NULL,
  "shelf" varchar(50) COLLATE "pg_catalog"."default" NOT NULL DEFAULT 'want-to-read'::character varying,
  "user_rating" int4,
  "date_added" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "date_read" timestamp(6),
  "review_id" int4,
  "notes" text COLLATE "pg_catalog"."default"
)
;
ALTER TABLE "public"."user_books" OWNER TO "postgres";

-- ----------------------------
-- Records of user_books
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS "public"."users";
CREATE TABLE "public"."users" (
  "id" int4 NOT NULL DEFAULT nextval('users_id_seq'::regclass),
  "email" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "password" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "username" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "created_at" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "profile_picture_url" varchar(500) COLLATE "pg_catalog"."default" NOT NULL,
  "bio" text COLLATE "pg_catalog"."default",
  "first_name" varchar(100) COLLATE "pg_catalog"."default",
  "last_name" varchar(100) COLLATE "pg_catalog"."default",
  "active_status" bool NOT NULL DEFAULT false
)
;
ALTER TABLE "public"."users" OWNER TO "postgres";

-- ----------------------------
-- Records of users
-- ----------------------------
BEGIN;
INSERT INTO "public"."users" ("id", "email", "password", "username", "created_at", "profile_picture_url", "bio", "first_name", "last_name", "active_status") VALUES (1, 'john.doe@example.com', 'hashed_password', 'johndoe', '2025-06-05 13:27:18.805936', 'https://example.com/profile.jpg', 'Just a reader.', 'John', 'Doe', 'f');
INSERT INTO "public"."users" ("id", "email", "password", "username", "created_at", "profile_picture_url", "bio", "first_name", "last_name", "active_status") VALUES (2, 'alice@example.com', 'hashed_pass_1', 'alice123', '2025-06-05 13:29:53.56362', 'http://example.com/alice.jpg', 'Alice is a passionate reader.', 'Alice', 'Allen', 'f');
INSERT INTO "public"."users" ("id", "email", "password", "username", "created_at", "profile_picture_url", "bio", "first_name", "last_name", "active_status") VALUES (3, 'bob@example.com', 'hashed_pass_2', 'bobby99', '2025-06-05 13:29:53.56362', 'http://example.com/bob.jpg', 'Bob likes sci-fi books.', 'Bob', 'Allen', 'f');
INSERT INTO "public"."users" ("id", "email", "password", "username", "created_at", "profile_picture_url", "bio", "first_name", "last_name", "active_status") VALUES (4, 'anika.rahman@example.com', 'password123', 'anika_rahman', '2025-06-22 19:36:44.18794', 'https://example.com/images/anika.jpg', 'Bookworm from Dhaka, loves poetry and rain.', 'Anika', 'Rahman', 'f');
INSERT INTO "public"."users" ("id", "email", "password", "username", "created_at", "profile_picture_url", "bio", "first_name", "last_name", "active_status") VALUES (5, 'arjun.patel@example.com', 'securepass456', 'arjun_p', '2025-06-22 19:36:44.18794', 'https://example.com/images/arjun.jpg', 'Tech enthusiast from Gujarat. Coffee is life.', 'Arjun', 'Patel', 'f');
INSERT INTO "public"."users" ("id", "email", "password", "username", "created_at", "profile_picture_url", "bio", "first_name", "last_name", "active_status") VALUES (6, 'emily.thompson@example.com', 'mypass789', 'emilyt', '2025-06-22 19:36:44.18794', 'https://example.com/images/emily.jpg', 'NYC-based journalist with a love for mystery novels.', 'Emily', 'Thompson', 'f');
INSERT INTO "public"."users" ("id", "email", "password", "username", "created_at", "profile_picture_url", "bio", "first_name", "last_name", "active_status") VALUES (7, 'jakub.nowak@example.com', 'jakub321', 'jakub_nowak', '2025-06-22 19:36:44.18794', 'https://example.com/images/jakub.jpg', 'Traveller from Krakow, into history and photography.', 'Jakub', 'Nowak', 'f');
INSERT INTO "public"."users" ("id", "email", "password", "username", "created_at", "profile_picture_url", "bio", "first_name", "last_name", "active_status") VALUES (8, 'mahmudul.karim@example.com', 'karim007', 'mahmudul_k', '2025-06-22 19:36:44.18794', 'https://example.com/images/karim.jpg', 'Aspiring author from Chittagong. Writes fiction.', 'Mahmudul', 'Karim', 'f');
INSERT INTO "public"."users" ("id", "email", "password", "username", "created_at", "profile_picture_url", "bio", "first_name", "last_name", "active_status") VALUES (9, 'sofia.rossi@example.com', 'italylove', 'sofia_r', '2025-06-22 19:36:44.18794', 'https://example.com/images/sofia.jpg', 'Book reviewer from Florence. Big fan of romance.', 'Sofia', 'Rossi', 'f');
INSERT INTO "public"."users" ("id", "email", "password", "username", "created_at", "profile_picture_url", "bio", "first_name", "last_name", "active_status") VALUES (10, 'liam.murphy@example.com', 'liamirish', 'liam_murphy', '2025-06-22 19:36:44.18794', 'https://example.com/images/liam.jpg', 'From Dublin. Fantasy nerd. Tea over coffee always.', 'Liam', 'Murphy', 'f');
INSERT INTO "public"."users" ("id", "email", "password", "username", "created_at", "profile_picture_url", "bio", "first_name", "last_name", "active_status") VALUES (11, 'sneha.iyer@example.com', 'sneha098', 'sneha_iyer', '2025-06-22 19:36:44.18794', 'https://example.com/images/sneha.jpg', 'Literature student from Chennai. Bibliophile forever.', 'Sneha', 'Iyer', 'f');
INSERT INTO "public"."users" ("id", "email", "password", "username", "created_at", "profile_picture_url", "bio", "first_name", "last_name", "active_status") VALUES (12, 'noah.bennett@example.com', 'bennett_pass', 'noahbennett', '2025-06-22 19:36:44.18794', 'https://example.com/images/noah.jpg', 'Seattle-based coder. Enjoys thriller books.', 'Noah', 'Bennet', 'f');
INSERT INTO "public"."users" ("id", "email", "password", "username", "created_at", "profile_picture_url", "bio", "first_name", "last_name", "active_status") VALUES (13, 'aline.dupont@example.com', 'bonjour123', 'aline_dupont', '2025-06-22 19:36:44.18794', 'https://example.com/images/aline.jpg', 'Parisian book lover with a soft spot for classics.', 'Aline', 'Dupont', 'f');
INSERT INTO "public"."users" ("id", "email", "password", "username", "created_at", "profile_picture_url", "bio", "first_name", "last_name", "active_status") VALUES (15, 'test@example.com', '$2b$10$PU6U4ATQIusDgUokc6qPPuGS3.V9/zoPCmZPGw5apJNz/KB5Tu7Uy', 'testuser', '2025-06-24 21:01:15.277777', '', 'I love reading books!', 'Jalil', 'Uddin', 'f');
INSERT INTO "public"."users" ("id", "email", "password", "username", "created_at", "profile_picture_url", "bio", "first_name", "last_name", "active_status") VALUES (16, 'tesdjhkjfhat@example.com', '$2b$10$PoEGI6JhNyI6DqApZuWtI.4ybaTCtO4iL57eVinNJ1zgQLe6/nyoa', 'ksjddffhkja', '2025-06-24 21:25:14.050238', '', 'I love reading books!', 'Khalil', 'Uddin', 'f');
INSERT INTO "public"."users" ("id", "email", "password", "username", "created_at", "profile_picture_url", "bio", "first_name", "last_name", "active_status") VALUES (17, 'tesdjhkdfdjfhat@example.com', '$2b$10$ejCZRITmt.DFv3VyADIOoe.qK.7JpxoTCBCqkfFU0Ol5QeulZgHw2', 'ksjdddfdffhkja', '2025-06-24 22:42:34.300337', '', 'I love reading books!', 'Khalil', 'Uddin', 'f');
INSERT INTO "public"."users" ("id", "email", "password", "username", "created_at", "profile_picture_url", "bio", "first_name", "last_name", "active_status") VALUES (18, 'anabildas2003@gmail.com', '$2b$10$IgqFThVy5.OmSSE2YEhtO.ilqy0rnRvZWunh7UQLsewIXyyRZ6dVS', 'anabil', '2025-06-24 22:48:40.487592', 'https://scontent.fdac181-1.fna.fbcdn.net/v/t39.30808-6/504157351_1215671550285575_3822665019208153508_n.jpg?_nc_cat=103&ccb=1-7&_nc_sid=6ee11a&_nc_eui2=AeFLVoW9WhDdoksWFDhdaGiAC5XXNLdXcewLldc0t1dx7Jibma3JJoIpQRPKyd9-ZNOEKZitSVstGJJ7BamcUCFq&_nc_ohc=tZEug1wQv0AQ7kNvwHDO9L5&_nc_oc=AdmdXeLo9LjIJP3SZPF8ql9orTiKi37smLHTT_52vjSmMa0k-CNiZt8_we48qyy4lgw&_nc_zt=23&_nc_ht=scontent.fdac181-1.fna&_nc_gid=MqjVbI1adf6z4-A2k3m2zg&oh=00_AfM8ztVgymcQPOh0UMnvt_DMbsG8biuTmLXGebcpksKLVg&oe=6860F28C', 'Bookworm from Dhaka', 'Anabil', 'Das', 't');
INSERT INTO "public"."users" ("id", "email", "password", "username", "created_at", "profile_picture_url", "bio", "first_name", "last_name", "active_status") VALUES (20, 'diprairham3223@gmail.com', '$2b$10$O4EiPu9Kog.72vbbXariSOSyPKiUrPV1ok6EsCez/fscVljoil9B2', 'dipra3223', '2025-06-25 11:25:43.996847', '', '', 'Irham', 'Dipra', 't');
INSERT INTO "public"."users" ("id", "email", "password", "username", "created_at", "profile_picture_url", "bio", "first_name", "last_name", "active_status") VALUES (19, 'anabilratno@gmail.com', '$2b$10$ZHOMMH6qDrya9p3gA.SX4.zMXa7TU.ot/invZkhPccFr2m46t3rzC', 'qdeqed', '2025-06-25 10:49:10.839111', '', '', 'ASDF', 'aa', 'f');
COMMIT;

-- ----------------------------
-- Table structure for votes
-- ----------------------------
DROP TABLE IF EXISTS "public"."votes";
CREATE TABLE "public"."votes" (
  "id" int4 NOT NULL DEFAULT nextval('votes_id_seq'::regclass),
  "user_id" int4 NOT NULL,
  "review_id" int4,
  "comment_id" int4,
  "vote_type" varchar(10) COLLATE "pg_catalog"."default" NOT NULL,
  "created_at" timestamp(6) NOT NULL
)
;
ALTER TABLE "public"."votes" OWNER TO "postgres";

-- ----------------------------
-- Records of votes
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for wished_books
-- ----------------------------
DROP TABLE IF EXISTS "public"."wished_books";
CREATE TABLE "public"."wished_books" (
  "user_id" int4 NOT NULL,
  "book_id" int4 NOT NULL
)
;
ALTER TABLE "public"."wished_books" OWNER TO "postgres";

-- ----------------------------
-- Records of wished_books
-- ----------------------------
BEGIN;
INSERT INTO "public"."wished_books" ("user_id", "book_id") VALUES (18, 4114);
INSERT INTO "public"."wished_books" ("user_id", "book_id") VALUES (18, 4117);
INSERT INTO "public"."wished_books" ("user_id", "book_id") VALUES (18, 4116);
INSERT INTO "public"."wished_books" ("user_id", "book_id") VALUES (18, 1);
INSERT INTO "public"."wished_books" ("user_id", "book_id") VALUES (18, 10);
INSERT INTO "public"."wished_books" ("user_id", "book_id") VALUES (20, 4114);
COMMIT;

-- ----------------------------
-- Table structure for wishlists
-- ----------------------------
DROP TABLE IF EXISTS "public"."wishlists";
CREATE TABLE "public"."wishlists" (
  "id" int4 NOT NULL DEFAULT nextval('wishlists_id_seq'::regclass),
  "user_id" int4 NOT NULL,
  "status" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "added_at" timestamp(6) NOT NULL
)
;
ALTER TABLE "public"."wishlists" OWNER TO "postgres";

-- ----------------------------
-- Records of wishlists
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."authors_id_seq"
OWNED BY "public"."authors"."id";
SELECT setval('"public"."authors_id_seq"', 21, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."book_characters_id_seq"
OWNED BY "public"."book_characters"."id";
SELECT setval('"public"."book_characters_id_seq"', 1, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."book_suggestions_id_seq"
OWNED BY "public"."book_suggestions"."id";
SELECT setval('"public"."book_suggestions_id_seq"', 1, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."books_id_seq"
OWNED BY "public"."books"."id";
SELECT setval('"public"."books_id_seq"', 4122, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."comments_id_seq"
OWNED BY "public"."comments"."id";
SELECT setval('"public"."comments_id_seq"', 1, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."genres_id_seq"
OWNED BY "public"."genres"."id";
SELECT setval('"public"."genres_id_seq"', 28, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."languages_id_seq"
OWNED BY "public"."languages"."id";
SELECT setval('"public"."languages_id_seq"', 23, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."login_history_id_seq"
OWNED BY "public"."login_history"."id";
SELECT setval('"public"."login_history_id_seq"', 1, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."publication_houses_id_seq"
OWNED BY "public"."publication_houses"."id";
SELECT setval('"public"."publication_houses_id_seq"', 26, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."ratings_id_seq"
OWNED BY "public"."ratings"."id";
SELECT setval('"public"."ratings_id_seq"', 1, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."reviews_id_seq"
OWNED BY "public"."reviews"."id";
SELECT setval('"public"."reviews_id_seq"', 1, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."user_books_id_seq"
OWNED BY "public"."user_books"."id";
SELECT setval('"public"."user_books_id_seq"', 1, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."users_id_seq"
OWNED BY "public"."users"."id";
SELECT setval('"public"."users_id_seq"', 20, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."votes_id_seq"
OWNED BY "public"."votes"."id";
SELECT setval('"public"."votes_id_seq"', 1, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."wishlists_id_seq"
OWNED BY "public"."wishlists"."id";
SELECT setval('"public"."wishlists_id_seq"', 1, true);

-- ----------------------------
-- Primary Key structure for table authors
-- ----------------------------
ALTER TABLE "public"."authors" ADD CONSTRAINT "authors_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table book_authors
-- ----------------------------
ALTER TABLE "public"."book_authors" ADD CONSTRAINT "book_authors_pkey" PRIMARY KEY ("book_id", "author_id");

-- ----------------------------
-- Primary Key structure for table book_character_appearances
-- ----------------------------
ALTER TABLE "public"."book_character_appearances" ADD CONSTRAINT "book_character_appearances_pkey" PRIMARY KEY ("book_id", "character_id");

-- ----------------------------
-- Primary Key structure for table book_characters
-- ----------------------------
ALTER TABLE "public"."book_characters" ADD CONSTRAINT "book_characters_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Checks structure for table book_suggestions
-- ----------------------------
ALTER TABLE "public"."book_suggestions" ADD CONSTRAINT "book_suggestions_approved_check" CHECK (approved = ANY (ARRAY['0'::bpchar, '1'::bpchar]));

-- ----------------------------
-- Primary Key structure for table book_suggestions
-- ----------------------------
ALTER TABLE "public"."book_suggestions" ADD CONSTRAINT "book_suggestions_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table books
-- ----------------------------
CREATE INDEX "idx_books_creator" ON "public"."books" USING btree (
  "added_by" "pg_catalog"."int4_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table books
-- ----------------------------
ALTER TABLE "public"."books" ADD CONSTRAINT "books_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table comments
-- ----------------------------
CREATE INDEX "idx_comments_review_created" ON "public"."comments" USING btree (
  "review_id" "pg_catalog"."int4_ops" ASC NULLS LAST,
  "created_at" "pg_catalog"."timestamp_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table comments
-- ----------------------------
ALTER TABLE "public"."comments" ADD CONSTRAINT "comments_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Uniques structure for table genres
-- ----------------------------
ALTER TABLE "public"."genres" ADD CONSTRAINT "genres_name_key" UNIQUE ("name");

-- ----------------------------
-- Primary Key structure for table genres
-- ----------------------------
ALTER TABLE "public"."genres" ADD CONSTRAINT "genres_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Uniques structure for table languages
-- ----------------------------
ALTER TABLE "public"."languages" ADD CONSTRAINT "languages_iso_code_key" UNIQUE ("iso_code");

-- ----------------------------
-- Primary Key structure for table languages
-- ----------------------------
ALTER TABLE "public"."languages" ADD CONSTRAINT "languages_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table login_history
-- ----------------------------
CREATE INDEX "idx_login_history_user" ON "public"."login_history" USING btree (
  "user_id" "pg_catalog"."int4_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table login_history
-- ----------------------------
ALTER TABLE "public"."login_history" ADD CONSTRAINT "login_history_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table moderator_accounts
-- ----------------------------
ALTER TABLE "public"."moderator_accounts" ADD CONSTRAINT "moderator_accounts_pkey" PRIMARY KEY ("user_id");

-- ----------------------------
-- Primary Key structure for table publication_houses
-- ----------------------------
ALTER TABLE "public"."publication_houses" ADD CONSTRAINT "publication_houses_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table ratings
-- ----------------------------
CREATE INDEX "idx_ratings_book" ON "public"."ratings" USING btree (
  "book_id" "pg_catalog"."int4_ops" ASC NULLS LAST
);

-- ----------------------------
-- Checks structure for table ratings
-- ----------------------------
ALTER TABLE "public"."ratings" ADD CONSTRAINT "ratings_value_check" CHECK (value >= 1 AND value <= 5);

-- ----------------------------
-- Primary Key structure for table ratings
-- ----------------------------
ALTER TABLE "public"."ratings" ADD CONSTRAINT "ratings_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table reviews
-- ----------------------------
CREATE INDEX "idx_reviews_book" ON "public"."reviews" USING btree (
  "book_id" "pg_catalog"."int4_ops" ASC NULLS LAST
);

-- ----------------------------
-- Checks structure for table reviews
-- ----------------------------
ALTER TABLE "public"."reviews" ADD CONSTRAINT "reviews_rating_check" CHECK (rating >= 1 AND rating <= 5);

-- ----------------------------
-- Primary Key structure for table reviews
-- ----------------------------
ALTER TABLE "public"."reviews" ADD CONSTRAINT "reviews_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table user_accounts
-- ----------------------------
ALTER TABLE "public"."user_accounts" ADD CONSTRAINT "user_accounts_pkey" PRIMARY KEY ("user_id");

-- ----------------------------
-- Indexes structure for table user_books
-- ----------------------------
CREATE INDEX "idx_user_books_book" ON "public"."user_books" USING btree (
  "book_id" "pg_catalog"."int4_ops" ASC NULLS LAST
);
CREATE INDEX "idx_user_books_date_added" ON "public"."user_books" USING btree (
  "date_added" "pg_catalog"."timestamp_ops" ASC NULLS LAST
);
CREATE INDEX "idx_user_books_shelf" ON "public"."user_books" USING btree (
  "shelf" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "idx_user_books_user" ON "public"."user_books" USING btree (
  "user_id" "pg_catalog"."int4_ops" ASC NULLS LAST
);

-- ----------------------------
-- Uniques structure for table user_books
-- ----------------------------
ALTER TABLE "public"."user_books" ADD CONSTRAINT "user_books_user_id_book_id_key" UNIQUE ("user_id", "book_id");

-- ----------------------------
-- Checks structure for table user_books
-- ----------------------------
ALTER TABLE "public"."user_books" ADD CONSTRAINT "user_books_user_rating_check" CHECK (user_rating >= 1 AND user_rating <= 5);
ALTER TABLE "public"."user_books" ADD CONSTRAINT "user_books_shelf_check" CHECK (shelf::text = ANY (ARRAY['want-to-read'::character varying, 'currently-reading'::character varying, 'read'::character varying]::text[]));

-- ----------------------------
-- Primary Key structure for table user_books
-- ----------------------------
ALTER TABLE "public"."user_books" ADD CONSTRAINT "user_books_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Uniques structure for table users
-- ----------------------------
ALTER TABLE "public"."users" ADD CONSTRAINT "users_email_key" UNIQUE ("email");
ALTER TABLE "public"."users" ADD CONSTRAINT "users_username_key" UNIQUE ("username");

-- ----------------------------
-- Primary Key structure for table users
-- ----------------------------
ALTER TABLE "public"."users" ADD CONSTRAINT "users_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table votes
-- ----------------------------
CREATE INDEX "idx_votes_user" ON "public"."votes" USING btree (
  "user_id" "pg_catalog"."int4_ops" ASC NULLS LAST
);

-- ----------------------------
-- Checks structure for table votes
-- ----------------------------
ALTER TABLE "public"."votes" ADD CONSTRAINT "votes_vote_type_check" CHECK (vote_type::text = ANY (ARRAY['up'::character varying, 'down'::character varying]::text[]));
ALTER TABLE "public"."votes" ADD CONSTRAINT "vote_target_ck" CHECK (review_id IS NOT NULL AND comment_id IS NULL OR review_id IS NULL AND comment_id IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table votes
-- ----------------------------
ALTER TABLE "public"."votes" ADD CONSTRAINT "votes_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table wished_books
-- ----------------------------
ALTER TABLE "public"."wished_books" ADD CONSTRAINT "wished_books_pkey" PRIMARY KEY ("user_id", "book_id");

-- ----------------------------
-- Primary Key structure for table wishlists
-- ----------------------------
ALTER TABLE "public"."wishlists" ADD CONSTRAINT "wishlists_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Foreign Keys structure for table book_authors
-- ----------------------------
ALTER TABLE "public"."book_authors" ADD CONSTRAINT "book_authors_author_id_fkey" FOREIGN KEY ("author_id") REFERENCES "public"."authors" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE "public"."book_authors" ADD CONSTRAINT "book_authors_book_id_fkey" FOREIGN KEY ("book_id") REFERENCES "public"."books" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table book_character_appearances
-- ----------------------------
ALTER TABLE "public"."book_character_appearances" ADD CONSTRAINT "book_character_appearances_book_id_fkey" FOREIGN KEY ("book_id") REFERENCES "public"."books" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE "public"."book_character_appearances" ADD CONSTRAINT "book_character_appearances_character_id_fkey" FOREIGN KEY ("character_id") REFERENCES "public"."book_characters" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table book_suggestions
-- ----------------------------
ALTER TABLE "public"."book_suggestions" ADD CONSTRAINT "book_suggestions_approved_by_fkey" FOREIGN KEY ("approved_by") REFERENCES "public"."moderator_accounts" ("user_id") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."book_suggestions" ADD CONSTRAINT "book_suggestions_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."user_accounts" ("user_id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table books
-- ----------------------------
ALTER TABLE "public"."books" ADD CONSTRAINT "books_created_by_fkey" FOREIGN KEY ("added_by") REFERENCES "public"."users" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."books" ADD CONSTRAINT "books_genre_id_fkey" FOREIGN KEY ("genre_id") REFERENCES "public"."genres" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE "public"."books" ADD CONSTRAINT "books_language_id_fkey" FOREIGN KEY ("language_id") REFERENCES "public"."languages" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE "public"."books" ADD CONSTRAINT "books_publication_house_id_fkey" FOREIGN KEY ("publication_house_id") REFERENCES "public"."publication_houses" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table comments
-- ----------------------------
ALTER TABLE "public"."comments" ADD CONSTRAINT "comments_parent_comment_id_fkey" FOREIGN KEY ("parent_comment_id") REFERENCES "public"."comments" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE "public"."comments" ADD CONSTRAINT "comments_review_id_fkey" FOREIGN KEY ("review_id") REFERENCES "public"."reviews" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE "public"."comments" ADD CONSTRAINT "comments_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."users" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table login_history
-- ----------------------------
ALTER TABLE "public"."login_history" ADD CONSTRAINT "login_history_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."users" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table moderator_accounts
-- ----------------------------
ALTER TABLE "public"."moderator_accounts" ADD CONSTRAINT "moderator_accounts_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."users" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table ratings
-- ----------------------------
ALTER TABLE "public"."ratings" ADD CONSTRAINT "ratings_book_id_fkey" FOREIGN KEY ("book_id") REFERENCES "public"."books" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE "public"."ratings" ADD CONSTRAINT "ratings_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."users" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table reviews
-- ----------------------------
ALTER TABLE "public"."reviews" ADD CONSTRAINT "reviews_book_id_fkey" FOREIGN KEY ("book_id") REFERENCES "public"."books" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE "public"."reviews" ADD CONSTRAINT "reviews_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."users" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table user_accounts
-- ----------------------------
ALTER TABLE "public"."user_accounts" ADD CONSTRAINT "user_accounts_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."users" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table user_books
-- ----------------------------
ALTER TABLE "public"."user_books" ADD CONSTRAINT "user_books_book_id_fkey" FOREIGN KEY ("book_id") REFERENCES "public"."books" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE "public"."user_books" ADD CONSTRAINT "user_books_review_id_fkey" FOREIGN KEY ("review_id") REFERENCES "public"."reviews" ("id") ON DELETE SET NULL ON UPDATE NO ACTION;
ALTER TABLE "public"."user_books" ADD CONSTRAINT "user_books_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."users" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table votes
-- ----------------------------
ALTER TABLE "public"."votes" ADD CONSTRAINT "votes_comment_id_fkey" FOREIGN KEY ("comment_id") REFERENCES "public"."comments" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE "public"."votes" ADD CONSTRAINT "votes_review_id_fkey" FOREIGN KEY ("review_id") REFERENCES "public"."reviews" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE "public"."votes" ADD CONSTRAINT "votes_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."users" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table wished_books
-- ----------------------------
ALTER TABLE "public"."wished_books" ADD CONSTRAINT "wished_books_book_id_fkey" FOREIGN KEY ("book_id") REFERENCES "public"."books" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE "public"."wished_books" ADD CONSTRAINT "wished_books_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."users" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table wishlists
-- ----------------------------
ALTER TABLE "public"."wishlists" ADD CONSTRAINT "wishlists_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."user_accounts" ("user_id") ON DELETE CASCADE ON UPDATE NO ACTION;
