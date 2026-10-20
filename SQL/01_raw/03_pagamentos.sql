-- Table: raw.pagamentos

-- DROP TABLE IF EXISTS "raw".pagamentos;

CREATE TABLE IF NOT EXISTS "raw".pagamentos
(
    pagamento_id integer NOT NULL,
    data_pagamento date,
    valor_pagamento numeric(14,2),
    metodo_pagamento character varying(30) COLLATE pg_catalog."default",
    CONSTRAINT pagamentos_pkey PRIMARY KEY (pagamento_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".pagamentos
    OWNER to postgres;