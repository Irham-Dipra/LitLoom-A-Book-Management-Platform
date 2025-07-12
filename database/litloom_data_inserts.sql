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

--
-- Data for Name: authors; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.authors VALUES (1, 'Gabriel García Márquez', 'Colombian novelist and Nobel laureate known for magical realism, especially in "One Hundred Years of Solitude".', '1927-03-06', 'Colombia');
INSERT INTO public.authors VALUES (2, 'Rabindranath Tagore', 'Bengali polymath, poet, and the first non-European to win the Nobel Prize in Literature.', '1861-05-07', 'India');
INSERT INTO public.authors VALUES (3, 'Haruki Murakami', 'Japanese author known for blending pop culture, surrealism, and melancholy in works like "Norwegian Wood" and "Kafka on the Shore".', '1949-01-12', 'Japan');
INSERT INTO public.authors VALUES (4, 'Chinua Achebe', 'Nigerian writer best known for his novel "Things Fall Apart", a cornerstone of African literature.', '1930-11-16', 'Nigeria');
INSERT INTO public.authors VALUES (6, 'Humayun Ahmed', 'Bangladeshi author and filmmaker, famous for his fiction and characters like Himu and Misir Ali.', '1948-11-13', 'Bangladesh');
INSERT INTO public.authors VALUES (5, 'Virginia Woolf', 'English writer and modernist pioneer, known for "Mrs Dalloway" and "To the Lighthouse".', '1882-01-25', 'United Kingdom');
INSERT INTO public.authors VALUES (7, 'Sylvia Plath', 'American poet and novelist, known for her confessional style and "The Bell Jar".', '1932-10-27', 'United States');
INSERT INTO public.authors VALUES (8, 'Leo Tolstoy', 'Russian writer famous for epic novels like "War and Peace" and "Anna Karenina".', '1828-09-09', 'Russia');
INSERT INTO public.authors VALUES (9, 'Kazi Nazrul Islam', 'Revolutionary Bengali poet, writer, and musician, known as the "Rebel Poet" of Bengal.', '1899-05-24', 'Bangladesh');
INSERT INTO public.authors VALUES (10, 'George Orwell', 'British author known for dystopian classics like "1984" and "Animal Farm".', '1903-06-25', 'United Kingdom');
INSERT INTO public.authors VALUES (12, 'V.E. Schwab', 'Victoria Schwab is known for fantasy novels blending dark magic and human emotion.', '1987-07-07', 'United States');
INSERT INTO public.authors VALUES (13, 'T.J. Klune', 'American author of fantasy and romance with LGBTQ+ representation.', '1982-05-20', 'United States');
INSERT INTO public.authors VALUES (14, 'Andy Weir', 'Former software engineer and author of science fiction bestsellers.', '1972-06-16', 'United States');
INSERT INTO public.authors VALUES (15, 'Matt Haig', 'British author of fiction and nonfiction exploring mental health and the human experience.', '1975-07-03', 'United Kingdom');
INSERT INTO public.authors VALUES (16, 'Jennette McCurdy', 'Actress and author, known for her memoir on childhood trauma and healing.', '1992-06-26', 'United States');
INSERT INTO public.authors VALUES (17, 'Rebecca Yarros', 'American writer best known for emotionally charged romance and fantasy.', '1981-12-14', 'United States');
INSERT INTO public.authors VALUES (18, 'Suzanne Collins', 'Creator of *The Hunger Games* series, known for dystopian fiction.', '1962-08-10', 'United States');
INSERT INTO public.authors VALUES (19, 'Susanna Clarke', 'British author whose work blends historical fiction and fantasy.', '1959-11-01', 'United Kingdom');
INSERT INTO public.authors VALUES (20, 'Kate Elizabeth Russell', 'American author of controversial and introspective psychological fiction.', '1984-07-16', 'United States');
INSERT INTO public.authors VALUES (21, 'Sarah J. Maas', 'Bestselling fantasy author known for high-stakes romance and action.', '1986-03-05', 'United States');


