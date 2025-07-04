-- Trabalho de Banco de Dados - Oficina Automotiva


-----------------------------------------------------------------------------------------
--                               CRIAÇÃO DAS TABELAS
-----------------------------------------------------------------------------------------


-- Criação da tabela MONTADORA
CREATE TABLE MONTADORA
(
	COD_MONTADORA INTEGER PRIMARY KEY NOT NULL,
	NOME VARCHAR(15) NOT NULL
);


-- Criação da tabela TIPO_ITEM
CREATE TABLE TIPO_ITEM
(
	COD_TIPO_ITEM INTEGER PRIMARY KEY NOT NULL,
	NOME VARCHAR NOT NULL
);


-- Criação da tabela CLIENTE
CREATE TABLE CLIENTE
(
	COD_CLIENTE INTEGER PRIMARY KEY NOT NULL,
	CPF VARCHAR(15) NOT NULL,
	NOME VARCHAR(80) NOT NULL,
	DT_NASC DATE NOT NULL,
	TELEFONE VARCHAR(15) NOT NULL,
	EMAIL VARCHAR(40)
);


-- Criação da tabela FUNCIONARIO
CREATE TABLE FUNCIONARIO
(
	COD_FUNCIONARIO INTEGER PRIMARY KEY NOT NULL,
	CPF VARCHAR(15) NOT NULL,
	NOME VARCHAR(80) NOT NULL,
	DT_NASC DATE NOT NULL,
	TELEFONE VARCHAR(15) NOT NULL,
	EMAIL VARCHAR(40)
);


-- Criação da tabela MODELO
CREATE TABLE MODELO
(
	COD_MODELO INTEGER PRIMARY KEY NOT NULL,
	COD_MONTADORA INTEGER NOT NULL,
	NOME VARCHAR(25) NOT NULL,
	ANO INTEGER NOT NULL,
	FOREIGN KEY (COD_MONTADORA) REFERENCES MONTADORA(COD_MONTADORA)
);


-- Criação da tabela ITEM
CREATE TABLE ITEM
(
	COD_ITEM INTEGER PRIMARY KEY NOT NULL,
	COD_TIPO_ITEM INTEGER NOT NULL,
	NOME VARCHAR(100) NOT NULL,
	PRECO FLOAT NOT NULL,
	DESCRICAO TEXT NOT NULL,
	QUANTIDADE INTEGER,
	FOREIGN KEY (COD_TIPO_ITEM) REFERENCES TIPO_ITEM(COD_TIPO_ITEM)
);


-- Criação da tabela VEICULO
CREATE TABLE VEICULO
(
	COD_VEICULO INTEGER PRIMARY KEY NOT NULL,
	COD_MODELO INTEGER NOT NULL,
	PLACA VARCHAR(7) NOT NULL,
	COR VARCHAR(15),
	FOREIGN KEY (COD_MODELO) REFERENCES MODELO(COD_MODELO)
);


-- Criação da tabela ORDEM_SERVICO
CREATE TABLE ORDEM_SERVICO
(
	COD_ORDEM_SERVICO INTEGER PRIMARY KEY NOT NULL,
	COD_CLIENTE INTEGER NOT NULL,
	COD_FUNCIONARIO INTEGER NOT NULL,
	COD_VEICULO INTEGER NOT NULL,
	DATA_EMISSAO DATE NOT NULL,
	VALOR FLOAT NOT NULL,
	DESCONTO FLOAT NOT NULL,
	FOREIGN KEY (COD_CLIENTE) REFERENCES CLIENTE(COD_CLIENTE),
	FOREIGN KEY (COD_FUNCIONARIO) REFERENCES FUNCIONARIO(COD_FUNCIONARIO),
	FOREIGN KEY (COD_VEICULO) REFERENCES VEICULO(COD_VEICULO)
);


-- Criação da tabela ITEM_ORDEM
CREATE TABLE ITEM_ORDEM
(
	COD_ITEM_ORDEM INTEGER PRIMARY KEY NOT NULL,
	COD_ORDEM_SERVICO INTEGER NOT NULL,
	COD_ITEM INTEGER NOT NULL,
	QUANTIDADE INTEGER NOT NULL,
	FOREIGN KEY (COD_ORDEM_SERVICO) REFERENCES ORDEM_SERVICO(COD_ORDEM_SERVICO),
	FOREIGN KEY (COD_ITEM) REFERENCES ITEM(COD_ITEM)
);


