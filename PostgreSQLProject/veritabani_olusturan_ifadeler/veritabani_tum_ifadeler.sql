--
-- PostgreSQL database dump
--

-- Dumped from database version 11.8
-- Dumped by pg_dump version 12rc1

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
-- Name: project; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE project WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'Turkish_Turkey.1254' LC_CTYPE = 'Turkish_Turkey.1254';


ALTER DATABASE project OWNER TO postgres;

\connect project

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
-- Name: bursekle(integer, character varying, character varying, character varying, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.bursekle(tutar integer, verilmetarihi character varying, baslangictarihi character varying, bitistarihi character varying, bursiyer integer) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
declare
BEGIN
INSERT into burs(tutar,"verilmeTarihi","baslangicTarihi","bitisTarihi",bursiyer) values (tutar,verilmeTarihi,baslangicTarihi,bitisTarihi,bursiyer);

return 'başarıyla eklendi';
end;
$$;


ALTER FUNCTION public.bursekle(tutar integer, verilmetarihi character varying, baslangictarihi character varying, bitistarihi character varying, bursiyer integer) OWNER TO postgres;

--
-- Name: bursguncelle(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.bursguncelle() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
if NEW.tutar<>OLD.tutar then
insert into bursguncelle VALUES (old."bursId",old."verilmeTarihi",old."baslangicTarihi",old.tutar,new.tutar);
end if;
return new;
end;
$$;


ALTER FUNCTION public.bursguncelle() OWNER TO postgres;

--
-- Name: bursiyersayisi(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.bursiyersayisi() RETURNS integer
    LANGUAGE plpgsql
    AS $$
declare 
toplam integer;
begin
select count(*) into toplam from bursiyerler;
return toplam;
end;
$$;


ALTER FUNCTION public.bursiyersayisi() OWNER TO postgres;

--
-- Name: burssayisi(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.burssayisi() RETURNS integer
    LANGUAGE plpgsql
    AS $$
declare 
toplam integer;
begin
select count(*) into toplam from burs;
return toplam;
end;
$$;


ALTER FUNCTION public.burssayisi() OWNER TO postgres;

--
-- Name: burstoplam(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.burstoplam() RETURNS integer
    LANGUAGE plpgsql
    AS $$
declare 
toplam integer;
begin
toplam = (select SUM(burs.tutar) from burs);
return toplam;
end;
$$;


ALTER FUNCTION public.burstoplam() OWNER TO postgres;

--
-- Name: demirbasguncelle(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.demirbasguncelle() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
if NEW.tur<>OLD.tur then
insert into demirbasguncelle VALUES (old."demirbasId",old.tur,new.tur);
end if;
return new;
end;
$$;


ALTER FUNCTION public.demirbasguncelle() OWNER TO postgres;

--
-- Name: kullaniciguncelle(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.kullaniciguncelle() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
if NEW.mail<>OLD.mail then
insert into guncellenen VALUES (old."bursiyerId",old.ad,old.soyad,old.mail,new.mail);
end if;
return new;
end;
$$;


ALTER FUNCTION public.kullaniciguncelle() OWNER TO postgres;

--
-- Name: kullanicisay(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.kullanicisay() RETURNS integer
    LANGUAGE plpgsql
    AS $$
declare 
toplam integer;
begin
select count(*) into toplam from kullanici;
return toplam;
end;
$$;


ALTER FUNCTION public.kullanicisay() OWNER TO postgres;

--
-- Name: kurucuguncelle(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.kurucuguncelle() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
if NEW."vakifGorevi"<>OLD."vakifGorevi" then
insert into guncelkurucu VALUES (old."kurucuId",old.adi,old.soyadi,old."vakifGorevi",new."vakifGorevi");
end if;
return new;
end;
$$;


ALTER FUNCTION public.kurucuguncelle() OWNER TO postgres;

--
-- Name: aidat_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.aidat_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 99999999
    CACHE 1;


ALTER TABLE public.aidat_seq OWNER TO postgres;

SET default_tablespace = '';

--
-- Name: aidat; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.aidat (
    "aidatId" integer DEFAULT nextval('public.aidat_seq'::regclass) NOT NULL,
    tutar integer NOT NULL,
    "sonTarih" character varying(30) NOT NULL,
    "odenmeTarihi" character varying(30) NOT NULL,
    "odendiMi" character varying(30) NOT NULL,
    uye integer NOT NULL
);


ALTER TABLE public.aidat OWNER TO postgres;

--
-- Name: banka_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.banka_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 99999999
    CACHE 1;


ALTER TABLE public.banka_seq OWNER TO postgres;

--
-- Name: banka; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.banka (
    "bankaId" integer DEFAULT nextval('public.banka_seq'::regclass) NOT NULL,
    "hesapNo" character varying(50) NOT NULL,
    islem character varying(50) NOT NULL,
    ad character varying(50) NOT NULL,
    bakiye integer NOT NULL
);


ALTER TABLE public.banka OWNER TO postgres;

--
-- Name: burs_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.burs_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 99999999
    CACHE 1;


ALTER TABLE public.burs_seq OWNER TO postgres;

--
-- Name: burs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.burs (
    "bursId" integer DEFAULT nextval('public.burs_seq'::regclass) NOT NULL,
    tutar integer NOT NULL,
    "verilmeTarihi" character varying(30) NOT NULL,
    "baslangicTarihi" character varying(30) NOT NULL,
    "bitisTarihi" character varying(30) NOT NULL,
    bursiyer integer NOT NULL
);


ALTER TABLE public.burs OWNER TO postgres;

--
-- Name: bursguncelle; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bursguncelle (
    id integer NOT NULL,
    "verilmeTarihi" character varying(30) NOT NULL,
    "baslangicTarihi" character varying(30) NOT NULL,
    "eskiTutar" integer NOT NULL,
    "yeniTutar" integer NOT NULL
);


ALTER TABLE public.bursguncelle OWNER TO postgres;

--
-- Name: bursiyer_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bursiyer_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 99999999
    CACHE 1;


ALTER TABLE public.bursiyer_seq OWNER TO postgres;

--
-- Name: bursiyerler; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bursiyerler (
    "bursiyerId" integer DEFAULT nextval('public.bursiyer_seq'::regclass) NOT NULL,
    "bursiyerNo" integer NOT NULL,
    ad character varying(30) NOT NULL,
    soyad character varying(30) NOT NULL,
    okul character varying(30) NOT NULL,
    bolum character varying(30) NOT NULL,
    telefon character varying(30) NOT NULL,
    mail character varying(30) NOT NULL,
    "babaAdi" character varying(30) NOT NULL,
    referans character varying(30) NOT NULL,
    iban character varying(30) NOT NULL,
    koy character varying(30) NOT NULL,
    il integer NOT NULL,
    ilce integer NOT NULL
);


ALTER TABLE public.bursiyerler OWNER TO postgres;

--
-- Name: demirbas_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.demirbas_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 99999999
    CACHE 1;


ALTER TABLE public.demirbas_seq OWNER TO postgres;

--
-- Name: demirbas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.demirbas (
    "demirbasId" integer DEFAULT nextval('public.demirbas_seq'::regclass) NOT NULL,
    tur character varying(30) NOT NULL,
    kod character varying(30) NOT NULL,
    adet integer NOT NULL,
    dernek integer NOT NULL
);


ALTER TABLE public.demirbas OWNER TO postgres;

--
-- Name: demirbasguncelle; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.demirbasguncelle (
    id integer NOT NULL,
    "eskiTur" character varying(30) NOT NULL,
    "yeniTur" character varying(30) NOT NULL
);


ALTER TABLE public.demirbasguncelle OWNER TO postgres;

--
-- Name: dernek_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dernek_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 99999999
    CACHE 1;


ALTER TABLE public.dernek_seq OWNER TO postgres;

--
-- Name: dernek; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dernek (
    "dernekId" integer DEFAULT nextval('public.dernek_seq'::regclass) NOT NULL,
    adres character varying(100) NOT NULL,
    telefon character varying(30) NOT NULL,
    mail character varying(30) NOT NULL,
    il integer NOT NULL,
    ilce integer NOT NULL
);


ALTER TABLE public.dernek OWNER TO postgres;

--
-- Name: gelir_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.gelir_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 99999999
    CACHE 1;


ALTER TABLE public.gelir_seq OWNER TO postgres;

--
-- Name: gelir; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.gelir (
    "gelirId" integer DEFAULT nextval('public.gelir_seq'::regclass) NOT NULL,
    kurum character varying(50),
    kisi character varying(30) NOT NULL,
    tutar integer NOT NULL,
    tarih character varying(30) NOT NULL,
    tur integer
);


ALTER TABLE public.gelir OWNER TO postgres;

--
-- Name: gider_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.gider_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 99999999
    CACHE 1;


ALTER TABLE public.gider_seq OWNER TO postgres;

--
-- Name: gider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.gider (
    "giderId" integer DEFAULT nextval('public.gider_seq'::regclass) NOT NULL,
    kurum character varying(50),
    kisi character varying(30) NOT NULL,
    tutar integer NOT NULL,
    tarih character varying(30) NOT NULL,
    tur integer NOT NULL
);


ALTER TABLE public.gider OWNER TO postgres;

--
-- Name: guncelkurucu; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.guncelkurucu (
    id integer NOT NULL,
    adi character varying(30) NOT NULL,
    soyadi character varying(30) NOT NULL,
    "eskiGorevi" character varying(30) NOT NULL,
    "yeniGorevi" character varying(30) NOT NULL
);


ALTER TABLE public.guncelkurucu OWNER TO postgres;

--
-- Name: guncellenen; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.guncellenen (
    id integer NOT NULL,
    ad character varying(30) NOT NULL,
    soyad character varying(30) NOT NULL,
    "eskiMail" character varying(50) NOT NULL,
    "yeniMail" character varying(50) NOT NULL
);


ALTER TABLE public.guncellenen OWNER TO postgres;

--
-- Name: il_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.il_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 99999999
    CACHE 1;


ALTER TABLE public.il_seq OWNER TO postgres;

--
-- Name: il; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.il (
    "ilId" integer DEFAULT nextval('public.il_seq'::regclass) NOT NULL,
    isim character varying NOT NULL
);


ALTER TABLE public.il OWNER TO postgres;

--
-- Name: ilce_auto; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ilce_auto
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 99999999
    CACHE 1;


ALTER TABLE public.ilce_auto OWNER TO postgres;

--
-- Name: ilce; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ilce (
    "ilceId" integer DEFAULT nextval('public.ilce_auto'::regclass) NOT NULL,
    isim character varying NOT NULL,
    il integer NOT NULL
);


ALTER TABLE public.ilce OWNER TO postgres;

--
-- Name: kasa_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.kasa_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 99999999
    CACHE 1;


ALTER TABLE public.kasa_seq OWNER TO postgres;

--
-- Name: kasa; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.kasa (
    "kasaId" integer DEFAULT nextval('public.kasa_seq'::regclass) NOT NULL,
    "gelirToplam" integer NOT NULL,
    "giderToplam" integer NOT NULL,
    kar integer NOT NULL,
    "toplamPara" integer NOT NULL
);


ALTER TABLE public.kasa OWNER TO postgres;

--
-- Name: kullanici_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.kullanici_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 99999999
    CACHE 1;


ALTER TABLE public.kullanici_seq OWNER TO postgres;

--
-- Name: kullanici; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.kullanici (
    "kullaniciId" integer DEFAULT nextval('public.kullanici_seq'::regclass) NOT NULL,
    ad character varying(30) NOT NULL,
    soyad character varying(30) NOT NULL,
    "kullaniciAdi" character varying(30) NOT NULL,
    sifre character varying(30) NOT NULL,
    il integer DEFAULT 1 NOT NULL,
    ilce integer DEFAULT 1 NOT NULL
);


ALTER TABLE public.kullanici OWNER TO postgres;

--
-- Name: kurum_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.kurum_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 99999999
    CACHE 1;


ALTER TABLE public.kurum_seq OWNER TO postgres;

--
-- Name: kurucu; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.kurucu (
    "kurucuId" integer DEFAULT nextval('public.kurum_seq'::regclass) NOT NULL,
    adi character varying(30) NOT NULL,
    soyadi character varying(30) NOT NULL,
    telefon character varying(30) NOT NULL,
    mail character varying(30) NOT NULL,
    "calismaYeri" character varying(30) NOT NULL,
    meslek character varying(30) NOT NULL,
    "vakifGorevi" character varying(30) NOT NULL,
    il integer NOT NULL,
    ilce integer NOT NULL
);


ALTER TABLE public.kurucu OWNER TO postgres;

--
-- Name: kurul_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.kurul_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 99999999
    CACHE 1;


ALTER TABLE public.kurul_seq OWNER TO postgres;

--
-- Name: kurul; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.kurul (
    "kurulId" integer DEFAULT nextval('public.kurul_seq'::regclass) NOT NULL,
    adi character varying(30) NOT NULL,
    soyadi character varying(30) NOT NULL,
    telefon character varying(30) NOT NULL,
    gorev character varying(30) NOT NULL,
    "calismaYeri" character varying(30) NOT NULL,
    meslek character varying(30) NOT NULL,
    mail character varying(30) NOT NULL,
    il integer NOT NULL,
    ilce integer NOT NULL
);


ALTER TABLE public.kurul OWNER TO postgres;

--
-- Name: mezun_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.mezun_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 99999999
    CACHE 1;


ALTER TABLE public.mezun_seq OWNER TO postgres;

--
-- Name: mezun; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mezun (
    "mezunId" integer DEFAULT nextval('public.mezun_seq'::regclass) NOT NULL,
    ad character varying(30) NOT NULL,
    soyad character varying(30) NOT NULL,
    tarih character varying(30) NOT NULL,
    meslek character varying(30) NOT NULL,
    koy character varying(30) NOT NULL,
    okul character varying(30) NOT NULL,
    telefon character varying(30) NOT NULL,
    mail character varying(30) NOT NULL,
    il integer NOT NULL,
    ilce integer NOT NULL
);


ALTER TABLE public.mezun OWNER TO postgres;

--
-- Name: tur_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tur_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 99999999
    CACHE 1;


ALTER TABLE public.tur_seq OWNER TO postgres;

--
-- Name: tur; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tur (
    "turId" integer DEFAULT nextval('public.tur_seq'::regclass) NOT NULL,
    isim character varying(30) NOT NULL
);


ALTER TABLE public.tur OWNER TO postgres;

--
-- Name: uye_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.uye_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 99999999
    CACHE 1;


ALTER TABLE public.uye_seq OWNER TO postgres;

--
-- Name: uyeler; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.uyeler (
    "uyeId" integer DEFAULT nextval('public.uye_seq'::regclass) NOT NULL,
    ad character varying(30) NOT NULL,
    soyadi character varying(30) NOT NULL,
    telefon character varying(30) NOT NULL,
    mail character varying(30) NOT NULL,
    firma character varying(30) NOT NULL,
    "uyeNo" character varying(30) NOT NULL,
    "toplamAidat" integer NOT NULL,
    meslek character varying(30) NOT NULL,
    iban character varying(30) NOT NULL,
    il integer NOT NULL,
    ilce integer NOT NULL
);


ALTER TABLE public.uyeler OWNER TO postgres;

--
-- Name: yetkili_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.yetkili_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 99999999
    CACHE 1;


ALTER TABLE public.yetkili_seq OWNER TO postgres;

--
-- Name: yetkili; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.yetkili (
    "yetkiliId" integer DEFAULT nextval('public.yetkili_seq'::regclass) NOT NULL,
    ad character varying(30) NOT NULL,
    soyad character varying(30) NOT NULL,
    telefon character varying(30) NOT NULL,
    mail character varying(30) NOT NULL,
    dernek integer NOT NULL
);


ALTER TABLE public.yetkili OWNER TO postgres;

--
-- Data for Name: aidat; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: banka; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: burs; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.burs VALUES
	(1, 500, '24/07/2018', '30/05/2018', '24/10/2020', 1),
	(3, 600, '24/07/2018', '30/06/2018', '30/07/2019', 1),
	(4, 850, '30/06/2017', '30/05/2017', '30/05/2018', 1);


--
-- Data for Name: bursguncelle; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.bursguncelle VALUES
	(2, '24/07/2018', '30/05/2018', 3, 400);


--
-- Data for Name: bursiyerler; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.bursiyerler VALUES
	(1, 123, 'Emre', 'Usta', 'FSMVÜ', 'Bilgisayar Mühendisliği', '05414919734', 'emre.usta@stu.fsm.edu.tr', 'Şaban', 'Kendisi', 'TR12154615541', 'Çatalca', 1, 2),
	(4, 2134234, 'Arda', 'Usta', 'Yavuz Selim', 'Orta okul', '05331905638', 'ardaustaa34@gmail.com', 'Şaban', 'Kendisi', 'TR124554', 'Aydinlar', 1, 2),
	(6, 1213, 'Arda', 'Usta', 'Yavuz Selim', 'Orta okul', '05331905638', 'ardaustaa34@gmail.com', 'Şaban', 'Kendisi', 'TR124554', 'Aydinlar', 1, 2),
	(2, 1234, 'Arda', 'Usta', 'Yavuz Selim', 'Orta okul', '05331905638', 'ardausta08@gmail.com', 'Şaban', 'Kendisi', 'TR124554', 'Aydinlar', 1, 2),
	(3, 213123, 'Arda', 'Usta', 'Yavuz Selim', 'Orta okul', '05331905638', 'emreustaa34@gmail.com', 'Şaban', 'Kendisi', 'TR124554', 'Aydinlar', 1, 2),
	(5, 213213, 'Arda', 'Usta', 'Yavuz Selim', 'Orta okul', '05331905638', 'emreustaa34@gmail.com', 'Şaban', 'Kendisi', 'TR124554', 'Aydinlar', 1, 2);


--
-- Data for Name: demirbas; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.demirbas VALUES
	(2, 'sandalye', '2', 50, 1),
	(3, 'kasa', '4', 50, 1),
	(1, 'kalem', '1', 50, 1);


--
-- Data for Name: demirbasguncelle; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.demirbasguncelle VALUES
	(1, 'masa', 'kalem');


--
-- Data for Name: dernek; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.dernek VALUES
	(1, 'İstanbul', '0212123456', 'info@dernek.com', 1, 1),
	(2, 'İstanbul', '0212123456', 'info@dernek.com', 1, 1),
	(3, 'İstanbul', '0212123456', 'info@dernek.com', 1, 1),
	(4, 'İstanbul', '0212123456', 'info@dernek.com', 1, 2),
	(5, 'İstanbul', '0212123456', 'info@dernek.com', 1, 2);


--
-- Data for Name: gelir; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: gider; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: guncelkurucu; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.guncelkurucu VALUES
	(2, 'Emre', 'Usta', 'Kurucu', 'Yönetici');


--
-- Data for Name: guncellenen; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.guncellenen VALUES
	(1, 'Emre', 'Usta', 'emreustaa34@gmail.com', 'emre.usta@stu.fsm.edu.tr'),
	(2, 'Arda', 'Usta', 'ardaustaa34@gmail.com', 'ardausta08@gmail.com'),
	(3, 'Arda', 'Usta', 'ardaustaa34@gmail.com', 'emreustaa34@gmail.com'),
	(5, 'Arda', 'Usta', 'ardaustaa34@gmail.com', 'emreustaa34@gmail.com');


--
-- Data for Name: il; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.il VALUES
	(1, 'İstanbul'),
	(2, 'Ankara'),
	(3, 'Malatya'),
	(5, 'Antalya'),
	(6, 'Osmaniye'),
	(4, 'Sivas');


--
-- Data for Name: ilce; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.ilce VALUES
	(2, 'Fatih', 1),
	(3, 'Etimesgut', 2);


--
-- Data for Name: kasa; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: kullanici; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.kullanici VALUES
	(2, 'Emre', 'USTA', 'emreustaa', 'eeee', 1, 2),
	(4, 'asdasd', 'asdasdas', 'sadasds', 'sadas', 1, 2),
	(9, 'dsfsdf', 'fdssdf', 'dsfdfs', 'dsfsd', 1, 2),
	(12, 'Emre', 'Usta', 'emreusta98', 'emreustaa1998', 1, 2);


--
-- Data for Name: kurucu; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.kurucu VALUES
	(1, 'Emre', 'Usta', '05414919734', 'emreustaa34@gmail.com', 'FSMVÜ', 'Öğrenci', 'Kurucu', 1, 2),
	(2, 'Emre', 'Usta', '05414919734', 'emreustaa34@gmail.com', 'FSMVÜ', 'Öğrenci', 'Yönetici', 1, 2);


--
-- Data for Name: kurul; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.kurul VALUES
	(1, 'Arda', 'Usta', '05331905638', 'Üye', 'Yavuz Selim', 'Öğrenci', 'ardaustaa34@gmail.com', 1, 2);


--
-- Data for Name: mezun; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: tur; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: uyeler; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.uyeler VALUES
	(1, 'Emre', 'Usta', '0541491734', 'emreustaa34@gmail.com', 'Inovatif Arge', '1234', 50, 'Öğrenci', 'TR750335641645423', 1, 2);


--
-- Data for Name: yetkili; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Name: aidat_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.aidat_seq', 1, false);


--
-- Name: banka_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.banka_seq', 1, false);


--
-- Name: burs_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.burs_seq', 4, true);


--
-- Name: bursiyer_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.bursiyer_seq', 6, true);


--
-- Name: demirbas_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.demirbas_seq', 4, true);


--
-- Name: dernek_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dernek_seq', 5, true);


--
-- Name: gelir_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.gelir_seq', 1, false);


--
-- Name: gider_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.gider_seq', 1, false);


--
-- Name: il_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.il_seq', 5, true);


--
-- Name: ilce_auto; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ilce_auto', 1, true);


--
-- Name: kasa_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.kasa_seq', 1, false);


--
-- Name: kullanici_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.kullanici_seq', 12, true);


--
-- Name: kurul_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.kurul_seq', 1, true);


--
-- Name: kurum_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.kurum_seq', 3, true);


--
-- Name: mezun_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.mezun_seq', 1, false);


--
-- Name: tur_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tur_seq', 1, false);


--
-- Name: uye_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.uye_seq', 1, true);


--
-- Name: yetkili_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.yetkili_seq', 1, false);


--
-- Name: aidat aidat_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aidat
    ADD CONSTRAINT aidat_pkey PRIMARY KEY ("aidatId");


--
-- Name: banka banka_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.banka
    ADD CONSTRAINT banka_pkey PRIMARY KEY ("bankaId");


--
-- Name: burs burs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.burs
    ADD CONSTRAINT burs_pkey PRIMARY KEY ("bursId");


--
-- Name: bursguncelle bursguncelle_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bursguncelle
    ADD CONSTRAINT bursguncelle_pkey PRIMARY KEY (id);


--
-- Name: bursiyerler bursiyerler_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bursiyerler
    ADD CONSTRAINT bursiyerler_pkey PRIMARY KEY ("bursiyerId");


--
-- Name: demirbas demirbas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.demirbas
    ADD CONSTRAINT demirbas_pkey PRIMARY KEY ("demirbasId");


--
-- Name: demirbasguncelle demirbasguncelle_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.demirbasguncelle
    ADD CONSTRAINT demirbasguncelle_pkey PRIMARY KEY (id);


--
-- Name: dernek dernek_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dernek
    ADD CONSTRAINT dernek_pkey PRIMARY KEY ("dernekId");


--
-- Name: gelir gelir_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gelir
    ADD CONSTRAINT gelir_pkey PRIMARY KEY ("gelirId", kisi);


--
-- Name: gider gider_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gider
    ADD CONSTRAINT gider_pkey PRIMARY KEY ("giderId");


--
-- Name: guncelkurucu guncelkurucu_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.guncelkurucu
    ADD CONSTRAINT guncelkurucu_pkey PRIMARY KEY (id);


--
-- Name: guncellenen guncellenen_bursiyer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.guncellenen
    ADD CONSTRAINT guncellenen_bursiyer_pkey PRIMARY KEY (id);


--
-- Name: il il_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.il
    ADD CONSTRAINT il_pkey PRIMARY KEY ("ilId");


--
-- Name: ilce ilce_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ilce
    ADD CONSTRAINT ilce_pkey PRIMARY KEY ("ilceId");


--
-- Name: kasa kasa_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kasa
    ADD CONSTRAINT kasa_pkey PRIMARY KEY ("kasaId");


--
-- Name: kullanici kullanici_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kullanici
    ADD CONSTRAINT kullanici_pkey PRIMARY KEY ("kullaniciId");


--
-- Name: kurucu kurucu_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kurucu
    ADD CONSTRAINT kurucu_pkey PRIMARY KEY ("kurucuId");


--
-- Name: kurul kurul_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kurul
    ADD CONSTRAINT kurul_pkey PRIMARY KEY ("kurulId");


--
-- Name: mezun mezun_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mezun
    ADD CONSTRAINT mezun_pkey PRIMARY KEY ("mezunId");


--
-- Name: tur tur_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tur
    ADD CONSTRAINT tur_pkey PRIMARY KEY ("turId");


--
-- Name: uyeler uyeler_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.uyeler
    ADD CONSTRAINT uyeler_pkey PRIMARY KEY ("uyeId");


--
-- Name: yetkili yetkili_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.yetkili
    ADD CONSTRAINT yetkili_pkey PRIMARY KEY ("yetkiliId");


--
-- Name: fki_aidat_uye_foreign; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_aidat_uye_foreign ON public.aidat USING btree (uye);


--
-- Name: fki_burs_bursiyer_foreign; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_burs_bursiyer_foreign ON public.burs USING btree (bursiyer);


--
-- Name: fki_bursiyer_il_foreign; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_bursiyer_il_foreign ON public.bursiyerler USING btree (il);


--
-- Name: fki_bursiyer_ilce_foreign; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_bursiyer_ilce_foreign ON public.bursiyerler USING btree (ilce);


--
-- Name: fki_demirbas_dernek_foreign; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_demirbas_dernek_foreign ON public.demirbas USING btree (dernek);


--
-- Name: fki_gelir_tur_foreign; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_gelir_tur_foreign ON public.gelir USING btree (tur);


--
-- Name: fki_gider_tur_seq; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_gider_tur_seq ON public.gider USING btree (tur);


--
-- Name: fki_ilce_il_foreign; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_ilce_il_foreign ON public.ilce USING btree (il);


--
-- Name: fki_kullanici_il_foreign; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_kullanici_il_foreign ON public.kullanici USING btree (il);


--
-- Name: fki_kullanici_ilce_foreign; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_kullanici_ilce_foreign ON public.kullanici USING btree (ilce);


--
-- Name: fki_kurucu_il_foreign; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_kurucu_il_foreign ON public.kurucu USING btree (il);


--
-- Name: fki_kurucu_ilce_foreign; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_kurucu_ilce_foreign ON public.kurucu USING btree (ilce);


--
-- Name: fki_kurul_il_foreign; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_kurul_il_foreign ON public.kurul USING btree (il);


--
-- Name: fki_kurul_ilce_foreign; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_kurul_ilce_foreign ON public.kurul USING btree (ilce);


--
-- Name: fki_mezun_il_foreign; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_mezun_il_foreign ON public.mezun USING btree (il);


--
-- Name: fki_mezun_ilce_foreign; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_mezun_ilce_foreign ON public.mezun USING btree (ilce);


--
-- Name: fki_uye_il_foreign; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_uye_il_foreign ON public.uyeler USING btree (il);


--
-- Name: fki_uye_ilce_foreign; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_uye_ilce_foreign ON public.uyeler USING btree (ilce);


--
-- Name: fki_yetkili_dernek_foreign; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_yetkili_dernek_foreign ON public.yetkili USING btree (dernek);


--
-- Name: bursiyerler kullanicitrigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER kullanicitrigger BEFORE UPDATE ON public.bursiyerler FOR EACH ROW EXECUTE PROCEDURE public.kullaniciguncelle();


--
-- Name: burs logburs; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER logburs BEFORE UPDATE ON public.burs FOR EACH ROW EXECUTE PROCEDURE public.bursguncelle();


--
-- Name: demirbas logdemirbas; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER logdemirbas BEFORE UPDATE ON public.demirbas FOR EACH ROW EXECUTE PROCEDURE public.demirbasguncelle();


--
-- Name: kurucu logkurucu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER logkurucu BEFORE UPDATE ON public.kurucu FOR EACH ROW EXECUTE PROCEDURE public.kurucuguncelle();


--
-- Name: aidat aidat_uye_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aidat
    ADD CONSTRAINT aidat_uye_foreign FOREIGN KEY (uye) REFERENCES public.uyeler("uyeId") NOT VALID;


--
-- Name: burs burs_bursiyer_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.burs
    ADD CONSTRAINT burs_bursiyer_foreign FOREIGN KEY (bursiyer) REFERENCES public.bursiyerler("bursiyerId") NOT VALID;


--
-- Name: bursiyerler bursiyer_il_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bursiyerler
    ADD CONSTRAINT bursiyer_il_foreign FOREIGN KEY (il) REFERENCES public.il("ilId") NOT VALID;


--
-- Name: bursiyerler bursiyer_ilce_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bursiyerler
    ADD CONSTRAINT bursiyer_ilce_foreign FOREIGN KEY (ilce) REFERENCES public.ilce("ilceId") NOT VALID;


--
-- Name: demirbas demirbas_dernek_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.demirbas
    ADD CONSTRAINT demirbas_dernek_foreign FOREIGN KEY (dernek) REFERENCES public.dernek("dernekId") NOT VALID;


--
-- Name: gelir gelir_tur_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gelir
    ADD CONSTRAINT gelir_tur_foreign FOREIGN KEY (tur) REFERENCES public.tur("turId") NOT VALID;


--
-- Name: gider gider_tur_seq; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gider
    ADD CONSTRAINT gider_tur_seq FOREIGN KEY (tur) REFERENCES public.tur("turId") NOT VALID;


--
-- Name: ilce ilce_il_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ilce
    ADD CONSTRAINT ilce_il_foreign FOREIGN KEY (il) REFERENCES public.il("ilId") NOT VALID;


--
-- Name: kullanici kullanici_il_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kullanici
    ADD CONSTRAINT kullanici_il_foreign FOREIGN KEY (il) REFERENCES public.il("ilId") NOT VALID;


--
-- Name: kullanici kullanici_ilce_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kullanici
    ADD CONSTRAINT kullanici_ilce_foreign FOREIGN KEY (ilce) REFERENCES public.ilce("ilceId") NOT VALID;


--
-- Name: kurucu kurucu_il_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kurucu
    ADD CONSTRAINT kurucu_il_foreign FOREIGN KEY (il) REFERENCES public.il("ilId") NOT VALID;


--
-- Name: kurucu kurucu_ilce_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kurucu
    ADD CONSTRAINT kurucu_ilce_foreign FOREIGN KEY (ilce) REFERENCES public.ilce("ilceId") NOT VALID;


--
-- Name: kurul kurul_il_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kurul
    ADD CONSTRAINT kurul_il_foreign FOREIGN KEY (il) REFERENCES public.il("ilId") NOT VALID;


--
-- Name: kurul kurul_ilce_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kurul
    ADD CONSTRAINT kurul_ilce_foreign FOREIGN KEY (ilce) REFERENCES public.ilce("ilceId") NOT VALID;


--
-- Name: mezun mezun_il_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mezun
    ADD CONSTRAINT mezun_il_foreign FOREIGN KEY (il) REFERENCES public.il("ilId") NOT VALID;


--
-- Name: mezun mezun_ilce_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mezun
    ADD CONSTRAINT mezun_ilce_foreign FOREIGN KEY (ilce) REFERENCES public.ilce("ilceId") NOT VALID;


--
-- Name: uyeler uye_il_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.uyeler
    ADD CONSTRAINT uye_il_foreign FOREIGN KEY (il) REFERENCES public.il("ilId") NOT VALID;


--
-- Name: uyeler uye_ilce_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.uyeler
    ADD CONSTRAINT uye_ilce_foreign FOREIGN KEY (ilce) REFERENCES public.ilce("ilceId") NOT VALID;


--
-- Name: yetkili yetkili_dernek_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.yetkili
    ADD CONSTRAINT yetkili_dernek_foreign FOREIGN KEY (dernek) REFERENCES public.dernek("dernekId") NOT VALID;


--
-- PostgreSQL database dump complete
--

