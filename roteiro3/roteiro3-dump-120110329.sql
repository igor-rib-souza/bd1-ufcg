--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.24
-- Dumped by pg_dump version 9.5.24

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE ONLY public.venda DROP CONSTRAINT venda_id_medicamento_fkey;
ALTER TABLE ONLY public.venda DROP CONSTRAINT venda_cpf_funcionario_fkey;
ALTER TABLE ONLY public.venda DROP CONSTRAINT venda_cpf_cliente_fkey;
ALTER TABLE ONLY public.funcionario DROP CONSTRAINT funcionario_id_farmacia_fkey;
ALTER TABLE ONLY public.farmacia DROP CONSTRAINT farmacia_cpf_gerente_fkey;
ALTER TABLE ONLY public.entrega DROP CONSTRAINT entrega_id_medicamento_fkey;
ALTER TABLE ONLY public.entrega DROP CONSTRAINT entrega_id_endereco_fkey;
ALTER TABLE ONLY public.entrega DROP CONSTRAINT entrega_cpf_cliente_fkey;
ALTER TABLE ONLY public.endereco_cliente DROP CONSTRAINT endereco_cliente_cpf_cliente_fkey;
DROP TRIGGER teste ON public.venda;
DROP TRIGGER teste ON public.medicamento;
DROP TRIGGER teste ON public.funcionario;
DROP TRIGGER teste ON public.farmacia;
DROP TRIGGER teste ON public.entrega;
DROP TRIGGER teste ON public.endereco_cliente;
DROP TRIGGER teste ON public.cliente;
ALTER TABLE ONLY public.venda DROP CONSTRAINT venda_pkey;
ALTER TABLE ONLY public.medicamento DROP CONSTRAINT medicamento_pkey;
ALTER TABLE ONLY public.funcionario DROP CONSTRAINT funcionario_pkey;
ALTER TABLE ONLY public.farmacia DROP CONSTRAINT farmacia_tipo_excl;
ALTER TABLE ONLY public.farmacia DROP CONSTRAINT farmacia_pkey;
ALTER TABLE ONLY public.farmacia DROP CONSTRAINT farmacia_bairro_key;
ALTER TABLE ONLY public.entrega DROP CONSTRAINT entrega_pkey;
ALTER TABLE ONLY public.endereco_cliente DROP CONSTRAINT endereco_cliente_pkey;
ALTER TABLE ONLY public.cliente DROP CONSTRAINT cliente_pkey;
DROP TABLE public.venda;
DROP TABLE public.medicamento;
DROP TABLE public.funcionario;
DROP TABLE public.farmacia;
DROP TABLE public.entrega;
DROP TABLE public.endereco_cliente;
DROP TABLE public.cliente;
SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: cliente; Type: TABLE; Schema: public; Owner: igorrds
--

CREATE TABLE public.cliente (
    cpf character(11) NOT NULL,
    nome character varying(160) NOT NULL,
    data_nascimento date NOT NULL,
    telefone character varying(18) NOT NULL,
    email character varying(50),
    CONSTRAINT cliente_cpf_check CHECK ((length(cpf) = 11)),
    CONSTRAINT cliente_data_nascimento_check CHECK ((date_part('year'::text, age((('now'::text)::date)::timestamp with time zone, (data_nascimento)::timestamp with time zone)) >= (18)::double precision))
);


ALTER TABLE public.cliente OWNER TO igorrds;

--
-- Name: endereco_cliente; Type: TABLE; Schema: public; Owner: igorrds
--

CREATE TABLE public.endereco_cliente (
    id integer NOT NULL,
    cpf_cliente character(11) NOT NULL,
    endereco text NOT NULL,
    tipo character(10) NOT NULL,
    CONSTRAINT endereco_cliente_tipo_check CHECK ((tipo = ANY (ARRAY['residência'::bpchar, 'trabalho'::bpchar, 'outro'::bpchar])))
);


ALTER TABLE public.endereco_cliente OWNER TO igorrds;

--
-- Name: entrega; Type: TABLE; Schema: public; Owner: igorrds
--

CREATE TABLE public.entrega (
    id integer NOT NULL,
    id_medicamento integer NOT NULL,
    cpf_cliente character(11) NOT NULL,
    id_endereco integer NOT NULL,
    valor numeric,
    CONSTRAINT entrega_check CHECK (public.endereco_pertence_a_cliente(id_endereco, cpf_cliente))
);


ALTER TABLE public.entrega OWNER TO igorrds;

--
-- Name: farmacia; Type: TABLE; Schema: public; Owner: igorrds
--