--
-- Data for Name: genres; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.genres VALUES (1, 'Fiction');
INSERT INTO public.genres VALUES (2, 'Non-Fiction');
INSERT INTO public.genres VALUES (3, 'Fantasy');
INSERT INTO public.genres VALUES (4, 'Science Fiction');
INSERT INTO public.genres VALUES (5, 'Mystery');
INSERT INTO public.genres VALUES (6, 'Thriller');
INSERT INTO public.genres VALUES (7, 'Romance');
INSERT INTO public.genres VALUES (8, 'Historical');
INSERT INTO public.genres VALUES (9, 'Biography');
INSERT INTO public.genres VALUES (10, 'Self-Help');
INSERT INTO public.genres VALUES (11, 'Poetry');
INSERT INTO public.genres VALUES (12, 'Horror');
INSERT INTO public.genres VALUES (13, 'Young Adult');
INSERT INTO public.genres VALUES (14, 'Classics');
INSERT INTO public.genres VALUES (15, 'Graphic Novel');
INSERT INTO public.genres VALUES (16, 'Philosophy');
INSERT INTO public.genres VALUES (17, 'Science');
INSERT INTO public.genres VALUES (18, 'Travel');
INSERT INTO public.genres VALUES (19, 'Religion');
INSERT INTO public.genres VALUES (20, 'Drama');
INSERT INTO public.genres VALUES (26, 'Memoir');
INSERT INTO public.genres VALUES (27, 'Historical Fiction');
INSERT INTO public.genres VALUES (28, 'new genre');


--
-- Data for Name: languages; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.languages VALUES (1, 'English', 'en');
INSERT INTO public.languages VALUES (2, 'Bengali', 'bn');
INSERT INTO public.languages VALUES (3, 'Hindi', 'hi');
INSERT INTO public.languages VALUES (4, 'Spanish', 'es');
INSERT INTO public.languages VALUES (5, 'French', 'fr');
INSERT INTO public.languages VALUES (6, 'Chinese', 'zh');
INSERT INTO public.languages VALUES (7, 'Arabic', 'ar');
INSERT INTO public.languages VALUES (8, 'Russian', 'ru');
INSERT INTO public.languages VALUES (9, 'German', 'de');
INSERT INTO public.languages VALUES (10, 'Portuguese', 'pt');
INSERT INTO public.languages VALUES (11, 'Japanese', 'ja');
INSERT INTO public.languages VALUES (12, 'Italian', 'it');
INSERT INTO public.languages VALUES (13, 'Urdu', 'ur');
INSERT INTO public.languages VALUES (14, 'Persian', 'fa');
INSERT INTO public.languages VALUES (15, 'Turkish', 'tr');
INSERT INTO public.languages VALUES (16, 'Korean', 'ko');
INSERT INTO public.languages VALUES (17, 'Dutch', 'nl');
INSERT INTO public.languages VALUES (18, 'Swedish', 'sv');
INSERT INTO public.languages VALUES (19, 'Greek', 'el');
INSERT INTO public.languages VALUES (20, 'Polish', 'pl');
INSERT INTO public.languages VALUES (21, 'Tamil', 'ta');
INSERT INTO public.languages VALUES (22, 'Malayalam', 'ml');