-- Criação da tabela LOG_REGISTRO
CREATE TABLE log_registro (
    id SERIAL PRIMARY KEY,
    tabela_nome TEXT,
    operacao TEXT,
    chave_primaria TEXT,
    dados_antigos JSONB,
    dados_novos JSONB,
    data_log TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	usuario TEXT
);


-----------------------------------------------------------------------------------------
--                                    FUNÇÕES
-----------------------------------------------------------------------------------------


-- Função genérica para realizar operações de INSERT
CREATE OR REPLACE FUNCTION INSERIR_DADOS
(
	P_TABELA TEXT, 
	P_CAMPOS TEXT, 
	P_VALORES TEXT
) 
RETURNS VOID AS
$$
BEGIN
    EXECUTE FORMAT
	(
        'INSERT INTO %I (%s) VALUES (%s)',
        P_TABELA, P_CAMPOS, P_VALORES
    );
END;
$$ 
LANGUAGE PLPGSQL;


-- Função genérica para realizar operações de UPDATE
CREATE OR REPLACE FUNCTION ATUALIZAR_DADOS
(
    p_tabela TEXT,
    p_set TEXT,
    p_where TEXT
)
RETURNS VOID AS
$$
BEGIN
    EXECUTE FORMAT
	(
        'UPDATE %I SET %s WHERE %s',
        p_tabela, p_set, p_where
    );
END;
$$
LANGUAGE plpgsql;


-- Função genérica para realizar operações de DELETE
CREATE OR REPLACE FUNCTION deletar_dados(
    p_tabela TEXT,
    p_where TEXT
) RETURNS VOID AS
$$
BEGIN
    IF p_where IS NULL OR TRIM(p_where) = '' THEN
        -- DELETE sem WHERE (deleta tudo)
        EXECUTE FORMAT('DELETE FROM %I', p_tabela);
    ELSE
        -- DELETE com WHERE
        EXECUTE FORMAT('DELETE FROM %I WHERE %s', p_tabela, p_where);
    END IF;
END;
$$ LANGUAGE plpgsql;



/*
Normaliza o nome de uma tabela, fazendo com que a primeira letra de cada palavra
seja maiúscula
*/
CREATE OR REPLACE FUNCTION NORMALIZAR_NOME()
RETURNS TRIGGER AS
$$
BEGIN
    NEW.NOME = INITCAP(NEW.NOME);
    RETURN NEW;
END;
$$
LANGUAGE PLPGSQL;


-- Normaliza o e-mail de uma tabela fazendo com que todas as letras sejam minúsculas
CREATE OR REPLACE FUNCTION NORMALIZAR_EMAIL()
RETURNS TRIGGER AS
$$
BEGIN
    NEW.EMAIL = LOWER(NEW.EMAIL);
    RETURN NEW;
END;
$$
LANGUAGE PLPGSQL;


-- Normaliza o campo COR de uma tabela fazendo com que todas as letras sejam maiúsculas
CREATE OR REPLACE FUNCTION NORMALIZAR_COR()
RETURNS TRIGGER AS
$$
BEGIN
    NEW.COR = INITCAP(NEW.COR);
    RETURN NEW;
END;
$$
LANGUAGE PLPGSQL;


/*
Normaliza a placa de um carro para que ela esteja de acordo com as regras
de emplacamento do Brasil (abrange tanto o modelo antigo de placas quanto o novo)
*/
CREATE OR REPLACE FUNCTION NORMALIZAR_PLACA()
RETURNS TRIGGER AS
$$
DECLARE
	PLACA_FORMATADA TEXT;
BEGIN
	-- Elimina espaços e hífens na placa
	PLACA_FORMATADA = UPPER(REPLACE(NEW.PLACA, ' ', ''));
	PLACA_FORMATADA = REPLACE(PLACA_FORMATADA, '-', '');

	IF PLACA_FORMATADA ~ '^[A-Z]{3}[0-9]{4}$'
	OR PLACA_FORMATADA ~ '^[A-Z]{3}[0-9]{1}[A-Z]{1}[0-9]{2}$' THEN
		NEW.PLACA = PLACA_FORMATADA;
	ELSE
		RAISE EXCEPTION 'Placa inválida!';
	END IF;

	RETURN NEW;
END;
$$
LANGUAGE PLPGSQL;


-- Faz o controle de estoque entre ITEM E ITEM_ORDEM
CREATE OR REPLACE FUNCTION CONTROLAR_ESTOQUE()
RETURNS TRIGGER AS
$$
DECLARE
    ESTOQUE_ATUAL INTEGER;
    DIFERENCA INTEGER;