CREATE TABLE public.farmacia (
    id integer NOT NULL,
    cnpj character(18) NOT NULL,
    cpf_gerente character(11),
    tipo character(1) NOT NULL,
    nome character varying(160) NOT NULL,
    bairro character varying(120) NOT NULL,
    cidade character varying(50) NOT NULL,
    estado public.estado_nordeste NOT NULL,
    telefone character varying(18) NOT NULL,
    email character varying(50),
    CONSTRAINT farmacia_cnpj_check CHECK ((length(cnpj) = 18)),
    CONSTRAINT farmacia_cpf_gerente_check CHECK ((public.get_tipo_funcionario(cpf_gerente) = ANY (ARRAY['administrador'::public.tipo_funcionario, 'farmacêutico'::public.tipo_funcionario]))),
    CONSTRAINT farmacia_tipo_check CHECK ((tipo = ANY (ARRAY['S'::bpchar, 'F'::bpchar])))
);


ALTER TABLE public.farmacia OWNER TO igorrds;

--
-- Name: funcionario; Type: TABLE; Schema: public; Owner: igorrds
--

CREATE TABLE public.funcionario (
    cpf character(11) NOT NULL,
    nome character varying(160) NOT NULL,
    data_nascimento date NOT NULL,
    endereco text NOT NULL,
    telefone character varying(18) NOT NULL,
    email character varying(50),
    tipo public.tipo_funcionario NOT NULL,
    id_farmacia integer,
    CONSTRAINT funcionario_cpf_check CHECK ((length(cpf) = 11))
);


ALTER TABLE public.funcionario OWNER TO igorrds;

--
-- Name: medicamento; Type: TABLE; Schema: public; Owner: igorrds
--

CREATE TABLE public.medicamento (
    id integer NOT NULL,
    nome character varying(160) NOT NULL,
    valor numeric NOT NULL,
    venda_exclusiva_por_receita boolean NOT NULL
);


ALTER TABLE public.medicamento OWNER TO igorrds;

--
-- Name: venda; Type: TABLE; Schema: public; Owner: igorrds
--

CREATE TABLE public.venda (
    id integer NOT NULL,
    cpf_funcionario character(11) NOT NULL,
    id_medicamento integer NOT NULL,
    cpf_cliente character(11),
    data date NOT NULL,
    CONSTRAINT venda_check CHECK (((public.get_venda_exclusiva_por_receita_medicamento(id_medicamento) = false) OR (cpf_cliente IS NOT NULL))),
    CONSTRAINT venda_cpf_funcionario_check CHECK ((public.get_tipo_funcionario(cpf_funcionario) = 'vendedor'::public.tipo_funcionario))
);


ALTER TABLE public.venda OWNER TO igorrds;

--
-- Data for Name: cliente; Type: TABLE DATA; Schema: public; Owner: igorrds
--



--
-- Data for Name: endereco_cliente; Type: TABLE DATA; Schema: public; Owner: igorrds
--



--
-- Data for Name: entrega; Type: TABLE DATA; Schema: public; Owner: igorrds
--



--
-- Data for Name: farmacia; Type: TABLE DATA; Schema: public; Owner: igorrds
--



--
-- Data for Name: funcionario; Type: TABLE DATA; Schema: public; Owner: igorrds
--



--
-- Data for Name: medicamento; Type: TABLE DATA; Schema: public; Owner: igorrds
--



--
-- Data for Name: venda; Type: TABLE DATA; Schema: public; Owner: igorrds
--



--
-- Name: cliente_pkey; Type: CONSTRAINT; Schema: public; Owner: igorrds
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_pkey PRIMARY KEY (cpf);


--
-- Name: endereco_cliente_pkey; Type: CONSTRAINT; Schema: public; Owner: igorrds
--

ALTER TABLE ONLY public.endereco_cliente
    ADD CONSTRAINT endereco_cliente_pkey PRIMARY KEY (id);


--
-- Name: entrega_pkey; Type: CONSTRAINT; Schema: public; Owner: igorrds
--

ALTER TABLE ONLY public.entrega
    ADD CONSTRAINT entrega_pkey PRIMARY KEY (id);


--
-- Name: farmacia_bairro_key; Type: CONSTRAINT; Schema: public; Owner: igorrds
--

ALTER TABLE ONLY public.farmacia
    ADD CONSTRAINT farmacia_bairro_key UNIQUE (bairro);


--
-- Name: farmacia_pkey; Type: CONSTRAINT; Schema: public; Owner: igorrds
--

ALTER TABLE ONLY public.farmacia
    ADD CONSTRAINT farmacia_pkey PRIMARY KEY (id);


--
-- Name: farmacia_tipo_excl; Type: CONSTRAINT; Schema: public; Owner: igorrds
--

ALTER TABLE ONLY public.farmacia
    ADD CONSTRAINT farmacia_tipo_excl EXCLUDE USING gist (tipo WITH =) WHERE ((tipo = 'S'::bpchar));


--
-- Name: funcionario_pkey; Type: CONSTRAINT; Schema: public; Owner: igorrds
--

ALTER TABLE ONLY public.funcionario
    ADD CONSTRAINT funcionario_pkey PRIMARY KEY (cpf);


--
-- Name: medicamento_pkey; Type: CONSTRAINT; Schema: public; Owner: igorrds
--

