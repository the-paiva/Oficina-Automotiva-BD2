/*
Arquivo txt que contém uma série de comandos com finalidade de povoar a tabela e 
facilitar testes
*/


INSERT INTO CLIENTE VALUES
(
	1,
	'080.083.623-59',
	'henrIQUe paIvA',
	'09-12-2004',
	'86995631565',
	'hrPAIva3@gaYmail.com'
);


INSERT INTO FUNCIONARIO VALUES 
(
    1,
    '321.654.987-00',
    'ana cArOLina DOs sANtos',
    '1995-08-12',
    '99988-7766',
    'ANA.CAROLINA@EMAIL.COM'
);

DELETE FROM FUNCIONARIO;


INSERT INTO MONTADORA (cod_montadora, nome)
VALUES (1, 'chEVRolEt');


INSERT INTO modelo (cod_modelo, cod_montadora, nome, ano)
VALUES (1, 1, 'onIx', 2022);


INSERT INTO tipo_item (cod_tipo_item, nome)
VALUES (1, 'pEÇa');


INSERT INTO tipo_item (cod_tipo_item, nome)
VALUES (2, 'servIÇo');



INSERT INTO item (cod_item, cod_tipo_item, nome, preco, descricao, quantidade)
VALUES (
    1,
    1,
    'fiLTrO dE ólEo',
    45.90,
    'Filtro de óleo original para motores GM 1.0/1.4',
    20
);


INSERT INTO veiculo (cod_veiculo, cod_modelo, placa, cor)
VALUES (
	1,
	1,
	'ael1234',
	'vErmelho'
);


INSERT INTO ORDEM_SERVICO (COD_ORDEM_SERVICO, COD_CLIENTE, COD_FUNCIONARIO, COD_VEICULO, DATA_EMISSAO, VALOR, DESCONTO)
VALUES (
	1,
	1,
	1,
	1,
	NOW(),
	0,
	0
);


INSERT INTO ITEM_ORDEM(COD_ITEM_ORDEM, COD_ORDEM_SERVICO, COD_ITEM, QUANTIDADE)
VALUES
(
	1,
	1,
	1,
	5
);


INSERT INTO ITEM_ORDEM(COD_ITEM_ORDEM, COD_ORDEM_SERVICO, COD_ITEM, QUANTIDADE)
VALUES
(
	2,
	1,
	1,
	3
);


INSERT INTO ITEM_ORDEM(COD_ITEM_ORDEM, COD_ORDEM_SERVICO, COD_ITEM, QUANTIDADE)
VALUES
(
	3,
	1,
	1,
	16
);


INSERT INTO ORDEM_SERVICO
(
    COD_ORDEM_SERVICO, 
	COD_CLIENTE, 
	COD_FUNCIONARIO, 
	COD_VEICULO,
    VALOR, 
	DESCONTO
) 
VALUES 
(
    2,
	1, 
	1, 
	1, 
	0.0, 
	0.0
);


INSERT INTO CLIENTE 
(
    COD_CLIENTE, CPF, NOME, DT_NASC, TELEFONE, EMAIL
) 
VALUES 
(
    99, '000.000.000-00', 'Ailton', '1975-07-01', '99999-0000', 'ailton@timon.com'
);


INSERT INTO ORDEM_SERVICO (
    COD_ORDEM_SERVICO, COD_CLIENTE, COD_FUNCIONARIO, COD_VEICULO, DATA_EMISSAO,
    VALOR, DESCONTO
) VALUES (
    101, 1, 1, 1, '2025-07-02', 500.00, 0.00
);



UPDATE ITEM_ORDEM
SET QUANTIDADE = 4
WHERE COD_ITEM_ORDEM = 1;


DELETE
FROM ITEM_ORDEM
WHERE COD_ITEM_ORDEM = 2;


UPDATE ITEM_ORDEM
SET QUANTIDADE = 3
WHERE COD_ITEM_ORDEM = 1;


UPDATE ITEM_ORDEM
SET QUANTIDADE = 21
WHERE COD_ITEM_ORDEM = 1;


DELETE FROM ITEM_ORDEM;
DELETE FROM CLIENTE;
DELETE FROM ITEM