BEGIN
    -- Tira do estoque
    IF TG_OP = 'INSERT' THEN
        SELECT QUANTIDADE INTO ESTOQUE_ATUAL FROM ITEM WHERE COD_ITEM = NEW.COD_ITEM;

        IF ESTOQUE_ATUAL < NEW.QUANTIDADE THEN
            RAISE EXCEPTION 'Estoque insuficiente para o item %, disponível: %, solicitado: %',
                NEW.COD_ITEM, ESTOQUE_ATUAL, NEW.QUANTIDADE;
        END IF;

        UPDATE ITEM
        SET QUANTIDADE = QUANTIDADE - NEW.QUANTIDADE
        WHERE COD_ITEM = NEW.COD_ITEM;

    -- Ajusta a diferença
    ELSIF TG_OP = 'UPDATE' THEN
        DIFERENCA = NEW.QUANTIDADE - OLD.QUANTIDADE;

        IF DIFERENCA <> 0 THEN
            SELECT QUANTIDADE INTO ESTOQUE_ATUAL FROM ITEM WHERE COD_ITEM = NEW.COD_ITEM;

            -- Se estiver aumentando a quantidade usada, verificar se há estoque suficiente
            IF DIFERENCA > 0 AND ESTOQUE_ATUAL < DIFERENCA THEN
                RAISE EXCEPTION 'Estoque insuficiente para atualizar o item %, disponível: %, necessário: %',
                    NEW.COD_ITEM, ESTOQUE_ATUAL, DIFERENCA;
            END IF;

            UPDATE ITEM
            SET QUANTIDADE = QUANTIDADE - DIFERENCA
            WHERE COD_ITEM = NEW.COD_ITEM;
        END IF;

    -- Devolve ao estoque
    ELSIF TG_OP = 'DELETE' THEN
        UPDATE ITEM
        SET QUANTIDADE = QUANTIDADE + OLD.QUANTIDADE
        WHERE COD_ITEM = OLD.COD_ITEM;
    END IF;

    RETURN NULL;
END;
$$
LANGUAGE PLPGSQL;


/*
Calcular o valor da ordem de serviço de acordo com os itens vinculados a essa ordem
através da tabela ITEM_ORDEM
*/
CREATE OR REPLACE FUNCTION CALCULAR_VALOR_DE_ORDEM_DE_SERVICO()
RETURNS TRIGGER AS
$$
DECLARE
    TOTAL NUMERIC = 0;
    ORDEM_ID INTEGER;
BEGIN
    -- Identifica a ordem de serviço a ser atualizada
    IF TG_OP = 'DELETE' THEN
        ORDEM_ID = OLD.COD_ORDEM_SERVICO;
    ELSE
        ORDEM_ID = NEW.COD_ORDEM_SERVICO;
    END IF;

    -- Recalcula o valor total somando: QUANTIDADE * PRECO
    SELECT SUM(ITEM_ORDEM.QUANTIDADE * ITEM.PRECO)
    INTO TOTAL
    FROM ITEM_ORDEM
    JOIN ITEM ON ITEM.COD_ITEM = ITEM_ORDEM.COD_ITEM
    WHERE ITEM_ORDEM.COD_ORDEM_SERVICO = ORDEM_ID;

    -- Atualiza o valor na tabela ORDEM_SERVICO
    UPDATE ORDEM_SERVICO
    SET VALOR = COALESCE(TOTAL, 0)
    WHERE COD_ORDEM_SERVICO = ORDEM_ID;

    RETURN NULL;
END;
$$
LANGUAGE PLPGSQL;


-- Impede que um cliente que tenha uma ordem de serviço registrada seja deletado
CREATE OR REPLACE FUNCTION IMPEDIR_DELETE_DE_CLIENTE_COM_OS()
RETURNS TRIGGER AS
$$
DECLARE
    TEM_ORDEM_DE_SERVICO BOOLEAN;
BEGIN
    -- Verifica se existe pelo menos uma ordem de serviço vinculada ao cliente
    SELECT EXISTS 
	(
        SELECT 1
        FROM ORDEM_SERVICO
        WHERE COD_CLIENTE = OLD.COD_CLIENTE
    ) 
	INTO TEM_ORDEM_DE_SERVICO;

    -- Se tiver, impede a exclusão
    IF TEM_ORDEM_DE_SERVICO THEN
        RAISE EXCEPTION 'Não é possível excluir o cliente %, pois ele possui ordens de serviço registradas.', OLD.NOME;
    END IF;

    RETURN OLD;
END;
$$
LANGUAGE PLPGSQL;