--
-- Data for Name: publication_houses; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.publication_houses VALUES (1, 'Penguin Random House', '1745 Broadway, New York, NY 10019', 'United States', 'contact@penguinrandomhouse.com');
INSERT INTO public.publication_houses VALUES (2, 'HarperCollins', '195 Broadway, New York, NY 10007', 'United States', 'info@harpercollins.com');
INSERT INTO public.publication_houses VALUES (3, 'Simon & Schuster', '1230 Avenue of the Americas, New York, NY 10020', 'United States', 'info@simonandschuster.com');
INSERT INTO public.publication_houses VALUES (4, 'Houghton Mifflin Harcourt', '125 High Street, Boston, MA 02110', 'United States', 'contact@hmhco.com');
INSERT INTO public.publication_houses VALUES (5, 'Vintage Books', '20 Vauxhall Bridge Road, London SW1V 2SA', 'United Kingdom', 'info@vintage-books.co.uk');
INSERT INTO public.publication_houses VALUES (6, 'Bloomsbury Publishing', '50 Bedford Square, London WC1B 3DP', 'United Kingdom', 'info@bloomsbury.com');
INSERT INTO public.publication_houses VALUES (7, 'Gallimard', '5 Rue Gaston Gallimard, 75007 Paris', 'France', 'contact@gallimard.fr');
INSERT INTO public.publication_houses VALUES (8, 'Ananda Publishers', '13/1A Ballygunge Place, Kolkata, West Bengal 700019', 'India', 'contact@anandapub.in');
INSERT INTO public.publication_houses VALUES (9, 'Seagull Books', '36C S. P. Mukherjee Road, Kolkata 700025', 'India', 'info@seagullbooks.org');
INSERT INTO public.publication_houses VALUES (10, 'Rokomari Publications', '380 Tejgaon Industrial Area, Dhaka 1208', 'Bangladesh', 'support@rokomari.com');
INSERT INTO public.publication_houses VALUES (11, 'Agamee Prakashani', '36 Banglabazar, Dhaka-1100', 'Bangladesh', 'agamee.bd@gmail.com');
INSERT INTO public.publication_houses VALUES (12, 'Sheba Prokashoni', '38 Banglabazar, Dhaka-1100', 'Bangladesh', 'info@sheba.com.bd');
INSERT INTO public.publication_houses VALUES (13, 'Al Mahmud Library', 'Shahbagh, Dhaka 1000', 'Bangladesh', 'contact@al-mahmudlib.org');
INSERT INTO public.publication_houses VALUES (14, 'Shinchosha Publishing', '71 Yaraicho, Shinjuku City, Tokyo 162-8711', 'Japan', 'info@shinchosha.co.jp');
INSERT INTO public.publication_houses VALUES (15, 'Heinemann', 'Halley Court, Jordan Hill, Oxford OX2 8EJ', 'United Kingdom', 'info@heinemann.com');
INSERT INTO public.publication_houses VALUES (16, 'Faber and Faber', 'Bloomsbury House, 74-77 Great Russell St, London WC1B 3DA', 'United Kingdom', 'enquiries@faber.co.uk');
INSERT INTO public.publication_houses VALUES (17, 'Alianza Editorial', 'Calle Juan Ignacio Luca de Tena, 17, Madrid', 'Spain', 'contacto@alianzaeditorial.es');
INSERT INTO public.publication_houses VALUES (19, 'Tor Books', '175 Fifth Avenue, New York, NY 10010', 'United States', 'info@tor.com');
INSERT INTO public.publication_houses VALUES (20, 'Crown Publishing Group', '1745 Broadway, New York, NY 10019', 'United States', 'contact@crownpublishing.com');
INSERT INTO public.publication_houses VALUES (21, 'Canongate Books', '14 High Street, Edinburgh EH1 1TE', 'United Kingdom', 'info@canongate.co.uk');
INSERT INTO public.publication_houses VALUES (23, 'Entangled Publishing', 'New York, NY', 'United States', 'info@entangledpublishing.com');
INSERT INTO public.publication_houses VALUES (24, 'Scholastic Press', '557 Broadway, New York, NY 10012', 'United States', 'contact@scholastic.com');
INSERT INTO public.publication_houses VALUES (26, 'Dutton', '1290 Avenue of the Americas, New York, NY 10104', 'United States', 'contact@duttonbooks.com');


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.users VALUES (1, 'john.doe@example.com', 'hashed_password', 'johndoe', '2025-06-05 13:27:18.805936', 'https://example.com/profile.jpg', 'Just a reader.', 'John', 'Doe', false);
INSERT INTO public.users VALUES (2, 'alice@example.com', 'hashed_pass_1', 'alice123', '2025-06-05 13:29:53.56362', 'http://example.com/alice.jpg', 'Alice is a passionate reader.', 'Alice', 'Allen', false);
INSERT INTO public.users VALUES (3, 'bob@example.com', 'hashed_pass_2', 'bobby99', '2025-06-05 13:29:53.56362', 'http://example.com/bob.jpg', 'Bob likes sci-fi books.', 'Bob', 'Allen', false);
INSERT INTO public.users VALUES (4, 'anika.rahman@example.com', 'password123', 'anika_rahman', '2025-06-22 19:36:44.18794', 'https://example.com/images/anika.jpg', 'Bookworm from Dhaka, loves poetry and rain.', 'Anika', 'Rahman', false);
INSERT INTO public.users VALUES (5, 'arjun.patel@example.com', 'securepass456', 'arjun_p', '2025-06-22 19:36:44.18794', 'https://example.com/images/arjun.jpg', 'Tech enthusiast from Gujarat. Coffee is life.', 'Arjun', 'Patel', false);
INSERT INTO public.users VALUES (6, 'emily.thompson@example.com', 'mypass789', 'emilyt', '2025-06-22 19:36:44.18794', 'https://example.com/images/emily.jpg', 'NYC-based journalist with a love for mystery novels.', 'Emily', 'Thompson', false);
INSERT INTO public.users VALUES (7, 'jakub.nowak@example.com', 'jakub321', 'jakub_nowak', '2025-06-22 19:36:44.18794', 'https://example.com/images/jakub.jpg', 'Traveller from Krakow, into history and photography.', 'Jakub', 'Nowak', false);
INSERT INTO public.users VALUES (8, 'mahmudul.karim@example.com', 'karim007', 'mahmudul_k', '2025-06-22 19:36:44.18794', 'https://example.com/images/karim.jpg', 'Aspiring author from Chittagong. Writes fiction.', 'Mahmudul', 'Karim', false);
INSERT INTO public.users VALUES (9, 'sofia.rossi@example.com', 'italylove', 'sofia_r', '2025-06-22 19:36:44.18794', 'https://example.com/images/sofia.jpg', 'Book reviewer from Florence. Big fan of romance.', 'Sofia', 'Rossi', false);
INSERT INTO public.users VALUES (10, 'liam.murphy@example.com', 'liamirish', 'liam_murphy', '2025-06-22 19:36:44.18794', 'https://example.com/images/liam.jpg', 'From Dublin. Fantasy nerd. Tea over coffee always.', 'Liam', 'Murphy', false);
INSERT INTO public.users VALUES (11, 'sneha.iyer@example.com', 'sneha098', 'sneha_iyer', '2025-06-22 19:36:44.18794', 'https://example.com/images/sneha.jpg', 'Literature student from Chennai. Bibliophile forever.', 'Sneha', 'Iyer', false);
INSERT INTO public.users VALUES (12, 'noah.bennett@example.com', 'bennett_pass', 'noahbennett', '2025-06-22 19:36:44.18794', 'https://example.com/images/noah.jpg', 'Seattle-based coder. Enjoys thriller books.', 'Noah', 'Bennet', false);
INSERT INTO public.users VALUES (13, 'aline.dupont@example.com', 'bonjour123', 'aline_dupont', '2025-06-22 19:36:44.18794', 'https://example.com/images/aline.jpg', 'Parisian book lover with a soft spot for classics.', 'Aline', 'Dupont', false);
INSERT INTO public.users VALUES (15, 'test@example.com', '$2b$10$PU6U4ATQIusDgUokc6qPPuGS3.V9/zoPCmZPGw5apJNz/KB5Tu7Uy', 'testuser', '2025-06-24 21:01:15.277777', '', 'I love reading books!', 'Jalil', 'Uddin', false);
INSERT INTO public.users VALUES (16, 'tesdjhkjfhat@example.com', '$2b$10$PoEGI6JhNyI6DqApZuWtI.4ybaTCtO4iL57eVinNJ1zgQLe6/nyoa', 'ksjddffhkja', '2025-06-24 21:25:14.050238', '', 'I love reading books!', 'Khalil', 'Uddin', false);
INSERT INTO public.users VALUES (17, 'tesdjhkdfdjfhat@example.com', '$2b$10$ejCZRITmt.DFv3VyADIOoe.qK.7JpxoTCBCqkfFU0Ol5QeulZgHw2', 'ksjdddfdffhkja', '2025-06-24 22:42:34.300337', '', 'I love reading books!', 'Khalil', 'Uddin', false);
INSERT INTO public.users VALUES (19, 'anabilratno@gmail.com', '$2b$10$ZHOMMH6qDrya9p3gA.SX4.zMXa7TU.ot/invZkhPccFr2m46t3rzC', 'qdeqed', '2025-06-25 10:49:10.839111', '', '', 'ASDF', 'aa', false);
INSERT INTO public.users VALUES (20, 'diprairham3223@gmail.com', '$2b$10$O4EiPu9Kog.72vbbXariSOSyPKiUrPV1ok6EsCez/fscVljoil9B2', 'dipra3223', '2025-06-25 11:25:43.996847', '', '', 'Irham', 'Dipra', false);
INSERT INTO public.users VALUES (18, 'anabildas2003@gmail.com', '$2b$10$IgqFThVy5.OmSSE2YEhtO.ilqy0rnRvZWunh7UQLsewIXyyRZ6dVS', 'anabil', '2025-06-24 22:48:40.487592', 'https://scontent.fdac181-1.fna.fbcdn.net/v/t39.30808-6/504157351_1215671550285575_3822665019208153508_n.jpg?_nc_cat=103&ccb=1-7&_nc_sid=6ee11a&_nc_eui2=AeFLVoW9WhDdoksWFDhdaGiAC5XXNLdXcewLldc0t1dx7Jibma3JJoIpQRPKyd9-ZNOEKZitSVstGJJ7BamcUCFq&_nc_ohc=tZEug1wQv0AQ7kNvwHDO9L5&_nc_oc=AdmdXeLo9LjIJP3SZPF8ql9orTiKi37smLHTT_52vjSmMa0k-CNiZt8_we48qyy4lgw&_nc_zt=23&_nc_ht=scontent.fdac181-1.fna&_nc_gid=MqjVbI1adf6z4-A2k3m2zg&oh=00_AfM8ztVgymcQPOh0UMnvt_DMbsG8biuTmLXGebcpksKLVg&oe=6860F28C', 'Bookworm from Dhaka', 'Anabil', 'Das', false);


