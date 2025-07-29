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

 Date: 27/07/2025 12:47:14
*/


-- ----------------------------
-- Table structure for user_books
-- ----------------------------
DROP TABLE IF EXISTS "public"."user_books";
CREATE TABLE "public"."user_books" (
  "id" int4 NOT NULL DEFAULT nextval('user_books_id_seq'::regclass),
  "user_id" int4 NOT NULL,
  "book_id" int4 NOT NULL,
  "shelf" varchar(50) COLLATE "pg_catalog"."default" NOT NULL DEFAULT 'want-to-read'::character varying,
  "date_added" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "date_read" timestamp(6),
  "review_id" int4,
  "notes" text COLLATE "pg_catalog"."default",
  "deleted_book_title" varchar(255) COLLATE "pg_catalog"."default"
)
;
ALTER TABLE "public"."user_books" OWNER TO "postgres";

-- ----------------------------
-- Indexes structure for table user_books
-- ----------------------------
CREATE INDEX "idx_user_books_book" ON "public"."user_books" USING btree (
  "book_id" "pg_catalog"."int4_ops" ASC NULLS LAST
);
CREATE INDEX "idx_user_books_date_added" ON "public"."user_books" USING btree (
  "date_added" "pg_catalog"."timestamp_ops" ASC NULLS LAST
);
CREATE INDEX "idx_user_books_deleted_title" ON "public"."user_books" USING btree (
  "deleted_book_title" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_book_title IS NOT NULL;
CREATE INDEX "idx_user_books_shelf" ON "public"."user_books" USING btree (
  "shelf" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "idx_user_books_user" ON "public"."user_books" USING btree (
  "user_id" "pg_catalog"."int4_ops" ASC NULLS LAST
);
CREATE INDEX "idx_user_books_user_date_read" ON "public"."user_books" USING btree (
  "user_id" "pg_catalog"."int4_ops" ASC NULLS LAST,
  "date_read" "pg_catalog"."timestamp_ops" ASC NULLS LAST
);
CREATE INDEX "idx_user_books_user_shelf" ON "public"."user_books" USING btree (
  "user_id" "pg_catalog"."int4_ops" ASC NULLS LAST,
  "shelf" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Uniques structure for table user_books
-- ----------------------------
ALTER TABLE "public"."user_books" ADD CONSTRAINT "user_books_user_id_book_id_key" UNIQUE ("user_id", "book_id");

-- ----------------------------
-- Checks structure for table user_books
-- ----------------------------
ALTER TABLE "public"."user_books" ADD CONSTRAINT "user_books_shelf_check" CHECK (shelf::text = ANY (ARRAY['want-to-read'::character varying::text, 'currently-reading'::character varying::text, 'read'::character varying::text]));

-- ----------------------------
-- Primary Key structure for table user_books
-- ----------------------------
ALTER TABLE "public"."user_books" ADD CONSTRAINT "user_books_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Foreign Keys structure for table user_books
-- ----------------------------
ALTER TABLE "public"."user_books" ADD CONSTRAINT "user_books_book_id_fkey" FOREIGN KEY ("book_id") REFERENCES "public"."books" ("id") ON DELETE SET NULL ON UPDATE NO ACTION;
ALTER TABLE "public"."user_books" ADD CONSTRAINT "user_books_review_id_fkey" FOREIGN KEY ("review_id") REFERENCES "public"."reviews" ("id") ON DELETE SET NULL ON UPDATE NO ACTION;
ALTER TABLE "public"."user_books" ADD CONSTRAINT "user_books_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."users" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;
