DO $pdd_schema$
BEGIN
--
-- PostgreSQL database dump
--
-- Dumped from database version 14.0
-- Dumped by pg_dump version 14.0
SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
PERFORM pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;
ALTER TABLE IF EXISTS ONLY public.person_roles DROP CONSTRAINT IF EXISTS fk_role_id;
ALTER TABLE IF EXISTS ONLY public.company_reviews DROP CONSTRAINT IF EXISTS fk_person_id;
ALTER TABLE IF EXISTS ONLY public.person_roles DROP CONSTRAINT IF EXISTS fk_person_id;
ALTER TABLE IF EXISTS ONLY public.users DROP CONSTRAINT IF EXISTS fk_person_id;
ALTER TABLE IF EXISTS ONLY public.employee_records DROP CONSTRAINT IF EXISTS fk_person_id;
ALTER TABLE IF EXISTS ONLY public.people DROP CONSTRAINT IF EXISTS fk_modified_by;
ALTER TABLE IF EXISTS ONLY public.companies DROP CONSTRAINT IF EXISTS fk_modified_by;
ALTER TABLE IF EXISTS ONLY public.people DROP CONSTRAINT IF EXISTS fk_employee_status;
ALTER TABLE IF EXISTS ONLY public.company_reviews DROP CONSTRAINT IF EXISTS fk_created_by;
ALTER TABLE IF EXISTS ONLY public.person_roles DROP CONSTRAINT IF EXISTS fk_created_by;
ALTER TABLE IF EXISTS ONLY public.employee_records DROP CONSTRAINT IF EXISTS fk_created_by;
ALTER TABLE IF EXISTS ONLY public.people DROP CONSTRAINT IF EXISTS fk_created_by;
ALTER TABLE IF EXISTS public.company_areas DROP CONSTRAINT IF EXISTS fk_created_by;
ALTER TABLE IF EXISTS ONLY public.companies DROP CONSTRAINT IF EXISTS fk_created_by;
ALTER TABLE IF EXISTS ONLY public.people DROP CONSTRAINT IF EXISTS fk_country;
ALTER TABLE IF EXISTS ONLY public.companies DROP CONSTRAINT IF EXISTS fk_country;
ALTER TABLE IF EXISTS ONLY public.company_reviews DROP CONSTRAINT IF EXISTS fk_company_id;
ALTER TABLE IF EXISTS ONLY public.employee_records DROP CONSTRAINT IF EXISTS fk_company_id;
ALTER TABLE IF EXISTS public.company_areas DROP CONSTRAINT IF EXISTS fk_company_id;
ALTER TABLE IF EXISTS public.company_areas DROP CONSTRAINT IF EXISTS fk_area_id;
DROP INDEX IF EXISTS public.idx_users_email;
DROP INDEX IF EXISTS public.idx_people_name_normalized;
DROP INDEX IF EXISTS public.idx_employee_status_name_normalized;
DROP INDEX IF EXISTS public.idx_countries_name_normalized;
DROP INDEX IF EXISTS public.idx_company_id_person_id;
DROP INDEX IF EXISTS public.idx_companies_name_normalized;
DROP INDEX IF EXISTS public.idx_business_roles_name_normalized;
DROP INDEX IF EXISTS public.idx_business_areas_name_normalized;
ALTER TABLE IF EXISTS ONLY public.users DROP CONSTRAINT IF EXISTS users_pkey;
ALTER TABLE IF EXISTS ONLY public.person_roles DROP CONSTRAINT IF EXISTS pk_person_roles;
ALTER TABLE IF EXISTS ONLY public.company_areas DROP CONSTRAINT IF EXISTS pk_company_areas;
ALTER TABLE IF EXISTS ONLY public.people DROP CONSTRAINT IF EXISTS people_pkey;
ALTER TABLE IF EXISTS ONLY public.employee_status DROP CONSTRAINT IF EXISTS employee_status_pkey;
ALTER TABLE IF EXISTS ONLY public.countries DROP CONSTRAINT IF EXISTS countries_pkey;
ALTER TABLE IF EXISTS ONLY public.company_reviews DROP CONSTRAINT IF EXISTS company_reviews_pkey;
ALTER TABLE IF EXISTS ONLY public.companies DROP CONSTRAINT IF EXISTS companies_pkey;
ALTER TABLE IF EXISTS ONLY public.business_roles DROP CONSTRAINT IF EXISTS business_roles_pkey;
ALTER TABLE IF EXISTS ONLY public.business_areas DROP CONSTRAINT IF EXISTS business_areas_pkey;
DROP TABLE IF EXISTS public.users;
DROP TABLE IF EXISTS public.person_roles;
DROP TABLE IF EXISTS public.people;
DROP TABLE IF EXISTS public.employee_status;
DROP TABLE IF EXISTS public.employee_records;
DROP TABLE IF EXISTS public.countries;
DROP TABLE IF EXISTS public.company_reviews;
DROP TABLE IF EXISTS public.company_areas_proptech;
DROP TABLE IF EXISTS public.company_areas_mobility;
DROP TABLE IF EXISTS public.company_areas_manufacturing;
DROP TABLE IF EXISTS public.company_areas_insurtech;
DROP TABLE IF EXISTS public.company_areas_healthcare;
DROP TABLE IF EXISTS public.company_areas_hardware;
DROP TABLE IF EXISTS public.company_areas_general;
DROP TABLE IF EXISTS public.company_areas_fintech;
DROP TABLE IF EXISTS public.company_areas_enterprise;
DROP TABLE IF EXISTS public.company_areas_edtech;
DROP TABLE IF EXISTS public.company_areas_consumer;
DROP TABLE IF EXISTS public.company_areas_bigdata;
DROP TABLE IF EXISTS public.company_areas_ai;
DROP TABLE IF EXISTS public.company_areas;
DROP TABLE IF EXISTS public.companies;
DROP TABLE IF EXISTS public.business_roles;
DROP TABLE IF EXISTS public.business_areas;
DROP TYPE IF EXISTS public.valid_genders;
--
-- Name: valid_genders; Type: TYPE; Schema: public; Owner: -
--
CREATE TYPE public.valid_genders AS ENUM (
    'M',
    'F'
);
SET default_tablespace = '';
SET default_table_access_method = heap;
--
-- Name: business_areas; Type: TABLE; Schema: public; Owner: -
--
CREATE TABLE public.business_areas (
    id smallint NOT NULL,
    name character varying NOT NULL,
    name_normalized character varying NOT NULL
);
--
-- Name: TABLE business_areas; Type: COMMENT; Schema: public; Owner: -
--
COMMENT ON TABLE public.business_areas IS 'Business areas that companies may be invloved.';
--
-- Name: COLUMN business_areas.name_normalized; Type: COMMENT; Schema: public; Owner: -
--
COMMENT ON COLUMN public.business_areas.name_normalized IS 'lowercased';
--
-- Name: business_areas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--
ALTER TABLE public.business_areas ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.business_areas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
--
-- Name: business_roles; Type: TABLE; Schema: public; Owner: -
--
CREATE TABLE public.business_roles (
    id smallint NOT NULL,
    name character varying NOT NULL,
    name_normalized character varying NOT NULL
);
--
-- Name: TABLE business_roles; Type: COMMENT; Schema: public; Owner: -
--
COMMENT ON TABLE public.business_roles IS 'Roles in a team that employees are specialized working with.';
--
-- Name: COLUMN business_roles.name_normalized; Type: COMMENT; Schema: public; Owner: -
--
COMMENT ON COLUMN public.business_roles.name_normalized IS 'lowercased';
--
-- Name: business_roles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--
ALTER TABLE public.business_roles ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.business_roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
--
-- Name: companies; Type: TABLE; Schema: public; Owner: -
--
CREATE TABLE public.companies (
    id bigint NOT NULL,
    name character varying NOT NULL,
    name_normalized character varying NOT NULL,
    web character varying,
    linkedin character varying,
    tweeter character varying,
    company_line character varying,
    about character varying,
    country smallint,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    modified_at timestamp with time zone DEFAULT now() NOT NULL,
    created_by bigint DEFAULT 1 NOT NULL,
    modified_by bigint DEFAULT 1 NOT NULL
);
--
-- Name: COLUMN companies.name_normalized; Type: COMMENT; Schema: public; Owner: -
--
COMMENT ON COLUMN public.companies.name_normalized IS 'lowercased';
--
-- Name: COLUMN companies.company_line; Type: COMMENT; Schema: public; Owner: -
--
COMMENT ON COLUMN public.companies.company_line IS 'company moto';
--
-- Name: COLUMN companies.country; Type: COMMENT; Schema: public; Owner: -
--
COMMENT ON COLUMN public.companies.country IS 'headquaters country';
--
-- Name: companies_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--
ALTER TABLE public.companies ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.companies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
--
-- Name: company_areas; Type: TABLE; Schema: public; Owner: -
--
CREATE TABLE public.company_areas (
    company_id bigint NOT NULL,
    area_id smallint NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    created_by bigint DEFAULT 1 NOT NULL
)
PARTITION BY LIST (area_id);
--
-- Name: TABLE company_areas; Type: COMMENT; Schema: public; Owner: -
--
COMMENT ON TABLE public.company_areas IS 'Companies - business areas.';
--
-- Name: COLUMN company_areas.area_id; Type: COMMENT; Schema: public; Owner: -
--
COMMENT ON COLUMN public.company_areas.area_id IS 'partitioned by';
--
-- Name: company_areas_ai; Type: TABLE; Schema: public; Owner: -
--
CREATE TABLE public.company_areas_ai (
    company_id bigint NOT NULL,
    area_id smallint NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    created_by bigint DEFAULT 1 NOT NULL
);
--
-- Name: company_areas_bigdata; Type: TABLE; Schema: public; Owner: -
--
CREATE TABLE public.company_areas_bigdata (
    company_id bigint NOT NULL,
    area_id smallint NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    created_by bigint DEFAULT 1 NOT NULL
);
--
-- Name: company_areas_consumer; Type: TABLE; Schema: public; Owner: -
--
CREATE TABLE public.company_areas_consumer (
    company_id bigint NOT NULL,
    area_id smallint NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    created_by bigint DEFAULT 1 NOT NULL
);
--
-- Name: company_areas_edtech; Type: TABLE; Schema: public; Owner: -
--
CREATE TABLE public.company_areas_edtech (
    company_id bigint NOT NULL,
    area_id smallint NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    created_by bigint DEFAULT 1 NOT NULL
);
--
-- Name: company_areas_enterprise; Type: TABLE; Schema: public; Owner: -
--
CREATE TABLE public.company_areas_enterprise (
    company_id bigint NOT NULL,
    area_id smallint NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    created_by bigint DEFAULT 1 NOT NULL
);
--
-- Name: company_areas_fintech; Type: TABLE; Schema: public; Owner: -
--
CREATE TABLE public.company_areas_fintech (
    company_id bigint NOT NULL,
    area_id smallint NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    created_by bigint DEFAULT 1 NOT NULL
);
--
-- Name: company_areas_general; Type: TABLE; Schema: public; Owner: -
--
CREATE TABLE public.company_areas_general (
    company_id bigint NOT NULL,
    area_id smallint NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    created_by bigint DEFAULT 1 NOT NULL
);
--
-- Name: company_areas_hardware; Type: TABLE; Schema: public; Owner: -
--
CREATE TABLE public.company_areas_hardware (
    company_id bigint NOT NULL,
    area_id smallint NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    created_by bigint DEFAULT 1 NOT NULL
);
--
-- Name: company_areas_healthcare; Type: TABLE; Schema: public; Owner: -
--
CREATE TABLE public.company_areas_healthcare (
    company_id bigint NOT NULL,
    area_id smallint NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    created_by bigint DEFAULT 1 NOT NULL
);
--
-- Name: company_areas_insurtech; Type: TABLE; Schema: public; Owner: -
--
CREATE TABLE public.company_areas_insurtech (
    company_id bigint NOT NULL,
    area_id smallint NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    created_by bigint DEFAULT 1 NOT NULL
);
--
-- Name: company_areas_manufacturing; Type: TABLE; Schema: public; Owner: -
--
CREATE TABLE public.company_areas_manufacturing (
    company_id bigint NOT NULL,
    area_id smallint NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    created_by bigint DEFAULT 1 NOT NULL
);
--
-- Name: company_areas_mobility; Type: TABLE; Schema: public; Owner: -
--
CREATE TABLE public.company_areas_mobility (
    company_id bigint NOT NULL,
    area_id smallint NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    created_by bigint DEFAULT 1 NOT NULL
);
--
-- Name: company_areas_proptech; Type: TABLE; Schema: public; Owner: -
--
CREATE TABLE public.company_areas_proptech (
    company_id bigint NOT NULL,
    area_id smallint NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    created_by bigint DEFAULT 1 NOT NULL
);
--
-- Name: company_reviews; Type: TABLE; Schema: public; Owner: -
--
CREATE TABLE public.company_reviews (
    id bigint NOT NULL,
    company_id bigint NOT NULL,
    person_id bigint,
    review character varying NOT NULL,
    score smallint,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    modified_at timestamp with time zone DEFAULT now() NOT NULL,
    created_by bigint DEFAULT 1 NOT NULL,
    CONSTRAINT company_reviews_rate_check CHECK (((score IS NULL) OR ((score > 0) AND (score <= 5))))
);
--
-- Name: TABLE company_reviews; Type: COMMENT; Schema: public; Owner: -
--
COMMENT ON TABLE public.company_reviews IS 'Company reviews made by people.';
--
-- Name: COLUMN company_reviews.company_id; Type: COMMENT; Schema: public; Owner: -
--
COMMENT ON COLUMN public.company_reviews.company_id IS 'company reviewed';
--
-- Name: COLUMN company_reviews.person_id; Type: COMMENT; Schema: public; Owner: -
--
COMMENT ON COLUMN public.company_reviews.person_id IS 'person reviewer';
--
-- Name: COLUMN company_reviews.review; Type: COMMENT; Schema: public; Owner: -
--
COMMENT ON COLUMN public.company_reviews.review IS 'written review by a person';
--
-- Name: COLUMN company_reviews.score; Type: COMMENT; Schema: public; Owner: -
--
COMMENT ON COLUMN public.company_reviews.score IS 'score 1-5';
--
-- Name: company_reviews_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--
ALTER TABLE public.company_reviews ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.company_reviews_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
--
-- Name: countries; Type: TABLE; Schema: public; Owner: -
--
CREATE TABLE public.countries (
    code smallint NOT NULL,
    iso2 character(2) NOT NULL,
    iso3 character(3) NOT NULL,
    name character varying NOT NULL,
    name_normalized character varying NOT NULL,
    culture character varying
);
--
-- Name: COLUMN countries.code; Type: COMMENT; Schema: public; Owner: -
--
COMMENT ON COLUMN public.countries.code IS 'Contry ISO 3166 numeric code.';
--
-- Name: COLUMN countries.iso2; Type: COMMENT; Schema: public; Owner: -
--
COMMENT ON COLUMN public.countries.iso2 IS 'Contry ISO 3166 alpha-2 code.';
--
-- Name: COLUMN countries.iso3; Type: COMMENT; Schema: public; Owner: -
--
COMMENT ON COLUMN public.countries.iso3 IS 'Contry ISO 3166 alpha-3 code.';
--
-- Name: COLUMN countries.name_normalized; Type: COMMENT; Schema: public; Owner: -
--
COMMENT ON COLUMN public.countries.name_normalized IS 'lowercased';
--
-- Name: COLUMN countries.culture; Type: COMMENT; Schema: public; Owner: -
--
COMMENT ON COLUMN public.countries.culture IS 'The CultureInfo class specifies a unique name for each culture, based on RFC 4646. The name is a combination of an ISO 639 two-letter lowercase culture code associated with a language and an ISO 3166 two-letter uppercase subculture code associated with a country or region. ';
--
-- Name: employee_records; Type: TABLE; Schema: public; Owner: -
--
CREATE TABLE public.employee_records (
    company_id bigint NOT NULL,
    person_id bigint NOT NULL,
    employment_started_at date NOT NULL,
    employment_ended_at date,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    created_by bigint DEFAULT 1 NOT NULL
);
--
-- Name: TABLE employee_records; Type: COMMENT; Schema: public; Owner: -
--
COMMENT ON TABLE public.employee_records IS 'History of employment in companies by people.';
--
-- Name: COLUMN employee_records.employment_ended_at; Type: COMMENT; Schema: public; Owner: -
--
COMMENT ON COLUMN public.employee_records.employment_ended_at IS 'if this is null, it means person is still working there';
--
-- Name: employee_status; Type: TABLE; Schema: public; Owner: -
--
CREATE TABLE public.employee_status (
    id smallint NOT NULL,
    name character varying NOT NULL,
    name_normalized character varying NOT NULL
);
--
-- Name: TABLE employee_status; Type: COMMENT; Schema: public; Owner: -
--
COMMENT ON TABLE public.employee_status IS 'List of possible statuses in regards to employment.';
--
-- Name: COLUMN employee_status.name_normalized; Type: COMMENT; Schema: public; Owner: -
--
COMMENT ON COLUMN public.employee_status.name_normalized IS 'lowercased';
--
-- Name: employee_status_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--
ALTER TABLE public.employee_status ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.employee_status_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
--
-- Name: people; Type: TABLE; Schema: public; Owner: -
--
CREATE TABLE public.people (
    id bigint NOT NULL,
    first_name character varying NOT NULL,
    last_name character varying NOT NULL,
    name_normalized character varying NOT NULL,
    employee_status smallint NOT NULL,
    gender public.valid_genders,
    email character varying,
    linkedin character varying,
    twitter character varying,
    birth date,
    country smallint,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    modified_at timestamp with time zone DEFAULT now() NOT NULL,
    created_by bigint DEFAULT 1 NOT NULL,
    modified_by bigint DEFAULT 1 NOT NULL
);
--
-- Name: COLUMN people.name_normalized; Type: COMMENT; Schema: public; Owner: -
--
COMMENT ON COLUMN public.people.name_normalized IS 'first_name + '' '' + last_name + ''\n''  last_name + ''  '' +  first_name  all in lowercase to enable both searches (staring with first or last name).';
--
-- Name: COLUMN people.gender; Type: COMMENT; Schema: public; Owner: -
--
COMMENT ON COLUMN public.people.gender IS 'M or F';
--
-- Name: people_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--
ALTER TABLE public.people ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.people_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
--
-- Name: person_roles; Type: TABLE; Schema: public; Owner: -
--
CREATE TABLE public.person_roles (
    person_id bigint NOT NULL,
    role_id smallint NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    created_by bigint DEFAULT 1 NOT NULL
);
--
-- Name: TABLE person_roles; Type: COMMENT; Schema: public; Owner: -
--
COMMENT ON TABLE public.person_roles IS 'Person - business roles';
--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--
CREATE TABLE public.users (
    id bigint NOT NULL,
    email character varying NOT NULL,
    name character varying,
    data json DEFAULT '{}'::json NOT NULL,
    providers character varying[] DEFAULT '{}'::character varying[] NOT NULL,
    timezone character varying NOT NULL,
    culture character varying NOT NULL,
    person_id bigint,
    lockout_end timestamp with time zone,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);
