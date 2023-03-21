-- exercicio 01

create table clientes(
    id int primary key auto_increment,
    nome varchar(100) not null,
    cpf char(14) unique not null,
    telefone varchar(20),
    endereco varchar(100)
);

INSERT INTO clientes (nome, cpf, telefone, endereco)
VALUES
  ('João da Silva', '123.456.789-00', '(11) 1234-5678', 'Rua A, 123'),
  ('Maria Oliveira', '987.654.321-00', '(11) 2345-6789', 'Rua B, 456'),
  ('Pedro Santos', '555.555.555-55', '(11) 3456-7890', 'Rua C, 789'),
  ('Ana Souza', '111.222.333-44', '(11) 4567-8901', 'Rua D, 1011'),
  ('Luiz Costa', '444.444.444-44', '(11) 5678-9012', 'Rua E, 1213'),
  ('Marta Pereira', '777.777.777-77', '(11) 6789-0123', 'Rua F, 1415'),
  ('Fernando Alves', '999.999.999-99', '(11) 7890-1234', 'Rua G, 1617'),
  ('Julia Santos', '222.222.222-22', '(11) 8901-2345', 'Rua H, 1819'),
  ('Roberto Silva', '333.333.333-33', '(11) 9012-3456', 'Rua I, 2021'),
  ('Carla Rodrigues', '666.666.666-66', '(11) 0123-4567', 'Rua J, 2223');

CREATE TABLE pedidos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    data_compra DATETIME NOT NULL,
    valor FLOAT NOT NULL,
    idCliente INT NOT NULL,
    CONSTRAINT pedidos_fk_cliente
        FOREIGN KEY (idCliente) REFERENCES clientes(id)
            ON UPDATE CASCADE ON DELETE RESTRICT
);

Claro! Segue abaixo o exemplo de 10 INSERTS na tabela "pedidos", com chaves estrangeiras aleatórias da tabela "clientes":


INSERT INTO pedidos (data_compra, valor, idCliente)
VALUES ('2022-01-01 10:00:00', 50.00, 1),
       ('2022-01-02 11:00:00', 100.00, 1),
       ('2022-01-03 12:00:00', 150.00, 1),
       ('2022-01-04 13:00:00', 200.00, 5),
       ('2022-01-05 14:00:00', 250.00, 5),
       ('2022-01-06 15:00:00', 300.00, 6),
       ('2022-01-03 12:00:00', 150.00, 3),
       ('2022-01-04 13:00:00', 200.00, 9),
       ('2022-01-05 14:00:00', 250.00, 5),
       ('2022-01-06 15:00:00', 300.00, 6),
       ('2022-01-07 16:00:00', 350.00, 7),
       ('2022-01-08 17:00:00', 400.00, 8),
       ('2022-01-09 18:00:00', 450.00, 9),
       ('2022-01-07 16:00:00', 350.00, 6),
       ('2022-01-08 17:00:00', 400.00, 8),
       ('2022-01-09 18:00:00', 450.00, 7),
       ('2022-01-10 19:00:00', 500.00, 9);

select cli.nome, sum(valor) as valor_total, count(ped.id) as total_pedidos
from clientes cli 
    inner join pedidos ped 
        on cli.id=ped.idCliente
group by cli.nome 
having count(ped.id) >=3;

--------------------------------------------------------------------------
-- exercicio 02

CREATE TABLE produtos (
    id INT PRIMARY KEY auto_increment,
    nome VARCHAR(50) NOT NULL,
    categoria VARCHAR(50) NOT NULL,
    preco DECIMAL(10, 2) NOT NULL
);

INSERT INTO produtos (nome, categoria, preco) VALUES
('Arroz', 'Alimentos', 10.50),
('Feijão', 'Alimentos', 8.75),
('Leite', 'Bebidas', 3.50),
('Refrigerante', 'Bebidas', 5.00),
('Detergente', 'Limpeza', 2.25);

CREATE TABLE vendas (
    id INT PRIMARY KEY auto_increment,
    idProd INT NOT NULL,
    data_vend date not null,
    qtd INT NOT NULL,
    constraint vendas_fk_prod
    FOREIGN KEY (idProd) REFERENCES produtos (id)
		on update cascade on delete restrict
);

INSERT INTO vendas (idProd, data_vend, qtd) VALUES
(1, '2022-01-15', 50),
(2, '2022-02-20', 75),
(3, '2022-01-01', 100),
(1, '2022-03-10', 80),
(4, '2022-02-28', 150);

