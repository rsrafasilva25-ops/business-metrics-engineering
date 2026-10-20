-- Table: raw.faturas

-- DROP TABLE IF EXISTS "raw".faturas;

CREATE TABLE IF NOT EXISTS "raw".faturas
(
    fatura_id integer NOT NULL,
    cliente_id integer,
    data_emissao date,
    data_vencimento date,
    valor_original numeric(14,2),
    status_origem character varying(30) COLLATE pg_catalog."default",
    CONSTRAINT faturas_pkey PRIMARY KEY (fatura_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".faturas
    OWNER to postgres;