--
-- Name: TABLE users; Type: COMMENT; Schema: public; Owner: -
--
COMMENT ON TABLE public.users IS 'System users. May or may not be a person (in people records).';
--
-- Name: COLUMN users.data; Type: COMMENT; Schema: public; Owner: -
--
COMMENT ON COLUMN public.users.data IS 'json data received from external auth provider';
--
-- Name: COLUMN users.providers; Type: COMMENT; Schema: public; Owner: -
--
COMMENT ON COLUMN public.users.providers IS 'list of external auth providers autorized this user';
--
-- Name: COLUMN users.timezone; Type: COMMENT; Schema: public; Owner: -
--
COMMENT ON COLUMN public.users.timezone IS 'timezone from browser';
--
-- Name: COLUMN users.culture; Type: COMMENT; Schema: public; Owner: -
--
COMMENT ON COLUMN public.users.culture IS 'matching culture by browser timezone';
--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--
ALTER TABLE public.users ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
--
-- Name: company_areas_ai; Type: TABLE ATTACH; Schema: public; Owner: -
--
ALTER TABLE ONLY public.company_areas ATTACH PARTITION public.company_areas_ai FOR VALUES IN ('11');
--
-- Name: company_areas_bigdata; Type: TABLE ATTACH; Schema: public; Owner: -
--
ALTER TABLE ONLY public.company_areas ATTACH PARTITION public.company_areas_bigdata FOR VALUES IN ('6');
--
-- Name: company_areas_consumer; Type: TABLE ATTACH; Schema: public; Owner: -
--
ALTER TABLE ONLY public.company_areas ATTACH PARTITION public.company_areas_consumer FOR VALUES IN ('13');
--
-- Name: company_areas_edtech; Type: TABLE ATTACH; Schema: public; Owner: -
--
ALTER TABLE ONLY public.company_areas ATTACH PARTITION public.company_areas_edtech FOR VALUES IN ('12');
--
-- Name: company_areas_enterprise; Type: TABLE ATTACH; Schema: public; Owner: -
--
ALTER TABLE ONLY public.company_areas ATTACH PARTITION public.company_areas_enterprise FOR VALUES IN ('2');
--
-- Name: company_areas_fintech; Type: TABLE ATTACH; Schema: public; Owner: -
--
ALTER TABLE ONLY public.company_areas ATTACH PARTITION public.company_areas_fintech FOR VALUES IN ('3');
--
-- Name: company_areas_general; Type: TABLE ATTACH; Schema: public; Owner: -
--
ALTER TABLE ONLY public.company_areas ATTACH PARTITION public.company_areas_general FOR VALUES IN ('1');
--
-- Name: company_areas_hardware; Type: TABLE ATTACH; Schema: public; Owner: -
--
ALTER TABLE ONLY public.company_areas ATTACH PARTITION public.company_areas_hardware FOR VALUES IN ('9');
--
-- Name: company_areas_healthcare; Type: TABLE ATTACH; Schema: public; Owner: -
--
ALTER TABLE ONLY public.company_areas ATTACH PARTITION public.company_areas_healthcare FOR VALUES IN ('7');
--
-- Name: company_areas_insurtech; Type: TABLE ATTACH; Schema: public; Owner: -
--
ALTER TABLE ONLY public.company_areas ATTACH PARTITION public.company_areas_insurtech FOR VALUES IN ('5');
--
-- Name: company_areas_manufacturing; Type: TABLE ATTACH; Schema: public; Owner: -
--
ALTER TABLE ONLY public.company_areas ATTACH PARTITION public.company_areas_manufacturing FOR VALUES IN ('8');
--
-- Name: company_areas_mobility; Type: TABLE ATTACH; Schema: public; Owner: -
--
ALTER TABLE ONLY public.company_areas ATTACH PARTITION public.company_areas_mobility FOR VALUES IN ('4');
--
-- Name: company_areas_proptech; Type: TABLE ATTACH; Schema: public; Owner: -
--
ALTER TABLE ONLY public.company_areas ATTACH PARTITION public.company_areas_proptech FOR VALUES IN ('10');
--
-- Name: business_areas business_areas_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--
ALTER TABLE ONLY public.business_areas
    ADD CONSTRAINT business_areas_pkey PRIMARY KEY (id);