-- Impede que um item que já foi usado em alguma ordem de serviço seja deletado
CREATE OR REPLACE FUNCTION IMPEDIR_DELETE_DE_ITEM_UTILIZADO()
RETURNS TRIGGER AS
$$
DECLARE
    ITEM_UTILIZADO BOOLEAN;
BEGIN
    -- Verifica se o item foi usado em alguma ordem de serviço
    SELECT EXISTS
	(
        SELECT 1
        FROM ITEM_ORDEM
        WHERE COD_ITEM = OLD.COD_ITEM
    )
	INTO ITEM_UTILIZADO;

    -- Se foi usado, impede a exclusão
    IF ITEM_UTILIZADO THEN
        RAISE EXCEPTION 'Não é possível excluir o item %, pois ele está vinculado a uma ou mais ordens de serviço.', OLD.NOME;
    END IF;

    RETURN OLD;
END;
$$
LANGUAGE PLPGSQL;


/* 
Define a data atual como data de emissão padrão, servindo para os casos em que a
data de emissão da ordem de serviço não foi informada
*/
CREATE OR REPLACE FUNCTION DEFINIR_DATA_DE_EMISSAO_PADRAO()
RETURNS TRIGGER AS
$$
BEGIN
    -- Se o campo data_emissao estiver vazio, define a data atual
    IF NEW.DATA_EMISSAO IS NULL THEN
        NEW.DATA_EMISSAO = CURRENT_DATE;
    END IF;

    RETURN NEW;
END;
$$
LANGUAGE PLPGSQL;


-- Parabeniza o cliente que é inserido no banco na data do seu aniversário
CREATE OR REPLACE FUNCTION PARABENIZAR_CLIENTE_ANIVERSARIANTE()
RETURNS TRIGGER AS
$$
BEGIN
    -- Verifica se o cliente está fazendo aniversário hoje
    IF EXTRACT(MONTH FROM NEW.DT_NASC) = EXTRACT(MONTH FROM CURRENT_DATE)
	AND EXTRACT(DAY FROM NEW.DT_NASC) = EXTRACT(DAY FROM CURRENT_DATE) THEN
        RAISE NOTICE '🎉 Parabéns pelo seu aniversário, %! 🎉', NEW.NOME;
    END IF;

    RETURN NEW;
END;
$$
LANGUAGE PLPGSQL;



CREATE OR REPLACE FUNCTION atualizar_valor_ordem()
RETURNS TRIGGER AS
$$
DECLARE
    total NUMERIC := 0;
    ordem_id INTEGER;
    mes_nascimento INTEGER;
    mes_emissao INTEGER;
    ano_emissao INTEGER;
    ja_tem_desconto BOOLEAN;
BEGIN
    -- Identifica a ordem de serviço a ser atualizada
    IF TG_OP = 'DELETE' THEN
        ordem_id := OLD.cod_ordem_servico;
    ELSE
        ordem_id := NEW.cod_ordem_servico;
    END IF;

    -- Calcula o valor total da O.S.
    SELECT SUM(item_ordem.quantidade * item.preco)
    INTO total
    FROM item_ordem
    JOIN item ON item.cod_item = item_ordem.cod_item
    WHERE item_ordem.cod_ordem_servico = ordem_id;

    -- Atualiza o valor (sem aplicar desconto ainda)
    UPDATE ordem_servico
    SET valor = COALESCE(total, 0)
    WHERE cod_ordem_servico = ordem_id;

    -- Pega o mês de nascimento do cliente
    SELECT EXTRACT(MONTH FROM cliente.dt_nasc)
    INTO mes_nascimento
    FROM ordem_servico
    JOIN cliente ON cliente.cod_cliente = ordem_servico.cod_cliente
    WHERE ordem_servico.cod_ordem_servico = ordem_id;

    -- Pega o mês e ano da emissão da O.S.
    SELECT EXTRACT(MONTH FROM data_emissao), EXTRACT(YEAR FROM data_emissao)
    INTO mes_emissao, ano_emissao
    FROM ordem_servico
    WHERE cod_ordem_servico = ordem_id;

    -- Verifica se é mês de aniversário e se ainda não tem desconto
    IF mes_emissao = mes_nascimento THEN
        SELECT EXISTS (
            SELECT 1
            FROM ordem_servico os
            WHERE os.cod_cliente = (
                SELECT cod_cliente FROM ordem_servico WHERE cod_ordem_servico = ordem_id
            )
            AND EXTRACT(MONTH FROM os.data_emissao) = mes_emissao
            AND EXTRACT(YEAR FROM os.data_emissao) = ano_emissao
            AND os.desconto > 0
            AND os.cod_ordem_servico <> ordem_id
        ) INTO ja_tem_desconto;

        IF NOT ja_tem_desconto THEN
            -- Aplica o desconto de 10% na ordem atual
            UPDATE ordem_servico
            SET desconto = total * 0.10
            WHERE cod_ordem_servico = ordem_id;

            RAISE NOTICE '🎉 Desconto de aniversário aplicado! 🎉';
        END IF;
    END IF;

    RETURN NULL;
