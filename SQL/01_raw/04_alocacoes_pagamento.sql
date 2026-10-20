-- Table: raw.alocacoes_pagamento

-- DROP TABLE IF EXISTS "raw".alocacoes_pagamento;

CREATE TABLE IF NOT EXISTS "raw".alocacoes_pagamento
(
    alocacao_id integer NOT NULL,
    pagamento_id integer,
    fatura_id integer,
    valor_alocado numeric(14,2),
    CONSTRAINT alocacoes_pagamento_pkey PRIMARY KEY (alocacao_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".alocacoes_pagamento
    OWNER to postgres;