--
-- Name: business_roles business_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--
ALTER TABLE ONLY public.business_roles
    ADD CONSTRAINT business_roles_pkey PRIMARY KEY (id);
--
-- Name: companies companies_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--
ALTER TABLE ONLY public.companies
    ADD CONSTRAINT companies_pkey PRIMARY KEY (id);
--
-- Name: company_reviews company_reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--
ALTER TABLE ONLY public.company_reviews
    ADD CONSTRAINT company_reviews_pkey PRIMARY KEY (id);
--
-- Name: countries countries_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--
ALTER TABLE ONLY public.countries
    ADD CONSTRAINT countries_pkey PRIMARY KEY (code);
--
-- Name: employee_status employee_status_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--
ALTER TABLE ONLY public.employee_status
    ADD CONSTRAINT employee_status_pkey PRIMARY KEY (id);
--
-- Name: people people_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--
ALTER TABLE ONLY public.people
    ADD CONSTRAINT people_pkey PRIMARY KEY (id);
--
-- Name: company_areas pk_company_areas; Type: CONSTRAINT; Schema: public; Owner: -
--
ALTER TABLE ONLY public.company_areas
    ADD CONSTRAINT pk_company_areas PRIMARY KEY (company_id, area_id);
--
-- Name: person_roles pk_person_roles; Type: CONSTRAINT; Schema: public; Owner: -
--
ALTER TABLE ONLY public.person_roles
    ADD CONSTRAINT pk_person_roles PRIMARY KEY (person_id, role_id);