END;
$$ LANGUAGE plpgsql;



/*
Registra os logs do sistema, disponibilizando um histórico de informações sobre
as movimentações realizadas no banco.
*/
CREATE OR REPLACE FUNCTION registrar_log() 
RETURNS TRIGGER AS
$$
DECLARE
    v_primary_key_column TEXT;
    v_primary_key_value TEXT;
BEGIN
    -- Obter o nome da coluna da chave primária
    SELECT kcu.column_name
    INTO v_primary_key_column
    FROM information_schema.table_constraints tc
    JOIN information_schema.key_column_usage kcu
        ON tc.constraint_name = kcu.constraint_name
       AND tc.table_name = kcu.table_name
    WHERE tc.table_name = TG_TABLE_NAME
      AND tc.constraint_type = 'PRIMARY KEY'
    LIMIT 1;

    -- Obter o valor da chave primária da linha afetada
    EXECUTE FORMAT('SELECT ($1).%I::TEXT', v_primary_key_column)
    INTO v_primary_key_value
    USING CASE WHEN TG_OP = 'INSERT' THEN NEW ELSE OLD END;

    -- Inserir log com base na operação
    IF TG_OP = 'INSERT' THEN
        INSERT INTO log_registro (tabela_nome, operacao, chave_primaria, dados_novos, usuario)
        VALUES (TG_TABLE_NAME, 'CADASTRO', v_primary_key_value, TO_JSONB(NEW), CURRENT_USER);
        RETURN NEW;

    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO log_registro (tabela_nome, operacao, chave_primaria, dados_antigos, dados_novos, usuario)
        VALUES (TG_TABLE_NAME, 'ATUALIZAÇÃO', v_primary_key_value, TO_JSONB(OLD), TO_JSONB(NEW), CURRENT_USER);
        RETURN NEW;

    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO log_registro (tabela_nome, operacao, chave_primaria, dados_antigos, usuario)
        VALUES (TG_TABLE_NAME, 'REMOÇÃO', v_primary_key_value, TO_JSONB(OLD), CURRENT_USER);
        RETURN OLD;
    END IF;

    RETURN NULL;
END;
$$ LANGUAGE plpgsql;



DROP FUNCTION IMPEDIR_PK_DUPLICADA()

/*
Retorna uma mensagem de erro personalizado caso haja a tentativa de inserir uma chave
primária que já existe no sistema.
*/
CREATE OR REPLACE FUNCTION impedir_pk_duplicada()
RETURNS TRIGGER AS
$$
DECLARE
    pk_coluna TEXT;
    pk_valor TEXT;
    existe_pk BOOLEAN;
BEGIN
    -- Descobre o nome da coluna da chave primária
    SELECT key_column_usage.column_name
    INTO pk_coluna
    FROM information_schema.table_constraints,
         information_schema.key_column_usage
    WHERE table_constraints.constraint_name = key_column_usage.constraint_name
      AND table_constraints.table_name = key_column_usage.table_name
      AND table_constraints.table_name = TG_TABLE_NAME
      AND table_constraints.constraint_type = 'PRIMARY KEY'
    LIMIT 1;

    -- Obtém o valor do NEW.<pk_coluna>
    EXECUTE FORMAT('SELECT ($1).%I::TEXT', pk_coluna)
    INTO pk_valor
    USING NEW;

    -- Verifica se o valor já existe
    EXECUTE FORMAT(
        'SELECT EXISTS (SELECT 1 FROM %I WHERE %I = %L)',
        TG_TABLE_NAME, pk_coluna, pk_valor
    )
    INTO existe_pk;

    IF existe_pk THEN
        RAISE EXCEPTION 'A chave primária informada já está cadastrada no sistema';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


-- Função genérica para a criação de usuários e sua inserção em um grupo
CREATE OR REPLACE FUNCTION criar_usuario(
    p_usuario TEXT,
    p_senha TEXT,
    p_grupo TEXT
) RETURNS VOID AS
$$
DECLARE
    grupo_existe BOOLEAN;
    usuario_existe BOOLEAN;
