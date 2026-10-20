-- Table: audit.execucoes_testes

-- DROP TABLE IF EXISTS audit.execucoes_testes;

CREATE TABLE IF NOT EXISTS audit.execucoes_testes
(
    execucao_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    iniciado_em timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    finalizado_em timestamp without time zone,
    status_geral character varying(10) COLLATE pg_catalog."default",
    CONSTRAINT execucoes_testes_pkey PRIMARY KEY (execucao_id),
    CONSTRAINT execucoes_testes_status_geral_check CHECK (status_geral::text = ANY (ARRAY['PASSOU'::character varying, 'FALHOU'::character varying]::text[]))
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS audit.execucoes_testes
    OWNER to postgres;