--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--
ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
--
-- Name: idx_business_areas_name_normalized; Type: INDEX; Schema: public; Owner: -
--
CREATE UNIQUE INDEX idx_business_areas_name_normalized ON public.business_areas USING btree (name_normalized);
--
-- Name: idx_business_roles_name_normalized; Type: INDEX; Schema: public; Owner: -
--
CREATE UNIQUE INDEX idx_business_roles_name_normalized ON public.business_roles USING btree (name_normalized);
--
-- Name: idx_companies_name_normalized; Type: INDEX; Schema: public; Owner: -
--
CREATE INDEX idx_companies_name_normalized ON public.companies USING btree (name_normalized);
--
-- Name: idx_company_id_person_id; Type: INDEX; Schema: public; Owner: -
--
CREATE INDEX idx_company_id_person_id ON public.employee_records USING btree (company_id, person_id);
--
-- Name: idx_countries_name_normalized; Type: INDEX; Schema: public; Owner: -
--
CREATE INDEX idx_countries_name_normalized ON public.countries USING btree (name_normalized);
--
-- Name: idx_employee_status_name_normalized; Type: INDEX; Schema: public; Owner: -
--
CREATE UNIQUE INDEX idx_employee_status_name_normalized ON public.employee_status USING btree (name_normalized);
--
-- Name: idx_people_name_normalized; Type: INDEX; Schema: public; Owner: -
--
CREATE INDEX idx_people_name_normalized ON public.people USING btree (name_normalized);
--
-- Name: idx_users_email; Type: INDEX; Schema: public; Owner: -
--
CREATE UNIQUE INDEX idx_users_email ON public.users USING btree (email);
--
-- Name: company_areas fk_area_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--
ALTER TABLE public.company_areas
    ADD CONSTRAINT fk_area_id FOREIGN KEY (area_id) REFERENCES public.business_areas(id) DEFERRABLE;