BEGIN
    -- Verifica se o grupo já existe
    SELECT EXISTS (
        SELECT 1 FROM pg_roles WHERE rolname = p_grupo
    ) INTO grupo_existe;

    IF NOT grupo_existe THEN
        RAISE EXCEPTION 'Grupo informado não existe';
    END IF;

    -- Verifica se o usuário já existe
    SELECT EXISTS (
        SELECT 1 FROM pg_roles WHERE rolname = p_usuario
    ) INTO usuario_existe;

    IF NOT usuario_existe THEN
        EXECUTE FORMAT('CREATE ROLE %I WITH LOGIN PASSWORD %L;', p_usuario, p_senha);
    ELSE
        RAISE EXCEPTION 'Usuário "%" já existe.', p_usuario;
    END IF;

    -- Adiciona o usuário ao grupo
    EXECUTE FORMAT('GRANT %I TO %I;', p_grupo, p_usuario);
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION itens_da_ordem(p_cod_ordem INTEGER)
RETURNS TABLE (
    nome_item VARCHAR,
    quantidade INTEGER,
    preco_unitario FLOAT,
    valor_total_item FLOAT
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        i.nome,
        io.quantidade,
        i.preco,
        io.quantidade * i.preco AS valor_total_item
    FROM 
        item_ordem io
    JOIN 
        item i ON i.cod_item = io.cod_item
    WHERE 
        io.cod_ordem_servico = p_cod_ordem;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION impedir_item_duplicado()
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM item_ordem
        WHERE cod_ordem_servico = NEW.cod_ordem_servico
          AND cod_item = NEW.cod_item
    ) THEN
        RAISE EXCEPTION 
            'Item já inserido na ordem. Considere alterar a quantidade.';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


-----------------------------------------------------------------------------------------
--                                    TRIGGERS
-----------------------------------------------------------------------------------------


-- Trigger que executa a função NORMALIZAR_EMAIL() na tabela CLIENTE
CREATE OR REPLACE TRIGGER TRG_NORMALIZAR_EMAIL_CLIENTE
BEFORE INSERT OR UPDATE ON CLIENTE
FOR EACH ROW
EXECUTE FUNCTION NORMALIZAR_EMAIL();


-- Trigger que executa a função NORMALIZAR_EMAIL() na tabela FUNCIONARIO
CREATE OR REPLACE TRIGGER TRG_NORMALIZAR_EMAIL_FUNCIONARIO
BEFORE INSERT OR UPDATE ON FUNCIONARIO
FOR EACH ROW
EXECUTE FUNCTION NORMALIZAR_EMAIL();


-- Trigger que executa a função NORMALIZAR_NOME() na tabela CLIENTE
CREATE OR REPLACE TRIGGER TRG_NORMALIZAR_NOME_CLIENTE
BEFORE INSERT OR UPDATE ON CLIENTE
FOR EACH ROW
EXECUTE FUNCTION NORMALIZAR_NOME();


-- Trigger que executa a função NORMALIZAR_NOME() na tabela FUNCIONARIO
CREATE OR REPLACE TRIGGER TRG_NORMALIZAR_NOME_FUNCIONARIO
BEFORE INSERT OR UPDATE ON FUNCIONARIO
FOR EACH ROW
EXECUTE FUNCTION NORMALIZAR_NOME();


-- Trigger que executa a função NORMALIZAR_NOME() na tabela NOME_ITEM
CREATE OR REPLACE TRIGGER TRG_NORMALIZAR_NOME_ITEM
BEFORE INSERT OR UPDATE ON ITEM
FOR EACH ROW
EXECUTE FUNCTION NORMALIZAR_NOME();


-- Trigger que executa a função NORMALIZAR_NOME() na tabela NOME_MODELO
CREATE OR REPLACE TRIGGER TRG_NORMALIZAR_NOME_MODELO
BEFORE INSERT OR UPDATE ON MODELO
FOR EACH ROW
EXECUTE FUNCTION NORMALIZAR_NOME();


-- Trigger que executa a função NORMALIZAR_NOME() na tabela NOME_MONTADORA
CREATE OR REPLACE TRIGGER TRG_NORMALIZAR_NOME_MONTADORA
BEFORE INSERT OR UPDATE ON MONTADORA
FOR EACH ROW
EXECUTE FUNCTION NORMALIZAR_NOME();


-- Trigger que executa a função NORMALIZAR_NOME() na tabela TIPO_ITEM
CREATE OR REPLACE TRIGGER TRG_NORMALIZAR_NOME_TIPO_ITEM
BEFORE INSERT OR UPDATE ON TIPO_ITEM
FOR EACH ROW
EXECUTE FUNCTION NORMALIZAR_NOME();