select prod.nome, avg(preco) as media, sum(vend.qtd) as total_vendida
from produtos prod 
    left join vendas vend 
        on prod.id=vend.idProd
group by prod.categoria;

--------------------------------------------------------------------------

-- exercico 03

CREATE TABLE produto (
    id INT PRIMARY KEY auto_increment,
    nome VARCHAR(50) NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    categoria VARCHAR(50) NOT NULL
);

INSERT INTO produto (nome, preco, categoria) VALUES
('Arroz', 10.50, 'Alimentos'),
('Feijão', 8.90, 'Alimentos'),
('Camiseta', 25.00, 'Vestuário'),
('Calça', 50.00, 'Vestuário'),
('Notebook', 2500.00, 'Eletrônicos'),
('Smartphone', 1500.00, 'Eletrônicos'),
('Mesa', 500.00, 'Móveis');

CREATE TABLE fornecedor (
    id INT PRIMARY KEY auto_increment,
    nome VARCHAR(50) NOT NULL,
    endereco VARCHAR(100) NOT NULL,
    telefone VARCHAR(20) NOT NULL
);

INSERT INTO fornecedor (nome, endereco, telefone) VALUES
('Fornecedor A', 'Rua A, 123', '(11) 1111-1111'),
('Fornecedor B', 'Rua B, 456', '(22) 2222-2222'),
('Fornecedor C', 'Rua C, 789', '(33) 3333-3333'),
('Fornecedor D', 'Rua D, 321', '(44) 4444-4444'),
('Fornecedor E', 'Rua E, 654', '(55) 5555-5555'),
('Fornecedor F', 'Rua F, 987', '(66) 6666-6666'),
('Fornecedor G', 'Rua G, 234', '(77) 7777-7777');

CREATE TABLE compras (
    id INT PRIMARY KEY auto_increment,
    idFornecedor INT NOT NULL,
    idProd INT NOT NULL,
    data_compra DATE NOT NULL,
    qtd INT NOT NULL,
    constraint compras_fk_forn
    FOREIGN KEY (idFornecedor) REFERENCES fornecedor (id)
        on update cascade on delete restrict,
    constraint compras_fk_prod
    FOREIGN KEY (idProd) REFERENCES produtos (id)
        on update cascade on delete restrict
);

INSERT INTO compras (idFornecedor, idProd, data_compra, qtd) VALUES
(1, 1, '2022-01-01', 100),
(2, 2, '2022-02-01', 50),
(3, 3, '2022-03-01', 80),
(4, 4, '2022-04-01', 120),
(5, 5, '2022-05-01', 10),
(6, 6, '2022-06-01', 200),
(7, 7, '2022-07-01', 150);


select  forn.nome, 
        prod.nome, 
        sum(cp.qtd) as total
from fornecedor forn 
    inner join compras comp 
        on forn.id=comp.idFornecedor
    inner join compra_produtos cp
        on cp.idCompra=comp.id
    inner join produto prod 
        on prod.id=cp.idProd
group by forn.nome, prod.nome 
having sum(cp.qtd) >= 100 

--------------------------------------------------------------------------

-- exercicio 04


CREATE TABLE departamentos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL
);

INSERT INTO departamentos (nome) 
VALUES  ('Vendas'),
        ('Marketing'),
        ('Financeiro');

CREATE TABLE funcionarios (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    salario DECIMAL(10, 2) NOT NULL,
    idDepartamento INT,
    constraint func_fk_depart
        FOREIGN KEY (idDepartamento) REFERENCES departamentos(id)
            on update cascade on delete restrict
);

INSERT INTO funcionarios (nome, salario, idDepartamento) 
VALUES 
('João', 5000.00, 1),
('Maria', 6000.00, 1),
('Pedro', 4500.00, 2),
('Ana', 5500.00, 2),
('José', 8000.00, 3),
('Paulo', 7500.00, 3),
('Julia', 5000.00, 1),
('Lucas', 5500.00, 1),
('Fernanda', 7000.00, 2),
('Rafael', 6500.00, 2),


select depart.nome, func.nome, avg(func.salario) as media_salarial
from funcionarios func
    left join departamentos depart 
            on func.id=depart.idFunc
group by depart.nome, func.nome
having avg(func.salario) >=50000

--------------------------------------------------------------------------

-- exercicio 05

select cli.nome, prod.nome, sum(comp.valor_total) as total
from cliente cli
    right join compras comp
        on cli.id=comp.idCliente
    inner join produtos prod 
        on comp.idProd=prod.id
group by cli.nome, prod.nome
