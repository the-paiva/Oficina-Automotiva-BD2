/*
Arquivo que contém uma série de comandos com a finalidade de povoar a tabela e 
facilitar testes
*/


-----------------------------------------------------------------------------------------
--										INSERTS
-----------------------------------------------------------------------------------------


SELECT INSERIR_DADOS
(
	'cliente',
	'cod_cliente, cpf, nome, dt_nasc, telefone, email',
	'1, ''080.083.623-59'', ''henrIQUe paIvA'', ''2004-12-09'', ''86995631565'', ''hrPAIva3@gMail.com'''
);


SELECT INSERIR_DADOS
(
	'cliente',
	'cod_cliente, cpf, nome, dt_nasc, telefone, email',
	'2, ''184.212.883-34'', ''Daci'', ''1963-05-21'', ''(86)99434-5432'', ''dada@gmail.com'''
);


SELECT INSERIR_DADOS
(
    'cliente',
    'cod_cliente, cpf, nome, dt_nasc, telefone, email',
    '3, ''111.111.111-11'', ''Carlos Almeida'', ''1985-02-10'', ''99999-1001'', ''carlos@ifpi.edu.br'''
);


SELECT INSERIR_DADOS
(
    'cliente',
    'cod_cliente, cpf, nome, dt_nasc, telefone, email',
    '4, ''222.222.222-22'', ''Luciana Freitas'', ''1990-07-15'', ''99999-1002'', ''luciana@ifpi.edu.br'''
);


SELECT INSERIR_DADOS
(
    'cliente',
    'cod_cliente, cpf, nome, dt_nasc, telefone, email',
    '5, ''333.333.333-33'', ''Roberto Dias'', ''1978-12-03'', ''99999-1003'', ''roberto@ifpi.edu.br'''
);


SELECT INSERIR_DADOS
(
    'cliente',
    'cod_cliente, cpf, nome, dt_nasc, telefone, email',
    '6, ''444.444.444-44'', ''Fernanda Costa'', ''1995-09-20'', ''99999-1004'', ''fernanda@ifpi.edu.br'''
);


SELECT INSERIR_DADOS
(
    'cliente',
    'cod_cliente, cpf, nome, dt_nasc, telefone, email',
    '7, ''555.555.555-55'', ''João Batista'', ''1988-04-11'', ''99999-1005'', ''joao@ifpi.edu.br'''
);


SELECT INSERIR_DADOS(
	'cliente',
	'cod_cliente, cpf, nome, dt_nasc, telefone, email',
	'8, ''888.888.888-88'', ''Creuza Martins'', ''1968-03-25'', ''(86)99999-1006'', ''creucreu@gmail.com'''
);


SELECT INSERIR_DADOS
(
	'cliente',
	'cod_cliente, cpf, nome, dt_nasc, telefone, email',
	'9, ''123.456.789-00'', ''Rodrigo Sá'', ''2000-06-12'', ''(86)99563-1290'', ''rodrgsak@gaymail.com'''
);


SELECT INSERIR_DADOS
(
    'cliente',
    'cod_cliente, cpf, nome, dt_nasc, telefone, email',
    '10, ''123.456.789-00'', ''Joana Teste'', ''2000-06-17'', ''99999-1234'', ''joana@ifpi.edu.br'''
);


SELECT INSERIR_DADOS(
    'cliente',
    'cod_cliente, cpf, nome, dt_nasc, telefone, email',
    '11, ''756-643-872-98'', ''Lucas Silva'', ''1998-02-15'', ''(86)98154-1873'', ''lucasilva@gmail.com'''
);

SELECT INSERIR_DADOS(
    'cliente',
    'cod_cliente, cpf, nome, dt_nasc, telefone, email',
    '12, ''123-456-789-00'', ''Ana Beatriz'', ''1995-07-22'', ''(86)98888-1122'', ''ana.b@gmail.com'''
);

SELECT INSERIR_DADOS(
    'cliente',
    'cod_cliente, cpf, nome, dt_nasc, telefone, email',
    '13, ''234-567-890-11'', ''João Pedro'', ''1987-11-03'', ''(86)98765-4433'', ''joaop@gmail.com'''
);