SELECT * FROM CLIENTE
SELECT * FROM FUNCIONARIO
SELECT * FROM MODELO
SELECT * FROM MONTADORA
SELECT * FROM ITEM
SELECT * FROM TIPO_ITEM
SELECT * FROM VEICULO
SELECT * FROM ORDEM_SERVICO
SELECT * FROM ITEM_ORDEM


SELECT INSERIR_DADOS(
    'cliente',
    'cod_cliente, cpf, nome, dt_nasc, telefone, email',
    '10, ''123.456.789-00'', ''Joana Teste'', ''2000-06-17'', ''99999-1234'', ''joana@ifpi.edu.br'''
);


SELECT INSERIR_DADOS(
    'cliente',
    'cod_cliente, cpf, nome, dt_nasc, telefone, email',
    '3, ''111.111.111-11'', ''Carlos Almeida'', ''1985-02-10'', ''99999-1001'', ''carlos@ifpi.edu.br'''
);

SELECT INSERIR_DADOS(
    'cliente',
    'cod_cliente, cpf, nome, dt_nasc, telefone, email',
    '4, ''222.222.222-22'', ''Luciana Freitas'', ''1990-07-15'', ''99999-1002'', ''luciana@ifpi.edu.br'''
);

SELECT INSERIR_DADOS(
    'cliente',
    'cod_cliente, cpf, nome, dt_nasc, telefone, email',
    '5, ''333.333.333-33'', ''Roberto Dias'', ''1978-12-03'', ''99999-1003'', ''roberto@ifpi.edu.br'''
);

SELECT INSERIR_DADOS(
    'cliente',
    'cod_cliente, cpf, nome, dt_nasc, telefone, email',
    '6, ''444.444.444-44'', ''Fernanda Costa'', ''1995-09-20'', ''99999-1004'', ''fernanda@ifpi.edu.br'''
);

SELECT INSERIR_DADOS(
    'cliente',
    'cod_cliente, cpf, nome, dt_nasc, telefone, email',
    '7, ''555.555.555-55'', ''João Batista'', ''1988-04-11'', ''99999-1005'', ''joao@ifpi.edu.br'''
);


SELECT INSERIR_DADOS(
    'funcionario',
    'cod_funcionario, cpf, nome, dt_nasc, telefone, email',
    '3, ''131.776.053-00'', ''Antônio Nivaldo'', ''1958-05-10'', ''99321-0741'', ''nini@outlook.com'''
);


SELECT INSERIR_DADOS('funcionario', 'cod_funcionario, cpf, nome, dt_nasc, telefone, email',
'4, ''999.999.999-99'', ''Renato Silva'', ''1990-10-01'', ''98888-0001'', ''carlos@oficina.com''');


SELECT INSERIR_DADOS('funcionario', 'cod_funcionario, cpf, nome, dt_nasc, telefone, email',
'5, ''888.888.888-88'', ''Débora Maria'', ''1985-07-09'', ''98888-0002'', ''debora@oficina.com''');


SELECT INSERIR_DADOS(
	'cliente',
	'cod_cliente, cpf, nome, dt_nasc, telefone, email',
	'2, ''184.212.883-34'', ''Daci'', ''1963-05-21'', ''(86)99434-5432'', ''dada@gmail.com'''
);


SELECT INSERIR_DADOS(
	'cliente',
	'cod_cliente, cpf, nome, dt_nasc, telefone, email',
	'3, ''123.456.789-00'', ''Rodrigo Sá'', ''2000-06-12'', ''(86)99563-1290'', ''rodrgsak@gaymail.com'''
);


SELECT INSERIR_DADOS(
    'funcionario',
    'cod_funcionario, cpf, nome, dt_nasc, telefone, email',
    '2, ''987.654.321-00'', ''Carlos Silva'', ''1985-03-22'', ''99888-7766'', ''carlos@ifpi.edu.br'''
);


SELECT INSERIR_DADOS(
    'montadora',
    'cod_montadora, nome',
    '2, ''FiAt'''
);


SELECT INSERIR_DADOS('montadora', 'cod_montadora, nome',
'3, ''Hyundai''');


