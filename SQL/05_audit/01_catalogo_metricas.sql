-- Table: audit.catalogo_metricas

-- DROP TABLE IF EXISTS audit.catalogo_metricas;

CREATE TABLE IF NOT EXISTS audit.catalogo_metricas
(
    metrica_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    nome_metrica character varying(100) COLLATE pg_catalog."default" NOT NULL,
    descricao text COLLATE pg_catalog."default" NOT NULL,
    regra_calculo text COLLATE pg_catalog."default" NOT NULL,
    unidade character varying(30) COLLATE pg_catalog."default" NOT NULL,
    responsavel character varying(100) COLLATE pg_catalog."default",
    atualizado_em timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT catalogo_metricas_pkey PRIMARY KEY (metrica_id),
    CONSTRAINT catalogo_metricas_nome_metrica_key UNIQUE (nome_metrica)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS audit.catalogo_metricas
    OWNER to postgres;