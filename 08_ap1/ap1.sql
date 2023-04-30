
create table piloto(
    id int primary key auto_increment,
    nome varchar(150) not null,
    cpf varchar(14) not null unique,
    endereco varchar(100) not null,
    cidade varchar(50) not null,
    hora_voo float not null,
    salario float
);

create table comicario(
    id int primary key auto_increment,
    nome varchar(150) not null,
    cpf varchar(14) not null unique,
    endereco varchar(100) not null,
    cidade varchar(50) not null,
    salario float
);

create table aviao(
    id int primary key auto_increment,
    hora_voo float not null,
    qtd_passageiros int not null,
    data_fabrica date not null
);

create table equipe(
    id_aviao int,
    id_comicario int,
        constraint equipe_fk_comicario
            foreign key (id_comicario) references comicario(id)
                on delete restrict on update cascade,
        constraint equipe_fk_aviao
            foreign key (id_aviao) references aviao(id)
                on delete restrict on update cascade
);


create table voo(
    id int primary key auto_increment,
    id_piloto int,
    id_aviao int,
    origem varchar(50) not null,
    destino  varchar(50) not null,
    tempo_voo float not null,
    data_voo datetime not null,
        constraint voo_fk_piloto
            foreign key (id_piloto) references piloto(id)
                on delete restrict on update cascade,
        constraint voo_fk_aviao
            foreign key (id_aviao) references aviao(id)
                on delete restrict on update cascade
);

create table passageiro(
    id int primary key auto_increment,
    nome varchar(150) not null,
    cpf varchar(14) not null unique,
    endereco varchar(100) not null,
    cidade varchar(50) not null,
    classe varchar(20) not null,
);

create table voo_passageiro(
    id_passageiro int,
    id_voo int,
        constraint voo_passageiro_fk_passageiro
            foreign key (id_passageiro) references passageiro(id)
                on delete restrict on update cascade,
        constraint voo_passageiro_fk_voo
            foreign key (id_voo) references voo(id)
                on delete restrict on update cascade
);


-- inserts -----------------------------------------------------------------------------

INSERT INTO piloto (nome, cpf, endereco, cidade, hora_voo, salario) VALUES 
    ('João Silva', '123.456.789-10', 'Rua das Flores, 123', 'São Paulo', 120.5, 5000.0),
    ('Maria Souza', '234.567.890-21', 'Av. Paulista, 456', 'São Paulo', 200.0, 8000.0),
    ('José Santos', '345.678.901-32', 'Rua dos Girassóis, 789', 'Rio de Janeiro', 150.0, 6000.0),
    ('Aline Ferreira', '456.789.012-43', 'Rua das Árvores, 321', 'Belo Horizonte', 100.0, 4000.0),
    ('Carlos Oliveira', '567.890.123-54', 'Av. Atlântica, 987', 'Rio de Janeiro', 180.5, 7000.0);


INSERT INTO comicario (nome, cpf, endereco, cidade, salario) VALUES
    ('João da Silva', '123.456.789-00', 'Rua das Flores, 123', 'São Paulo', 2000),
    ('Maria José', '987.654.321-00', 'Av. Paulista, 456', 'São Paulo', 2500),
    ('Pedro Paulo', '456.789.123-00', 'Rua dos Santos, 789', 'Rio de Janeiro', 1800),
    ('Camila Souza', '111.222.333-44', 'Av. Atlântica, 987', 'Rio de Janeiro', 2800),
    ('Lucas Oliveira', '555.666.777-88', 'Rua das Palmeiras, 456', 'Belo Horizonte', 1900),
    ('Amanda Santos', '999.888.777-66', 'Av. dos Estados, 123', 'Belo Horizonte', 2200),
    ('Thiago Ferreira', '777.888.999-00', 'Rua da República, 234', 'Curitiba', 2300),
    ('Juliana Costa', '333.222.111-00', 'Av. das Flores, 567', 'Curitiba', 2000),
    ('Fernando Mendes', '444.555.666-77', 'Rua do Comércio, 890', 'Porto Alegre', 2500),
    ('Carla Rodrigues', '222.333.444-55', 'Av. Rio Branco, 456', 'Porto Alegre', 2100),
    ('Gustavo Santos', '777.666.555-44', 'Rua das Oliveiras, 123', 'São Paulo', 2700),
    ('Roberta Almeida', '555.444.333-22', 'Av. Paulista, 789', 'São Paulo', 2900),
    ('Renato Lima', '222.111.000-99', 'Rua da Carioca, 234', 'Rio de Janeiro', 2600),
    ('Juliana Alves', '888.999.000-11', 'Av. Atlântica, 567', 'Rio de Janeiro', 2400),
    ('Carlos Nunes', '666.777.888-99', 'Rua das Acácias, 890', 'Belo Horizonte', 2300),
    ('Vanessa Silva', '333.444.555-66', 'Av. dos Estados, 123', 'Belo Horizonte', 2500),
    ('Henrique Oliveira', '111.000.999-88', 'Rua da República, 456', 'Curitiba', 1900),
    ('Raquel Ferreira', '444.333.222-11', 'Av. das Flores, 789', 'Curitiba', 2700),
    ('Renan Costa', '777.888.999-11', 'Rua do Comércio, 234', 'Porto Alegre', 2100),
    ('Marina Mendes', '111.222.333-44', 'Av. Rio Branco, 567', 'Porto Alegre', 2800);