--
-- Data for Name: books; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.books VALUES (4110, 'The Invisible Life of Addie LaRue', 'A young woman makes a Faustian bargain to live forever but is cursed to be forgotten by everyone she meets.', '2020-10-06', 'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1584633432i/50623864.jpg', 'United States', 1, 3, 19, 'https://example.com/pdfs/invisible_life_addie_larue.pdf', 4.20, '2025-06-25 00:02:31.071762', 1);
INSERT INTO public.books VALUES (4111, 'The House in the Cerulean Sea', 'A charming tale of a caseworker sent to a magical orphanage, discovering love and acceptance.', '2020-03-17', 'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1569514209i/45047384.jpg', 'United States', 1, 3, 19, 'https://example.com/pdfs/house_cerulean_sea.pdf', 4.40, '2025-06-25 00:02:31.071762', 1);
INSERT INTO public.books VALUES (4114, 'Project Hail Mary', 'A lone astronaut wakes up on a spaceship with no memory and must save Earth from disaster.', '2021-05-04', 'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1597695864i/54493401.jpg', 'United States', 1, 4, 20, 'https://example.com/pdfs/project_hail_mary.pdf', 4.50, '2025-06-25 00:05:48.888889', 1);
INSERT INTO public.books VALUES (4115, 'The Midnight Library', 'Between life and death lies a library where every book represents a different path life could have taken.', '2020-08-13', 'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1602190253i/52578297.jpg', 'United Kingdom', 1, 3, 21, 'https://example.com/pdfs/midnight_library.pdf', 4.10, '2025-06-25 00:05:48.888889', 1);
INSERT INTO public.books VALUES (4116, 'I’m Glad My Mom Died', 'A raw and honest memoir by Jennette McCurdy about her complicated relationship with her mother and healing.', '2022-08-09', 'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1649286799i/59364173.jpg', 'United States', 1, 26, 3, 'https://example.com/pdfs/im_glad_my_mom_died.pdf', 4.70, '2025-06-25 00:09:02.151792', 1);
INSERT INTO public.books VALUES (4117, 'Fourth Wing', 'A fierce young woman trains in a deadly military academy in a world of dragons and political intrigue.', '2023-05-02', 'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1701980900i/61431922.jpg', 'United States', 1, 3, 23, 'https://example.com/pdfs/fourth_wing.pdf', 4.30, '2025-06-25 00:09:02.151792', 1);
INSERT INTO public.books VALUES (4118, 'The Ballad of Songbirds and Snakes', 'A prequel to The Hunger Games, following the rise of a young Coriolanus Snow.', '2020-05-19', 'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1593892032i/51901147.jpg', 'United States', 1, 27, 24, 'https://example.com/pdfs/ballad_songbirds_snakes.pdf', 4.00, '2025-06-25 00:09:51.435282', 1);
INSERT INTO public.books VALUES (4119, 'Piranesi', 'A surreal and mysterious tale of a man living in a strange, labyrinthine house filled with statues.', '2020-09-15', 'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1609095173i/50202953.jpg', 'United Kingdom', 1, 3, 6, 'https://example.com/pdfs/piranesi.pdf', 4.10, '2025-06-25 00:09:51.435282', 1);
INSERT INTO public.books VALUES (4120, 'My Dark Vanessa', 'A gripping psychological thriller exploring a complex and controversial relationship.', '2020-06-02', 'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1583447793i/44890081.jpg', 'United States', 1, 6, 26, 'https://example.com/pdfs/my_dark_vanessa.pdf', 4.00, '2025-06-25 00:09:51.435282', 1);
INSERT INTO public.books VALUES (4121, 'House of Earth and Blood', 'The first book in a fantasy series about a woman caught between gods, demons, and mortal politics.', '2020-03-03', 'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1559142847i/44778083.jpg', 'United States', 1, 3, 6, 'https://example.com/pdfs/house_earth_blood.pdf', 4.20, '2025-06-25 00:09:51.435282', 1);
INSERT INTO public.books VALUES (4122, 'fkldsj', 'dskfhkjsadh', '2025-07-09', 'jhskjfka', 'ds,fnkl', 7, 2, 8, 'dskljfklsjdf', 0.00, '2025-07-09 07:10:12.286151', 1);
INSERT INTO public.books VALUES (1, 'One Hundred Years of Solitude', 'A multi-generational tale of the Buendía family, blending magical realism with political and social commentary.', '1967-05-30', 'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1327881361i/320.jpg', 'Colombia', 4, 1, 17, 'https://example.com/pdfs/solitude.pdf', 4.70, '2025-06-22 21:19:18.608485', 1);
INSERT INTO public.books VALUES (2, 'Gitanjali', 'A collection of poems reflecting devotion, love, and spirituality that earned Tagore the Nobel Prize.', '1910-08-14', 'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1348514071i/66414.jpg', 'India', 2, 11, 8, 'https://example.com/pdfs/gitanjali.pdf', 4.50, '2025-06-22 21:19:18.608485', 2);
INSERT INTO public.books VALUES (3, 'Kafka on the Shore', 'A metaphysical and surreal novel following a runaway teenager and a man who can talk to cats.', '2002-09-12', 'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1429638085i/4929.jpg', 'Japan', 11, 3, 14, 'https://example.com/pdfs/kafka.pdf', 4.30, '2025-06-22 21:19:18.608485', 3);
INSERT INTO public.books VALUES (4, 'Things Fall Apart', 'A powerful novel about pre-colonial life in Nigeria and the impact of European colonialism.', '1958-06-17', 'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1645022990i/60316758.jpg', 'Nigeria', 1, 1, 15, 'https://example.com/pdfs/thingsfallapart.pdf', 4.60, '2025-06-22 21:19:18.608485', 4);
INSERT INTO public.books VALUES (5, 'Himu', 'The story of a free-spirited young man who walks barefoot and questions society through his simplicity.', '1990-03-01', 'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1627028538i/58612471.jpg', 'Bangladesh', 2, 1, 11, 'https://example.com/pdfs/himu.pdf', 4.40, '2025-06-22 21:19:18.608485', 5);
INSERT INTO public.books VALUES (6, 'The Bell Jar', 'A semi-autobiographical novel exploring mental illness, identity, and societal expectations.', '1963-01-14', 'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1668645154i/56616095.jpg', 'United States', 1, 1, 16, 'https://example.com/pdfs/belljar.pdf', 4.20, '2025-06-22 21:19:18.608485', 6);
INSERT INTO public.books VALUES (8, 'Mrs Dalloway', 'A modernist novel capturing one day in the life of Clarissa Dalloway, rich with inner thought and stream-of-consciousness.', '1925-05-14', 'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1646148221i/14942.jpg', 'United Kingdom', 1, 1, 16, 'https://example.com/pdfs/mrsdalloway.pdf', 4.10, '2025-06-22 21:19:18.608485', 8);
INSERT INTO public.books VALUES (9, 'Shonchita', 'A collection of revolutionary poems challenging oppression and injustice in colonial Bengal.', '1922-08-01', 'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1505814718i/17201996.jpg', 'Bangladesh', 2, 11, 12, 'https://example.com/pdfs/rebelpoetry.pdf', 4.60, '2025-06-22 21:19:18.608485', 9);
INSERT INTO public.books VALUES (10, '1984', 'A dystopian novel depicting a totalitarian regime that surveils, manipulates, and erases truth.', '1949-06-08', 'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1657781256i/61439040.jpg', 'United Kingdom', 1, 6, 1, 'https://example.com/pdfs/1984.pdf', 4.90, '2025-06-22 21:19:18.608485', 10);
INSERT INTO public.books VALUES (7, 'War and Peace', 'A historical epic interweaving personal lives and military campaigns during the Napoleonic era.', '1869-01-01', 'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1413215930i/656.jpg', 'Russia', 1, 8, 5, 'https://example.com/pdfs/warpeace.pdf', 4.80, '2025-06-22 21:19:18.608485', 7);


