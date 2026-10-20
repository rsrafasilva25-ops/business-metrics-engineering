-- View: audit.validacao_integridade_financeira

-- DROP VIEW audit.validacao_integridade_financeira;

CREATE OR REPLACE VIEW audit.validacao_integridade_financeira
 AS
 SELECT 'PAGAMENTO_VALOR_INVALIDO'::text AS teste,
    stg_pagamentos.pagamento_id::text AS registro,
    stg_pagamentos.valor_pagamento AS valor,
    'Pagamento nulo, zero ou negativo'::text AS problema
   FROM staging.stg_pagamentos
  WHERE stg_pagamentos.valor_pagamento IS NULL OR stg_pagamentos.valor_pagamento <= 0::numeric
UNION ALL
 SELECT 'ALOCACAO_VALOR_INVALIDO'::text AS teste,
    stg_alocacoes_pagamento.alocacao_id::text AS registro,
    stg_alocacoes_pagamento.valor_alocado AS valor,
    'Alocacao nula, zero ou negativa'::text AS problema
   FROM staging.stg_alocacoes_pagamento
  WHERE stg_alocacoes_pagamento.valor_alocado IS NULL OR stg_alocacoes_pagamento.valor_alocado <= 0::numeric
UNION ALL
 SELECT 'PAGAMENTO_SUPERALOCADO'::text AS teste,
    p.pagamento_id::text AS registro,
    sum(a.valor_alocado) AS valor,
    'Total alocado maior que o pagamento'::text AS problema
   FROM staging.stg_pagamentos p
     JOIN staging.stg_alocacoes_pagamento a ON p.pagamento_id = a.pagamento_id
  GROUP BY p.pagamento_id, p.valor_pagamento
 HAVING sum(a.valor_alocado) > p.valor_pagamento
UNION ALL
 SELECT 'FATURA_SUPERALOCADA'::text AS teste,
    f.fatura_id::text AS registro,
    sum(a.valor_alocado) AS valor,
    'Total alocado maior que o valor da fatura'::text AS problema
   FROM staging.stg_faturas f
     JOIN staging.stg_alocacoes_pagamento a ON f.fatura_id = a.fatura_id
  GROUP BY f.fatura_id, f.valor_original
 HAVING sum(a.valor_alocado) > f.valor_original;

ALTER TABLE audit.validacao_integridade_financeira
    OWNER TO postgres;

