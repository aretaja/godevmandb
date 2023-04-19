--
-- PostgreSQL database dump
--

-- Dumped from database version 13.9 (Debian 13.9-0+deb11u1)
-- Dumped by pg_dump version 13.9 (Debian 13.9-0+deb11u1)

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
-- Name: snmp_auth_proto; Type: TYPE; Schema: public; Owner: godevman
--

CREATE TYPE public.snmp_auth_proto AS ENUM (
    'NoAuth',
    'MD5',
    'SHA'
);


ALTER TYPE public.snmp_auth_proto OWNER TO godevman;

--
-- Name: snmp_priv_proto; Type: TYPE; Schema: public; Owner: godevman
--

CREATE TYPE public.snmp_priv_proto AS ENUM (
    'NoPriv',
    'DES',
    'AES',
    'AES192',
    'AES192C',
    'AES256',
    'AES256C'
);


ALTER TYPE public.snmp_priv_proto OWNER TO godevman;

--
-- Name: snmp_sec_level; Type: TYPE; Schema: public; Owner: godevman
--

CREATE TYPE public.snmp_sec_level AS ENUM (
    'noAuthNoPriv',
    'authNoPriv',
    'authPriv'
);


ALTER TYPE public.snmp_sec_level OWNER TO godevman;

--
-- Name: update_updated_on(); Type: FUNCTION; Schema: public; Owner: godevman
--

CREATE FUNCTION public.update_updated_on() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_on = now();
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_updated_on() OWNER TO godevman;

--
-- Name: archived_interfaces_ifa_id_seq; Type: SEQUENCE; Schema: public; Owner: godevman
--

CREATE SEQUENCE public.archived_interfaces_ifa_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.archived_interfaces_ifa_id_seq OWNER TO godevman;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: archived_interfaces; Type: TABLE; Schema: public; Owner: godevman
--