INSERT INTO aviao (hora_voo, qtd_passageiros, data_fabrica) VALUES 
    (5.7, 120, '2020-05-12'),
    (7.2, 150, '2018-09-24'),
    (9.1, 200, '2019-03-07'),
    (6.5, 100, '2021-01-18'),
    (4.8, 80, '2017-11-30');

INSERT INTO equipe (id_aviao, id_comicario) VALUES
(1, 21),
(1, 22),
(1, 23),
(2, 24),
(2, 25),
(2, 26),
(3, 27),
(3, 28),
(3, 29),
(4, 30),
(4, 31),
(4, 32),
(5, 33),
(5, 34),
(5, 35),
(1, 36),
(2, 37),
(3, 38),
(4, 39);

INSERT INTO voo (id_piloto, id_aviao, origem, destino, tempo_voo, data_voo) VALUES 
(1, 1, 'São Paulo', 'Rio de Janeiro', 1.5,2023-04-22 14:30:00),
(2, 2, 'Brasília', 'Salvador', 2.3,2023-05-01 12:00:00),
(3, 3, 'Belo Horizonte', 'Porto Alegre', 3.1,2023-06-10 19:45:00),
(4, 4, 'Rio de Janeiro', 'Curitiba', 2.8,2023-07-15 08:15:00),
(5, 5, 'Recife', 'Fortaleza', 1.9,2023-08-20 16:30:00),
(1, 2, 'São Paulo', 'Rio de Janeiro', 1.5,2023-09-05 10:00:00),
(2, 3, 'Brasília', 'Belo Horizonte', 1.8,2023-10-12 21:00:00),
(3, 4, 'Rio de Janeiro', 'Porto Alegre', 3.2,2023-11-25 15:45:00),
(4, 5, 'Curitiba', 'Florianópolis', 1.0,2023-12-30 09:30:00),
(5, 1, 'Manaus', 'São Paulo', 4.5,2024-01-08 18:00:00);


INSERT INTO passageiro (nome, cpf, endereco, cidade, id_voo, classe)
VALUES 
('João da Silva', '123.456.789-10', 'Rua das Flores, 123', 'São Paulo', 1, 'Econômica'),
('Maria Souza', '987.654.321-10', 'Av. Paulista, 456', 'São Paulo', 1, 'Econômica'),
('Pedro Rocha', '234.567.890-12', 'Rua dos Bobos, 222', 'Belo Horizonte', 2, 'Executiva'),
('Luciana Marques', '111.222.333-44', 'Av. Rio Branco, 100', 'Rio de Janeiro', 2, 'Econômica');


INSERT INTO passageiro (nome, cpf, endereco, cidade, id_voo, classe) VALUES 
('Ana Oliveira', '123.456.789-11', 'Rua das Flores, 321', 'São Paulo', 1, 'Econômica'),
('Lucas Souza', '111.222.333-44', 'Av. Paulista, 456', 'São Paulo', 1, 'Executiva'),
('Maria Santos', '234.567.890-12', 'Rua dos Bobos, 222', 'Belo Horizonte', 2, 'Executiva'),
('Pedro Souza', '333.222.111-00', 'Rua das Margaridas, 50', 'Florianópolis', 2, 'Econômica'),
('Paula Oliveira', '000.111.222-33', 'Rua do Sol, 123', 'Rio de Janeiro', 3, 'Executiva'),
('Luciana Marques', '444.555.666-77', 'Av. Rio Branco, 100', 'Rio de Janeiro', 3, 'Econômica'),
('Felipe Rocha', '555.666.777-88', 'Rua das Águas, 1000', 'Salvador', 4, 'Executiva'),
('Carla Alves', '888.999.000-11', 'Av. Brasil, 500', 'São Paulo', 4, 'Econômica'),
('João Silva', '222.333.444-55', 'Rua dos Pinheiros, 123', 'São Paulo', 5, 'Econômica'),
('Paulo Santos', '111.222.333-44', 'Av. Paulista, 456', 'São Paulo', 5, 'Executiva'),
('Ana Souza', '444.555.666-77', 'Rua das Rosas, 789', 'Belo Horizonte', 6, 'Econômica'),
('Bruno Oliveira', '777.888.999-00', 'Av. Atlântica, 123', 'Rio de Janeiro', 6, 'Executiva'),
('Carlos Rocha', '444.333.222-11', 'Rua das Pedras, 321', 'Natal', 7, 'Econômica'),
('Juliana Alves', '888.777.666-55', 'Av. Paulista, 456', 'São Paulo', 7, 'Executiva'),
('Lucas Santos', '111.222.333-44', 'Av. Rio Branco, 100', 'Rio de Janeiro', 8, 'Econômica');


