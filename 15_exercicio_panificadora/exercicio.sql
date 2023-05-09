create table Categoria(
    id int primary key auto_increment,
    descricao varchar(50) not null
);

create table Ingrediente(
    id int primary key auto_increment,
    descricao varchar(100) not null,
    estoque decimal(10,2) not null
);

create table Produto(
    id int primary key auto_increment,
    categoria int not null, 
    estoque int not null,
    data_prod date not null,
    constraint cate_fk_prod
        foreign key (categoria) references Categoria(id)
            on delete restrict on update cascade
);

create table Produto_ingrediente(
    id_produto int not null,
    id_ingrediente int not null,
    qtd decimal(10,2) not null,
    constraint prod_fk_receita
        foreign key (id_produto) references Produto(id)
            on delete restrict on update cascade,
    constraint ingre_fk_receite
        foreign key (id_ingrediente) references Ingrediente(id)
            on delete restrict on update cascade
);

CREATE TABLE Devolucao (
    id_produto int not null,
    date_dev date default now(),
    CONSTRAINT devo_fk_prod
        FOREIGN KEY (id_produto) REFERENCES Produto(id)
            ON DELETE RESTRICT ON UPDATE CASCADE
);
-- inserts ---------------------------------------------------------------

INSERT INTO Categoria (descricao) VALUES
    ('Pães'),
    ('Bolos'),
    ('Salgados'),
    ('Bebidas'),
    ('Doces');


INSERT INTO Ingrediente (descricao, estoque) VALUES
    ('Farinha de trigo', 50.00),
    ('Leite', 20.00),
    ('Ovos', 30.00),
    ('Fermento em pó', 5.00),
    ('Açúcar', 15.00),
    ('Manteiga', 10.00),
    ('Sal', 2.00),
    ('Óleo', 8.00),
    ('Creme de leite', 12.00),
    ('Cacau em pó', 7.00);

INSERT INTO Produto (categoria, estoque, data_prod)
VALUES (1, 50, '2023-05-08'),
       (2, 100, '2023-05-08'),
       (1, 75, '2023-05-08'),
       (2, 150, '2023-05-08'),
       (1, 25, '2023-05-07'),
       (2, 50, '2023-05-07'),
       (1, 100, '2023-05-07'),
       (2, 200, '2023-05-07'),
       (1, 30, '2023-05-06'),
       (2, 60, '2023-05-06');

INSERT INTO Produto (categoria, estoque, data_prod, data_validade) VALUES 
(3, 50, '2023-05-09', '2023-06-01'),
(4, 30, '2023-05-09', '2023-06-02'),
(5, 20, '2023-05-09', '2023-06-03'),
(3, 60, '2023-05-10', '2023-06-04'),
(4, 25, '2023-05-10', '2023-06-05'),
(5, 35, '2023-05-10', '2023-06-06'),
(3, 45, '2023-05-11', '2023-06-07'),
(4, 40, '2023-05-11', '2023-06-08'),
(5, 30, '2023-05-11', '2023-06-09'),
(3, 55, '2023-05-12', '2023-06-10');


INSERT INTO Produto_ingrediente (id_produto, id_ingrediente, qtd)
VALUES (1, 1, 0.5),
       (1, 2, 0.3),
       (1, 3, 0.2),
       (2, 2, 0.4),
       (2, 4, 0.2),
       (2, 5, 0.1),
       (3, 1, 0.3),
       (3, 2, 0.2),
       (3, 3, 0.2),
       (3, 4, 0.1),
       (3, 5, 0.1),
       (4, 2, 0.5),
       (4, 3, 0.2),
       (5, 1, 0.4),
       (5, 3, 0.3);

--------------------------------------------------------------------------

-- 3. Alterar a tabela de Produtos e incluir o tempo de validade. 

alter table Produto add column data_validade date not null;

-- Exibir quantos produtos há para cada categoria; 

select sum(estoque) as quantos, categoria  
from Produto
group by categoria
order by quantos desc;

-- Exibir todos os produtos, quais ingredientes e em que quantidade são  utilizados para produzi-lo; 

select prod.id as produto, ing.descricao, prod_ing.qtd
from Produto prod
    inner join Produto_ingrediente prod_ing 
        on prod.id = prod_ing.id_produto
    inner join Ingrediente ing 
        on prod_ing.id_ingrediente = ing.id
order by prod.id

-- Exibir qual a quantidade produzida de cada produto dos últimos 30 dias; 

select sum(estoque)
from Produto
where data_prod >= date_sub(curdate(), interval 30 day);

-- Se for dobrada a produção para o próximo mês, quanto de ingrediente será  necessário.  

select (prod_ing.qtd * 2) as dobro
from Produto prod
    inner join Produto_ingrediente prod_ing 
        on prod.id = prod_ing.id_produto
    inner join Ingrediente ing 
        on prod_ing.id_ingrediente = ing.id;

-- Mostrar os ingredientes que nunca foram utilizados; 

select descricao
from Ingrediente
where id not in (
    select id_ingrediente
    from Produto_ingrediente
);

-- Crie uma trigger para garantir o controle de estoque dos produtos fabricados.
-- Quanto um produto for fabricado deve dar saída dos estoque dos ingredientes utilizados.
-- Caso ocorra o estorno da fabricação, manter o estoque dos ingredientes atualizado também;

DELIMITER $$
CREATE TRIGGER estoque_ingrediente AFTER INSERT ON Produto 
	FOR EACH ROW
BEGIN
	update Ingrediente set qtd = (qtd - (select qtd from Produto_ingrediente where id_produto = new.id ) )
    where id in (select id from Produto_ingrediente);
END $$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER devolucao AFTER INSERT ON Devolucao 
	FOR EACH ROW
BEGIN
	update Ingrediente set qtd = (qtd + (select qtd from Produto_ingrediente where id_produto = new.id_produto ) )
    where id in (select id from Produto_ingrediente);
END $$
DELIMITER ;



-- Utilizando controle de transações, atualize as receitas para reduzir em 10% a  quantidade de fermento utilizada; 

SET AUTOCOMMIT=0

start transaction      -- inicia a transaction 

update Produto_ingrediente set qtd = (qtd * 0.9) where id_ingrediente = 4;           -- 4 é o id de fermento  

-- Confirme a transação do exercício anterior; 

commit               

-- Utilizando controle de transações, exclua todos os registros de produção do  último mês; 

start transaction 

delete Produtos where data_prod >= date_sub(curdate(), interval 30 day);


-- Desfaça a transação realizada no exercício anterior;

rollback
