-- View: marts.mart_indicadores_financeiros

-- DROP VIEW marts.mart_indicadores_financeiros;

CREATE OR REPLACE VIEW marts.mart_indicadores_financeiros
 AS
 SELECT count(*) AS total_faturas,
    sum(valor_original) AS total_faturado,
    sum(valor_recebido) AS total_recebido,
    sum(saldo_aberto) AS saldo_em_aberto,
    sum(
        CASE
            WHEN saldo_aberto > 0::numeric AND dias_atraso > 0 THEN saldo_aberto
            ELSE 0::numeric
        END) AS total_vencido,
    count(*) FILTER (WHERE saldo_aberto > 0::numeric AND dias_atraso > 0) AS quantidade_faturas_vencidas,
    round(100.0 * sum(
        CASE
            WHEN saldo_aberto > 0::numeric AND dias_atraso > 0 THEN saldo_aberto
            ELSE 0::numeric
        END) / NULLIF(sum(valor_original), 0::numeric), 2) AS percentual_vencido_sobre_faturado
   FROM intermediate.int_saldo_faturas;

ALTER TABLE marts.mart_indicadores_financeiros
    OWNER TO postgres;