INSERT INTO passageiro (nome, cpf, endereco, cidade, id_voo, classe)
VALUES ('Fernanda Silva', '222.333.444-55', 'Rua das Palmeiras, 456', 'São Paulo', 3, 'Econômica'),
       ('Carlos Oliveira', '333.444.555-66', 'Av. Brasil, 789', 'São Paulo', 3, 'Executiva'),
       ('Mariana Costa', '444.555.666-77', 'Rua das Flores, 987', 'Rio de Janeiro', 3, 'Econômica'),
       ('Pedro Henrique', '555.666.777-88', 'Av. Paulista, 123', 'São Paulo', 4, 'Econômica'),
       ('Gustavo Santos', '666.777.888-99', 'Rua das Oliveiras, 456', 'Belo Horizonte', 4, 'Executiva'),
       ('Mariana Sousa', '777.888.999-10', 'Av. das Américas, 456', 'Rio de Janeiro', 4, 'Econômica'),
       ('Ricardo Almeida', '888.999.000-11', 'Rua das Flores, 123', 'São Paulo', 5, 'Econômica'),
       ('Renata Oliveira', '999.000.111-22', 'Av. Brasil, 456', 'São Paulo', 5, 'Executiva'),
       ('Mauricio Souza', '000.111.222-33', 'Rua dos Bobos, 123', 'Belo Horizonte', 5, 'Econômica'),
       ('Carla Silva', '111.222.333-44', 'Av. Paulista, 789', 'São Paulo', 6, 'Econômica'),
       ('Giovanni Marques', '222.333.444-55', 'Rua das Palmeiras, 123', 'São Paulo', 6, 'Executiva'),
       ('Leticia Oliveira', '333.444.555-66', 'Av. Rio Branco, 789', 'Rio de Janeiro', 6, 'Econômica'),
       ('Bruna Costa', '444.555.666-77', 'Rua das Flores, 456', 'São Paulo', 7, 'Econômica'),
       ('Vitor Henrique', '555.666.777-88', 'Av. Paulista, 456', 'São Paulo', 7, 'Executiva'),
       ('Roberta Santos', '666.777.888-99', 'Rua das Oliveiras, 123', 'Belo Horizonte', 7, 'Econômica');



------------------------------------------------------------------------
-- primeira view 

create view voo_0_passageiro as 
    select v.*
    from voo v
        left join voo_passageiro vp 
            on v.id = vp.id_voo
    where vp.id_voo is null;


-- segunda view 

 create view voo_pas_data as
    select pas.id as id_pass, vo.id as id_vo, vo.data_voo
    from passageiro pas 
    inner join voo_passageiro vp 
        on  pas.id = vp.id_passageiro
    inner join voo vo 
        on vp.id_voo = vo.id;

-- terceira view 

create view comicario_mais_voo as
select comic.nome, sum(voo.tempo_voo) as tempo_voo, count(av.id) as qtd_voo
from comicario comic 
    inner join equipe eq 
        on comic.id = eq.id_comicario
    inner join aviao av 
        on eq.id_aviao = av.id 
    inner join voo 
        on av.id = voo.id_aviao
group by comic.nome
order by tempo_voo desc;

----------------------------------------------------------------------------------------
-- primeira procedure crud passageiro

DELIMITER $$
CREATE PROCEDURE crud_passageiro(id_crud int, nome_novo varchar(100), cpf_novo char(14), endereco_novo varchar(100),cid_novo varchar(50), classe_novo varchar(20), oper int )
BEGIN
    if (oper = 1) then
        if (select cpf from passageiro where cpf_novo=cpf) then
            select 'Dados duplicados!! Não é possível adicionar passageiro!!' as mensagem;
        else 
            INSERT INTO passageiro (nome, cpf, endereco, cidade, classe)
                    values(nome_novo, cpf_novo, endereco_novo,cid_novo, classe_novo);
            select concat('Passageiro ',nome_novo,' adicionado com sucesso!') as mensagem;
        end if;
    elseif (oper = 2) then
        if exists (select id from passageiro where id = id_crud ) then
            update passageiro set nome = nome_novo, cpf = cpf_novo, endereco = endereco_novo, cidade = cid_novo, classe = classe_novo
            where id = id_crud;
            select concat('O passageiro ',nome_novo,' foi atualizado com sucesso!!') as mensagem;
        end if;
    elseif (oper = 3) then 
        if exists (select id from passageiro where id = id_crud ) then
            delete from passageiro where id = id_crud;
            select concat('Passageiro com id ', id_crud, ' foi removido com sucesso') as mensagem;
        else 
            select concat('Não foi encontrado um passageiro com id ', id_crud) as mensagem;
        end if;
    else
        select 'Insira 1 para insert, 2 para update e 3 para delete';
    end if;