SELECT INSERIR_DADOS(
    'cliente',
    'cod_cliente, cpf, nome, dt_nasc, telefone, email',
    '14, ''345-678-901-22'', ''Carla Mendes'', ''2001-03-09'', ''(86)99999-0000'', ''carlam@hotmail.com'''
);

SELECT INSERIR_DADOS(
    'cliente',
    'cod_cliente, cpf, nome, dt_nasc, telefone, email',
    '15, ''456-789-012-33'', ''Felipe Andrade'', ''1990-12-30'', ''(86)99123-4567'', ''felipea@gmail.com'''
);


SELECT INSERIR_DADOS(
    'cliente',
    'cod_cliente, cpf, nome, dt_nasc, telefone, email',
    '16, ''567-890-123-44'', ''Mariana Costa'', ''1993-06-18'', ''(86)99444-5566'', ''maricosta@gmail.com'''
);


SELECT INSERIR_DADOS(
    'cliente',
    'cod_cliente, cpf, nome, dt_nasc, telefone, email',
    '17, ''440-550-660-77'', ''Marina Aguiar'', ''1981-08-27'', ''(86)99666-4554'', ''maguiar@hotmail.com'''
);


SELECT INSERIR_DADOS(
    'cliente',
    'cod_cliente, cpf, nome, dt_nasc, telefone, email',
    '17, ''567-890-123-44'', ''Mariana Costa'', ''1993-06-18'', ''(86)99444-5566'', ''maricosta@gmail.com'''
);


SELECT INSERIR_DADOS
(
	'cliente',
	'cod_cliente, cpf, nome, dt_nasc, telefone, email',
	'99, ''000.000.000-00'', ''Ailton'', ''1975-07-01'', ''99999-0000'', ''ailton@timon.com'''
);


SELECT INSERIR_DADOS
(
	'funcionario',
	'cod_funcionario, cpf, nome, dt_nasc, telefone, email',
	'1, ''321.654.987-00'', ''ana cArOLina DOs sANtos'', ''1995-08-12'', ''99988-7766'', ''ANA.CAROLINA@EMAIL.COM'''
);


SELECT INSERIR_DADOS
(
    'funcionario',
    'cod_funcionario, cpf, nome, dt_nasc, telefone, email',
    '2, ''987.654.321-00'', ''Carlos Silva'', ''1985-03-22'', ''99888-7766'', ''carlos@ifpi.edu.br'''
);


SELECT INSERIR_DADOS
(
    'funcionario',
    'cod_funcionario, cpf, nome, dt_nasc, telefone, email',
    '3, ''131.776.053-00'', ''Antônio Nivaldo'', ''1958-05-10'', ''99321-0741'', ''nini@outlook.com'''
);


SELECT INSERIR_DADOS
(
	'funcionario',
	'cod_funcionario, cpf, nome, dt_nasc, telefone, email',
	'4, ''999.999.999-99'', ''Renato Silva'', ''1990-10-01'', ''98888-0001'', ''carlos@oficina.com'''
);


SELECT INSERIR_DADOS
(
	'funcionario',
	'cod_funcionario, cpf, nome, dt_nasc, telefone, email',
	'5, ''888.888.888-88'', ''Débora Maria'', ''1985-07-09'', ''98888-0002'', ''debora@oficina.com'''
);


SELECT INSERIR_DADOS( 
    'funcionario',
    'cod_funcionario, cpf, nome, dt_nasc, telefone, email',
    '6, ''321.654.987-00'', ''Paulo Henrique'', ''1980-08-15'', ''(86)99991-1234'', ''paulo.henrique@gmail.com'''
);

SELECT INSERIR_DADOS( 
    'funcionario',
    'cod_funcionario, cpf, nome, dt_nasc, telefone, email',
    '7, ''987.654.321-11'', ''Juliana Moraes'', ''1992-04-28'', ''(86)98888-7766'', ''juliana.moraes@hotmail.com'''
);

SELECT INSERIR_DADOS( 
    'funcionario',
    'cod_funcionario, cpf, nome, dt_nasc, telefone, email',
    '8, ''456.123.789-22'', ''Rodrigo Tavares'', ''1985-11-05'', ''(86)99654-7890'', ''rodrigo.t@gmail.com'''
);