--
-- Data for Name: book_authors; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.book_authors VALUES (4110, 12);
INSERT INTO public.book_authors VALUES (4111, 13);
INSERT INTO public.book_authors VALUES (4114, 14);
INSERT INTO public.book_authors VALUES (4115, 15);
INSERT INTO public.book_authors VALUES (4116, 16);
INSERT INTO public.book_authors VALUES (4117, 17);
INSERT INTO public.book_authors VALUES (4118, 18);
INSERT INTO public.book_authors VALUES (4119, 19);
INSERT INTO public.book_authors VALUES (4120, 20);
INSERT INTO public.book_authors VALUES (4121, 21);
INSERT INTO public.book_authors VALUES (1, 1);
INSERT INTO public.book_authors VALUES (2, 2);
INSERT INTO public.book_authors VALUES (3, 3);
INSERT INTO public.book_authors VALUES (4, 4);
INSERT INTO public.book_authors VALUES (5, 6);
INSERT INTO public.book_authors VALUES (6, 7);
INSERT INTO public.book_authors VALUES (7, 8);
INSERT INTO public.book_authors VALUES (8, 5);
INSERT INTO public.book_authors VALUES (9, 9);
INSERT INTO public.book_authors VALUES (10, 10);
INSERT INTO public.book_authors VALUES (4122, 1);