--
-- Name: company_areas fk_company_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--
ALTER TABLE public.company_areas
    ADD CONSTRAINT fk_company_id FOREIGN KEY (company_id) REFERENCES public.companies(id) DEFERRABLE;
--
-- Name: employee_records fk_company_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--
ALTER TABLE ONLY public.employee_records
    ADD CONSTRAINT fk_company_id FOREIGN KEY (company_id) REFERENCES public.companies(id) DEFERRABLE;
--
-- Name: company_reviews fk_company_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--
ALTER TABLE ONLY public.company_reviews
    ADD CONSTRAINT fk_company_id FOREIGN KEY (company_id) REFERENCES public.companies(id) DEFERRABLE;
--
-- Name: companies fk_country; Type: FK CONSTRAINT; Schema: public; Owner: -
--
ALTER TABLE ONLY public.companies
    ADD CONSTRAINT fk_country FOREIGN KEY (country) REFERENCES public.countries(code) DEFERRABLE;
--
-- Name: people fk_country; Type: FK CONSTRAINT; Schema: public; Owner: -
--
ALTER TABLE ONLY public.people
    ADD CONSTRAINT fk_country FOREIGN KEY (country) REFERENCES public.countries(code) DEFERRABLE;
--
-- Name: companies fk_created_by; Type: FK CONSTRAINT; Schema: public; Owner: -
--
ALTER TABLE ONLY public.companies
    ADD CONSTRAINT fk_created_by FOREIGN KEY (created_by) REFERENCES public.users(id) DEFERRABLE;