SELECT INSERIR_DADOS( 
    'funcionario',
    'cod_funcionario, cpf, nome, dt_nasc, telefone, email',
    '9, ''789.456.123-33'', ''Camila Rocha'', ''1990-02-20'', ''(86)98777-1122'', ''camila.rocha@gmail.com'''
);

SELECT INSERIR_DADOS( 
    'funcionario',
    'cod_funcionario, cpf, nome, dt_nasc, telefone, email',
    '10, ''654.789.321-44'', ''Marcelo Vieira'', ''1975-09-12'', ''(86)99888-3344'', ''marcelo.v@empresa.com'''
);


SELECT INSERIR_DADOS( 
    'funcionario',
    'cod_funcionario, cpf, nome, dt_nasc, telefone, email',
    '11, ''666.777.888-99'', ''Marcos Viana'', ''1986-09-13'', ''(86)99888-3455'', ''marcos@outlook.com'''
);

SELECT * FROM FUNCIONARIO
SELECT * FROM LOG_REGISTRO


SELECT DELETAR_DADOS
(
	'funcionario',
	'cod_funcionario = 11'
);


SELECT INSERIR_DADOS
(
	'montadora',
	'cod_montadora, nome',
	'1, ''chEVRolEt'''
);


SELECT INSERIR_DADOS
(
    'montadora',
    'cod_montadora, nome',
    '2, ''FiAt'''
);


SELECT INSERIR_DADOS
(
	'montadora',
	'cod_montadora, nome',
	'3, ''Hyundai'''
);


SELECT INSERIR_DADOS
(
	'montadora',
	'cod_montadora, nome',
	'4, ''Mitsubishi'''
);


SELECT INSERIR_DADOS
(
	'montadora', 
	'cod_montadora, nome',
	'5, ''Toyota'''
);


SELECT INSERIR_DADOS
(
	'montadora', 
	'cod_montadora, nome',
	'6, ''Ford'''
);


SELECT INSERIR_DADOS
(
	'montadora', 
	'cod_montadora, nome',
	'7, ''Honda'''
);


SELECT INSERIR_DADOS
(
	'montadora', 
	'cod_montadora, nome',
	'8, ''Volkswagen'''
);


SELECT INSERIR_DADOS
(
	'modelo', 
	'cod_modelo, cod_montadora, nome, ano',
	'1, 1, ''onIx'', 2022'
);


SELECT INSERIR_DADOS(
    'modelo',
    'cod_modelo, cod_montadora, nome, ano',
    '2, 2, ''Uno'', 2020'
);


SELECT INSERIR_DADOS
(
	'modelo', 
	'cod_modelo, cod_montadora, nome, ano',
	'3, 2, ''Argo Trekking'', 2022'
);


SELECT INSERIR_DADOS
(
	'modelo',
	'cod_modelo, cod_montadora, nome, ano',
	'4, 3, ''HB20 Vision'', 2023'
);


SELECT INSERIR_DADOS
(
	'modelo',
	'cod_modelo, cod_montadora, nome, ano',
	'5, 4, ''Lancer GT'', 2020'
);


SELECT INSERIR_DADOS
(
	'modelo',
	'cod_modelo, cod_montadora, nome, ano',
	'6, 5, ''Corolla Cross'', 2023'
);


SELECT INSERIR_DADOS( 
    'modelo',
    'cod_modelo, cod_montadora, nome, ano',
    '7, 6, ''Ford Ka'', 2019' 
);

SELECT INSERIR_DADOS( 
    'modelo',
    'cod_modelo, cod_montadora, nome, ano',
    '8, 7, ''Civic'', 2021' 
);

SELECT INSERIR_DADOS( 
    'modelo',
    'cod_modelo, cod_montadora, nome, ano',
    '9, 8, ''Gol'', 2020' 
);

SELECT INSERIR_DADOS( 
    'modelo',
    'cod_modelo, cod_montadora, nome, ano',
    '10, 8, ''T-Cross'', 2022' 
);


SELECT INSERIR_DADOS
(
	'veiculo',
	'cod_veiculo, cod_modelo, placa, cor',
	'1, 1, ''ael1234'', ''vErmelho'''
);


SELECT INSERIR_DADOS(
    'veiculo',
    'cod_veiculo, cod_modelo, placa, cor',
    '2, 2, ''abc1d23'', ''preto metálico'''
);


