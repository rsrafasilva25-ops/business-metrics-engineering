-- View: audit.validacao_qualidade

-- DROP VIEW audit.validacao_qualidade;

CREATE OR REPLACE VIEW audit.validacao_qualidade
 AS
 SELECT 'CLIENTE_SEM_NOME'::text AS teste,
    count(*) AS quantidade
   FROM staging.stg_clientes
  WHERE stg_clientes.nome_cliente IS NULL
UNION ALL
 SELECT 'FATURA_VALOR_INVALIDO'::text AS teste,
    count(*) AS quantidade
   FROM staging.stg_faturas
  WHERE stg_faturas.valor_original IS NULL OR stg_faturas.valor_original <= 0::numeric
UNION ALL
 SELECT 'VENCIMENTO_ANTERIOR_EMISSAO'::text AS teste,
    count(*) AS quantidade
   FROM staging.stg_faturas
  WHERE stg_faturas.data_vencimento < stg_faturas.data_emissao
UNION ALL
 SELECT 'ALOCACAO_SEM_PAGAMENTO'::text AS teste,
    count(*) AS quantidade
   FROM staging.stg_alocacoes_pagamento a
     LEFT JOIN staging.stg_pagamentos p ON a.pagamento_id = p.pagamento_id
  WHERE p.pagamento_id IS NULL
UNION ALL
 SELECT 'ALOCACAO_SEM_FATURA'::text AS teste,
    count(*) AS quantidade
   FROM staging.stg_alocacoes_pagamento a
     LEFT JOIN staging.stg_faturas f ON a.fatura_id = f.fatura_id
  WHERE f.fatura_id IS NULL;

ALTER TABLE audit.validacao_qualidade
    OWNER TO postgres;

