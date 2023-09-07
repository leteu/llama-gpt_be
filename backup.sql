--
-- PostgreSQL database dump
--

-- Dumped from database version 14.8 (Homebrew)
-- Dumped by pg_dump version 14.8 (Homebrew)

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

CREATE TABLE public.tag (
    tag_id integer NOT NULL,
    "desc" character varying NOT NULL
);

ALTER TABLE public.tag OWNER TO postgres;

CREATE SEQUENCE public.tag_tag_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE public.tag_tag_id_seq OWNER TO postgres;

ALTER SEQUENCE public.tag_tag_id_seq OWNED BY public.tag.tag_id;

CREATE TABLE public.todo (
    todo_id integer NOT NULL,
    "desc" character varying,
    done boolean DEFAULT false NOT NULL,
    reg_dt timestamp without time zone NOT NULL,
    mod_dt timestamp without time zone,
    del_dt timestamp without time zone,
    tag_id bigint
);

ALTER TABLE public.todo OWNER TO postgres;

CREATE SEQUENCE public.todo_todo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE public.todo_todo_id_seq OWNER TO postgres;

ALTER SEQUENCE public.todo_todo_id_seq OWNED BY public.todo.todo_id;

ALTER TABLE ONLY public.tag ALTER COLUMN tag_id SET DEFAULT nextval('public.tag_tag_id_seq'::regclass);

ALTER TABLE ONLY public.todo ALTER COLUMN todo_id SET DEFAULT nextval('public.todo_todo_id_seq'::regclass);

SELECT pg_catalog.setval('public.tag_tag_id_seq', 1, true);

SELECT pg_catalog.setval('public.todo_todo_id_seq', 1, true);

ALTER TABLE ONLY public.tag
    ADD CONSTRAINT tag_pk PRIMARY KEY (tag_id);

ALTER TABLE ONLY public.todo
    ADD CONSTRAINT todo_pk PRIMARY KEY (todo_id);

ALTER TABLE ONLY public.todo
    ADD CONSTRAINT todo_fk FOREIGN KEY (tag_id) REFERENCES public.tag(tag_id);