SELECT INSERIR_DADOS
(
	'veiculo',
	'cod_veiculo, cod_modelo, placa, cor',
	'3, 2, ''XYZ2E45'', ''vermelho'''
);  -- Fiat Argo


SELECT INSERIR_DADOS
(
	'veiculo', 
	'cod_veiculo, cod_modelo, placa, cor',
	'4, 3, ''HYU3F67'', ''azul'''
);  -- Hyundai HB20


SELECT ATUALIZAR_DADOS
(
	'ordem_servico',
	'cod_veiculo = 3',
	'cod_cliente = 1'
);


SELECT * FROM vw_cliente_veiculo


SELECT INSERIR_DADOS
(
	'veiculo',
	'cod_veiculo, cod_modelo, placa, cor',
	'5, 4, ''MIT4G89'', ''preto'''
);  -- Mitsubishi Lancer


SELECT INSERIR_DADOS
(
	'veiculo',
	'cod_veiculo, cod_modelo, placa, cor',
	'6, 5, ''TOY5H01'', ''branco'''
);  -- Toyota Corolla Cross


-- Ford Ka
SELECT INSERIR_DADOS( 
    'veiculo',
    'cod_veiculo, cod_modelo, placa, cor',
    '7, 7, ''abc1k19'', ''vermelho'''
);

-- Honda Civic
SELECT INSERIR_DADOS( 
    'veiculo',
    'cod_veiculo, cod_modelo, placa, cor',
    '8, 8, ''def2c21'', ''cinza metálico'''
);

-- Volkswagen Gol
SELECT INSERIR_DADOS( 
    'veiculo',
    'cod_veiculo, cod_modelo, placa, cor',
    '9, 9, ''ghi3g20'', ''prata'''
);

-- Volkswagen T-Cross
SELECT INSERIR_DADOS( 
    'veiculo',
    'cod_veiculo, cod_modelo, placa, cor',
    '10, 10, ''jkl4t22'', ''branco'''
);


SELECT INSERIR_DADOS
(
	'item',
	'cod_item, cod_tipo_item, nome, preco, descricao, quantidade',
	'1, 1, ''fiLTrO dE ólEo'', 45.90, ''Filtro de óleo original para motores GM 1.0/1.4'', 20'
);


SELECT INSERIR_DADOS
(
    'item',
    'cod_item, cod_tipo_item, nome, preco, descricao, quantidade',
    '2, 1, ''Pastilha de Freio'', 79.90, ''Pastilha dianteira para modelos até 2022'', 30'
);


SELECT INSERIR_DADOS
(
	'item',
	'cod_item, cod_tipo_item, nome, preco, descricao, quantidade',
	'3, 2, ''Alinhamento e Balanceamento'', 80.00, ''Serviço completo de alinhamento 3D'', NULL'
);


SELECT INSERIR_DADOS
(
	'item', 
	'cod_item, cod_tipo_item, nome, preco, descricao, quantidade',
	'4, 1, ''Filtro de Ar Motor'', 45.00, ''Filtro para Toyota Corolla Cross'', 50'
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


SELECT INSERIR_DADOS(
    'item', 
    'cod_item, cod_tipo_item, nome, preco, descricao, quantidade',
    '17, 2, ''Revisão de Freios'', 90.00, ''Avaliação e regulagem do sistema de freio'', NULL'
);


SELECT INSERIR_DADOS
(
	'ordem_servico',
	'cod_ordem_servico, cod_cliente, cod_funcionario, cod_veiculo, data_emissao, valor, desconto',
	'1, 1, 1, 1, NOW(), 0, 0'
);


SELECT INSERIR_DADOS
(
	'ordem_servico',
	'cod_ordem_servico, cod_cliente, cod_funcionario, cod_veiculo, valor, desconto',
	'2, 1, 1, 1, 0.0, 0.0'
);


SELECT INSERIR_DADOS
(
    'ordem_servico',
    'cod_ordem_servico, cod_cliente, cod_funcionario, cod_veiculo, data_emissao, valor, desconto',
    '3, 2, 2, 2, ''2025-07-01'', 0.00, 0.00'
);


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
    'ordem_servico',
    'cod_ordem_servico, cod_cliente, cod_funcionario, cod_veiculo, data_emissao, valor, desconto',
    '6, 11, 5, 7, ''2025-03-08'', 0.00, 0.00'
);


