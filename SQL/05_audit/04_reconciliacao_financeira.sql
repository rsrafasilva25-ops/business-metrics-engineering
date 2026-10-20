-- View: audit.reconciliacao_financeira

-- DROP VIEW audit.reconciliacao_financeira;

CREATE OR REPLACE VIEW audit.reconciliacao_financeira
 AS
 SELECT data_referencia,
    sum(valor_original) AS total_faturado,
    sum(valor_recebido) AS total_recebido_alocado,
    sum(saldo_aberto) AS saldo_em_aberto,
    sum(valor_original) - sum(valor_recebido) - sum(saldo_aberto) AS diferenca_reconciliacao,
        CASE
            WHEN abs(sum(valor_original) - sum(valor_recebido) - sum(saldo_aberto)) < 0.01 THEN 'OK'::text
            ELSE 'DIVERGENCIA'::text
        END AS status_reconciliacao
   FROM intermediate.int_saldo_faturas
  GROUP BY data_referencia;

ALTER TABLE audit.reconciliacao_financeira
    OWNER TO postgres;