--
-- Name: company_areas fk_created_by; Type: FK CONSTRAINT; Schema: public; Owner: -
--
ALTER TABLE public.company_areas
    ADD CONSTRAINT fk_created_by FOREIGN KEY (created_by) REFERENCES public.users(id) DEFERRABLE;
--
-- Name: people fk_created_by; Type: FK CONSTRAINT; Schema: public; Owner: -
--
ALTER TABLE ONLY public.people
    ADD CONSTRAINT fk_created_by FOREIGN KEY (created_by) REFERENCES public.users(id) DEFERRABLE;
--
-- Name: employee_records fk_created_by; Type: FK CONSTRAINT; Schema: public; Owner: -
--
ALTER TABLE ONLY public.employee_records
    ADD CONSTRAINT fk_created_by FOREIGN KEY (created_by) REFERENCES public.users(id) DEFERRABLE;
--
-- Name: person_roles fk_created_by; Type: FK CONSTRAINT; Schema: public; Owner: -
--
ALTER TABLE ONLY public.person_roles
    ADD CONSTRAINT fk_created_by FOREIGN KEY (created_by) REFERENCES public.users(id) DEFERRABLE;
--
-- Name: company_reviews fk_created_by; Type: FK CONSTRAINT; Schema: public; Owner: -
--
ALTER TABLE ONLY public.company_reviews
    ADD CONSTRAINT fk_created_by FOREIGN KEY (created_by) REFERENCES public.users(id) DEFERRABLE;
