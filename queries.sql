-----------------------------------------------------------------------------------------
--								 CRIAÇÃO DE VIEWS
-----------------------------------------------------------------------------------------


-- Retorna as ordens de serviço com o valor final (valor total - desconto)
CREATE OR REPLACE VIEW TABELA_OS_COM_VALOR_FINAL AS
SELECT *, VALOR - (VALOR * DESCONTO_PERCENTUAL / 100) AS VALOR_FINAL
FROM ORDEM_SERVICO;


-- Retorna a lista de clientes por quantidade de ordens de serviços em ordem decrescente
CREATE OR REPLACE VIEW vw_clientes_mais_ordens AS
SELECT 
    c.nome AS cliente,
    COUNT(o.cod_ordem_servico) AS total_ordens
FROM 
    cliente c
JOIN 
    ordem_servico o ON c.cod_cliente = o.cod_cliente
GROUP BY 
    c.nome
ORDER BY 
    total_ordens DESC;


-- Retorna a lista de itens por quantidade usada em ordem decrescente
CREATE OR REPLACE VIEW vw_itens_mais_usados AS
SELECT 
    i.nome AS item,
    SUM(io.quantidade) AS total_usado
FROM 
    item i
JOIN 
    item_ordem io ON i.cod_item = io.cod_item
GROUP BY 
    i.nome
ORDER BY 
    total_usado DESC;


/*
Retorna o quanto cada funcionário faturou de acordo com os valores de suas respectivas
ordens de serviço
*/
CREATE OR REPLACE VIEW vw_faturamento_funcionario AS
SELECT 
    f.nome AS funcionario,
    COUNT(o.cod_ordem_servico) AS ordens_emitidas,
    ROUND(SUM((o.valor - o.desconto)::NUMERIC), 2) AS valor_total_recebido
FROM 
    funcionario f
JOIN 
    ordem_servico o ON f.cod_funcionario = o.cod_funcionario
GROUP BY 
    f.nome
ORDER BY 
    valor_total_recebido DESC;


/*
Retorna a lista de itens e suas respectivas quantidades, avisando também sobre a
situação do estoque (se está OK ou com baixo estoque)
*/
CREATE OR REPLACE VIEW vw_estoque_itens AS
SELECT 
    cod_item,
    nome,
    quantidade,
    CASE 
        WHEN quantidade < 5 THEN 
			'⚠️ Baixo Estoque'
        ELSE 
			'OK'
    END AS status_estoque
FROM item
ORDER BY quantidade ASC;


-- Retorna o faturamento total da oficina de cada mês
CREATE OR REPLACE VIEW vw_faturamento_mensal AS
SELECT 
    TO_CHAR(data_emissao, 'TMMonth') AS mes_nome,
    EXTRACT(YEAR FROM data_emissao) AS ano,
    COUNT(*) AS total_ordens,
    ROUND(SUM(valor - desconto)::NUMERIC, 2) AS faturamento
FROM ordem_servico
GROUP BY mes_nome, ano
ORDER BY ano DESC, mes_nome;


-- Retorna as ordens de serviço com seus respectivos descontos em ordem decrescente
CREATE OR REPLACE VIEW vw_ordens_maior_desconto AS
SELECT 
    o.cod_ordem_servico,
    c.nome AS cliente,
    o.valor,
    o.desconto,
    ROUND(((o.desconto / o.valor) * 100)::NUMERIC, 2) AS percentual_desconto
FROM ordem_servico o
JOIN cliente c ON o.cod_cliente = c.cod_cliente
WHERE o.valor > 0
ORDER BY percentual_desconto DESC;


-- Log simplificado para verificar as 50 operações mais recentes do sistema
CREATE OR REPLACE VIEW vw_logs_recentes AS
SELECT 
    id,
    tabela_nome,
    operacao,
    chave_primaria,
    usuario,
    data_log
FROM log_registro
ORDER BY data_log DESC
LIMIT 50;


-- Associa clientes aos seus respectivos veículos
CREATE OR REPLACE VIEW vw_veiculos_clientes AS
SELECT DISTINCT
	c.nome AS cliente,
    v.cod_veiculo,
    v.placa,
    v.cor,
    m.nome AS modelo,
    mo.nome AS montadora
FROM veiculo v
JOIN modelo m ON m.cod_modelo = v.cod_modelo
JOIN montadora mo ON mo.cod_montadora = m.cod_montadora
JOIN ordem_servico os ON os.cod_veiculo = v.cod_veiculo
JOIN cliente c ON c.cod_cliente = os.cod_cliente;


-- Registro de todas as operações realizadas por um usuário no sistema
CREATE OR REPLACE VIEW vw_auditoria_usuario AS
SELECT usuario, tabela_nome, operacao, chave_primaria, data_log
FROM log_registro
ORDER BY data_log DESC;


-----------------------------------------------------------------------------------------
--									   CONSULTAS
-----------------------------------------------------------------------------------------


SELECT * FROM CLIENTE
SELECT * FROM FUNCIONARIO
SELECT * FROM MODELO
SELECT * FROM MONTADORA
SELECT * FROM ITEM
SELECT * FROM TIPO_ITEM
SELECT * FROM VEICULO
SELECT * FROM ORDEM_SERVICO
SELECT * FROM ITEM_ORDEM
SELECT * FROM STATUS


SELECT *
FROM TABELA_OS_COM_VALOR_FINAL
WHERE COD_ORDEM_SERVICO = 1;


SELECT * FROM vw_faturamento_mensal
SELECT * FROM vw_clientes_mais_ordens
SELECT * FROM vw_itens_mais_usados
SELECT * FROM vw_faturamento_funcionario
SELECT * FROM vw_logs_recentes
SELECT * FROM vw_veiculos_clientes ORDER BY cliente ASC;
SELECT * FROM vw_auditoria_usuario
SELECT * FROM ITENS_DA_ORDEM(1)
SELECT * FROM ITEM