-- Trigger que executa a função NORMALIZAR_PLACA na tabela VEICULO
CREATE OR REPLACE TRIGGER TRG_NORMALIZAR_PLACA
BEFORE INSERT OR UPDATE ON VEICULO
FOR EACH ROW
EXECUTE FUNCTION NORMALIZAR_PLACA();


-- Trigger que executa a função NORMALIZAR_COR() na tabela VEICULO
CREATE OR REPLACE TRIGGER TRG_NORMALIZAR_COR
BEFORE INSERT OR UPDATE ON VEICULO
FOR EACH ROW
EXECUTE FUNCTION NORMALIZAR_COR();


-- Trigger que executa a função CONTROLAR_ESTOQUE() na tabela ITEM_ORDEM
CREATE OR REPLACE TRIGGER TRG_ESTOQUE_INSERT_UPDATE_DELETE
AFTER INSERT OR UPDATE OR DELETE ON ITEM_ORDEM
FOR EACH ROW
EXECUTE FUNCTION CONTROLAR_ESTOQUE();


-- Trigger que executa a função CALCULAR_VALOR_DE_ORDEM_DE_SERVICO() na tabela ITEM_ORDEM
CREATE OR REPLACE TRIGGER TRG_CALCULAR_VALOR_DE_ORDEM_DE_SERVICO
AFTER INSERT OR UPDATE OR DELETE ON ITEM_ORDEM
FOR EACH ROW
EXECUTE FUNCTION CALCULAR_VALOR_DE_ORDEM_DE_SERVICO();


-- Trigger que executa a função IMPEDIR_DELETE_DE_CLIENTE_OS() na tabela CLIENTE
CREATE OR REPLACE TRIGGER TRG_IMPEDIR_DELETE_DE_CLIENTE_COM_OS
BEFORE DELETE ON CLIENTE
FOR EACH ROW
EXECUTE FUNCTION IMPEDIR_DELETE_DE_CLIENTE_COM_OS();


-- Trigger que executa a função IMPEDIR_DELETE_DE_ITEM_UTILIZADO() na tabela ITEM
CREATE OR REPLACE TRIGGER TRG_IMPEDIR_DELETE_DE_ITEM_UTILIZADO
BEFORE DELETE ON ITEM
FOR EACH ROW
EXECUTE FUNCTION IMPEDIR_DELETE_DE_ITEM_UTILIZADO();


-- Trigger que executa a função DEFINIR_DATA_DE_EMISSAO_PADRAO() na tabela ORDEM_SERVICO
CREATE OR REPLACE TRIGGER TRG_DEFINIR_DATA_DE_EMISSAO_PADRAO
BEFORE INSERT ON ORDEM_SERVICO
FOR EACH ROW
EXECUTE FUNCTION DEFINIR_DATA_DE_EMISSAO_PADRAO();


-- Trigger que executa a função PARABENIZAR_CLIENTE_ANIVERSARIANTE() na tabela CLIENTE
CREATE OR REPLACE TRIGGER TRG_PARABENIZAR_CLIENTE_ANIVERSARIANTE
BEFORE INSERT OR UPDATE ON CLIENTE
FOR EACH ROW
EXECUTE FUNCTION PARABENIZAR_CLIENTE_ANIVERSARIANTE();


CREATE OR REPLACE TRIGGER trg_calcular_valor_de_ordem_de_servico
AFTER INSERT OR UPDATE OR DELETE ON item_ordem
FOR EACH ROW
EXECUTE FUNCTION atualizar_valor_ordem();



-- Trigger que executa a função REGISTRAR_LOG() na tabela CLIENTE
CREATE OR REPLACE TRIGGER TRG_LOG_CLIENTE
AFTER INSERT OR UPDATE OR DELETE ON CLIENTE
FOR EACH ROW EXECUTE FUNCTION REGISTRAR_LOG();


-- Trigger que executa a função REGISTRAR_LOG() na tabela FUNCIONARIO
CREATE OR REPLACE TRIGGER TRG_LOG_FUNCIONARIO
AFTER INSERT OR UPDATE OR DELETE ON FUNCIONARIO
FOR EACH ROW EXECUTE FUNCTION REGISTRAR_LOG();


-- Trigger que executa a função REGISTRAR_LOG() na tabela ITEM
CREATE OR REPLACE TRIGGER TRG_LOG_ITEM
AFTER INSERT OR UPDATE OR DELETE ON ITEM
FOR EACH ROW EXECUTE FUNCTION REGISTRAR_LOG();