SELECT INSERIR_DADOS('montadora', 'cod_montadora, nome',
'4, ''Mitsubishi''');


SELECT INSERIR_DADOS('montadora', 'cod_montadora, nome',
'5, ''Toyota''');


SELECT INSERIR_DADOS(
    'modelo',
    'cod_modelo, cod_montadora, nome, ano',
    '2, 2, ''Uno'', 2020'
);


SELECT INSERIR_DADOS('modelo', 'cod_modelo, cod_montadora, nome, ano',
'3, 2, ''Argo Trekking'', 2022');


SELECT INSERIR_DADOS('modelo', 'cod_modelo, cod_montadora, nome, ano',
'4, 3, ''HB20 Vision'', 2023');


SELECT INSERIR_DADOS('modelo', 'cod_modelo, cod_montadora, nome, ano',
'5, 4, ''Lancer GT'', 2020');


SELECT INSERIR_DADOS('modelo', 'cod_modelo, cod_montadora, nome, ano',
'6, 5, ''Corolla Cross'', 2023');


SELECT INSERIR_DADOS(
    'veiculo',
    'cod_veiculo, cod_modelo, placa, cor',
    '2, 2, ''abc1d23'', ''preto metálico'''
);


SELECT INSERIR_DADOS(
    'item',
    'cod_item, cod_tipo_item, nome, preco, descricao, quantidade',
    '2, 1, ''Pastilha de Freio'', 79.90, ''Pastilha dianteira para modelos até 2022'', 30'
);


SELECT INSERIR_DADOS(
    'ordem_servico',
    'cod_ordem_servico, cod_cliente, cod_funcionario, cod_veiculo, data_emissao, valor, desconto',
    '3, 2, 2, 2, ''2025-07-01'', 0.00, 0.00'
);


SELECT INSERIR_DADOS(
    'item_ordem',
    'cod_item_ordem, cod_ordem_servico, cod_item, quantidade',
    '3, 3, 2, 2'
);


SELECT INSERIR_DADOS(
    'item',
    'cod_item, cod_tipo_item, nome, preco, descricao, quantidade',
    '3, 1, ''Motor'', 207.90, ''Motorzinho vraum-vraum-vraum'', -10'
);


SELECT INSERIR_DADOS(
    'item_ordem',
    'cod_item_ordem, cod_ordem_servico, cod_item, quantidade',
    '4, 2, 2, -5'
);


SELECT INSERIR_DADOS(
    'item_ordem',
    'cod_item_ordem, cod_ordem_servico, cod_item, quantidade',
    '5, 2, 2, -5'
);


-- PASTILHA DE FREIO DIANTEIRA
SELECT INSERIR_DADOS
(
'item',
'cod_item, cod_tipo_item, nome, preco, descricao, quantidade',
'5, 1, ''Pastilha de Freio Dianteira Bosch'', 130.00, ''Compatível com linha GM e Fiat'', 40'
);

SELECT INSERIR_DADOS
(
'item', 
'cod_item, cod_tipo_item, nome, preco, descricao, quantidade',
'6, 2, ''Troca de Pastilha de Freio Dianteira'', 80.00, ''Serviço de substituição com verificação do disco'', NULL'
);


-- FILTRO DE ÓLEO
SELECT INSERIR_DADOS
(
'item',
'cod_item, cod_tipo_item, nome, preco, descricao, quantidade',
'7, 1, ''Filtro de Óleo Tecfil PSL804'', 25.00, ''Filtro compatível com Fiat, Chevrolet e Volkswagen'', 100'
);

SELECT INSERIR_DADOS
(
'item',
'cod_item, cod_tipo_item, nome, preco, descricao, quantidade',
'8, 2, ''Troca de Filtro de Óleo'', 35.00, ''Substituição do filtro com verificação do nível de óleo'', NULL'
);


-- ÓLEO DO MOTOR
SELECT INSERIR_DADOS
(
'item',
'cod_item, cod_tipo_item, nome, preco, descricao, quantidade',
'9, 1, ''Óleo 5W30 Sintético Mobil Super'', 55.00, ''Lubrificante sintético para motor flex - litro'', 200'
);