--
-- Data for Name: book_characters; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: book_character_appearances; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: moderator_accounts; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.moderator_accounts VALUES (18);
INSERT INTO public.moderator_accounts VALUES (20);


--
-- Data for Name: user_accounts; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.user_accounts VALUES (1);
INSERT INTO public.user_accounts VALUES (2);
INSERT INTO public.user_accounts VALUES (3);
INSERT INTO public.user_accounts VALUES (4);
INSERT INTO public.user_accounts VALUES (5);
INSERT INTO public.user_accounts VALUES (6);
INSERT INTO public.user_accounts VALUES (7);
INSERT INTO public.user_accounts VALUES (8);
INSERT INTO public.user_accounts VALUES (9);
INSERT INTO public.user_accounts VALUES (10);
INSERT INTO public.user_accounts VALUES (11);
INSERT INTO public.user_accounts VALUES (12);
INSERT INTO public.user_accounts VALUES (13);


--
-- Data for Name: book_suggestions; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: reviews; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: comments; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: login_history; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.login_history VALUES (2, 20, '2025-07-12 23:44:35.770887', '::1', '2025-07-12 23:48:03.464624');
INSERT INTO public.login_history VALUES (3, 20, '2025-07-12 23:48:56.148112', '::1', '2025-07-12 23:49:10.045609');


