--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.2
-- Dumped by pg_dump version 9.6.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: Test_DB; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE "Test_DB" IS 'Testing the Database forthe first time after installation';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: Student; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "Student" (
    id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE "Student" OWNER TO postgres;

--
-- Name: TABLE "Student"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE "Student" IS 'testing';


--
-- Name: Test1; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "Test1" (
    "Sno" integer NOT NULL,
    "FName" text[] NOT NULL,
    "Lname" text[] NOT NULL
);


ALTER TABLE "Test1" OWNER TO postgres;

--
-- Name: TABLE "Test1"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE "Test1" IS 'Testing Db';


--
-- Name: COLUMN "Test1"."Sno"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN "Test1"."Sno" IS 'for the serial number';


--
-- Name: COLUMN "Test1"."FName"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN "Test1"."FName" IS 'For defining name';


--
-- Name: Test_2; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "Test_2" (
    "Sno" "char"[] NOT NULL,
    "Name" text NOT NULL,
    "Education" text[] NOT NULL,
    "Age" integer NOT NULL,
    "MobileNumber" integer[] NOT NULL
);


ALTER TABLE "Test_2" OWNER TO postgres;

--
-- Name: TABLE "Test_2"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE "Test_2" IS 'Testing table';


--
-- Name: Test_3; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "Test_3" (
    "Sno" integer NOT NULL,
    "Address" text[] NOT NULL
);


ALTER TABLE "Test_3" OWNER TO postgres;

--
-- Name: TABLE "Test_3"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE "Test_3" IS 'Testing DB';


--
-- Name: company; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE company (
    id integer NOT NULL,
    name text NOT NULL,
    age integer NOT NULL,
    address character(50),
    saary real
);


ALTER TABLE company OWNER TO postgres;

--
-- Name: department; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE department (
    id integer NOT NULL,
    dept character(50) NOT NULL,
    emp_id integer NOT NULL
);


ALTER TABLE department OWNER TO postgres;

--
-- Name: department1; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE department1 (
    id integer,
    dept text,
    emp_id integer
);


ALTER TABLE department1 OWNER TO postgres;

--
-- Name: department2; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE department2 (
    id integer,
    dept text,
    emp_id integer
);


ALTER TABLE department2 OWNER TO postgres;

--
-- Name: studets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE studets (
    id integer,
    name_of_student text
);


ALTER TABLE studets OWNER TO postgres;

--
-- Data for Name: Student; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "Student" (id, name) FROM stdin;
1	sai
10	krishna
\.


--
-- Data for Name: Test1; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "Test1" ("Sno", "FName", "Lname") FROM stdin;
1	{Sairaj}	{Kotagiri}
2	{Sai}	{Raj}
3	{Raj}	{SAi}
4	{sai}	{kotagiri}
8	{Sai}	{Raj}
\.


--
-- Data for Name: Test_2; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "Test_2" ("Sno", "Name", "Education", "Age", "MobileNumber") FROM stdin;
\.


--
-- Data for Name: Test_3; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "Test_3" ("Sno", "Address") FROM stdin;
1	{5-89,Shbaunagar}
2	{5-90,Shbaunagar}
3	{5-103,Shbaunagar}
4	{4-103,Shbaunagar}
\.


--
-- Data for Name: company; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY company (id, name, age, address, saary) FROM stdin;
7	Sairaj	20	Telangana                                         	50000
1	Raj	20	Hyderabad                                         	10000
2	sai	20	BANGLORE                                          	20000
3	chintu	24	Delhi                                             	45000
4	sairajkotagiri	25	USA                                               	40000
8	saikotagiri	24	AMERICA                                           	100000
6	saikotagiri	24	AMERICA                                           	100000
9	saikotagiri	24	AMERICA                                           	100000
\.


--
-- Data for Name: department; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY department (id, dept, emp_id) FROM stdin;
2	ECE                                               	102
3	EEE                                               	103
1	CSE                                               	101
\.


--
-- Data for Name: department1; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY department1 (id, dept, emp_id) FROM stdin;
\.


--
-- Data for Name: department2; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY department2 (id, dept, emp_id) FROM stdin;
\.


--
-- Data for Name: studets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY studets (id, name_of_student) FROM stdin;
1	s1
2	s2
3	s3
4	s4
5	s5
\.


--
-- Name: Test1 Test1_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Test1"
    ADD CONSTRAINT "Test1_pkey" PRIMARY KEY ("Sno");


--
-- Name: Test_2 Test_2_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Test_2"
    ADD CONSTRAINT "Test_2_pkey" PRIMARY KEY ("Sno");


--
-- Name: company company_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY company
    ADD CONSTRAINT company_pkey PRIMARY KEY (id);


--
-- Name: department department_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY department
    ADD CONSTRAINT department_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

