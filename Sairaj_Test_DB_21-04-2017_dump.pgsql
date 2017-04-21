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

--
-- Name: emp_stamp(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION emp_stamp() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
   BEGIN
       IF NEW.empname IS NULL THEN
           RAISE EXCEPTION 'empname cannot be null';
       END IF;
       IF NEW.last_name IS NULL THEN
           RAISE EXCEPTION 'last_name cannot be null';
       END IF;
       IF NEW.salary IS NULL OR NEW.salary THEN
           RAISE EXCEPTION '% cannot have null salary or should be lessthan zero', NEW.salary;
       END IF;
       -- IF NEW.salary < 0 THEN
       --    RAISE EXCEPTION '% cannot have a negative salary', NEW.salary;
       -- END IF;
	   IF NEW.email_id IS NULL THEN
           RAISE EXCEPTION 'email_id cannot be null';
       END IF;
       IF NEW.time_st IS NULL THEN
           RAISE EXCEPTION 'time_st cannot be null';
       END IF;
       
       -- NEW.last_date := current_timestamp;
       -- NEW.last_user := current_user;
       RETURN NEW;
   END;
$$;


ALTER FUNCTION public.emp_stamp() OWNER TO postgres;

--
-- Name: get_emp(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION get_emp(eage integer) RETURNS TABLE(iden integer, nam text)
    LANGUAGE plpgsql
    AS $$
begin
return query select id,name from company where saary = eage;
end;
$$;


ALTER FUNCTION public.get_emp(eage integer) OWNER TO postgres;

--
-- Name: get_film_titles(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION get_film_titles(p_year integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE 
 fname TEXT DEFAULT '';
 rec_film RECORD;
 cur_details CURSOR(p_year INTEGER) 
 FOR SELECT 
 FROM details
 WHERE salary = p_year;
BEGIN
   -- Open the cursor
   OPEN cur_details(p_year);
 
   LOOP
    -- fetch row into the film
      FETCH cur_details INTO rec_film;
    -- exit when no more row to fetch
      EXIT WHEN NOT FOUND;
 
    -- build the output
      IF rec_film.fname LIKE '%ful%' THEN 
         fname := fname || ',' || rec_film.fname || ':' || rec_film.salary;
      END IF;
   END LOOP;
  
   -- Close the cursor
   CLOSE cur_details;
 
   RETURN fname;
END; $$;


ALTER FUNCTION public.get_film_titles(p_year integer) OWNER TO postgres;

--
-- Name: inc_by_per(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION inc_by_per(a integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
begin
update details set salary = ((salary+1) * (50000)) ;
end;
$$;


ALTER FUNCTION public.inc_by_per(a integer) OWNER TO postgres;

--
-- Name: inc_by_percentage(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION inc_by_percentage(a integer) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
begin 
update details set salary = (salary * 0.5) where salary = 80000;
end;
$$;


ALTER FUNCTION public.inc_by_percentage(a integer) OWNER TO postgres;

--
-- Name: minmax(integer, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION minmax(a integer, b integer, c integer, OUT min integer, OUT max integer) RETURNS record
    LANGUAGE plpgsql
    AS $$
begin
max = greatest(a,b,c);
min = least(a,b,c);
end;
$$;


ALTER FUNCTION public.minmax(a integer, b integer, c integer, OUT min integer, OUT max integer) OWNER TO postgres;

--
-- Name: mul(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION mul(INOUT a integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
begin
a = a * a;
end;
$$;


ALTER FUNCTION public.mul(INOUT a integer) OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: company; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE company (
    id integer NOT NULL,
    name text NOT NULL,
    age integer NOT NULL,
    add character(50),
    saary real
);


ALTER TABLE company OWNER TO postgres;

--
-- Name: myfunction(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION myfunction() RETURNS SETOF company
    LANGUAGE plpgsql
    AS $$
DECLARE 
cur CURSOR FOR SELECT * FROM company;
rec company%ROWTYPE;
BEGIN
OPEN cur;
-- RAISE NOTICE 'id,name,age,salary';
loop
FETCH cur INTO rec;
  if not found then
       exit ;
  end if;
RAISE NOTICE 'id %,name %,age %,add %,saary %',rec.id,rec.name,rec.age,rec.add,rec.saary;
end loop;
RETURN;
END;
$$;


ALTER FUNCTION public.myfunction() OWNER TO postgres;

--
-- Name: total(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION total() RETURNS integer
    LANGUAGE plpgsql
    AS $$
declare
total integer;
begin
select * into total from company;
return total;
end;
$$;


ALTER FUNCTION public.total() OWNER TO postgres;

--
-- Name: updat_fun(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION updat_fun(a integer) RETURNS TABLE(t_dept text, emp_id integer)
    LANGUAGE plpgsql
    AS $$
begin
return query update department set emp_id = emp_id * (a/100);
end;
$$;


ALTER FUNCTION public.updat_fun(a integer) OWNER TO postgres;

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
-- Name: details; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE details (
    empname text,
    last_name text,
    salary integer,
    email_id text,
    time_st timestamp without time zone,
    sno_id integer
);


ALTER TABLE details OWNER TO postgres;

--
-- Name: emp; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE emp (
    empname text,
    salary integer,
    last_date timestamp without time zone,
    last_user text
);


ALTER TABLE emp OWNER TO postgres;

--
-- Name: messages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE messages (
    date date,
    id integer NOT NULL
);


ALTER TABLE messages OWNER TO postgres;

--
-- Name: messages_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE messages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE messages_id_seq OWNER TO postgres;

--
-- Name: messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE messages_id_seq OWNED BY messages.id;


--
-- Name: studets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE studets (
    id integer,
    name_of_student text
);


ALTER TABLE studets OWNER TO postgres;

--
-- Name: messages id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY messages ALTER COLUMN id SET DEFAULT nextval('messages_id_seq'::regclass);


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

COPY company (id, name, age, add, saary) FROM stdin;
7	Sairaj	20	Telangana                                         	50000
2	sai	20	BANGLORE                                          	20000
3	chintu	24	Delhi                                             	45000
4	sairajkotagiri	25	USA                                               	40000
8	saikotagiri	24	AMERICA                                           	100000
6	saikotagiri	24	AMERICA                                           	100000
9	saikotagiri	24	AMERICA                                           	100000
1	Raj	20	Hyderabad                                         	10000
10	candy	24	rajumandry                                        	50000
11	abc	32	UK                                                	1000000
\.


--
-- Data for Name: department; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY department (id, dept, emp_id) FROM stdin;
3	EEE                                               	300
2	ECE                                               	111
1	CSE                                               	111
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
-- Data for Name: details; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY details (empname, last_name, salary, email_id, time_st, sno_id) FROM stdin;
sairaj	sairaj	50000	sairaj3@gmail.com	2017-05-20 07:59:00	\N
sai	sairaj	50000	sai3@gmail.com	2017-04-20 07:00:00	\N
sairaj	kotagiri	50000	saikotagiri2013@gmail.com	2017-04-20 08:00:00	\N
sai	kotagiri	50000	sai2013@gmail.com	2017-04-20 08:01:00	\N
sairajkotagiri	kotagiri	50000	sairaj2013@gmail.com	2017-04-20 20:02:00	\N
\.


--
-- Data for Name: emp; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY emp (empname, salary, last_date, last_user) FROM stdin;
sairaj	50000	2017-04-20 19:35:19.788652	postgres
sairaj	50000	2017-04-20 19:43:05.670192	raj
sairaj	50000	2017-04-20 00:00:00	raj
saira1j	50000	2017-03-20 00:00:00	raj1
sairaj	50000	2017-04-20 10:10:10	raj
saira1j	50000	2017-03-20 07:46:00	raj1
sairaj	50000	2017-04-20 23:32:10	raj
\.


--
-- Data for Name: messages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY messages (date, id) FROM stdin;
\.


--
-- Name: messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('messages_id_seq', 1, false);


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
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id);


--
-- Name: emp emp_stamp; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER emp_stamp BEFORE INSERT OR UPDATE ON emp FOR EACH ROW EXECUTE PROCEDURE emp_stamp();


--
-- PostgreSQL database dump complete
--