--
-- Data for Name: ratings; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.ratings VALUES (2, 20, 4111, 4, '2025-07-11 16:44:26.477122');
INSERT INTO public.ratings VALUES (3, 20, 4116, 5, '2025-07-11 16:44:48.702206');


--
-- Data for Name: user_books; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.user_books VALUES (1, 18, 4114, 'want-to-read', NULL, '2025-07-11 16:00:09.394345', NULL, NULL, NULL);
INSERT INTO public.user_books VALUES (2, 18, 4117, 'want-to-read', NULL, '2025-07-11 16:00:09.394345', NULL, NULL, NULL);
INSERT INTO public.user_books VALUES (3, 18, 4116, 'want-to-read', NULL, '2025-07-11 16:00:09.394345', NULL, NULL, NULL);
INSERT INTO public.user_books VALUES (4, 18, 1, 'want-to-read', NULL, '2025-07-11 16:00:09.394345', NULL, NULL, NULL);
INSERT INTO public.user_books VALUES (5, 18, 10, 'want-to-read', NULL, '2025-07-11 16:00:09.394345', NULL, NULL, NULL);
INSERT INTO public.user_books VALUES (6, 20, 4114, 'want-to-read', NULL, '2025-07-11 16:00:09.394345', NULL, NULL, NULL);
INSERT INTO public.user_books VALUES (8, 20, 4116, 'read', 5, '2025-07-11 16:44:46.66829', '2025-07-12 18:20:46.008', NULL, NULL);
INSERT INTO public.user_books VALUES (7, 20, 4111, 'read', 4, '2025-07-11 16:04:49.067943', '2025-07-12 18:21:11.584', NULL, NULL);


--
-- Data for Name: votes; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Name: authors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.authors_id_seq', 21, true);


--
-- Name: book_characters_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.book_characters_id_seq', 1, false);


--
-- Name: book_suggestions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.book_suggestions_id_seq', 1, false);


--
-- Name: books_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.books_id_seq', 4122, true);


--
-- Name: comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.comments_id_seq', 1, false);


--
-- Name: genres_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.genres_id_seq', 28, true);


--
-- Name: languages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.languages_id_seq', 23, true);


--
-- Name: login_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.login_history_id_seq', 3, true);


--
-- Name: publication_houses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.publication_houses_id_seq', 26, true);


--
-- Name: ratings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.ratings_id_seq', 3, true);


--
-- Name: reviews_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.reviews_id_seq', 1, true);


--
-- Name: user_books_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.user_books_id_seq', 13, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.users_id_seq', 20, true);


--
-- Name: votes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.votes_id_seq', 1, false);


--
-- PostgreSQL database dump complete
--

