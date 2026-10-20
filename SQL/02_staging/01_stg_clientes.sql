-- View: staging.stg_clientes

-- DROP VIEW staging.stg_clientes;

CREATE OR REPLACE VIEW staging.stg_clientes
 AS
 SELECT cliente_id,
    NULLIF(TRIM(BOTH FROM nome_cliente), ''::text) AS nome_cliente,
    upper(TRIM(BOTH FROM segmento)) AS segmento,
    data_cadastro,
    upper(TRIM(BOTH FROM status_cliente)) AS status_cliente
   FROM raw.clientes;

ALTER TABLE staging.stg_clientes
    OWNER TO postgres;

