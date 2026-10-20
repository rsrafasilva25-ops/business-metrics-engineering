-- View: staging.stg_faturas

-- DROP VIEW staging.stg_faturas;

CREATE OR REPLACE VIEW staging.stg_faturas
 AS
 SELECT fatura_id,
    cliente_id,
    data_emissao,
    data_vencimento,
    valor_original,
    upper(TRIM(BOTH FROM status_origem)) AS status_origem
   FROM raw.faturas;

ALTER TABLE staging.stg_faturas
    OWNER TO postgres;

