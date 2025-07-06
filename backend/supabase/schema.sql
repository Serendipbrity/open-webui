

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


CREATE SCHEMA IF NOT EXISTS "public";


ALTER SCHEMA "public" OWNER TO "pg_database_owner";


COMMENT ON SCHEMA "public" IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = "heap";


CREATE TABLE IF NOT EXISTS "public"."conversation_threads" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "user_id" "uuid",
    "title" "text",
    "created_at" timestamp without time zone DEFAULT "now"()
);


ALTER TABLE "public"."conversation_threads" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."memory_cleanup_log" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "memory_point_id" "uuid",
    "deleted_at" timestamp without time zone DEFAULT "now"()
);


ALTER TABLE "public"."memory_cleanup_log" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."memory_points" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "parent_id" "uuid",
    "message_id" "uuid",
    "user_id" "uuid",
    "vector" "public"."vector"(1536),
    "importance_score" double precision DEFAULT 0,
    "summary" "text",
    "created_at" timestamp without time zone DEFAULT "now"()
);


ALTER TABLE "public"."memory_points" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."messages" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "thread_id" "uuid",
    "user_id" "uuid",
    "role" "text",
    "content" "text",
    "deleted" boolean DEFAULT false,
    "created_at" timestamp without time zone DEFAULT "now"(),
    CONSTRAINT "messages_role_check" CHECK (("role" = ANY (ARRAY['user'::"text", 'bodhi'::"text", 'system'::"text"])))
);


ALTER TABLE "public"."messages" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."users" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "email" "text",
    "created_at" timestamp without time zone DEFAULT "now"()
);


ALTER TABLE "public"."users" OWNER TO "postgres";


ALTER TABLE ONLY "public"."conversation_threads"
    ADD CONSTRAINT "conversation_threads_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."memory_cleanup_log"
    ADD CONSTRAINT "memory_cleanup_log_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."memory_points"
    ADD CONSTRAINT "memory_points_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."messages"
    ADD CONSTRAINT "messages_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."users"
    ADD CONSTRAINT "users_email_key" UNIQUE ("email");



ALTER TABLE ONLY "public"."users"
    ADD CONSTRAINT "users_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."conversation_threads"
    ADD CONSTRAINT "conversation_threads_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."memory_points"
    ADD CONSTRAINT "memory_points_message_id_fkey" FOREIGN KEY ("message_id") REFERENCES "public"."messages"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."memory_points"
    ADD CONSTRAINT "memory_points_parent_id_fkey" FOREIGN KEY ("parent_id") REFERENCES "public"."memory_points"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."memory_points"
    ADD CONSTRAINT "memory_points_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."messages"
    ADD CONSTRAINT "messages_thread_id_fkey" FOREIGN KEY ("thread_id") REFERENCES "public"."conversation_threads"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."messages"
    ADD CONSTRAINT "messages_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE CASCADE;



GRANT USAGE ON SCHEMA "public" TO "postgres";
GRANT USAGE ON SCHEMA "public" TO "anon";
GRANT USAGE ON SCHEMA "public" TO "authenticated";
GRANT USAGE ON SCHEMA "public" TO "service_role";



GRANT ALL ON TABLE "public"."conversation_threads" TO "anon";
GRANT ALL ON TABLE "public"."conversation_threads" TO "authenticated";
GRANT ALL ON TABLE "public"."conversation_threads" TO "service_role";



GRANT ALL ON TABLE "public"."memory_cleanup_log" TO "anon";
GRANT ALL ON TABLE "public"."memory_cleanup_log" TO "authenticated";
GRANT ALL ON TABLE "public"."memory_cleanup_log" TO "service_role";



GRANT ALL ON TABLE "public"."memory_points" TO "anon";
GRANT ALL ON TABLE "public"."memory_points" TO "authenticated";
GRANT ALL ON TABLE "public"."memory_points" TO "service_role";



GRANT ALL ON TABLE "public"."messages" TO "anon";
GRANT ALL ON TABLE "public"."messages" TO "authenticated";
GRANT ALL ON TABLE "public"."messages" TO "service_role";



GRANT ALL ON TABLE "public"."users" TO "anon";
GRANT ALL ON TABLE "public"."users" TO "authenticated";
GRANT ALL ON TABLE "public"."users" TO "service_role";



ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "service_role";






ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "service_role";






ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "service_role";






RESET ALL;
