-- FUNCTION: audit.executar_testes_qualidade()

-- DROP FUNCTION IF EXISTS audit.executar_testes_qualidade();

CREATE OR REPLACE FUNCTION audit.executar_testes_qualidade(
	)
    RETURNS TABLE(teste character varying, quantidade integer, resultado character varying) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
DECLARE
    v_execucao_id BIGINT;
    v_total_falhas INTEGER := 0;
BEGIN
    -- Cria o registro da execucao.
    INSERT INTO audit.execucoes_testes (
        iniciado_em,
        status_geral
    )
    VALUES (
        CURRENT_TIMESTAMP,
        'PASSOU'
    )
    RETURNING execucao_id INTO v_execucao_id;

    -- Registra os resultados vinculados a essa execucao.
    INSERT INTO audit.resultados_testes (
        execucao_id,
        nome_teste,
        quantidade_falhas,
        status
    )
    SELECT
        v_execucao_id,
        v.teste,
        v.quantidade,
        CASE
            WHEN v.quantidade = 0 THEN 'PASSOU'
            ELSE 'FALHOU'
        END
    FROM audit.validacao_qualidade v;

    -- Soma as falhas encontradas.
    SELECT COALESCE(SUM(v.quantidade), 0)
    INTO v_total_falhas
    FROM audit.validacao_qualidade v;

    -- Atualiza o status final da execucao.
    UPDATE audit.execucoes_testes
    SET
        finalizado_em = CURRENT_TIMESTAMP,
        status_geral = CASE
            WHEN v_total_falhas = 0 THEN 'PASSOU'
            ELSE 'FALHOU'
        END
    WHERE execucao_id = v_execucao_id;

    -- Retorna o resumo dos testes.
    RETURN QUERY
    SELECT
        v.teste::VARCHAR,
        v.quantidade::INTEGER,
        (
            CASE
                WHEN v.quantidade = 0 THEN 'PASSOU'
                ELSE 'FALHOU'
            END
        )::VARCHAR
    FROM audit.validacao_qualidade v;
END;
$BODY$;

ALTER FUNCTION audit.executar_testes_qualidade()
    OWNER TO postgres;

