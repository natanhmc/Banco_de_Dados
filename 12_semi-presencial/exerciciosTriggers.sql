create table produtos (
    id int primary key auto_increment,
    descricao varchar(100) not null,
    valor decimal(10,2) not null,
    status_prod enum('ativo', 'inativo') default 'ativo' not null,
    qtd_estoque int not null
);

create table produtos_em_falta (
    prd_codigo int primary key,
    prd_descricao varchar(100) not null,
    prd_qtd_estoque int not null,
);

create table orcamentos (
    id int primary key auto_increment,
    data_orc date not null,
    status_orc enum('ativo', 'inativo') default 'ativo' not null
);

create table orcamentos_produtos (
    id_produto int not null,
    id_orcamento int not null,
    qtd_produto int not null,
    status_orcp enum('ativo', 'inativo') default 'ativo' not null,
    foreign key (id_produto) references produtos(id),
    foreign key (id_orcamento) references orcamentos(id)
);

create table produtos_atualizados (
    prd_codigo int not null,
    prd_qtd_anterior int not null,
    prd_qtd_atualizada int not null,
    prd_valor decimal(10,2) not null,
    data_atual datetime not null default NOW(),
    Primary key (prd_codigo, data_atual)
);


--  Insert ta table orcamento_produtos -------------------------------------------
DELIMITER $$
CREATE TRIGGER estoque_orcamento_prod  AFTER INSERT ON orcamentos_produtos
	FOR EACH ROW
BEGIN
    DECLARE qtd_atual;
    SET qtd_atual = (SELECT qtd_estoque FROM produtos WHERE id = NEW.id_produto);

    IF qtd_atual >= NEW.qtd_produto THEN 
        UPDATE produtos SET qtd_estoque = qtd_estoque - NEW.qtd_produto
        WHERE id = NEW.id_produto;
    ELSE
        INSERT INTO produtos_em_falta (prd_codigo, prd_descricao, prd_qtd_estoque)
        VALUES (NEW.id_produto, (SELECT descricao FROM produtos WHERE id = NEW.id_produto), NEW.qtd_produto - qtd_atual);

        UPDATE produtos set status_prod = "inativo", qtd_estoque = 0;
    
END $$
DELIMITER ;

-- Update na table orcamento_produtos --------------------------------------------- 
DELIMITER $$
CREATE TRIGGER status_orcamento_prod  AFTER UPDATE ON orcamentos_produtos
	FOR EACH ROW
BEGIN

    IF NEW.status_orcp = "inativo" THEN 
        UPDATE produtos SET qtd_estoque = qtd_estoque + NEW.qtd_produto
        WHERE id = NEW.id_produto;
    END IF;
    
END $$
DELIMITER ;
--  Delete na table orcamento_produtos -------------------------------------------
DELIMITER $$
CREATE TRIGGER delete_ativo_orcamentos_produtos BEFORE DELETE ON orcamentos_produtos
    FOR EACH ROW
BEGIN
    IF OLD.status_orcp = 'ativo' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Não é permitido excluir orçamento_produto com status ativo';
    END IF;
END$$
DELIMITER ;


-- Update na table produtos -------------------------------------------------------
DELIMITER $$
CREATE TRIGGER atualiza_prod AFTER UPDATE ON produtos 
    FOR EACH ROW 
BEGIN 
    INSERT INTO produtos_atualizados (prd_codigo, prd_qtd_anterior, prd_qtd_atualizada, prd_valor) 
    VALUES (NEW.id,OLD.qtd_estoque,NEW.qtd_estoque, OLD.valor);
END $$
DELIMITER ;

-- Delete na table atualiza_prod ------------------------------------------------------
DELIMITER $$
CREATE TRIGGER delete_atualiza_prod BEFORE DELETE ON atualiza_prod
    FOR EACH ROW
BEGIN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Não é permitido excluir um registro de atualização';
END$$
DELIMITER ;