--
-- Name: people fk_employee_status; Type: FK CONSTRAINT; Schema: public; Owner: -
--
ALTER TABLE ONLY public.people
    ADD CONSTRAINT fk_employee_status FOREIGN KEY (employee_status) REFERENCES public.employee_status(id) DEFERRABLE;
--
-- Name: companies fk_modified_by; Type: FK CONSTRAINT; Schema: public; Owner: -
--
ALTER TABLE ONLY public.companies
    ADD CONSTRAINT fk_modified_by FOREIGN KEY (modified_by) REFERENCES public.users(id) DEFERRABLE;
--
-- Name: people fk_modified_by; Type: FK CONSTRAINT; Schema: public; Owner: -
--
ALTER TABLE ONLY public.people
    ADD CONSTRAINT fk_modified_by FOREIGN KEY (modified_by) REFERENCES public.users(id) DEFERRABLE;
--
-- Name: employee_records fk_person_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--
ALTER TABLE ONLY public.employee_records
    ADD CONSTRAINT fk_person_id FOREIGN KEY (person_id) REFERENCES public.people(id) DEFERRABLE;
--
-- Name: users fk_person_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--
ALTER TABLE ONLY public.users
    ADD CONSTRAINT fk_person_id FOREIGN KEY (person_id) REFERENCES public.people(id) DEFERRABLE;
--
-- Name: person_roles fk_person_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--
ALTER TABLE ONLY public.person_roles
    ADD CONSTRAINT fk_person_id FOREIGN KEY (person_id) REFERENCES public.people(id) DEFERRABLE;
--
-- Name: company_reviews fk_person_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--
ALTER TABLE ONLY public.company_reviews
    ADD CONSTRAINT fk_person_id FOREIGN KEY (person_id) REFERENCES public.people(id) DEFERRABLE;
--
-- Name: person_roles fk_role_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--
ALTER TABLE ONLY public.person_roles
    ADD CONSTRAINT fk_role_id FOREIGN KEY (role_id) REFERENCES public.business_roles(id) DEFERRABLE;
--
-- PostgreSQL database dump complete
--
END $pdd_schema$
LANGUAGE plpgsql;
