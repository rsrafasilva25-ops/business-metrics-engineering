-- View: staging.stg_alocacoes_pagamento

-- DROP VIEW staging.stg_alocacoes_pagamento;

CREATE OR REPLACE VIEW staging.stg_alocacoes_pagamento
 AS
 SELECT alocacao_id,
    pagamento_id,
    fatura_id,
    valor_alocado
   FROM raw.alocacoes_pagamento;

ALTER TABLE staging.stg_alocacoes_pagamento
    OWNER TO postgres;

