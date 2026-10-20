# Business Metrics Engineering

## Sobre o projeto

Projeto de engenharia e análise de dados desenvolvido em PostgreSQL para demonstrar como dados financeiros podem ser estruturados, tratados, validados e transformados em indicadores confiáveis para apoiar decisões de negócio.

O projeto utiliza dados fictícios de clientes, faturas, pagamentos e alocações financeiras.

## Objetivos

- Estruturar dados em camadas com responsabilidades definidas.
- Padronizar informações e aplicar regras de negócio em SQL.
- Calcular saldos em aberto, valores vencidos e indicadores financeiros.
- Analisar a inadimplência por segmento de clientes.
- Implementar verificações de qualidade, integridade e reconciliação financeira.

## Arquitetura

O projeto está organizado em cinco camadas:

- **raw:** tabelas com os dados de origem.
- **staging:** views para padronização e preparação dos dados.
- **intermediate:** regras de cálculo de recebimentos, saldos, atrasos e aging.
- **marts:** indicadores financeiros e análises por segmento.
- **audit:** catálogo de métricas, testes de qualidade, integridade e reconciliação.

## Indicadores implementados

- Total faturado.
- Total recebido por alocação às faturas.
- Saldo financeiro em aberto.
- Saldo vencido.
- Quantidade de faturas vencidas.
- Percentual do saldo vencido sobre o total faturado.
- Inadimplência por segmento de clientes.

## Qualidade e validação

O projeto inclui testes para identificar inconsistências cadastrais, valores inválidos, datas incoerentes e alocações sem correspondência com pagamentos ou faturas.

Também inclui validações de integridade financeira e reconciliação entre os valores faturados, recebidos e em aberto.

Na execução validada em 19/10/2026, os cinco testes de qualidade foram aprovados, sem falhas, e a reconciliação financeira apresentou status OK.

## Tecnologias

- PostgreSQL
- SQL
- Modelagem de dados
- Indicadores financeiros
- Testes de qualidade e reconciliação de dados

## Observação

Este é um projeto de portfólio desenvolvido com dados sintéticos. Os resultados demonstram a aplicação de regras de negócio e técnicas de validação, não resultados financeiros de uma empresa real.

## Próximos passos

- Documentar a execução completa do projeto do zero.
- Ampliar os cenários de teste com dados inconsistentes.
- Integrar os indicadores a um dashboard no Power BI.
- Evoluir a documentação técnica e o versionamento dos scripts.