SELECT INSERIR_DADOS
(
'item',
'cod_item, cod_tipo_item, nome, preco, descricao, quantidade',
'10, 2, ''Troca de Óleo de Motor'', 50.00, ''Drenagem, substituição e descarte ambientalmente correto'', NULL'
);


-- FILTRO DE AR CONDICIONADO
SELECT INSERIR_DADOS
(
'item',
'cod_item, cod_tipo_item, nome, preco, descricao, quantidade',
'11, 1, ''Filtro de Cabine Ar Condicionado Wega'', 40.00, ''Retém impurezas do ar interno do veículo'', 60'
);

SELECT INSERIR_DADOS
(
'item',
'cod_item, cod_tipo_item, nome, preco, descricao, quantidade',
'12, 2, ''Troca de Filtro do Ar Condicionado'', 30.00, ''Desmontagem do porta-luvas e substituição do filtro'', NULL'
);


-- BATERIA 60AH
SELECT INSERIR_DADOS(
'item',
'cod_item, cod_tipo_item, nome, preco, descricao, quantidade',
'13, 1, ''Bateria Moura 60Ah'', 420.00, ''Bateria automotiva com 18 meses de garantia'', 15'
);

SELECT INSERIR_DADOS
(
'item',
'cod_item, cod_tipo_item, nome, preco, descricao, quantidade',
'14, 2, ''Troca de Bateria'', 25.00, ''Teste de carga e substituição da bateria'', NULL'
);


-- PNEU 175/65 R14
SELECT INSERIR_DADOS
(
'item',
'cod_item, cod_tipo_item, nome, preco, descricao, quantidade',
'15, 1, ''Pneu 175/65 R14 Goodyear Aro 14'', 310.00, ''Pneu radial para carros compactos, índice de carga 82T'', 30'
);

SELECT INSERIR_DADOS
(
'item',
'cod_item, cod_tipo_item, nome, preco, descricao, quantidade',
'16, 2, ''Montagem e Balanceamento de Pneu'', 60.00, ''Montagem, enchimento e balanceamento com contrapeso'', NULL'
);


SELECT ATUALIZAR_DADOS(
    'cliente',
    'nome = ''Joana Atualizada'', telefone = ''99999-0000''',
    'cod_cliente = 10'
);


SELECT ATUALIZAR_DADOS(
    'funcionario',
    'nome = ''Carlos Souza'', email = ''carlosnovo@ifpi.edu.br''',
    'cod_funcionario = 1'
);


SELECT ATUALIZAR_DADOS(
    'funcionario',
    'dt_nasc = ''1990-07-04''',
    'cod_funcionario IN(1, 2)'
);


SELECT ATUALIZAR_DADOS(
    'montadora',
    'nome = ''Fiat India''',
    'cod_montadora = 2'
);


SELECT INSERIR_DADOS('veiculo', 'cod_veiculo, cod_modelo, placa, cor',
'3, 2, ''XYZ2E45'', ''vermelho''');  -- Fiat Argo


SELECT INSERIR_DADOS('veiculo', 'cod_veiculo, cod_modelo, placa, cor',
'4, 3, ''HYU3F67'', ''azul''');  -- Hyundai HB20


SELECT INSERIR_DADOS('veiculo', 'cod_veiculo, cod_modelo, placa, cor',
'5, 4, ''MIT4G89'', ''preto''');  -- Mitsubishi Lancer


SELECT INSERIR_DADOS('veiculo', 'cod_veiculo, cod_modelo, placa, cor',
'6, 5, ''TOY5H01'', ''branco''');  -- Toyota Corolla Cross


SELECT INSERIR_DADOS('item', 'cod_item, cod_tipo_item, nome, preco, descricao, quantidade',
'3, 2, ''Alinhamento e Balanceamento'', 80.00, ''Serviço completo de alinhamento 3D'', NULL');

SELECT INSERIR_DADOS('item', 'cod_item, cod_tipo_item, nome, preco, descricao, quantidade',
'4, 1, ''Filtro de Ar Motor'', 45.00, ''Filtro para Toyota Corolla Cross'', 50');


