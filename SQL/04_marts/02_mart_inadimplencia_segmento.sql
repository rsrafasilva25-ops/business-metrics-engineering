-- View: marts.mart_inadimplencia_segmento

-- DROP VIEW marts.mart_inadimplencia_segmento;

CREATE OR REPLACE VIEW marts.mart_inadimplencia_segmento
 AS
 SELECT s.data_referencia,
    c.segmento,
    count(*) AS quantidade_faturas,
    sum(s.valor_original) AS total_faturado,
    sum(s.saldo_aberto) AS saldo_em_aberto,
    sum(
        CASE
            WHEN s.dias_atraso > 0 THEN s.saldo_aberto
            ELSE 0::numeric
        END) AS saldo_vencido,
    round(100.0 * sum(
        CASE
            WHEN s.dias_atraso > 0 THEN s.saldo_aberto
            ELSE 0::numeric
        END) / NULLIF(sum(s.valor_original), 0::numeric), 2) AS percentual_inadimplencia
   FROM intermediate.int_saldo_faturas s
     LEFT JOIN staging.stg_clientes c ON s.cliente_id = c.cliente_id
  GROUP BY s.data_referencia, c.segmento;

ALTER TABLE marts.mart_inadimplencia_segmento
    OWNER TO postgres;