CREATE TABLE public.archived_interfaces (
    ifa_id bigint DEFAULT nextval('public.archived_interfaces_ifa_id_seq'::regclass) NOT NULL,
    ifindex bigint,
    otn_if_id bigint,
    cisco_opt_power_index character varying,
    hostname character varying NOT NULL,
    host_ip4 inet,
    host_ip6 inet,
    manufacturer character varying NOT NULL,
    model character varying NOT NULL,
    descr character varying NOT NULL,
    alias character varying,
    type_enum smallint,
    mac macaddr,
    updated_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    created_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.archived_interfaces OWNER TO godevman;

--
-- Name: archived_subinterfaces_sifa_id_seq; Type: SEQUENCE; Schema: public; Owner: godevman
--

CREATE SEQUENCE public.archived_subinterfaces_sifa_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.archived_subinterfaces_sifa_id_seq OWNER TO godevman;

--
-- Name: archived_subinterfaces; Type: TABLE; Schema: public; Owner: godevman
--

CREATE TABLE public.archived_subinterfaces (
    sifa_id bigint DEFAULT nextval('public.archived_subinterfaces_sifa_id_seq'::regclass) NOT NULL,
    ifindex bigint,
    descr character varying NOT NULL,
    parent_descr character varying,
    alias character varying,
    type character varying,
    mac macaddr,
    hostname character varying NOT NULL,
    host_ip4 inet,
    host_ip6 inet,
    notes character varying,
    updated_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    created_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.archived_subinterfaces OWNER TO godevman;

--
-- Name: con_capacities; Type: TABLE; Schema: public; Owner: godevman
--

CREATE TABLE public.con_capacities (
    con_cap_id bigint NOT NULL,
    descr character varying NOT NULL,
    notes character varying,
    updated_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    created_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.con_capacities OWNER TO godevman;

--
-- Name: con_capacities_con_cap_id_seq; Type: SEQUENCE; Schema: public; Owner: godevman
--

CREATE SEQUENCE public.con_capacities_con_cap_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.con_capacities_con_cap_id_seq OWNER TO godevman;

--
-- Name: con_capacities_con_cap_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: godevman
--

ALTER SEQUENCE public.con_capacities_con_cap_id_seq OWNED BY public.con_capacities.con_cap_id;


--
-- Name: con_classes; Type: TABLE; Schema: public; Owner: godevman
--

CREATE TABLE public.con_classes (
    con_class_id bigint NOT NULL,
    descr character varying NOT NULL,
    notes character varying,
    updated_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    created_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.con_classes OWNER TO godevman;

--
-- Name: con_classes_con_class_id_seq; Type: SEQUENCE; Schema: public; Owner: godevman
--

CREATE SEQUENCE public.con_classes_con_class_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.con_classes_con_class_id_seq OWNER TO godevman;

--
-- Name: con_classes_con_class_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: godevman
--

ALTER SEQUENCE public.con_classes_con_class_id_seq OWNED BY public.con_classes.con_class_id;


--
-- Name: con_providers; Type: TABLE; Schema: public; Owner: godevman
--

CREATE TABLE public.con_providers (
    con_prov_id bigint NOT NULL,
    descr character varying NOT NULL,
    notes character varying,
    updated_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    created_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.con_providers OWNER TO godevman;

--
-- Name: con_providers_con_prov_id_seq; Type: SEQUENCE; Schema: public; Owner: godevman
--

CREATE SEQUENCE public.con_providers_con_prov_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.con_providers_con_prov_id_seq OWNER TO godevman;

--
-- Name: con_providers_con_prov_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: godevman
--

ALTER SEQUENCE public.con_providers_con_prov_id_seq OWNED BY public.con_providers.con_prov_id;


--
-- Name: con_types; Type: TABLE; Schema: public; Owner: godevman
--

CREATE TABLE public.con_types (
    con_type_id bigint NOT NULL,
    descr character varying NOT NULL,
    notes character varying,
    updated_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    created_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.con_types OWNER TO godevman;

--
-- Name: con_types_con_type_id_seq; Type: SEQUENCE; Schema: public; Owner: godevman
--

CREATE SEQUENCE public.con_types_con_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.con_types_con_type_id_seq OWNER TO godevman;

--
-- Name: con_types_con_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: godevman
--

ALTER SEQUENCE public.con_types_con_type_id_seq OWNED BY public.con_types.con_type_id;


--
-- Name: connections; Type: TABLE; Schema: public; Owner: godevman
--

CREATE TABLE public.connections (
    con_id bigint NOT NULL,
    site_id bigint NOT NULL,
    con_prov_id bigint NOT NULL,
    con_type_id bigint NOT NULL,
    con_cap_id bigint NOT NULL,
    con_class_id bigint NOT NULL,
    hint character varying,
    notes character varying,
    in_use boolean DEFAULT false NOT NULL,
    updated_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    created_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.connections OWNER TO godevman;

--
-- Name: connections_con_id_seq; Type: SEQUENCE; Schema: public; Owner: godevman
--

CREATE SEQUENCE public.connections_con_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.connections_con_id_seq OWNER TO godevman;

--
-- Name: connections_con_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: godevman
--

ALTER SEQUENCE public.connections_con_id_seq OWNED BY public.connections.con_id;


--
-- Name: countries; Type: TABLE; Schema: public; Owner: godevman
--

CREATE TABLE public.countries (
    country_id bigint NOT NULL,
    code character varying NOT NULL,
    descr character varying NOT NULL,
    updated_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    created_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.countries OWNER TO godevman;

--
-- Name: COLUMN countries.code; Type: COMMENT; Schema: public; Owner: godevman
--

COMMENT ON COLUMN public.countries.code IS 'ISO 3166-1 Alpha-2 code';


--
-- Name: countries_country_id_seq; Type: SEQUENCE; Schema: public; Owner: godevman
--

CREATE SEQUENCE public.countries_country_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.countries_country_id_seq OWNER TO godevman;

--
-- Name: countries_country_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: godevman
--

ALTER SEQUENCE public.countries_country_id_seq OWNED BY public.countries.country_id;


--
-- Name: credentials; Type: TABLE; Schema: public; Owner: godevman
--

CREATE TABLE public.credentials (
    cred_id bigint NOT NULL,
    label character varying NOT NULL,
    username character varying,
    enc_secret text NOT NULL,
    updated_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    created_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.credentials OWNER TO godevman;

--
-- Name: credentials_cred_id_seq; Type: SEQUENCE; Schema: public; Owner: godevman
--

CREATE SEQUENCE public.credentials_cred_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.credentials_cred_id_seq OWNER TO godevman;

--
-- Name: credentials_cred_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: godevman
--

ALTER SEQUENCE public.credentials_cred_id_seq OWNED BY public.credentials.cred_id;


--
-- Name: custom_entities; Type: TABLE; Schema: public; Owner: godevman
--

CREATE TABLE public.custom_entities (
    cent_id bigint NOT NULL,
    manufacturer character varying NOT NULL,
    serial_nr character varying NOT NULL,
    part character varying,
    descr character varying,
    updated_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    created_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.custom_entities OWNER TO godevman;

--
-- Name: custom_entities_cext_id_seq; Type: SEQUENCE; Schema: public; Owner: godevman
--

CREATE SEQUENCE public.custom_entities_cext_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.custom_entities_cext_id_seq OWNER TO godevman;

--
-- Name: custom_entities_cext_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: godevman
--

ALTER SEQUENCE public.custom_entities_cext_id_seq OWNED BY public.custom_entities.cent_id;


--
-- Name: device_classes; Type: TABLE; Schema: public; Owner: godevman
--

CREATE TABLE public.device_classes (
    class_id bigint NOT NULL,
    descr character varying NOT NULL,
    updated_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    created_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.device_classes OWNER TO godevman;

--
-- Name: device_classes_class_id_seq; Type: SEQUENCE; Schema: public; Owner: godevman
--

CREATE SEQUENCE public.device_classes_class_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.device_classes_class_id_seq OWNER TO godevman;

--
-- Name: device_classes_class_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: godevman
--

ALTER SEQUENCE public.device_classes_class_id_seq OWNED BY public.device_classes.class_id;


--
-- Name: device_credentials_cred_id_seq; Type: SEQUENCE; Schema: public; Owner: godevman
--

CREATE SEQUENCE public.device_credentials_cred_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.device_credentials_cred_id_seq OWNER TO godevman;

--
-- Name: device_credentials; Type: TABLE; Schema: public; Owner: godevman
--

CREATE TABLE public.device_credentials (
    cred_id bigint DEFAULT nextval('public.device_credentials_cred_id_seq'::regclass) NOT NULL,
    dev_id bigint NOT NULL,
    username character varying NOT NULL,
    enc_secret text NOT NULL,
    updated_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    created_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.device_credentials OWNER TO godevman;

--
-- Name: device_domains; Type: TABLE; Schema: public; Owner: godevman
--

CREATE TABLE public.device_domains (
    dom_id bigint NOT NULL,
    descr character varying NOT NULL,
    updated_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    created_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.device_domains OWNER TO godevman;

--
-- Name: device_domains_dom_id_seq; Type: SEQUENCE; Schema: public; Owner: godevman
--

CREATE SEQUENCE public.device_domains_dom_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.device_domains_dom_id_seq OWNER TO godevman;

--
-- Name: device_domains_dom_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: godevman
--

ALTER SEQUENCE public.device_domains_dom_id_seq OWNED BY public.device_domains.dom_id;


--
-- Name: device_extensions; Type: TABLE; Schema: public; Owner: godevman
--

CREATE TABLE public.device_extensions (
    ext_id bigint NOT NULL,
    dev_id bigint NOT NULL,
    field character varying NOT NULL,
    content character varying,
    updated_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    created_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.device_extensions OWNER TO godevman;

--
-- Name: device_extensions_ext_id_seq; Type: SEQUENCE; Schema: public; Owner: godevman
--

CREATE SEQUENCE public.device_extensions_ext_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.device_extensions_ext_id_seq OWNER TO godevman;

--
-- Name: device_extensions_ext_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: godevman
--

ALTER SEQUENCE public.device_extensions_ext_id_seq OWNED BY public.device_extensions.ext_id;


--
-- Name: device_licenses; Type: TABLE; Schema: public; Owner: godevman
--

CREATE TABLE public.device_licenses (
    lic_id bigint NOT NULL,
    dev_id bigint NOT NULL,
    product character varying,
    descr character varying,
    installed integer,
    unlocked integer,
    tot_inst integer,
    used integer,
    condition character varying,
    updated_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    created_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.device_licenses OWNER TO godevman;

--
-- Name: device_licenses_lic_id_seq; Type: SEQUENCE; Schema: public; Owner: godevman
--

CREATE SEQUENCE public.device_licenses_lic_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.device_licenses_lic_id_seq OWNER TO godevman;

--
-- Name: device_licenses_lic_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: godevman
--

ALTER SEQUENCE public.device_licenses_lic_id_seq OWNED BY public.device_licenses.lic_id;


--
-- Name: device_states; Type: TABLE; Schema: public; Owner: godevman
--

CREATE TABLE public.device_states (
    dev_id bigint NOT NULL,
    up_time timestamp with time zone,
    down_time timestamp with time zone,
    method character varying NOT NULL,
    updated_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    created_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.device_states OWNER TO godevman;

--
-- Name: device_types; Type: TABLE; Schema: public; Owner: godevman
--

CREATE TABLE public.device_types (
    sys_id character varying NOT NULL,
    class_id bigint NOT NULL,
    manufacturer character varying NOT NULL,
    model character varying NOT NULL,
    hc boolean DEFAULT false NOT NULL,
    snmp_ver smallint DEFAULT '0'::smallint NOT NULL,
    updated_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    created_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.device_types OWNER TO godevman;

--
-- Name: COLUMN device_types.sys_id; Type: COMMENT; Schema: public; Owner: godevman
--

COMMENT ON COLUMN public.device_types.sys_id IS 'snmp sysObjectId or some unique identifier if snmp is not supported';


--
-- Name: COLUMN device_types.snmp_ver; Type: COMMENT; Schema: public; Owner: godevman
--

COMMENT ON COLUMN public.device_types.snmp_ver IS 'highest supported snmp version';


--
-- Name: devices; Type: TABLE; Schema: public; Owner: godevman
--

CREATE TABLE public.devices (
    dev_id bigint NOT NULL,
    site_id bigint,
    dom_id bigint NOT NULL,
    snmp_main_id bigint,
    snmp_ro_id bigint,
    parent bigint,
    sys_id character varying DEFAULT 'no-snmp'::character varying NOT NULL,
    ip4_addr inet,
    ip6_addr inet,
    host_name character varying NOT NULL,
    sys_name character varying,
    sys_location character varying,
    sys_contact character varying,
    sw_version character varying,
    ext_model character varying,
    installed boolean DEFAULT false NOT NULL,
    monitor boolean DEFAULT false NOT NULL,
    graph boolean DEFAULT false NOT NULL,
    backup boolean DEFAULT false NOT NULL,
    source character varying DEFAULT 'manual'::character varying NOT NULL,
    type_changed boolean DEFAULT false NOT NULL,
    backup_failed boolean DEFAULT false NOT NULL,
    validation_failed boolean DEFAULT false NOT NULL,
    unresponsive boolean DEFAULT false NOT NULL,
    notes text,
    updated_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    created_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.devices OWNER TO godevman;

--
-- Name: devices_dev_id_seq; Type: SEQUENCE; Schema: public; Owner: godevman
--

CREATE SEQUENCE public.devices_dev_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.devices_dev_id_seq OWNER TO godevman;

--
-- Name: devices_dev_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: godevman
--

ALTER SEQUENCE public.devices_dev_id_seq OWNED BY public.devices.dev_id;


--
-- Name: entities; Type: TABLE; Schema: public; Owner: godevman
--

CREATE TABLE public.entities (
    ent_id bigint NOT NULL,
    parent_ent_id bigint,
    snmp_ent_id bigint,
    dev_id bigint NOT NULL,
    slot character varying,
    descr character varying,
    model character varying,
    hw_product character varying,
    hw_revision character varying,
    serial_nr character varying,
    sw_product character varying,
    sw_revision character varying,
    manufacturer character varying,
    physical boolean DEFAULT false NOT NULL,
    updated_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    created_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.entities OWNER TO godevman;

--
-- Name: entities_ent_id_seq; Type: SEQUENCE; Schema: public; Owner: godevman
--

CREATE SEQUENCE public.entities_ent_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.entities_ent_id_seq OWNER TO godevman;

--
-- Name: entities_ent_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: godevman
--

ALTER SEQUENCE public.entities_ent_id_seq OWNED BY public.entities.ent_id;


--
-- Name: entity_phy_indexes; Type: TABLE; Schema: public; Owner: godevman
--

CREATE TABLE public.entity_phy_indexes (
    ei_id bigint NOT NULL,
    ent_id bigint NOT NULL,
    phy_index bigint NOT NULL,
    descr character varying NOT NULL,
    updated_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    created_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.entity_phy_indexes OWNER TO godevman;

--
-- Name: entity_indexes_ei_id_seq; Type: SEQUENCE; Schema: public; Owner: godevman
--

CREATE SEQUENCE public.entity_indexes_ei_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.entity_indexes_ei_id_seq OWNER TO godevman;

--
-- Name: entity_indexes_ei_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: godevman
--

ALTER SEQUENCE public.entity_indexes_ei_id_seq OWNED BY public.entity_phy_indexes.ei_id;


--
-- Name: int_bw_stats; Type: TABLE; Schema: public; Owner: godevman
--

CREATE TABLE public.int_bw_stats (
    bw_id bigint NOT NULL,
    if_id bigint NOT NULL,
    to50in smallint,
    to75in smallint,
    to90in smallint,
    to100in smallint,
    to50out smallint,
    to75out smallint,
    to90out smallint,
    to100out smallint,
    if_group character varying NOT NULL,
    updated_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    created_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.int_bw_stats OWNER TO godevman;

--
-- Name: int_bw_stats_bw_id_seq; Type: SEQUENCE; Schema: public; Owner: godevman
--

CREATE SEQUENCE public.int_bw_stats_bw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.int_bw_stats_bw_id_seq OWNER TO godevman;

--
-- Name: int_bw_stats_bw_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: godevman
--

ALTER SEQUENCE public.int_bw_stats_bw_id_seq OWNED BY public.int_bw_stats.bw_id;


--
-- Name: interface_relations; Type: TABLE; Schema: public; Owner: godevman
--

CREATE TABLE public.interface_relations (
    ir_id bigint NOT NULL,
    if_id bigint NOT NULL,
    if_id_up bigint,
    if_id_down bigint,
    updated_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    created_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.interface_relations OWNER TO godevman;

--
-- Name: interface_relations_ir_id_seq; Type: SEQUENCE; Schema: public; Owner: godevman
--

CREATE SEQUENCE public.interface_relations_ir_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.interface_relations_ir_id_seq OWNER TO godevman;

--
-- Name: interface_relations_ir_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: godevman
--

ALTER SEQUENCE public.interface_relations_ir_id_seq OWNED BY public.interface_relations.ir_id;


--
-- Name: interfaces_if_id_seq; Type: SEQUENCE; Schema: public; Owner: godevman
--

CREATE SEQUENCE public.interfaces_if_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.interfaces_if_id_seq OWNER TO godevman;

--
-- Name: interfaces; Type: TABLE; Schema: public; Owner: godevman
--

CREATE TABLE public.interfaces (
    if_id bigint DEFAULT nextval('public.interfaces_if_id_seq'::regclass) NOT NULL,
    con_id bigint,
    parent bigint,
    otn_if_id bigint,
    dev_id bigint NOT NULL,
    ent_id bigint,
    ifindex bigint,
    descr character varying NOT NULL,
    alias character varying,
    oper smallint,
    adm smallint,
    speed bigint,
    minspeed bigint,
    type_enum smallint,
    mac macaddr,
    monstatus smallint DEFAULT '1'::smallint NOT NULL,
    monerrors smallint DEFAULT '1'::smallint NOT NULL,
    monload smallint DEFAULT '1'::smallint NOT NULL,
    updated_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    created_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    montraffic smallint DEFAULT '2'::smallint NOT NULL
);


ALTER TABLE public.interfaces OWNER TO godevman;

--
-- Name: interfaces2vlans; Type: TABLE; Schema: public; Owner: godevman
--

CREATE TABLE public.interfaces2vlans (
    v_id bigint NOT NULL,
    if_id bigint NOT NULL,
    updated_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    created_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.interfaces2vlans OWNER TO godevman;

--
-- Name: ip_interfaces; Type: TABLE; Schema: public; Owner: godevman
--

CREATE TABLE public.ip_interfaces (
    ip_id bigint NOT NULL,
    dev_id bigint NOT NULL,
    ifindex bigint,
    ip_addr inet NOT NULL,
    descr character varying,
    alias character varying,
    updated_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    created_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.ip_interfaces OWNER TO godevman;

--
-- Name: ip_interfaces_ip_id_seq; Type: SEQUENCE; Schema: public; Owner: godevman
--

CREATE SEQUENCE public.ip_interfaces_ip_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ip_interfaces_ip_id_seq OWNER TO godevman;

--
-- Name: ip_interfaces_ip_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: godevman
--

ALTER SEQUENCE public.ip_interfaces_ip_id_seq OWNED BY public.ip_interfaces.ip_id;


--
-- Name: ospf_nbrs; Type: TABLE; Schema: public; Owner: godevman
--

CREATE TABLE public.ospf_nbrs (
    nbr_id bigint NOT NULL,
    dev_id bigint NOT NULL,
    nbr_ip inet NOT NULL,
    condition character varying,
    updated_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    created_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.ospf_nbrs OWNER TO godevman;

--
-- Name: ospf_nbrs_nbr_id_seq; Type: SEQUENCE; Schema: public; Owner: godevman
--

CREATE SEQUENCE public.ospf_nbrs_nbr_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ospf_nbrs_nbr_id_seq OWNER TO godevman;

--
-- Name: ospf_nbrs_nbr_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: godevman
--

ALTER SEQUENCE public.ospf_nbrs_nbr_id_seq OWNED BY public.ospf_nbrs.nbr_id;


--
-- Name: rl_nbrs; Type: TABLE; Schema: public; Owner: godevman
--

CREATE TABLE public.rl_nbrs (
    nbr_id bigint NOT NULL,
    dev_id bigint NOT NULL,
    nbr_ent_id bigint,
    nbr_sysname character varying NOT NULL,
    updated_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    created_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.rl_nbrs OWNER TO godevman;

--
-- Name: rl_nbrs_nbr_id_seq; Type: SEQUENCE; Schema: public; Owner: godevman
--

CREATE SEQUENCE public.rl_nbrs_nbr_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rl_nbrs_nbr_id_seq OWNER TO godevman;

--
-- Name: rl_nbrs_nbr_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: godevman
--

ALTER SEQUENCE public.rl_nbrs_nbr_id_seq OWNED BY public.rl_nbrs.nbr_id;


--
-- Name: sites_site_id_seq; Type: SEQUENCE; Schema: public; Owner: godevman
--

CREATE SEQUENCE public.sites_site_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sites_site_id_seq OWNER TO godevman;

--
-- Name: sites; Type: TABLE; Schema: public; Owner: godevman
--

CREATE TABLE public.sites (
    site_id bigint DEFAULT nextval('public.sites_site_id_seq'::regclass) NOT NULL,
    country_id bigint NOT NULL,
    uident character varying,
    descr character varying NOT NULL,
    latitude real,
    longitude real,
    area character varying,
    addr character varying,
    notes character varying,
    ext_id bigint,
    ext_name character varying,
    updated_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    created_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.sites OWNER TO godevman;

--
-- Name: snmp_credentials; Type: TABLE; Schema: public; Owner: godevman
--

CREATE TABLE public.snmp_credentials (
    snmp_cred_id bigint NOT NULL,
    label character varying NOT NULL,
    variant integer NOT NULL,
    auth_name character varying NOT NULL,
    auth_proto public.snmp_auth_proto,
    auth_pass text,
    sec_level public.snmp_sec_level,
    priv_proto public.snmp_priv_proto,
    priv_pass text,
    updated_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    created_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.snmp_credentials OWNER TO godevman;

--
-- Name: COLUMN snmp_credentials.auth_name; Type: COMMENT; Schema: public; Owner: godevman
--

COMMENT ON COLUMN public.snmp_credentials.auth_name IS 'Community or SecName';


--
-- Name: snmp_credentials_snmp_cred_id_seq; Type: SEQUENCE; Schema: public; Owner: godevman
--

CREATE SEQUENCE public.snmp_credentials_snmp_cred_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.snmp_credentials_snmp_cred_id_seq OWNER TO godevman;

--
-- Name: snmp_credentials_snmp_cred_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: godevman
--

ALTER SEQUENCE public.snmp_credentials_snmp_cred_id_seq OWNED BY public.snmp_credentials.snmp_cred_id;


--
-- Name: subinterfaces_sif_id_seq; Type: SEQUENCE; Schema: public; Owner: godevman
--

CREATE SEQUENCE public.subinterfaces_sif_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.subinterfaces_sif_id_seq OWNER TO godevman;

--
-- Name: subinterfaces; Type: TABLE; Schema: public; Owner: godevman
--

CREATE TABLE public.subinterfaces (
    sif_id bigint DEFAULT nextval('public.subinterfaces_sif_id_seq'::regclass) NOT NULL,
    if_id bigint,
    ifindex bigint,
    descr character varying NOT NULL,
    alias character varying,
    oper smallint,
    adm smallint,
    speed bigint,
    type_enum character varying,
    mac macaddr,
    notes character varying,
    updated_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    created_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.subinterfaces OWNER TO godevman;

--
-- Name: user_authzs; Type: TABLE; Schema: public; Owner: godevman
--

CREATE TABLE public.user_authzs (
    username character varying NOT NULL,
    dom_id bigint NOT NULL,
    userlevel smallint NOT NULL,
    updated_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    created_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.user_authzs OWNER TO godevman;

--
-- Name: COLUMN user_authzs.userlevel; Type: COMMENT; Schema: public; Owner: godevman
--

COMMENT ON COLUMN public.user_authzs.userlevel IS 'Domain level for user';


--
-- Name: user_graphs; Type: TABLE; Schema: public; Owner: godevman
--

CREATE TABLE public.user_graphs (
    graph_id bigint NOT NULL,
    username character varying NOT NULL,
    uri character varying NOT NULL,
    descr character varying NOT NULL,
    shared boolean DEFAULT false NOT NULL,
    updated_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    created_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.user_graphs OWNER TO godevman;

--
-- Name: user_graphs_graph_id_seq; Type: SEQUENCE; Schema: public; Owner: godevman
--

CREATE SEQUENCE public.user_graphs_graph_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_graphs_graph_id_seq OWNER TO godevman;

--
-- Name: user_graphs_graph_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: godevman
--

ALTER SEQUENCE public.user_graphs_graph_id_seq OWNED BY public.user_graphs.graph_id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: godevman
--

CREATE TABLE public.users (
    username character varying NOT NULL,
    userlevel smallint NOT NULL,
    notes text,
    updated_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    created_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.users OWNER TO godevman;

--
-- Name: COLUMN users.userlevel; Type: COMMENT; Schema: public; Owner: godevman
--

COMMENT ON COLUMN public.users.userlevel IS 'Global level for user';


--
-- Name: vars; Type: TABLE; Schema: public; Owner: godevman
--

CREATE TABLE public.vars (
    descr character varying NOT NULL,
    content character varying,
    notes text,
    updated_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    created_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.vars OWNER TO godevman;

--
-- Name: vlans; Type: TABLE; Schema: public; Owner: godevman
--

CREATE TABLE public.vlans (
    v_id bigint NOT NULL,
    dev_id bigint NOT NULL,
    vlan bigint NOT NULL,
    descr character varying,
    updated_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    created_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.vlans OWNER TO godevman;

--
-- Name: vlans_v_id_seq; Type: SEQUENCE; Schema: public; Owner: godevman
--

CREATE SEQUENCE public.vlans_v_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.vlans_v_id_seq OWNER TO godevman;

--
-- Name: vlans_v_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: godevman
--

ALTER SEQUENCE public.vlans_v_id_seq OWNED BY public.vlans.v_id;


--
-- Name: xconnects; Type: TABLE; Schema: public; Owner: godevman
--

CREATE TABLE public.xconnects (
    xc_id bigint NOT NULL,
    dev_id bigint NOT NULL,
    peer_dev_id bigint,
    if_id bigint,
    vc_idx bigint NOT NULL,
    vc_id bigint NOT NULL,
    peer_ip inet,
    peer_ifalias character varying,
    xname character varying,
    descr character varying,
    op_stat character varying,
    op_stat_in character varying,
    op_stat_out character varying,
    updated_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    created_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.xconnects OWNER TO godevman;

--
-- Name: xconnects_xc_id_seq; Type: SEQUENCE; Schema: public; Owner: godevman
--

CREATE SEQUENCE public.xconnects_xc_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.xconnects_xc_id_seq OWNER TO godevman;

--
-- Name: xconnects_xc_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: godevman
--

ALTER SEQUENCE public.xconnects_xc_id_seq OWNED BY public.xconnects.xc_id;


--
-- Name: con_capacities con_cap_id; Type: DEFAULT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.con_capacities ALTER COLUMN con_cap_id SET DEFAULT nextval('public.con_capacities_con_cap_id_seq'::regclass);


--
-- Name: con_classes con_class_id; Type: DEFAULT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.con_classes ALTER COLUMN con_class_id SET DEFAULT nextval('public.con_classes_con_class_id_seq'::regclass);


--
-- Name: con_providers con_prov_id; Type: DEFAULT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.con_providers ALTER COLUMN con_prov_id SET DEFAULT nextval('public.con_providers_con_prov_id_seq'::regclass);


--
-- Name: con_types con_type_id; Type: DEFAULT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.con_types ALTER COLUMN con_type_id SET DEFAULT nextval('public.con_types_con_type_id_seq'::regclass);


--
-- Name: connections con_id; Type: DEFAULT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.connections ALTER COLUMN con_id SET DEFAULT nextval('public.connections_con_id_seq'::regclass);


--
-- Name: countries country_id; Type: DEFAULT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.countries ALTER COLUMN country_id SET DEFAULT nextval('public.countries_country_id_seq'::regclass);


--
-- Name: credentials cred_id; Type: DEFAULT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.credentials ALTER COLUMN cred_id SET DEFAULT nextval('public.credentials_cred_id_seq'::regclass);


--
-- Name: custom_entities cent_id; Type: DEFAULT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.custom_entities ALTER COLUMN cent_id SET DEFAULT nextval('public.custom_entities_cext_id_seq'::regclass);


--
-- Name: device_classes class_id; Type: DEFAULT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.device_classes ALTER COLUMN class_id SET DEFAULT nextval('public.device_classes_class_id_seq'::regclass);


--
-- Name: device_domains dom_id; Type: DEFAULT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.device_domains ALTER COLUMN dom_id SET DEFAULT nextval('public.device_domains_dom_id_seq'::regclass);


--
-- Name: device_extensions ext_id; Type: DEFAULT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.device_extensions ALTER COLUMN ext_id SET DEFAULT nextval('public.device_extensions_ext_id_seq'::regclass);


--
-- Name: device_licenses lic_id; Type: DEFAULT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.device_licenses ALTER COLUMN lic_id SET DEFAULT nextval('public.device_licenses_lic_id_seq'::regclass);


--
-- Name: devices dev_id; Type: DEFAULT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.devices ALTER COLUMN dev_id SET DEFAULT nextval('public.devices_dev_id_seq'::regclass);


--
-- Name: entities ent_id; Type: DEFAULT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.entities ALTER COLUMN ent_id SET DEFAULT nextval('public.entities_ent_id_seq'::regclass);


--
-- Name: entity_phy_indexes ei_id; Type: DEFAULT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.entity_phy_indexes ALTER COLUMN ei_id SET DEFAULT nextval('public.entity_indexes_ei_id_seq'::regclass);


--
-- Name: int_bw_stats bw_id; Type: DEFAULT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.int_bw_stats ALTER COLUMN bw_id SET DEFAULT nextval('public.int_bw_stats_bw_id_seq'::regclass);


--
-- Name: interface_relations ir_id; Type: DEFAULT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.interface_relations ALTER COLUMN ir_id SET DEFAULT nextval('public.interface_relations_ir_id_seq'::regclass);


--
-- Name: ip_interfaces ip_id; Type: DEFAULT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.ip_interfaces ALTER COLUMN ip_id SET DEFAULT nextval('public.ip_interfaces_ip_id_seq'::regclass);


--
-- Name: ospf_nbrs nbr_id; Type: DEFAULT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.ospf_nbrs ALTER COLUMN nbr_id SET DEFAULT nextval('public.ospf_nbrs_nbr_id_seq'::regclass);


--
-- Name: rl_nbrs nbr_id; Type: DEFAULT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.rl_nbrs ALTER COLUMN nbr_id SET DEFAULT nextval('public.rl_nbrs_nbr_id_seq'::regclass);


--
-- Name: snmp_credentials snmp_cred_id; Type: DEFAULT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.snmp_credentials ALTER COLUMN snmp_cred_id SET DEFAULT nextval('public.snmp_credentials_snmp_cred_id_seq'::regclass);


--
-- Name: user_graphs graph_id; Type: DEFAULT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.user_graphs ALTER COLUMN graph_id SET DEFAULT nextval('public.user_graphs_graph_id_seq'::regclass);


--
-- Name: vlans v_id; Type: DEFAULT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.vlans ALTER COLUMN v_id SET DEFAULT nextval('public.vlans_v_id_seq'::regclass);


--
-- Name: xconnects xc_id; Type: DEFAULT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.xconnects ALTER COLUMN xc_id SET DEFAULT nextval('public.xconnects_xc_id_seq'::regclass);


--
-- Name: con_capacities con_capacities_name; Type: CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.con_capacities
    ADD CONSTRAINT con_capacities_name UNIQUE (descr);


--
-- Name: con_capacities con_capacities_pkey; Type: CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.con_capacities
    ADD CONSTRAINT con_capacities_pkey PRIMARY KEY (con_cap_id);


--
-- Name: con_classes con_classes_name; Type: CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.con_classes
    ADD CONSTRAINT con_classes_name UNIQUE (descr);


--
-- Name: con_classes con_classes_pkey; Type: CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.con_classes
    ADD CONSTRAINT con_classes_pkey PRIMARY KEY (con_class_id);


--
-- Name: con_providers con_providers_descr; Type: CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.con_providers
    ADD CONSTRAINT con_providers_descr UNIQUE (descr);


--
-- Name: con_providers con_providers_pkey; Type: CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.con_providers
    ADD CONSTRAINT con_providers_pkey PRIMARY KEY (con_prov_id);


--
-- Name: con_types con_types_name; Type: CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.con_types
    ADD CONSTRAINT con_types_name UNIQUE (descr);


--
-- Name: con_types con_types_pkey; Type: CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.con_types
    ADD CONSTRAINT con_types_pkey PRIMARY KEY (con_type_id);


--
-- Name: connections connections_hint; Type: CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.connections
    ADD CONSTRAINT connections_hint UNIQUE (hint);


--
-- Name: connections connections_pkey; Type: CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.connections
    ADD CONSTRAINT connections_pkey PRIMARY KEY (con_id);


--
-- Name: countries countries_code; Type: CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.countries
    ADD CONSTRAINT countries_code UNIQUE (code);


--
-- Name: countries countries_name; Type: CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.countries
    ADD CONSTRAINT countries_name UNIQUE (descr);


--
-- Name: countries countries_pkey; Type: CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.countries
    ADD CONSTRAINT countries_pkey PRIMARY KEY (country_id);


--
-- Name: credentials credentials_label; Type: CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.credentials
    ADD CONSTRAINT credentials_label UNIQUE (label);


--
-- Name: credentials credentials_pkey; Type: CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.credentials
    ADD CONSTRAINT credentials_pkey PRIMARY KEY (cred_id);


--
-- Name: device_classes device_classes_name; Type: CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.device_classes
    ADD CONSTRAINT device_classes_name UNIQUE (descr);


--
-- Name: device_classes device_classes_pkey; Type: CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.device_classes
    ADD CONSTRAINT device_classes_pkey PRIMARY KEY (class_id);


--
-- Name: device_credentials device_credentials_dev_id_user; Type: CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.device_credentials
    ADD CONSTRAINT device_credentials_dev_id_user UNIQUE (dev_id, username);


--
-- Name: device_credentials device_credentials_pkey; Type: CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.device_credentials
    ADD CONSTRAINT device_credentials_pkey PRIMARY KEY (cred_id);


--
-- Name: device_domains device_domains_descr; Type: CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.device_domains
    ADD CONSTRAINT device_domains_descr UNIQUE (descr);


--
-- Name: device_domains device_domains_pkey; Type: CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.device_domains
    ADD CONSTRAINT device_domains_pkey PRIMARY KEY (dom_id);


--
-- Name: device_extensions device_extensions_dev_id_field; Type: CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.device_extensions
    ADD CONSTRAINT device_extensions_dev_id_field UNIQUE (dev_id, field);


--
-- Name: device_extensions device_extensions_pkey; Type: CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.device_extensions
    ADD CONSTRAINT device_extensions_pkey PRIMARY KEY (ext_id);


--
-- Name: device_licenses device_licenses_dev_id_name; Type: CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.device_licenses
    ADD CONSTRAINT device_licenses_dev_id_name UNIQUE (dev_id, descr);


--
-- Name: device_licenses device_licenses_dev_id_product; Type: CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.device_licenses
    ADD CONSTRAINT device_licenses_dev_id_product UNIQUE (dev_id, product);


--
-- Name: device_licenses device_licenses_pkey; Type: CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.device_licenses
    ADD CONSTRAINT device_licenses_pkey PRIMARY KEY (lic_id);


--
-- Name: device_states device_states_pkey; Type: CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.device_states
    ADD CONSTRAINT device_states_pkey PRIMARY KEY (dev_id);


--
-- Name: device_types device_types_manufacturer_model; Type: CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.device_types
    ADD CONSTRAINT device_types_manufacturer_model UNIQUE (manufacturer, model);


--
-- Name: device_types device_types_sysobjectid; Type: CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.device_types
    ADD CONSTRAINT device_types_sysobjectid PRIMARY KEY (sys_id);


--
-- Name: devices devices_hostname; Type: CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.devices
    ADD CONSTRAINT devices_hostname UNIQUE (host_name);


--
-- Name: devices devices_ip4_addr; Type: CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.devices
    ADD CONSTRAINT devices_ip4_addr UNIQUE (ip4_addr);


--
-- Name: devices devices_ip6_addr; Type: CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.devices
    ADD CONSTRAINT devices_ip6_addr UNIQUE (ip6_addr);


--
-- Name: devices devices_pkey; Type: CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.devices
    ADD CONSTRAINT devices_pkey PRIMARY KEY (dev_id);


--
-- Name: entities entities_dev_id_snmp_ent_id; Type: CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.entities
    ADD CONSTRAINT entities_dev_id_snmp_ent_id UNIQUE (dev_id, snmp_ent_id);


--
-- Name: entities entities_pkey; Type: CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.entities
    ADD CONSTRAINT entities_pkey PRIMARY KEY (ent_id);


--
-- Name: custom_entities entity_extensions_manufacturer_serial; Type: CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.custom_entities
    ADD CONSTRAINT entity_extensions_manufacturer_serial UNIQUE (manufacturer, serial_nr);


--
-- Name: custom_entities entity_extensions_pkey; Type: CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.custom_entities
    ADD CONSTRAINT entity_extensions_pkey PRIMARY KEY (cent_id);


--
-- Name: entity_phy_indexes entity_indexes_ent_id_name; Type: CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.entity_phy_indexes
    ADD CONSTRAINT entity_indexes_ent_id_name UNIQUE (ent_id, descr);


--
-- Name: entity_phy_indexes entity_indexes_pkey; Type: CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.entity_phy_indexes
    ADD CONSTRAINT entity_indexes_pkey PRIMARY KEY (ei_id);


--
-- Name: int_bw_stats int_bw_stats_if_id_created_on; Type: CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.int_bw_stats
    ADD CONSTRAINT int_bw_stats_if_id_created_on UNIQUE (if_id, created_on);


--
-- Name: int_bw_stats int_bw_stats_pkey; Type: CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.int_bw_stats
    ADD CONSTRAINT int_bw_stats_pkey PRIMARY KEY (bw_id);


--
-- Name: interfaces2vlans interface2vlan_v_id_if_id; Type: CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.interfaces2vlans
    ADD CONSTRAINT interface2vlan_v_id_if_id PRIMARY KEY (v_id, if_id);


--
-- Name: interface_relations interface_relations_if_id_if_id_down; Type: CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.interface_relations
    ADD CONSTRAINT interface_relations_if_id_if_id_down UNIQUE (if_id, if_id_down);


--
-- Name: interface_relations interface_relations_if_id_if_id_up; Type: CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.interface_relations
    ADD CONSTRAINT interface_relations_if_id_if_id_up UNIQUE (if_id, if_id_up);


--
-- Name: interface_relations interface_relations_pkey; Type: CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.interface_relations
    ADD CONSTRAINT interface_relations_pkey PRIMARY KEY (ir_id);


--
-- Name: archived_interfaces interfaces_archive_pkey; Type: CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.archived_interfaces
    ADD CONSTRAINT interfaces_archive_pkey PRIMARY KEY (ifa_id);


--
-- Name: interfaces interfaces_dev_id_descr; Type: CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.interfaces
    ADD CONSTRAINT interfaces_dev_id_descr UNIQUE (dev_id, descr);


--
-- Name: interfaces interfaces_dev_id_index; Type: CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.interfaces
    ADD CONSTRAINT interfaces_dev_id_index UNIQUE (dev_id, ifindex);


--
-- Name: interfaces interfaces_pkey; Type: CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.interfaces
    ADD CONSTRAINT interfaces_pkey PRIMARY KEY (if_id);


--
-- Name: ip_interfaces ip_interfaces_ip_addr_dev_id; Type: CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.ip_interfaces
    ADD CONSTRAINT ip_interfaces_ip_addr_dev_id UNIQUE (ip_addr, dev_id);


--
-- Name: ip_interfaces ip_interfaces_pkey; Type: CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.ip_interfaces
    ADD CONSTRAINT ip_interfaces_pkey PRIMARY KEY (ip_id);


--
-- Name: ospf_nbrs ospf_nbrs_dev_id_nbr_ip; Type: CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.ospf_nbrs
    ADD CONSTRAINT ospf_nbrs_dev_id_nbr_ip UNIQUE (dev_id, nbr_ip);


--
-- Name: ospf_nbrs ospf_nbrs_pkey; Type: CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.ospf_nbrs
    ADD CONSTRAINT ospf_nbrs_pkey PRIMARY KEY (nbr_id);


--
-- Name: rl_nbrs rl_nbrs_dev_id_nbr_sysname_nbr_ent_id; Type: CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.rl_nbrs
    ADD CONSTRAINT rl_nbrs_dev_id_nbr_sysname_nbr_ent_id UNIQUE (dev_id, nbr_sysname, nbr_ent_id);


--
-- Name: rl_nbrs rl_nbrs_pkey; Type: CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.rl_nbrs
    ADD CONSTRAINT rl_nbrs_pkey PRIMARY KEY (nbr_id);


--
-- Name: sites sites_ext_id; Type: CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.sites
    ADD CONSTRAINT sites_ext_id UNIQUE (ext_id);


--
-- Name: sites sites_pkey; Type: CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.sites
    ADD CONSTRAINT sites_pkey PRIMARY KEY (site_id);


--
-- Name: sites sites_uid; Type: CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.sites
    ADD CONSTRAINT sites_uid UNIQUE (uident);


--
-- Name: snmp_credentials snmp_cred_name; Type: CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.snmp_credentials
    ADD CONSTRAINT snmp_cred_name UNIQUE (label);


--
-- Name: snmp_credentials snmp_cred_pkey; Type: CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.snmp_credentials
    ADD CONSTRAINT snmp_cred_pkey PRIMARY KEY (snmp_cred_id);


--
-- Name: archived_subinterfaces subinterfaces_archive_pkey; Type: CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.archived_subinterfaces
    ADD CONSTRAINT subinterfaces_archive_pkey PRIMARY KEY (sifa_id);


--
-- Name: subinterfaces subinterfaces_if_id_descr; Type: CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.subinterfaces
    ADD CONSTRAINT subinterfaces_if_id_descr UNIQUE (if_id, descr);


--
-- Name: subinterfaces subinterfaces_if_id_index; Type: CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.subinterfaces
    ADD CONSTRAINT subinterfaces_if_id_index UNIQUE (if_id, ifindex);


--
-- Name: subinterfaces subinterfaces_pkey; Type: CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.subinterfaces
    ADD CONSTRAINT subinterfaces_pkey PRIMARY KEY (sif_id);


--
-- Name: user_authzs user_authz_username_dom_id; Type: CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.user_authzs
    ADD CONSTRAINT user_authz_username_dom_id PRIMARY KEY (username, dom_id);


--
-- Name: user_graphs user_graphs_pkey; Type: CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.user_graphs
    ADD CONSTRAINT user_graphs_pkey PRIMARY KEY (graph_id);


--
-- Name: users users_username_pkey; Type: CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_pkey PRIMARY KEY (username);


--
-- Name: vars variables_name_pkey; Type: CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.vars
    ADD CONSTRAINT variables_name_pkey PRIMARY KEY (descr);


--
-- Name: vlans vlans_dev_id_vlan_descr; Type: CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.vlans
    ADD CONSTRAINT vlans_dev_id_vlan_descr UNIQUE (dev_id, vlan, descr);


--
-- Name: vlans vlans_pkey; Type: CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.vlans
    ADD CONSTRAINT vlans_pkey PRIMARY KEY (v_id);


--
-- Name: xconnects xconnects_dev_id_vc_idx; Type: CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.xconnects
    ADD CONSTRAINT xconnects_dev_id_vc_idx UNIQUE (dev_id, vc_idx);


--
-- Name: xconnects xconnects_pkey; Type: CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.xconnects
    ADD CONSTRAINT xconnects_pkey PRIMARY KEY (xc_id);


--
-- Name: archived_interfaces_alias; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX archived_interfaces_alias ON public.archived_interfaces USING btree (alias);


--
-- Name: archived_interfaces_created_on; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX archived_interfaces_created_on ON public.archived_interfaces USING btree (created_on);


--
-- Name: archived_interfaces_descr; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX archived_interfaces_descr ON public.archived_interfaces USING btree (descr);


--
-- Name: archived_interfaces_ifindex; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX archived_interfaces_ifindex ON public.archived_interfaces USING btree (ifindex);


--
-- Name: archived_interfaces_mac; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX archived_interfaces_mac ON public.archived_interfaces USING btree (mac);


--
-- Name: archived_interfaces_updated_on; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX archived_interfaces_updated_on ON public.archived_interfaces USING btree (updated_on);


--
-- Name: archived_subinterfaces_alias; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX archived_subinterfaces_alias ON public.archived_subinterfaces USING btree (alias);


--
-- Name: archived_subinterfaces_created_on; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX archived_subinterfaces_created_on ON public.archived_subinterfaces USING btree (created_on);


--
-- Name: archived_subinterfaces_updated_on; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX archived_subinterfaces_updated_on ON public.archived_subinterfaces USING btree (updated_on);


--
-- Name: con_capacities_created_on; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX con_capacities_created_on ON public.con_capacities USING btree (created_on);


--
-- Name: con_capacities_updated_on; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX con_capacities_updated_on ON public.con_capacities USING btree (updated_on);


--
-- Name: con_classes_created_on; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX con_classes_created_on ON public.con_classes USING btree (created_on);


--
-- Name: con_classes_updated_on; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX con_classes_updated_on ON public.con_classes USING btree (updated_on);


--
-- Name: con_providers_created_on; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX con_providers_created_on ON public.con_providers USING btree (created_on);


--
-- Name: con_providers_updated_on; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX con_providers_updated_on ON public.con_providers USING btree (updated_on);


--
-- Name: con_types_created_on; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX con_types_created_on ON public.con_types USING btree (created_on);


--
-- Name: con_types_updated_on; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX con_types_updated_on ON public.con_types USING btree (updated_on);


--
-- Name: connections_con_cap_id; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX connections_con_cap_id ON public.connections USING btree (con_cap_id);


--
-- Name: connections_con_class_id; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX connections_con_class_id ON public.connections USING btree (con_class_id);


--
-- Name: connections_con_prov_id; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX connections_con_prov_id ON public.connections USING btree (con_prov_id);


--
-- Name: connections_con_type_id; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX connections_con_type_id ON public.connections USING btree (con_type_id);


--
-- Name: connections_created_on; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX connections_created_on ON public.connections USING btree (created_on);


--
-- Name: connections_site_id; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX connections_site_id ON public.connections USING btree (site_id);


--
-- Name: connections_updated_on; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX connections_updated_on ON public.connections USING btree (updated_on);


--
-- Name: countries_created_on; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX countries_created_on ON public.countries USING btree (created_on);


--
-- Name: countries_updated_on; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX countries_updated_on ON public.countries USING btree (updated_on);


--
-- Name: credentials_created_on; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX credentials_created_on ON public.credentials USING btree (created_on);


--
-- Name: credentials_updated_on; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX credentials_updated_on ON public.credentials USING btree (updated_on);


--
-- Name: custom_entities_created_on; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX custom_entities_created_on ON public.custom_entities USING btree (created_on);


--
-- Name: custom_entities_serial_nr; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX custom_entities_serial_nr ON public.custom_entities USING btree (serial_nr);


--
-- Name: custom_entities_updated_on; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX custom_entities_updated_on ON public.custom_entities USING btree (updated_on);


--
-- Name: device_classes_created_on; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX device_classes_created_on ON public.device_classes USING btree (created_on);


--
-- Name: device_classes_updated_on; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX device_classes_updated_on ON public.device_classes USING btree (updated_on);


--
-- Name: device_credentials_created_on; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX device_credentials_created_on ON public.device_credentials USING btree (created_on);


--
-- Name: device_credentials_dev_id; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX device_credentials_dev_id ON public.device_credentials USING btree (dev_id);


--
-- Name: device_credentials_updated_on; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX device_credentials_updated_on ON public.device_credentials USING btree (updated_on);


--
-- Name: device_domains_created_on; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX device_domains_created_on ON public.device_domains USING btree (created_on);


--
-- Name: device_domains_updated_on; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX device_domains_updated_on ON public.device_domains USING btree (updated_on);


--
-- Name: device_extensions_created_on; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX device_extensions_created_on ON public.device_extensions USING btree (created_on);


--
-- Name: device_extensions_dev_id; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX device_extensions_dev_id ON public.device_extensions USING btree (dev_id);


--
-- Name: device_extensions_updated_on; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX device_extensions_updated_on ON public.device_extensions USING btree (updated_on);


--
-- Name: device_licenses_created_on; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX device_licenses_created_on ON public.device_licenses USING btree (created_on);


--
-- Name: device_licenses_dev_id; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX device_licenses_dev_id ON public.device_licenses USING btree (dev_id);


--
-- Name: device_licenses_name; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX device_licenses_name ON public.device_licenses USING btree (descr);


--
-- Name: device_licenses_product; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX device_licenses_product ON public.device_licenses USING btree (product);


--
-- Name: device_licenses_status; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX device_licenses_status ON public.device_licenses USING btree (condition);


--
-- Name: device_licenses_updated_on; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX device_licenses_updated_on ON public.device_licenses USING btree (updated_on);


--
-- Name: device_states_created_on; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX device_states_created_on ON public.device_states USING btree (created_on);


--
-- Name: device_states_updated_on; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX device_states_updated_on ON public.device_states USING btree (updated_on);


--
-- Name: device_types_class_id; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX device_types_class_id ON public.device_types USING btree (class_id);


--
-- Name: device_types_created_on; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX device_types_created_on ON public.device_types USING btree (created_on);


--
-- Name: device_types_updated_on; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX device_types_updated_on ON public.device_types USING btree (updated_on);


--
-- Name: devices_created_on; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX devices_created_on ON public.devices USING btree (created_on);


--
-- Name: devices_dom_id; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX devices_dom_id ON public.devices USING btree (dom_id);


--
-- Name: devices_parent; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX devices_parent ON public.devices USING btree (parent);


--
-- Name: devices_site_id; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX devices_site_id ON public.devices USING btree (site_id);


--
-- Name: devices_snmp_main_id; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX devices_snmp_main_id ON public.devices USING btree (snmp_main_id);


--
-- Name: devices_snmp_ro_id; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX devices_snmp_ro_id ON public.devices USING btree (snmp_ro_id);


--
-- Name: devices_sys_id; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX devices_sys_id ON public.devices USING btree (sys_id);


--
-- Name: devices_updated_on; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX devices_updated_on ON public.devices USING btree (updated_on);


--
-- Name: entities_created_on; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX entities_created_on ON public.entities USING btree (created_on);


--
-- Name: entities_dev_id; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX entities_dev_id ON public.entities USING btree (dev_id);


--
-- Name: entities_parent_ent_id; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX entities_parent_ent_id ON public.entities USING btree (parent_ent_id);


--
-- Name: entities_updated_on; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX entities_updated_on ON public.entities USING btree (updated_on);


--
-- Name: entity_indexes_ent_id; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX entity_indexes_ent_id ON public.entity_phy_indexes USING btree (ent_id);


--
-- Name: entity_phy_indexes_created_on; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX entity_phy_indexes_created_on ON public.entity_phy_indexes USING btree (created_on);


--
-- Name: entity_phy_indexes_updated_on; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX entity_phy_indexes_updated_on ON public.entity_phy_indexes USING btree (updated_on);


--
-- Name: int_bw_stats_created_on; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX int_bw_stats_created_on ON public.int_bw_stats USING btree (created_on);


--
-- Name: int_bw_stats_if_group; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX int_bw_stats_if_group ON public.int_bw_stats USING btree (if_group);


--
-- Name: int_bw_stats_if_id; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX int_bw_stats_if_id ON public.int_bw_stats USING btree (if_id);


--
-- Name: int_bw_stats_to100in; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX int_bw_stats_to100in ON public.int_bw_stats USING btree (to100in);


--
-- Name: int_bw_stats_to100out; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX int_bw_stats_to100out ON public.int_bw_stats USING btree (to100out);


--
-- Name: int_bw_stats_to50in; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX int_bw_stats_to50in ON public.int_bw_stats USING btree (to50in);


--
-- Name: int_bw_stats_to50out; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX int_bw_stats_to50out ON public.int_bw_stats USING btree (to50out);


--
-- Name: int_bw_stats_to75in; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX int_bw_stats_to75in ON public.int_bw_stats USING btree (to75in);


--
-- Name: int_bw_stats_to75out; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX int_bw_stats_to75out ON public.int_bw_stats USING btree (to75out);


--
-- Name: int_bw_stats_to90in; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX int_bw_stats_to90in ON public.int_bw_stats USING btree (to90in);


--
-- Name: int_bw_stats_to90out; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX int_bw_stats_to90out ON public.int_bw_stats USING btree (to90out);


--
-- Name: int_bw_stats_updated_on; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX int_bw_stats_updated_on ON public.int_bw_stats USING btree (updated_on);


--
-- Name: interface_relations_created_on; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX interface_relations_created_on ON public.interface_relations USING btree (created_on);


--
-- Name: interface_relations_if_id; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX interface_relations_if_id ON public.interface_relations USING btree (if_id);


--
-- Name: interface_relations_if_id_down; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX interface_relations_if_id_down ON public.interface_relations USING btree (if_id_down);


--
-- Name: interface_relations_if_id_up; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX interface_relations_if_id_up ON public.interface_relations USING btree (if_id_up);


--
-- Name: interface_relations_updated_on; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX interface_relations_updated_on ON public.interface_relations USING btree (updated_on);


--
-- Name: interfaces2vlans_created_on; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX interfaces2vlans_created_on ON public.interfaces2vlans USING btree (created_on);


--
-- Name: interfaces2vlans_updated_on; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX interfaces2vlans_updated_on ON public.interfaces2vlans USING btree (updated_on);


--
-- Name: interfaces_archive_host_ip4; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX interfaces_archive_host_ip4 ON public.archived_interfaces USING btree (host_ip4);


--
-- Name: interfaces_archive_host_ip6; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX interfaces_archive_host_ip6 ON public.archived_interfaces USING btree (host_ip6);


--
-- Name: interfaces_archive_hostname; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX interfaces_archive_hostname ON public.archived_interfaces USING btree (hostname);


--
-- Name: interfaces_con_id; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX interfaces_con_id ON public.interfaces USING btree (con_id);


--
-- Name: interfaces_created_on; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX interfaces_created_on ON public.interfaces USING btree (created_on);


--
-- Name: interfaces_descr; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX interfaces_descr ON public.interfaces USING btree (descr);


--
-- Name: interfaces_dev_id; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX interfaces_dev_id ON public.interfaces USING btree (dev_id);


--
-- Name: interfaces_index; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX interfaces_index ON public.interfaces USING btree (ifindex);


--
-- Name: interfaces_mac; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX interfaces_mac ON public.interfaces USING btree (mac);


--
-- Name: interfaces_otn_if_id; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX interfaces_otn_if_id ON public.interfaces USING btree (otn_if_id);


--
-- Name: interfaces_parent; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX interfaces_parent ON public.interfaces USING btree (parent);


--
-- Name: interfaces_updated_on; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX interfaces_updated_on ON public.interfaces USING btree (updated_on);


--
-- Name: ip_interfaces_created_on; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX ip_interfaces_created_on ON public.ip_interfaces USING btree (created_on);


--
-- Name: ip_interfaces_dev_id; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX ip_interfaces_dev_id ON public.ip_interfaces USING btree (dev_id);


--
-- Name: ip_interfaces_updated_on; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX ip_interfaces_updated_on ON public.ip_interfaces USING btree (updated_on);


--
-- Name: ospf_nbrs_created_on; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX ospf_nbrs_created_on ON public.ospf_nbrs USING btree (created_on);


--
-- Name: ospf_nbrs_dev_id; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX ospf_nbrs_dev_id ON public.ospf_nbrs USING btree (dev_id);


--
-- Name: ospf_nbrs_updated_on; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX ospf_nbrs_updated_on ON public.ospf_nbrs USING btree (updated_on);


--
-- Name: rl_nbrs_created_on; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX rl_nbrs_created_on ON public.rl_nbrs USING btree (created_on);


--
-- Name: rl_nbrs_dev_id; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX rl_nbrs_dev_id ON public.rl_nbrs USING btree (dev_id);


--
-- Name: rl_nbrs_nbr_ent_id; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX rl_nbrs_nbr_ent_id ON public.rl_nbrs USING btree (nbr_ent_id);


--
-- Name: rl_nbrs_updated_on; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX rl_nbrs_updated_on ON public.rl_nbrs USING btree (updated_on);


--
-- Name: sites_country_id; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX sites_country_id ON public.sites USING btree (country_id);


--
-- Name: sites_created_on; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX sites_created_on ON public.sites USING btree (created_on);


--
-- Name: sites_updated_on; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX sites_updated_on ON public.sites USING btree (updated_on);


--
-- Name: snmp_credentials_created_on; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX snmp_credentials_created_on ON public.snmp_credentials USING btree (created_on);


--
-- Name: snmp_credentials_updated_on; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX snmp_credentials_updated_on ON public.snmp_credentials USING btree (updated_on);


--
-- Name: subinterfaces_archive_descr; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX subinterfaces_archive_descr ON public.archived_subinterfaces USING btree (descr);


--
-- Name: subinterfaces_archive_host_ip4; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX subinterfaces_archive_host_ip4 ON public.archived_subinterfaces USING btree (host_ip4);


--
-- Name: subinterfaces_archive_host_ip6; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX subinterfaces_archive_host_ip6 ON public.archived_subinterfaces USING btree (host_ip6);


--
-- Name: subinterfaces_archive_hostname; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX subinterfaces_archive_hostname ON public.archived_subinterfaces USING btree (hostname);


--
-- Name: subinterfaces_archive_index; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX subinterfaces_archive_index ON public.archived_subinterfaces USING btree (ifindex);


--
-- Name: subinterfaces_archive_mac; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX subinterfaces_archive_mac ON public.archived_subinterfaces USING btree (mac);


--
-- Name: subinterfaces_created_on; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX subinterfaces_created_on ON public.subinterfaces USING btree (created_on);


--
-- Name: subinterfaces_if_id; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX subinterfaces_if_id ON public.subinterfaces USING btree (if_id);


--
-- Name: subinterfaces_mac; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX subinterfaces_mac ON public.subinterfaces USING btree (mac);


--
-- Name: subinterfaces_type; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX subinterfaces_type ON public.subinterfaces USING btree (type_enum);


--
-- Name: subinterfaces_updated_on; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX subinterfaces_updated_on ON public.subinterfaces USING btree (updated_on);


--
-- Name: user_authzs_created_on; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX user_authzs_created_on ON public.user_authzs USING btree (created_on);


--
-- Name: user_authzs_updated_on; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX user_authzs_updated_on ON public.user_authzs USING btree (updated_on);


--
-- Name: user_graphs_created_on; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX user_graphs_created_on ON public.user_graphs USING btree (created_on);


--
-- Name: user_graphs_updated_on; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX user_graphs_updated_on ON public.user_graphs USING btree (updated_on);


--
-- Name: users_created_on; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX users_created_on ON public.users USING btree (created_on);


--
-- Name: users_updated_on; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX users_updated_on ON public.users USING btree (updated_on);


--
-- Name: vars_created_on; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX vars_created_on ON public.vars USING btree (created_on);


--
-- Name: vars_updated_on; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX vars_updated_on ON public.vars USING btree (updated_on);


--
-- Name: vlans_created_on; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX vlans_created_on ON public.vlans USING btree (created_on);


--
-- Name: vlans_dev_id; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX vlans_dev_id ON public.vlans USING btree (dev_id);


--
-- Name: vlans_updated_on; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX vlans_updated_on ON public.vlans USING btree (updated_on);


--
-- Name: xconnects_created_on; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX xconnects_created_on ON public.xconnects USING btree (created_on);


--
-- Name: xconnects_dev_id; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX xconnects_dev_id ON public.xconnects USING btree (dev_id);


--
-- Name: xconnects_if_id; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX xconnects_if_id ON public.xconnects USING btree (if_id);


--
-- Name: xconnects_peer_dev_id; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX xconnects_peer_dev_id ON public.xconnects USING btree (peer_dev_id);


--
-- Name: xconnects_updated_on; Type: INDEX; Schema: public; Owner: godevman
--

CREATE INDEX xconnects_updated_on ON public.xconnects USING btree (updated_on);


--
-- Name: archived_interfaces update_archived_interfaces_updated_on; Type: TRIGGER; Schema: public; Owner: godevman
--

CREATE TRIGGER update_archived_interfaces_updated_on BEFORE UPDATE ON public.archived_interfaces FOR EACH ROW EXECUTE FUNCTION public.update_updated_on();


--
-- Name: archived_subinterfaces update_archived_subinterfaces_updated_on; Type: TRIGGER; Schema: public; Owner: godevman
--

CREATE TRIGGER update_archived_subinterfaces_updated_on BEFORE UPDATE ON public.archived_subinterfaces FOR EACH ROW EXECUTE FUNCTION public.update_updated_on();


--
-- Name: con_capacities update_con_capacities_updated_on; Type: TRIGGER; Schema: public; Owner: godevman
--

CREATE TRIGGER update_con_capacities_updated_on BEFORE UPDATE ON public.con_capacities FOR EACH ROW EXECUTE FUNCTION public.update_updated_on();


--
-- Name: con_classes update_con_classes_updated_on; Type: TRIGGER; Schema: public; Owner: godevman
--

CREATE TRIGGER update_con_classes_updated_on BEFORE UPDATE ON public.con_classes FOR EACH ROW EXECUTE FUNCTION public.update_updated_on();


--
-- Name: con_providers update_con_providers_updated_on; Type: TRIGGER; Schema: public; Owner: godevman
--

CREATE TRIGGER update_con_providers_updated_on BEFORE UPDATE ON public.con_providers FOR EACH ROW EXECUTE FUNCTION public.update_updated_on();


--
-- Name: con_types update_con_types_updated_on; Type: TRIGGER; Schema: public; Owner: godevman
--

CREATE TRIGGER update_con_types_updated_on BEFORE UPDATE ON public.con_types FOR EACH ROW EXECUTE FUNCTION public.update_updated_on();


--
-- Name: connections update_connections_updated_on; Type: TRIGGER; Schema: public; Owner: godevman
--

CREATE TRIGGER update_connections_updated_on BEFORE UPDATE ON public.connections FOR EACH ROW EXECUTE FUNCTION public.update_updated_on();


--
-- Name: countries update_countries_updated_on; Type: TRIGGER; Schema: public; Owner: godevman
--

CREATE TRIGGER update_countries_updated_on BEFORE UPDATE ON public.countries FOR EACH ROW EXECUTE FUNCTION public.update_updated_on();


--
-- Name: credentials update_credentials_updated_on; Type: TRIGGER; Schema: public; Owner: godevman
--

CREATE TRIGGER update_credentials_updated_on BEFORE UPDATE ON public.credentials FOR EACH ROW EXECUTE FUNCTION public.update_updated_on();


--
-- Name: custom_entities update_custom_entities_updated_on; Type: TRIGGER; Schema: public; Owner: godevman
--

CREATE TRIGGER update_custom_entities_updated_on BEFORE UPDATE ON public.custom_entities FOR EACH ROW EXECUTE FUNCTION public.update_updated_on();


--
-- Name: device_classes update_device_classes_updated_on; Type: TRIGGER; Schema: public; Owner: godevman
--

CREATE TRIGGER update_device_classes_updated_on BEFORE UPDATE ON public.device_classes FOR EACH ROW EXECUTE FUNCTION public.update_updated_on();


--
-- Name: device_credentials update_device_credentials_updated_on; Type: TRIGGER; Schema: public; Owner: godevman
--

CREATE TRIGGER update_device_credentials_updated_on BEFORE UPDATE ON public.device_credentials FOR EACH ROW EXECUTE FUNCTION public.update_updated_on();


--
-- Name: device_domains update_device_domains_updated_on; Type: TRIGGER; Schema: public; Owner: godevman
--

CREATE TRIGGER update_device_domains_updated_on BEFORE UPDATE ON public.device_domains FOR EACH ROW EXECUTE FUNCTION public.update_updated_on();


--
-- Name: device_extensions update_device_extensions_updated_on; Type: TRIGGER; Schema: public; Owner: godevman
--

CREATE TRIGGER update_device_extensions_updated_on BEFORE UPDATE ON public.device_extensions FOR EACH ROW EXECUTE FUNCTION public.update_updated_on();


--
-- Name: device_licenses update_device_licenses_updated_on; Type: TRIGGER; Schema: public; Owner: godevman
--

CREATE TRIGGER update_device_licenses_updated_on BEFORE UPDATE ON public.device_licenses FOR EACH ROW EXECUTE FUNCTION public.update_updated_on();


--
-- Name: device_states update_device_states_updated_on; Type: TRIGGER; Schema: public; Owner: godevman
--

CREATE TRIGGER update_device_states_updated_on BEFORE UPDATE ON public.device_states FOR EACH ROW EXECUTE FUNCTION public.update_updated_on();


--
-- Name: device_types update_device_types_updated_on; Type: TRIGGER; Schema: public; Owner: godevman
--

CREATE TRIGGER update_device_types_updated_on BEFORE UPDATE ON public.device_types FOR EACH ROW EXECUTE FUNCTION public.update_updated_on();


--
-- Name: devices update_devices_updated_on; Type: TRIGGER; Schema: public; Owner: godevman
--

CREATE TRIGGER update_devices_updated_on BEFORE UPDATE ON public.devices FOR EACH ROW EXECUTE FUNCTION public.update_updated_on();


--
-- Name: entities update_entities_updated_on; Type: TRIGGER; Schema: public; Owner: godevman
--

CREATE TRIGGER update_entities_updated_on BEFORE UPDATE ON public.entities FOR EACH ROW EXECUTE FUNCTION public.update_updated_on();


--
-- Name: entity_phy_indexes update_entity_indexes_updated_on; Type: TRIGGER; Schema: public; Owner: godevman
--

CREATE TRIGGER update_entity_indexes_updated_on BEFORE UPDATE ON public.entity_phy_indexes FOR EACH ROW EXECUTE FUNCTION public.update_updated_on();


--
-- Name: int_bw_stats update_int_bw_stats_updated_on; Type: TRIGGER; Schema: public; Owner: godevman
--

CREATE TRIGGER update_int_bw_stats_updated_on BEFORE UPDATE ON public.int_bw_stats FOR EACH ROW EXECUTE FUNCTION public.update_updated_on();


--
-- Name: interface_relations update_interface_relations_updated_on; Type: TRIGGER; Schema: public; Owner: godevman
--

CREATE TRIGGER update_interface_relations_updated_on BEFORE UPDATE ON public.interface_relations FOR EACH ROW EXECUTE FUNCTION public.update_updated_on();


--
-- Name: interfaces2vlans update_interfaces2vlans_updated_on; Type: TRIGGER; Schema: public; Owner: godevman
--

CREATE TRIGGER update_interfaces2vlans_updated_on BEFORE UPDATE ON public.interfaces2vlans FOR EACH ROW EXECUTE FUNCTION public.update_updated_on();


--
-- Name: interfaces update_interfaces_updated_on; Type: TRIGGER; Schema: public; Owner: godevman
--

CREATE TRIGGER update_interfaces_updated_on BEFORE UPDATE ON public.interfaces FOR EACH ROW EXECUTE FUNCTION public.update_updated_on();


--
-- Name: ip_interfaces update_ip_interfaces_updated_on; Type: TRIGGER; Schema: public; Owner: godevman
--

CREATE TRIGGER update_ip_interfaces_updated_on BEFORE UPDATE ON public.ip_interfaces FOR EACH ROW EXECUTE FUNCTION public.update_updated_on();


--
-- Name: ospf_nbrs update_ospf_nbrs_updated_on; Type: TRIGGER; Schema: public; Owner: godevman
--

CREATE TRIGGER update_ospf_nbrs_updated_on BEFORE UPDATE ON public.ospf_nbrs FOR EACH ROW EXECUTE FUNCTION public.update_updated_on();


--
-- Name: rl_nbrs update_rl_nbrs_updated_on; Type: TRIGGER; Schema: public; Owner: godevman
--

CREATE TRIGGER update_rl_nbrs_updated_on BEFORE UPDATE ON public.rl_nbrs FOR EACH ROW EXECUTE FUNCTION public.update_updated_on();


--
-- Name: sites update_sites_updated_on; Type: TRIGGER; Schema: public; Owner: godevman
--

CREATE TRIGGER update_sites_updated_on BEFORE UPDATE ON public.sites FOR EACH ROW EXECUTE FUNCTION public.update_updated_on();


--
-- Name: snmp_credentials update_snmp_credentials_updated_on; Type: TRIGGER; Schema: public; Owner: godevman
--

CREATE TRIGGER update_snmp_credentials_updated_on BEFORE UPDATE ON public.snmp_credentials FOR EACH ROW EXECUTE FUNCTION public.update_updated_on();


--
-- Name: subinterfaces update_subinterfaces_updated_on; Type: TRIGGER; Schema: public; Owner: godevman
--

CREATE TRIGGER update_subinterfaces_updated_on BEFORE UPDATE ON public.subinterfaces FOR EACH ROW EXECUTE FUNCTION public.update_updated_on();


--
-- Name: user_graphs update_user_graphs_updated_on; Type: TRIGGER; Schema: public; Owner: godevman
--

CREATE TRIGGER update_user_graphs_updated_on BEFORE UPDATE ON public.user_graphs FOR EACH ROW EXECUTE FUNCTION public.update_updated_on();


--
-- Name: users update_users_updated_on; Type: TRIGGER; Schema: public; Owner: godevman
--

CREATE TRIGGER update_users_updated_on BEFORE UPDATE ON public.users FOR EACH ROW EXECUTE FUNCTION public.update_updated_on();


--
-- Name: vars update_variables_updated_on; Type: TRIGGER; Schema: public; Owner: godevman
--

CREATE TRIGGER update_variables_updated_on BEFORE UPDATE ON public.vars FOR EACH ROW EXECUTE FUNCTION public.update_updated_on();


--
-- Name: vlans update_vlans_updated_on; Type: TRIGGER; Schema: public; Owner: godevman
--

CREATE TRIGGER update_vlans_updated_on BEFORE UPDATE ON public.vlans FOR EACH ROW EXECUTE FUNCTION public.update_updated_on();


--
-- Name: xconnects update_xconnects_updated_on; Type: TRIGGER; Schema: public; Owner: godevman
--

CREATE TRIGGER update_xconnects_updated_on BEFORE UPDATE ON public.xconnects FOR EACH ROW EXECUTE FUNCTION public.update_updated_on();


--
-- Name: connections connections_con_cap_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.connections
    ADD CONSTRAINT connections_con_cap_id_fkey FOREIGN KEY (con_cap_id) REFERENCES public.con_capacities(con_cap_id);


--
-- Name: connections connections_con_class_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.connections
    ADD CONSTRAINT connections_con_class_id_fkey FOREIGN KEY (con_class_id) REFERENCES public.con_classes(con_class_id);


--
-- Name: connections connections_con_prov_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.connections
    ADD CONSTRAINT connections_con_prov_id_fkey FOREIGN KEY (con_prov_id) REFERENCES public.con_providers(con_prov_id);


--
-- Name: connections connections_con_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.connections
    ADD CONSTRAINT connections_con_type_id_fkey FOREIGN KEY (con_type_id) REFERENCES public.con_types(con_type_id);


--
-- Name: connections connections_site_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.connections
    ADD CONSTRAINT connections_site_id_fkey FOREIGN KEY (site_id) REFERENCES public.sites(site_id);


--
-- Name: device_credentials device_credentials_dev_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.device_credentials
    ADD CONSTRAINT device_credentials_dev_id_fkey FOREIGN KEY (dev_id) REFERENCES public.devices(dev_id) ON DELETE CASCADE;


--
-- Name: device_extensions device_extensions_dev_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.device_extensions
    ADD CONSTRAINT device_extensions_dev_id_fkey FOREIGN KEY (dev_id) REFERENCES public.devices(dev_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: device_licenses device_licenses_dev_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.device_licenses
    ADD CONSTRAINT device_licenses_dev_id_fkey FOREIGN KEY (dev_id) REFERENCES public.devices(dev_id) ON DELETE CASCADE;


--
-- Name: device_states device_states_dev_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.device_states
    ADD CONSTRAINT device_states_dev_id_fkey FOREIGN KEY (dev_id) REFERENCES public.devices(dev_id) ON DELETE CASCADE;


--
-- Name: device_types device_types_class_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.device_types
    ADD CONSTRAINT device_types_class_id_fkey FOREIGN KEY (class_id) REFERENCES public.device_classes(class_id);


--
-- Name: devices devices_dom_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.devices
    ADD CONSTRAINT devices_dom_id_fkey FOREIGN KEY (dom_id) REFERENCES public.device_domains(dom_id);


--
-- Name: devices devices_parent_fkey; Type: FK CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.devices
    ADD CONSTRAINT devices_parent_fkey FOREIGN KEY (parent) REFERENCES public.devices(dev_id) ON DELETE SET NULL;


--
-- Name: devices devices_site_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.devices
    ADD CONSTRAINT devices_site_id_fkey FOREIGN KEY (site_id) REFERENCES public.sites(site_id);


--
-- Name: devices devices_snmp_main_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.devices
    ADD CONSTRAINT devices_snmp_main_id_fkey FOREIGN KEY (snmp_main_id) REFERENCES public.snmp_credentials(snmp_cred_id);


--
-- Name: devices devices_snmp_ro_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.devices
    ADD CONSTRAINT devices_snmp_ro_id_fkey FOREIGN KEY (snmp_ro_id) REFERENCES public.snmp_credentials(snmp_cred_id);


--
-- Name: devices devices_sys_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.devices
    ADD CONSTRAINT devices_sys_id_fkey FOREIGN KEY (sys_id) REFERENCES public.device_types(sys_id) ON UPDATE CASCADE;


--
-- Name: entities entities_dev_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.entities
    ADD CONSTRAINT entities_dev_id_fkey FOREIGN KEY (dev_id) REFERENCES public.devices(dev_id) ON DELETE CASCADE;


--
-- Name: entities entities_parent_ent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.entities
    ADD CONSTRAINT entities_parent_ent_id_fkey FOREIGN KEY (parent_ent_id) REFERENCES public.entities(ent_id) ON DELETE CASCADE;


--
-- Name: entity_phy_indexes entity_indexes_ent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.entity_phy_indexes
    ADD CONSTRAINT entity_indexes_ent_id_fkey FOREIGN KEY (ent_id) REFERENCES public.entities(ent_id) ON DELETE CASCADE;


--
-- Name: int_bw_stats int_bw_stats_if_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.int_bw_stats
    ADD CONSTRAINT int_bw_stats_if_id_fkey FOREIGN KEY (if_id) REFERENCES public.interfaces(if_id) ON DELETE CASCADE;


--
-- Name: interfaces2vlans interface2vlan_if_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.interfaces2vlans
    ADD CONSTRAINT interface2vlan_if_id_fkey FOREIGN KEY (if_id) REFERENCES public.interfaces(if_id) ON DELETE CASCADE;


--
-- Name: interfaces2vlans interface2vlan_v_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.interfaces2vlans
    ADD CONSTRAINT interface2vlan_v_id_fkey FOREIGN KEY (v_id) REFERENCES public.vlans(v_id) ON DELETE CASCADE;


--
-- Name: interface_relations interface_relations_if_id_down_fkey; Type: FK CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.interface_relations
    ADD CONSTRAINT interface_relations_if_id_down_fkey FOREIGN KEY (if_id_down) REFERENCES public.interfaces(if_id) ON DELETE CASCADE;


--
-- Name: interface_relations interface_relations_if_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.interface_relations
    ADD CONSTRAINT interface_relations_if_id_fkey FOREIGN KEY (if_id) REFERENCES public.interfaces(if_id) ON DELETE CASCADE;


--
-- Name: interface_relations interface_relations_if_id_up_fkey; Type: FK CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.interface_relations
    ADD CONSTRAINT interface_relations_if_id_up_fkey FOREIGN KEY (if_id_up) REFERENCES public.interfaces(if_id) ON DELETE CASCADE;


--
-- Name: interfaces interfaces_con_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.interfaces
    ADD CONSTRAINT interfaces_con_id_fkey FOREIGN KEY (con_id) REFERENCES public.connections(con_id) ON DELETE SET NULL;


--
-- Name: interfaces interfaces_dev_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.interfaces
    ADD CONSTRAINT interfaces_dev_id_fkey FOREIGN KEY (dev_id) REFERENCES public.devices(dev_id) ON DELETE CASCADE;


--
-- Name: interfaces interfaces_ent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.interfaces
    ADD CONSTRAINT interfaces_ent_id_fkey FOREIGN KEY (ent_id) REFERENCES public.entities(ent_id) ON DELETE SET NULL;


--
-- Name: interfaces interfaces_otn_if_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.interfaces
    ADD CONSTRAINT interfaces_otn_if_id_fkey FOREIGN KEY (otn_if_id) REFERENCES public.interfaces(if_id) ON DELETE SET NULL;


--
-- Name: interfaces interfaces_parent_fkey; Type: FK CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.interfaces
    ADD CONSTRAINT interfaces_parent_fkey FOREIGN KEY (parent) REFERENCES public.interfaces(if_id) ON DELETE CASCADE;


--
-- Name: ip_interfaces ip_interfaces_dev_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.ip_interfaces
    ADD CONSTRAINT ip_interfaces_dev_id_fkey FOREIGN KEY (dev_id) REFERENCES public.devices(dev_id) ON DELETE CASCADE;


--
-- Name: ospf_nbrs ospf_nbrs_dev_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.ospf_nbrs
    ADD CONSTRAINT ospf_nbrs_dev_id_fkey FOREIGN KEY (dev_id) REFERENCES public.devices(dev_id) ON DELETE CASCADE;


--
-- Name: rl_nbrs rl_nbrs_dev_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.rl_nbrs
    ADD CONSTRAINT rl_nbrs_dev_id_fkey FOREIGN KEY (dev_id) REFERENCES public.devices(dev_id) ON DELETE CASCADE;


--
-- Name: rl_nbrs rl_nbrs_nbr_ent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.rl_nbrs
    ADD CONSTRAINT rl_nbrs_nbr_ent_id_fkey FOREIGN KEY (nbr_ent_id) REFERENCES public.entities(ent_id) ON DELETE CASCADE;


--
-- Name: sites sites_country_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.sites
    ADD CONSTRAINT sites_country_id_fkey FOREIGN KEY (country_id) REFERENCES public.countries(country_id);


--
-- Name: subinterfaces subinterfaces_if_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.subinterfaces
    ADD CONSTRAINT subinterfaces_if_id_fkey FOREIGN KEY (if_id) REFERENCES public.interfaces(if_id) ON DELETE CASCADE;


--
-- Name: user_authzs user_authz_dom_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.user_authzs
    ADD CONSTRAINT user_authz_dom_id_fkey FOREIGN KEY (dom_id) REFERENCES public.device_domains(dom_id) ON DELETE CASCADE;


--
-- Name: user_authzs user_authzs_username_fkey; Type: FK CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.user_authzs
    ADD CONSTRAINT user_authzs_username_fkey FOREIGN KEY (username) REFERENCES public.users(username) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: user_graphs user_graphs_username_fkey; Type: FK CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.user_graphs
    ADD CONSTRAINT user_graphs_username_fkey FOREIGN KEY (username) REFERENCES public.users(username) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: vlans vlans_dev_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.vlans
    ADD CONSTRAINT vlans_dev_id_fkey FOREIGN KEY (dev_id) REFERENCES public.devices(dev_id) ON DELETE CASCADE;


--
-- Name: xconnects xconnects_dev_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.xconnects
    ADD CONSTRAINT xconnects_dev_id_fkey FOREIGN KEY (dev_id) REFERENCES public.devices(dev_id) ON DELETE CASCADE;


--
-- Name: xconnects xconnects_if_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.xconnects
    ADD CONSTRAINT xconnects_if_id_fkey FOREIGN KEY (if_id) REFERENCES public.interfaces(if_id) ON DELETE CASCADE;


--
-- Name: xconnects xconnects_peer_dev_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: godevman
--

ALTER TABLE ONLY public.xconnects
    ADD CONSTRAINT xconnects_peer_dev_id_fkey FOREIGN KEY (peer_dev_id) REFERENCES public.devices(dev_id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