SELECT INSERIR_DADOS
(
    'ordem_servico',
    'cod_ordem_servico, cod_cliente, cod_funcionario, cod_veiculo, data_emissao, valor, desconto',
    '7, 12, 6, 8, ''2024-12-23'', 0.00, 0.00'
);

SELECT INSERIR_DADOS
(
    'ordem_servico',
    'cod_ordem_servico, cod_cliente, cod_funcionario, cod_veiculo, data_emissao, valor, desconto',
    '8, 13, 7, 9, ''2025-09-30'', 0.00, 0.00'
);


SELECT INSERIR_DADOS
(
    'ordem_servico',
    'cod_ordem_servico, cod_cliente, cod_funcionario, cod_veiculo, data_emissao, valor, desconto',
    '9, 14, 8, 10, ''2025-04-13'', 0.00, 0.00'
);


SELECT INSERIR_DADOS
(
    'ordem_servico',
    'cod_ordem_servico, cod_cliente, cod_funcionario, cod_veiculo, data_emissao, valor, desconto, cod_status',
    '10, 5, 7, 5, ''2025-05-10'', 0.00, 0.00, 3'
);


SELECT INSERIR_DADOS
(
    'ordem_servico',
    'cod_ordem_servico, cod_cliente, cod_funcionario, cod_veiculo, data_emissao, valor, desconto_percentual, cod_status',
    '11, 3, 7, 5, ''2025-02-03'', 0.00, 5.00, 1'
);


SELECT INSERIR_DADOS
(
    'ordem_servico',
    'cod_ordem_servico, cod_cliente, cod_funcionario, cod_veiculo, data_emissao, valor, desconto_percentual, cod_status',
    '12, 6, 3, 3, ''2025-04-03'', 0.00, 0.00, 1'
);

SELECT INSERIR_DADOS
(
	'ordem_servico',
	'cod_ordem_servico, cod_cliente, cod_funcionario, cod_veiculo, valor, desconto_percentual',
	'13, 12, 2, 5, 0, 0'
);


SELECT INSERIR_DADOS
(
	'item_ordem',
	'cod_item_ordem, cod_ordem_servico, cod_item, quantidade',
	'1, 1, 1, 5'
);


SELECT INSERIR_DADOS
(
	'item_ordem',
	'cod_item_ordem, cod_ordem_servico, cod_item, quantidade',
	'2, 1, 1, 3'
);


SELECT INSERIR_DADOS
(
	'item_ordem',
	'cod_item_ordem, cod_ordem_servico, cod_item, quantidade',
	'3, 1, 1, 16'
);


SELECT INSERIR_DADOS
(
    'item_ordem',
    'cod_item_ordem, cod_ordem_servico, cod_item, quantidade',
    '3, 3, 2, 2'
);


SELECT INSERIR_DADOS
(
    'item_ordem',
    'cod_item_ordem, cod_ordem_servico, cod_item, quantidade',
    '4, 2, 2, -5'
);