END $$
DELIMITER ;

call crud_passageiro( null,'Natan', '222.657.123-55', 'Rua das Palmeiras, 456', 'São Paulo', 'Econômica',1);

-- segunda procedure crud voo

DELIMITER $$
    CREATE PROCEDURE crud_voo(id_voo_crud int, id_pilot_crud int, id_aviao_crud int, origem_crud varchar(50), destino_crud varchar(50), tempo_crud float, data_voo_crud datetime, oper int )
    BEGIN
        if (oper = 1) then
        if exists (select id from voo where data_voo_crud > DATE_ADD(data_voo, INTERVAL tempo_voo HOUR_MINUTE) 
				and data_voo <> data_voo_crud)then
            insert into voo (id_piloto, id_aviao, origem, destino, tempo_voo, data_voo)
                    values (id_pilot_crud, id_aviao_crud, origem_crud, destino_crud, tempo_crud, data_voo_crud);
            select concat('voo com destino a ',destino_crud,' inserido com sucesso na data de ',data_voo_crud) as mensagem;
        else 
            select 'Dados incorretos!!' as mensagem;
        end if;
    elseif (oper = 2) then
        if exists (select id from voo where id = id_voo_crud and data_voo <> data_voo_crud) then
            update voo set id_piloto = id_pilot_crud, id_aviao = id_aviao_crud, origem = origem_crud, destino = destino_crud, tempo_voo = tempo_crud, data_voo = data_voo_crud
            where id = id_voo_crud;
            select concat('O voo de id: ',id_voo_crud,' foi atualizado com sucesso!!') as mensagem;
        else 
            if (select id from voo where id != id_voo_crud) then
                select concat('Não foi encontrado um voo com id ', id_voo_crud) as mensagem;
            else
                select 'Data invalida!!' as mensagem;
            end if;
        end if;
    elseif (oper = 3) then 
        if exists (select id from voo_0_passageiro where id = id_voo_crud) then
            delete from voo where id = id_voo_crud;
            select concat('Voo com id ', id_voo_crud, ' foi removido com sucesso') as mensagem;
        else 
            select concat('Não é possível excluir este voo : ', id_voo_crud) as mensagem;
        end if;
    else
        select 'insira 1 para insert, 2 para update e 3 para delete' as mensagem;
    end if;
    END $$
DELIMITER ;



call crud_voo(null,5,5,'Santos', 'Bahia',1.25,'2026-10-20 20:30:00',1);

call crud_voo(23, 1, 1, 'Torres', 'Nova York', 7.25, '2025-11-20 10:35:00', 2);

call crud_voo(1, 5, 5, 'Santos', 'Bahia', 1.25, '2026-10-20 20:30:00', 3);            


-- terceira procedure adicionando passageiro

DELIMITER $$
CREATE PROCEDURE add_passageiro_voo(id_passag_add int, id_voo_add int)
BEGIN
    if exists (select id from passageiro where id = id_passag_add) 
       && exists (select id from voo where id = id_voo_add) 
       && not exists (select id_pass from voo_pas_data where id_pass = id_passag_add and id_vo = id_voo_add) 
    then
        insert into voo_passageiro (id_passageiro, id_voo) values (id_passag_add, id_voo_add);
    else 
        select 'Dados incorretos !!' as mensagem;
    end if;
END $$
DELIMITER ;

call add_passageiro_voo(34,8);


-- quarta procedure deletando passageiro

DELIMITER $$
CREATE PROCEDURE delete_passageiro_voo(id_passag_remove int, id_voo_remove int)
BEGIN
    DECLARE voo_data_voo DATE;
    
	SELECT data_voo INTO voo_data_voo FROM voo WHERE id = id_voo_remove;
    
    IF EXISTS (SELECT id_passageiro FROM voo_passageiro WHERE id_passageiro = id_passag_remove AND id_voo = id_voo_remove) 
       
    THEN
        DELETE FROM voo_passageiro WHERE id_passageiro = id_passag_remove AND id_voo = id_voo_remove;
    ELSE 
        SELECT 'Dados incorretos !!' AS mensagem;
    END IF;
END $$
DELIMITER ;

call delete_passageiro_voo(34,6);
