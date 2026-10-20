-- View: intermediate.int_saldo_faturas

-- DROP VIEW intermediate.int_saldo_faturas;

CREATE OR REPLACE VIEW intermediate.int_saldo_faturas
 AS
 WITH pagamentos_por_fatura AS (
         SELECT stg_alocacoes_pagamento.fatura_id,
            sum(stg_alocacoes_pagamento.valor_alocado) AS valor_recebido
           FROM staging.stg_alocacoes_pagamento
          GROUP BY stg_alocacoes_pagamento.fatura_id
        ), base AS (
         SELECT f.fatura_id,
            f.cliente_id,
            f.data_emissao,
            f.data_vencimento,
            f.valor_original,
            COALESCE(p.valor_recebido, 0::numeric) AS valor_recebido,
            f.valor_original - COALESCE(p.valor_recebido, 0::numeric) AS saldo_aberto,
            CURRENT_DATE AS data_referencia
           FROM staging.stg_faturas f
             LEFT JOIN pagamentos_por_fatura p ON f.fatura_id = p.fatura_id
        )
 SELECT fatura_id,
    cliente_id,
    data_emissao,
    data_vencimento,
    valor_original,
    valor_recebido,
    saldo_aberto,
    data_referencia,
        CASE
            WHEN saldo_aberto <= 0::numeric THEN 0
            WHEN data_vencimento >= data_referencia THEN 0
            ELSE data_referencia - data_vencimento
        END AS dias_atraso,
        CASE
            WHEN saldo_aberto <= 0::numeric THEN 'Quitada'::text
            WHEN data_vencimento >= data_referencia THEN 'A vencer'::text
            WHEN (data_referencia - data_vencimento) <= 30 THEN '01 a 30 dias'::text
            WHEN (data_referencia - data_vencimento) <= 60 THEN '31 a 60 dias'::text
            WHEN (data_referencia - data_vencimento) <= 90 THEN '61 a 90 dias'::text
            ELSE 'Acima de 90 dias'::text
        END AS faixa_aging
   FROM base;

ALTER TABLE intermediate.int_saldo_faturas
    OWNER TO postgres;

