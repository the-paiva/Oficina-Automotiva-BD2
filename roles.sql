-----------------------------------------------------------------------------------------
--                               CONTROLE DE ACESSO
-----------------------------------------------------------------------------------------


-- Criação dos grupos
CREATE ROLE atendente;
CREATE ROLE gerente;


-- Criação dos usuários
SELECT criar_usuario('anacarolina', '4n4c4r0l1n4', 'atendente');
SELECT criar_usuario('carlossouza', 'c4rl0s', 'gerente');


-- Permissões para o grupo ATENDENTE
GRANT CONNECT ON DATABASE "OficinaAutomotiva" TO atendente;
GRANT USAGE ON SCHEMA public TO atendente;
GRANT SELECT, INSERT, UPDATE ON cliente TO atendente;
GRANT SELECT ON item TO atendente;
GRANT SELECT, UPDATE, DELETE ON item_ordem TO atendente;
GRANT SELECT, INSERT, UPDATE ON veiculo TO atendente;
GRANT SELECT, INSERT, UPDATE ON modelo TO atendente;
GRANT SELECT, INSERT, UPDATE ON montadora TO atendente;
GRANT SELECT, INSERT, UPDATE ON ordem_servico TO atendente;
ALTER DEFAULT PRIVILEGES IN SCHEMA public
GRANT SELECT, INSERT, UPDATE ON TABLES TO atendente;


-- Permissões para o grupo GERENTE
GRANT CONNECT ON DATABASE "OficinaAutomotiva" TO gerente;
GRANT USAGE ON SCHEMA public TO gerente;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO gerente;
ALTER DEFAULT PRIVILEGES IN SCHEMA public
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO gerente;
GRANT SELECT ON log_registro TO gerente;
