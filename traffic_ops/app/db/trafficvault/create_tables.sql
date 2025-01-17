/*
    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/

--
-- PostgreSQL database dump
--

-- Dumped from database version 13.1
-- Dumped by pg_dump version 13.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner:
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


SET search_path = public, pg_catalog;

--
-- Name: on_update_current_timestamp_last_updated(); Type: FUNCTION; Schema: public; Owner: traffic_vault
--

CREATE OR REPLACE FUNCTION on_update_current_timestamp_last_updated() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  NEW.last_updated = now();
  RETURN NEW;
END;
$$;


ALTER FUNCTION on_update_current_timestamp_last_updated() OWNER TO traffic_vault;

SET default_tablespace = '';

--
-- Name: dnssec; Type: TABLE; Schema: public; Owner: traffic_vault
--

CREATE TABLE IF NOT EXISTS dnssec (
    cdn text NOT NULL,
    data bytea NOT NULL,
    last_updated timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE dnssec OWNER TO traffic_vault;

--
-- Name: sslkey; Type: TABLE; Schema: public; Owner: traffic_vault
--

CREATE TABLE IF NOT EXISTS sslkey (
    data bytea NOT NULL,
    deliveryservice text NOT NULL,
    cdn text NOT NULL,
    version text NOT NULL,
    last_updated timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE sslkey OWNER TO traffic_vault;



--
-- Name: uri_signing_key; Type: TABLE; Schema: public; Owner: traffic_vault
--

CREATE TABLE IF NOT EXISTS uri_signing_key (
    deliveryservice text NOT NULL,
    data bytea NOT NULL,
    last_updated timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE uri_signing_key OWNER TO traffic_vault;

--
-- Name: url_sig_key; Type: TABLE; Schema: public; Owner: traffic_vault
--

CREATE TABLE IF NOT EXISTS url_sig_key (
    deliveryservice text NOT NULL,
    data bytea NOT NULL,
    last_updated timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE url_sig_key OWNER TO traffic_vault;

--
-- Name: dnssec dnssec_pkey; Type: CONSTRAINT; Schema: public; Owner: traffic_vault
--

ALTER TABLE ONLY dnssec
    ADD CONSTRAINT dnssec_pkey PRIMARY KEY (cdn);


--
-- Name: sslkey sslkey_pkey; Type: CONSTRAINT; Schema: public; Owner: traffic_vault
--

ALTER TABLE ONLY sslkey
    ADD CONSTRAINT sslkey_pkey PRIMARY KEY (deliveryservice, cdn, version);


--
-- Name: uri_signing_key uri_signing_key_pkey; Type: CONSTRAINT; Schema: public; Owner: traffic_vault
--

ALTER TABLE ONLY uri_signing_key
    ADD CONSTRAINT uri_signing_key_pkey PRIMARY KEY (deliveryservice);


--
-- Name: url_sig_key url_sig_key_pkey; Type: CONSTRAINT; Schema: public; Owner: traffic_vault
--

ALTER TABLE ONLY url_sig_key
    ADD CONSTRAINT url_sig_key_pkey PRIMARY KEY (deliveryservice);


--
-- Name: sslkey_cdn_idx; Type: INDEX; Schema: public; Owner: traffic_vault
--

CREATE INDEX sslkey_cdn_idx ON sslkey USING btree (cdn);


--
-- Name: sslkey_deliveryservice_idx; Type: INDEX; Schema: public; Owner: traffic_vault
--

CREATE INDEX sslkey_deliveryservice_idx ON sslkey USING btree (deliveryservice);


--
-- Name: sslkey_version_idx; Type: INDEX; Schema: public; Owner: traffic_vault
--

CREATE INDEX sslkey_version_idx ON sslkey USING btree (version);


--
-- Name: dnssec dnssec_last_updated; Type: TRIGGER; Schema: public; Owner: traffic_vault
--

CREATE TRIGGER dnssec_last_updated BEFORE UPDATE ON dnssec FOR EACH ROW EXECUTE PROCEDURE on_update_current_timestamp_last_updated();


--
-- Name: sslkey sslkey_last_updated; Type: TRIGGER; Schema: public; Owner: traffic_vault
--

CREATE TRIGGER sslkey_last_updated BEFORE UPDATE ON sslkey FOR EACH ROW EXECUTE PROCEDURE on_update_current_timestamp_last_updated();


--
-- Name: uri_signing_key uri_signing_key_last_updated; Type: TRIGGER; Schema: public; Owner: traffic_vault
--

CREATE TRIGGER uri_signing_key_last_updated BEFORE UPDATE ON uri_signing_key FOR EACH ROW EXECUTE PROCEDURE on_update_current_timestamp_last_updated();


--
-- Name: url_sig_key url_sig_key_last_updated; Type: TRIGGER; Schema: public; Owner: traffic_vault
--

CREATE TRIGGER url_sig_key_last_updated BEFORE UPDATE ON url_sig_key FOR EACH ROW EXECUTE PROCEDURE on_update_current_timestamp_last_updated();


--
-- PostgreSQL database dump complete
--