ALTER TABLE ONLY public.medicamento
    ADD CONSTRAINT medicamento_pkey PRIMARY KEY (id);


--
-- Name: venda_pkey; Type: CONSTRAINT; Schema: public; Owner: igorrds
--

ALTER TABLE ONLY public.venda
    ADD CONSTRAINT venda_pkey PRIMARY KEY (id);


--
-- Name: teste; Type: TRIGGER; Schema: public; Owner: igorrds
--

CREATE TRIGGER teste AFTER INSERT OR DELETE OR UPDATE ON public.cliente FOR EACH ROW EXECUTE PROCEDURE public.cliente();


--
-- Name: teste; Type: TRIGGER; Schema: public; Owner: igorrds
--

CREATE TRIGGER teste AFTER INSERT OR DELETE OR UPDATE ON public.endereco_cliente FOR EACH ROW EXECUTE PROCEDURE public.endereco_cliente();


--
-- Name: teste; Type: TRIGGER; Schema: public; Owner: igorrds
--

CREATE TRIGGER teste AFTER INSERT OR DELETE OR UPDATE ON public.entrega FOR EACH ROW EXECUTE PROCEDURE public.entrega();


--
-- Name: teste; Type: TRIGGER; Schema: public; Owner: igorrds
--

CREATE TRIGGER teste AFTER INSERT OR DELETE OR UPDATE ON public.farmacia FOR EACH ROW EXECUTE PROCEDURE public.farmacia();


--
-- Name: teste; Type: TRIGGER; Schema: public; Owner: igorrds
--

CREATE TRIGGER teste AFTER INSERT OR DELETE OR UPDATE ON public.funcionario FOR EACH ROW EXECUTE PROCEDURE public.funcionario();


--
-- Name: teste; Type: TRIGGER; Schema: public; Owner: igorrds
--

CREATE TRIGGER teste AFTER INSERT OR DELETE OR UPDATE ON public.medicamento FOR EACH ROW EXECUTE PROCEDURE public.medicamento();


--
-- Name: teste; Type: TRIGGER; Schema: public; Owner: igorrds
--

CREATE TRIGGER teste AFTER INSERT OR DELETE OR UPDATE ON public.venda FOR EACH ROW EXECUTE PROCEDURE public.venda();


--
-- Name: endereco_cliente_cpf_cliente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: igorrds
--

ALTER TABLE ONLY public.endereco_cliente
    ADD CONSTRAINT endereco_cliente_cpf_cliente_fkey FOREIGN KEY (cpf_cliente) REFERENCES public.cliente(cpf);


--
-- Name: entrega_cpf_cliente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: igorrds
--

ALTER TABLE ONLY public.entrega
    ADD CONSTRAINT entrega_cpf_cliente_fkey FOREIGN KEY (cpf_cliente) REFERENCES public.cliente(cpf);


--
-- Name: entrega_id_endereco_fkey; Type: FK CONSTRAINT; Schema: public; Owner: igorrds
--

ALTER TABLE ONLY public.entrega
    ADD CONSTRAINT entrega_id_endereco_fkey FOREIGN KEY (id_endereco) REFERENCES public.endereco_cliente(id);


--
-- Name: entrega_id_medicamento_fkey; Type: FK CONSTRAINT; Schema: public; Owner: igorrds
--

ALTER TABLE ONLY public.entrega
    ADD CONSTRAINT entrega_id_medicamento_fkey FOREIGN KEY (id_medicamento) REFERENCES public.medicamento(id);


--
-- Name: farmacia_cpf_gerente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: igorrds
--

ALTER TABLE ONLY public.farmacia
    ADD CONSTRAINT farmacia_cpf_gerente_fkey FOREIGN KEY (cpf_gerente) REFERENCES public.funcionario(cpf);


--
-- Name: funcionario_id_farmacia_fkey; Type: FK CONSTRAINT; Schema: public; Owner: igorrds
--

ALTER TABLE ONLY public.funcionario
    ADD CONSTRAINT funcionario_id_farmacia_fkey FOREIGN KEY (id_farmacia) REFERENCES public.farmacia(id);


--
-- Name: venda_cpf_cliente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: igorrds
--

ALTER TABLE ONLY public.venda
    ADD CONSTRAINT venda_cpf_cliente_fkey FOREIGN KEY (cpf_cliente) REFERENCES public.cliente(cpf);


--
-- Name: venda_cpf_funcionario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: igorrds
--

ALTER TABLE ONLY public.venda
    ADD CONSTRAINT venda_cpf_funcionario_fkey FOREIGN KEY (cpf_funcionario) REFERENCES public.funcionario(cpf);


--
-- Name: venda_id_medicamento_fkey; Type: FK CONSTRAINT; Schema: public; Owner: igorrds
--

ALTER TABLE ONLY public.venda
    ADD CONSTRAINT venda_id_medicamento_fkey FOREIGN KEY (id_medicamento) REFERENCES public.medicamento(id);


--
-- PostgreSQL database dump complete
--