SELECT INSERIR_DADOS
(
'ordem_servico', 
'cod_ordem_servico, cod_cliente, cod_funcionario, cod_veiculo, data_emissao, valor, desconto',
'4, 5, 4, 1, ''2025-07-17'', 0.00, 0.00'
);


SELECT INSERIR_DADOS
(
'ordem_servico', 
'cod_ordem_servico, cod_cliente, cod_funcionario, cod_veiculo, data_emissao, valor, desconto',
'5, 4, 3, 2, ''2025-07-17'', 0.00, 0.00'
);


SELECT INSERIR_DADOS
(
'item_ordem',
'cod_item_ordem, cod_ordem_servico, cod_item, quantidade',
'5, 4, 1, 2'
);


SELECT INSERIR_DADOS
(
'item_ordem',
'cod_item_ordem, cod_ordem_servico, cod_item, quantidade',
'6, 5, 2, 1'
);


SELECT INSERIR_DADOS
(
'item_ordem',
'cod_item_ordem, cod_ordem_servico, cod_item, quantidade',
'7, 3, 3, 3'
);


SELECT ATUALIZAR_DADOS(
    'modelo',
    'nome = ''Onix Plus'', ano = 2023',
    'cod_modelo = 1'
);


SELECT ATUALIZAR_DADOS(
    'veiculo',
    'cor = ''branco pérola''',
    'cod_veiculo = 1'
);


SELECT ATUALIZAR_DADOS
(
    'item',
    'preco = 89.90, quantidade = 25',
    'cod_item = 2'
);


SELECT ATUALIZAR_DADOS
(
    'item',
    'quantidade = 30',
    'cod_item = 2'
);


SELECT ATUALIZAR_DADOS
(
    'ordem_servico',
    'cod_funcionario = 2, desconto = 40.50',
    'cod_ordem_servico = 1'
);


SELECT ATUALIZAR_DADOS
(
    'ordem_servico',
    'desconto = 50',
    'cod_ordem_servico = 1'
);


SELECT ATUALIZAR_DADOS
(
    'item_ordem',
    'quantidade = 5',
    'cod_item_ordem = 1'
);



CREATE OR REPLACE VIEW TABELA_OS_COM_VALOR_FINAL AS
SELECT *, VALOR - DESCONTO AS VALOR_FINAL
FROM ORDEM_SERVICO;


SELECT *
FROM TABELA_OS_COM_VALOR_FINAL
WHERE COD_ORDEM_SERVICO = 1;



SELECT ATUALIZAR_DADOS
(
    'item_ordem',
    'quantidade = 3',
    'cod_item_ordem = 1'
);


SELECT ATUALIZAR_DADOS
(
    'item_ordem',
    'quantidade = 5',
    'cod_item_ordem = 4'
);


SELECT DELETAR_DADOS
(
	'cliente',
	'cod_cliente = 99'
)


SELECT DELETAR_DADOS
(
	'item',
	'cod_item = 3'
);


SELECT DELETAR_DADOS
(
	'log_registro',
	NULL
);


SELECT INSERIR_DADOS(
	'cliente',
	'cod_cliente, cpf, nome, dt_nasc, telefone, email',
	'8, ''888.888.888-88'', ''Creuza Martins'', ''1968-03-25'', ''(86)99999-1006'', ''creucreu@gmail.com'''
);


SELECT ATUALIZAR_DADOS(
    'cliente',
    'nome = ''Darcy''',
    'cpf = ''184.212.883-34'' '
);


SELECT ATUALIZAR_DADOS(
    'funcionario',
    'nome = ''Antônio Ribeiro''',
    'cod_funcionario = 3'
);


SELECT ATUALIZAR_DADOS(
    'modelo',
    'ano = 2021',
    'cod_modelo = 2'
);


SELECT ATUALIZAR_DADOS(
    'montadora',
    'nome = ''Fiat''',
    'cod_montadora = 2'
);


SELECT ATUALIZAR_DADOS(
    'item',
    'preco = 85',
    'cod_item = 3'
);


SELECT ATUALIZAR_DADOS(
    'item_ordem',
    'quantidade = 3',
    'cod_item_ordem = 3'
);


