-- Table: raw.clientes

-- DROP TABLE IF EXISTS "raw".clientes;

CREATE TABLE IF NOT EXISTS "raw".clientes
(
    cliente_id integer NOT NULL,
    nome_cliente character varying(150) COLLATE pg_catalog."default",
    segmento character varying(50) COLLATE pg_catalog."default",
    data_cadastro date,
    status_cliente character varying(20) COLLATE pg_catalog."default",
    CONSTRAINT clientes_pkey PRIMARY KEY (cliente_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".clientes
    OWNER to postgres;