-- Trigger que executa a função REGISTRAR_LOG() na tabela ITEM_ORDEM
CREATE OR REPLACE TRIGGER TRG_LOG_ITEM_ORDEM
AFTER INSERT OR UPDATE OR DELETE ON ITEM_ORDEM
FOR EACH ROW EXECUTE FUNCTION REGISTRAR_LOG();


-- Trigger que executa a função REGISTRAR_LOG() na tabela MODELO
CREATE OR REPLACE TRIGGER TRG_LOG_MODELO
AFTER INSERT OR UPDATE OR DELETE ON MODELO
FOR EACH ROW EXECUTE FUNCTION REGISTRAR_LOG();


-- Trigger que executa a função REGISTRAR_LOG() na tabela MONTADORA
CREATE OR REPLACE TRIGGER TRG_LOG_MONTADORA
AFTER INSERT OR UPDATE OR DELETE ON MONTADORA
FOR EACH ROW EXECUTE FUNCTION REGISTRAR_LOG();


-- Trigger que executa a função REGISTRAR_LOG() na tabela ORDEM_SERVICO
CREATE OR REPLACE TRIGGER TRG_LOG_ORDEM_SERVICO
AFTER INSERT OR UPDATE OR DELETE ON ORDEM_SERVICO
FOR EACH ROW EXECUTE FUNCTION REGISTRAR_LOG();


-- Trigger que executa a função REGISTRAR_LOG() na tabela TIPO_ITEM
CREATE OR REPLACE TRIGGER TRG_LOG_TIPO_ITEM
AFTER INSERT OR UPDATE OR DELETE ON TIPO_ITEM
FOR EACH ROW EXECUTE FUNCTION REGISTRAR_LOG();


-- Trigger que executa a função REGISTRAR_LOG() na tabela VEICULO
CREATE OR REPLACE TRIGGER TRG_LOG_VEICULO
AFTER INSERT OR UPDATE OR DELETE ON VEICULO
FOR EACH ROW EXECUTE FUNCTION REGISTRAR_LOG();


-- Impede que um item tenha uma quantidade negativa no estoque
CREATE OR REPLACE FUNCTION IMPEDIR_QUANTIDADE_NEGATIVA_DE_ITEM()
RETURNS TRIGGER AS
$$
BEGIN
	IF NEW.QUANTIDADE < 0 THEN
		RAISE EXCEPTION 'Um item não pode ter uma quantidade negativa';
	END IF;

	RETURN NEW;
END;
$$
LANGUAGE PLPGSQL;


-- Trigger que executa a função IMPEDIR_QUANTIDADE_NEGATIVA_DE_ITEM() na tabela ITEM
CREATE OR REPLACE TRIGGER TRG_IMPEDIR_QUANTIDADE_NEGATIVA_DE_ITEM
BEFORE INSERT OR UPDATE ON ITEM
FOR EACH ROW
EXECUTE FUNCTION IMPEDIR_QUANTIDADE_NEGATIVA_DE_ITEM();


-- Trigger que executa a função IMPEDIR_QUANTIDADE_NEGATIVA_DE_ITEM() na tabela ITEM_ORDEM
CREATE OR REPLACE TRIGGER TRG_IMPEDIR_QUANTIDADE_NEGATIVA_DE_ITEM_ORDEM
BEFORE INSERT OR UPDATE ON ITEM_ORDEM
FOR EACH ROW
EXECUTE FUNCTION IMPEDIR_QUANTIDADE_NEGATIVA_DE_ITEM();


-- Trigger que executa a função IMPEDIR_ITEM_DUPLICADO() na tabela ITEM_ORDEM
CREATE TRIGGER trg_impedir_item_duplicado
BEFORE INSERT ON item_ordem
FOR EACH ROW
EXECUTE FUNCTION impedir_item_duplicado();


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


-----------------------------------------------------------------------------------------
--										VIEWS
-----------------------------------------------------------------------------------------

-- Retorna as ordens de serviço com o valor final (valor total - desconto)
CREATE OR REPLACE VIEW TABELA_OS_COM_VALOR_FINAL AS
SELECT *, VALOR - DESCONTO AS VALOR_FINAL
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
SELECT 
    v.cod_veiculo,
    v.placa,
    v.cor,
    m.nome AS modelo,
    mo.nome AS montadora,
    c.nome AS cliente
FROM veiculo v
JOIN modelo m ON m.cod_modelo = v.cod_modelo
JOIN montadora mo ON mo.cod_montadora = m.cod_montadora
JOIN ordem_servico os ON os.cod_veiculo = v.cod_veiculo
JOIN cliente c ON c.cod_cliente = os.cod_cliente;

