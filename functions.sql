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
            AND os.desconto_percentual > 0
            AND os.cod_ordem_servico <> ordem_id
        ) INTO ja_tem_desconto;

        IF NOT ja_tem_desconto THEN
            -- Aplica o desconto de 10% na ordem atual
            UPDATE ordem_servico
            SET desconto_percentual = 10
            WHERE cod_ordem_servico = ordem_id;

            RAISE NOTICE 'Desconto de aniversário aplicado!';
        END IF;
    END IF;

    RETURN NULL;
END;
$$ LANGUAGE plpgsql;


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
) AS 
$$
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
$$ 
LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION impedir_item_duplicado()
RETURNS TRIGGER AS 
$$
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
$$ 
LANGUAGE plpgsql;


/* 
Padroniza a coluna STATUS da tabela ORDEM_SERVICO, fazendo todas as strings de suas
linhas serem maiúsculas e eliminando espaços
*/
CREATE OR REPLACE FUNCTION PADRONIZAR_COLUNA_STATUS()
RETURNS TRIGGER AS 
$$
BEGIN
	NEW.STATUS = REPLACE(UPPER(NEW.STATUS), ' ', '');

	IF NEW.STATUS NOT IN ('EM ANDAMENTO', 'CANCELADA', 'CONCLUÍDA') THEN
		RAISE EXCEPTION 'Status informado inválido! Os tipos de status para uma ordem de serviço são: EM ANDAMENTO, CANCELADA e CONCLUÍDA.';
	END IF;
	
	RETURN NEW;
END;
$$
LANGUAGE PLPGSQL;


CREATE OR REPLACE FUNCTION VALIDAR_COD_STATUS()
RETURNS TRIGGER AS
$$
BEGIN
	IF NEW.COD_STATUS NOT IN (1, 2, 3) THEN
		RAISE EXCEPTION 'O código de status fornecido é inválido!';
	END IF;

	IF TG_OP = 'INSERT' AND NEW.COD_STATUS IN (2, 3) THEN
		NEW.COD_STATUS = 1;

		RAISE NOTICE 'Não é possível inserir uma ordem de serviço com status CONCLUÍDA (código 2) ou CANCELADA (código 3)';
	END IF;

	RETURN NEW;
END;
$$
LANGUAGE PLPGSQL;


CREATE OR REPLACE FUNCTION VALIDAR_VALOR_DE_OS()
RETURNS TRIGGER AS
$$
BEGIN
	IF TG_OP = 'INSERT' THEN
		NEW.VALOR = 0.00;

		RAISE NOTICE 'Não é possível inicializar uma ordem de serviço com valor acima de 0.';
	END IF;

	IF TG_OP = 'UPDATE' THEN

	END IF;

	RETURN NEW;
END;
$$
LANGUAGE PLPGSQL;


/*
Impede que a porcentagem de desconto de ORDEM_SERVICO seja menor que 0% e maior 
que 100%.
*/
CREATE OR REPLACE FUNCTION VALIDAR_DESCONTO()
RETURNS TRIGGER AS
$$
BEGIN
	IF NEW.DESCONTO_PERCENTUAL NOT BETWEEN 0 AND 100 THEN
		RAISE EXCEPTION 'Porcentagem do desconto deve estar entre 0 e 100.';
	END IF;

	RETURN NEW;
END;
$$
LANGUAGE PLPGSQL;