SELECT INSERIR_DADOS
(
    'item_ordem',
    'cod_item_ordem, cod_ordem_servico, cod_item, quantidade',
    '5, 2, 2, -5'
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


SELECT INSERIR_DADOS
(
    'item_ordem',
    'cod_item_ordem, cod_ordem_servico, cod_item, quantidade',
    '8, 1, 1, 2'
);


SELECT INSERIR_DADOS
(
    'item_ordem',
    'cod_item_ordem, cod_ordem_servico, cod_item, quantidade',
    '9, 1, 11, 2'
);


-- Ordem 6: Óleo e Troca de Óleo
SELECT INSERIR_DADOS(
    'item_ordem',
    'cod_item_ordem, cod_ordem_servico, cod_item, quantidade',
    '10, 6, 9, 3'
);


SELECT INSERIR_DADOS(
    'item_ordem',
    'cod_item_ordem, cod_ordem_servico, cod_item, quantidade',
    '11, 6, 10, 1'
);


-- Ordem 7: Filtro e Alinhamento
SELECT INSERIR_DADOS(
    'item_ordem',
    'cod_item_ordem, cod_ordem_servico, cod_item, quantidade',
    '12, 7, 11, 1'
);


SELECT INSERIR_DADOS(
    'item_ordem',
    'cod_item_ordem, cod_ordem_servico, cod_item, quantidade',
    '13, 7, 3, 1'
);


-- Ordem 8: Bateria e Revisão de Freios
SELECT INSERIR_DADOS(
    'item_ordem',
    'cod_item_ordem, cod_ordem_servico, cod_item, quantidade',
    '14, 8, 13, 2'
);


SELECT INSERIR_DADOS(
    'item_ordem',
    'cod_item_ordem, cod_ordem_servico, cod_item, quantidade',
    '15, 8, 17, 1'
);


-- Ordem 9: Óleo + Alinhamento e Balanceamento
SELECT INSERIR_DADOS(
    'item_ordem',
    'cod_item_ordem, cod_ordem_servico, cod_item, quantidade',
    '16, 9, 9, 1'
);


SELECT INSERIR_DADOS(
    'item_ordem',
    'cod_item_ordem, cod_ordem_servico, cod_item, quantidade',
    '17, 9, 3, 1'
);


SELECT INSERIR_DADOS
(
	'item_ordem',
	'cod_item_ordem, cod_ordem_servico, cod_item, quantidade',
	'18, 11, 3, 1'
);


SELECT INSERIR_DADOS
(
	'item_ordem',
	'cod_item_ordem, cod_ordem_servico, cod_item, quantidade',
	'19, 11, 17, 1'
);


SELECT INSERIR_DADOS
(
	'item_ordem',
	'cod_item_ordem, cod_ordem_servico, cod_item, quantidade',
	'20, 11, 3, 1'
);


SELECT INSERIR_DADOS
(
	'item_ordem',
	'cod_item_ordem, cod_ordem_servico, cod_item, quantidade',
	'20, 11, 3, 1'
);


SELECT INSERIR_DADOS
(
	'item_ordem',
	'cod_item_ordem, cod_ordem_servico, cod_item, quantidade',
	'21, 10, 2, 10'
);


SELECT INSERIR_DADOS
(
	'item_ordem',
	'cod_item_ordem, cod_ordem_servico, cod_item, quantidade',
	'22, 10, 17, 1'
);


SELECT INSERIR_DADOS
(
	'status',
	'cod_status, descricao',
	'1, ''EM ANDAMENTO'''
);


SELECT INSERIR_DADOS
(
	'status',
	'cod_status, descricao',
	'2, ''CONCLUÍDA'''
);


SELECT INSERIR_DADOS
(
	'status',
	'cod_status, descricao',
	'3, ''CANCELADA'''
);


-----------------------------------------------------------------------------------------
--										UPDATES
-----------------------------------------------------------------------------------------


SELECT ATUALIZAR_DADOS
(
    'cliente',
    'nome = ''Joana Atualizada'', telefone = ''99999-0000''',
    'cod_cliente = 10'
);


SELECT ATUALIZAR_DADOS
(
    'cliente',
    'nome = ''Darcy''',
    'cpf = ''184.212.883-34'' '
);


SELECT ATUALIZAR_DADOS
(
    'cliente',
    'nome = ''Darcy''',
    'cpf = ''184.212.883-34'' '
);


SELECT ATUALIZAR_DADOS
(
    'funcionario',
    'nome = ''Carlos Souza'', email = ''carlosnovo@ifpi.edu.br''',
    'cod_funcionario = 1'
);


SELECT ATUALIZAR_DADOS
(
    'funcionario',
    'dt_nasc = ''1990-07-04''',
    'cod_funcionario IN(1, 2)'
);


SELECT ATUALIZAR_DADOS(
    'funcionario',
    'nome = ''Antônio Ribeiro''',
    'cod_funcionario = 3'
);


SELECT ATUALIZAR_DADOS(
    'montadora',
    'nome = ''Fiat India''',
    'cod_montadora = 2'
);


SELECT ATUALIZAR_DADOS(
    'montadora',
    'nome = ''Fiat''',
    'cod_montadora = 2'
);


SELECT ATUALIZAR_DADOS(
    'modelo',
    'nome = ''Onix Plus'', ano = 2023',
    'cod_modelo = 1'
);


SELECT ATUALIZAR_DADOS(
    'modelo',
    'ano = 2021',
    'cod_modelo = 2'
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
    'item',
    'quantidade = 30',
    'cod_item = 2'
);


SELECT ATUALIZAR_DADOS(
    'item',
    'preco = 85',
    'cod_item = 3'
);


SELECT ATUALIZAR_DADOS(
    'item',
    'quantidade = 3',
    'cod_item = 5'
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


SELECT ATUALIZAR_DADOS(
    'ordem_servico',
    'data_emissao = ''2025-08-02'' ',
    'cod_ordem_servico = 101'
);


SELECT ATUALIZAR_DADOS(
    'ordem_servico',
    'data_emissao = ''2025-08-09'' ',
    'cod_ordem_servico = 5'
);


SELECT ATUALIZAR_DADOS
(
    'ordem_servico',
    'cod_status = 3',
    'cod_ordem_servico = 1'
);


SELECT ATUALIZAR_DADOS
(
    'ordem_servico',
    'status = ''CONCLUIDA''',
    'cod_ordem_servico = 1'
);


SELECT ATUALIZAR_DADOS
(
	'ordem_servico',
	'status = '' con cluida '' ',
	'cod_ordem_servico = 2'
);


SELECT ATUALIZAR_DADOS
(
	'ordem_servico',
	'status = ''CANCELADA'' ',
	'cod_ordem_servico = 2'
);


SELECT ATUALIZAR_DADOS
(
    'ordem_servico',
    'cod_status = 2',
    'cod_ordem_servico = 5'
);


SELECT ATUALIZAR_DADOS
(
    'item_ordem',
    'quantidade = 4',
    'cod_item_ordem = 1'
);


SELECT ATUALIZAR_DADOS
(
    'item_ordem',
    'quantidade = 21',
    'cod_item_ordem = 1'
);


SELECT ATUALIZAR_DADOS(
    'item_ordem',
    'quantidade = 3',
    'cod_item_ordem = 1'
);


SELECT ATUALIZAR_DADOS
(
    'item_ordem',
    'quantidade = 5',
    'cod_item_ordem = 1'
);


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


SELECT ATUALIZAR_DADOS(
    'item_ordem',
    'quantidade = 3',
    'cod_item_ordem = 3'
);


SELECT ATUALIZAR_DADOS(
    'item_ordem',
    'quantidade = 0',
    'cod_item_ordem = 1'
);


SELECT ATUALIZAR_DADOS(
    'item_ordem',
    'quantidade = 12',
    'cod_item_ordem = 21'
);


SELECT ATUALIZAR_DADOS(
    'item_ordem',
    'quantidade = 5',
    'cod_item_ordem = 21'
);


-----------------------------------------------------------------------------------------
--										DELETE
-----------------------------------------------------------------------------------------

SELECT DELETAR_DADOS
(
    'cliente',
    NULL
);


SELECT DELETAR_DADOS
(
	'cliente',
	'cod_cliente = 99'
);


SELECT DELETAR_DADOS
(
    'funcionario',
    ''
);


SELECT DELETAR_DADOS
(
	'item',
	'cod_item = 3'
);


SELECT DELETAR_DADOS
(
    'item',
    ''
);


SELECT DELETAR_DADOS
(
	'ordem_servico',
	'cod_ordem_servico = 11'
);

SELECT DELETAR_DADOS
(
	'ordem_servico',
	'cod_ordem_servico = 13'
)

SELECT DELETAR_DADOS
(
    'item_ordem',
    NULL
);


SELECT DELETAR_DADOS
(
    'item_ordem',
    'cod_item_ordem = 2'
);


SELECT DELETAR_DADOS
(
	'item_ordem',
	'cod_item_ordem = 2'
);


SELECT DELETAR_DADOS
(
	'item_ordem',
	'cod_item_ordem = 18'
);


SELECT DELETAR_DADOS
(
	'item_ordem',
	'cod_item_ordem = 2'
)


SELECT DELETAR_DADOS
(
	'status',
	'cod_status = 1'
);


SELECT DELETAR_DADOS
(
	'status',
	NULL
);


SELECT DELETAR_DADOS
(
	'item_ordem',
	'cod_item_ordem = 22'
);

