CREATE TABLE produtos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    valor DECIMAL(10,2) NOT NULL,
    saldo INT NOT NULL
);

CREATE TABLE orcamentos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    data DATE NOT NULL,
    status VARCHAR(20) NOT NULL
);

CREATE TABLE orcamentos_itens (
    id_prod INT NOT NULL,
    id_orc INT NOT NULL,
    valor_unit DECIMAL(10,2) NOT NULL,
    quantidade INT NOT NULL,
    valor_total_item DECIMAL(10,2) NOT NULL,
    CONSTRAINT prod_fk_orc_items
        FOREIGN KEY (id_prod) REFERENCES produtos(id)
            on update cascade on delete restrict,
    CONSTRAINT orc_fk_orc_items
        FOREIGN KEY (id_orc) REFERENCES orcamentos(id)
            on update cascade on delete restrict
);


INSERT INTO produtos (nome, valor, saldo) VALUES
('Produto A', 10.50, 50),
('Produto B', 20.75, 100),
('Produto C', 5.90, 30),
('Produto D', 35.20, 75),
('Produto E', 15.00, 60),
('Produto F', 12.80, 45),
('Produto G', 18.50, 80),
('Produto H', 28.90, 25),
('Produto I', 8.25, 90),
('Produto J', 40.00, 120),
('Produto K', 22.50, 55),
('Produto L', 16.70, 70),
('Produto M', 9.40, 40),
('Produto N', 31.10, 85),
('Produto O', 26.00, 65),
('Produto P', 14.50, 95),
('Produto Q', 19.80, 50),
('Produto R', 11.30, 80),
('Produto S', 23.75, 70),
('Produto T', 36.90, 110),
('Produto U', 7.60, 25),
('Produto V', 42.50, 90),
('Produto W', 27.80, 65),
('Produto X', 13.25, 50),
('Produto Y', 17.00, 75),
('Produto Z', 30.50, 100);

INSERT INTO orcamentos (data, status) VALUES
('2022-01-01', 'Em orçamento'),
('2022-01-05', 'Em orçamento'),
('2022-01-08', 'Vendido'),
('2022-01-10', 'Em orçamento'),
('2022-01-12', 'Cancelado'),
('2022-01-15', 'Vendido'),
('2022-01-18', 'Em orçamento'),
('2022-01-22', 'Vendido'),
('2022-01-25', 'Em orçamento'),
('2022-01-27', 'Em orçamento'),
('2022-01-30', 'Cancelado'),
('2022-02-02', 'Vendido'),
('2022-02-05', 'Vendido'),
('2022-02-08', 'Em orçamento'),
('2022-02-12', 'Em orçamento'),
('2022-02-15', 'Cancelado'),
('2022-02-18', 'Vendido'),
('2022-02-22', 'Vendido'),
('2022-02-25', 'Em orçamento'),
('2022-02-28', 'Em orçamento'),
('2022-03-03', 'Cancelado');


INSERT INTO orcamentos_itens (id_prod, id_orc, valor_unit, quantidade, valor_total_item) VALUES
(1, 1, 500.00, 2, 1000.00),
(2, 1, 1000.00, 1, 1000.00),
(3, 2, 800.00, 3, 2400.00),
(4, 2, 200.00, 10, 2000.00),
(5, 3, 300.00, 5, 1500.00),
(6, 3, 600.00, 2, 1200.00),
(7, 4, 1500.00, 1, 1500.00),
(8, 4, 900.00, 4, 3600.00),
(9, 5, 400.00, 7, 2800.00),
(10, 5, 700.00, 1, 700.00),
(11, 6, 250.00, 4, 1000.00),
(12, 6, 350.00, 3, 1050.00),
(13, 7, 100.00, 20, 2000.00),
(14, 7, 50.00, 30, 1500.00),
(15, 8, 900.00, 2, 1800.00),
(16, 8, 1500.00, 1, 1500.00),
(17, 9, 500.00, 4, 2000.00),
(18, 9, 1200.00, 1, 1200.00),
(19, 10, 700.00, 3, 2100.00),
(20, 10, 800.00, 2, 1600.00),
(21, 11, 1500.00, 1, 1500.00),
(22, 11, 1000.00, 2, 2000.00),
(23, 12, 300.00, 6, 1800.00),
(24, 12, 600.00, 3, 1800.00),
(25, 13, 400.00, 5, 2000.00);



create view vw_produt_orcam_item  (id, nome_prod,data_orcamento, status, valor_total, estoque ) as
    select prod.id as id, prod.nome as nome_prod, orc.data as data_orcamento, orc.status, sum(orc_item.valor_total_item) as valor_total, prod.saldo as estoque
    from orcamentos orc 
            join orcamentos_itens orc_item 
                on orc.id=orc_item.id_orc 
            join produtos prod 
                on orc_item.id_prod=prod.id 
    where orc.data >='2022-01-01' and orc.data<='2022-01-31' and prod.nome LIKE "%Produto B%" and prod.saldo> 0 and orc_item.valor_unit>10
    group by prod.id
    order by valor_total desc
    limit 10
--esse acho q nao faz sentido pois nao atende a todos os requesitos
create view orcamento_produtos(id, nome_prod,data_orcamento, status, valor_total, estoque ) as
    select prod.id as id, prod.nome as nome_prod, orc.data as data_orcamento, orc.status, sum(orc_item.valor_total_item) as valor_total, prod.saldo as estoque
    from orcamentos orc 
            join orcamentos_itens orc_item 
                on orc.id=orc_item.id_orc 
            join produtos prod 
                on orc_item.id_prod=prod.id 
    order by nome_prod acs


-- adicionar 20%
select prod.id, nome_prod, prod.valor, (prod.valor * 1.2)as valor_mais20
from produtos prod
        inner join vw_produt_orcam_item vw
            on prod.id = vw.id 
where estoque <= 5

-- deleter os produtos nao orçados
delete produtos from produtos prod
        left join orcamentos_itens 
            on prod.id = orcamentos_itens.id_prod
where orcamentos_itens.id_prod is null
    

-- Explique quando utilizar o GROUP BY, de um exemplo sql.
-- o group by serve para agrupar as tuplas quando tem uma função de agregação

select turma.numero as numero_turma, count(alunos) as qtd_por_turma
from alunos 
    inner join turma_aluno
        on id.aluno = turma_aluno.id_aluno
    inner join turma
        on turma_aluno.id_turma=turma.id
group by turma.numero

--Explique quando utilizar o HAVING, de um exemplo sql.
--o having é where do group by, é uma espécie de condição do group by

select turma.numero as numero_turma, count(alunos) as qtd_por_turma
from alunos 
    inner join turma_aluno
        on id.aluno = turma_aluno.id_aluno
    inner join turma
        on turma_aluno.id_turma=turma.id
group by turma.numero
having qtd_por_turma > 20

--Explique quando utilizar o UNION, de um exemplo sql.
-- ele seleciona apenas valores distintos entre as tabelas, é um select distinct entre tabelas

--table_A       table_B
--  A               B
--  B               C
--  C               D

select * from table_A
UNION
select * from table_B

resultado
    A 
    B 
    C 
    D 


--Explique quando utilizar o LEFT JOIN, de um exemplo sql.
-- ele mostra todas as tuplas da esquerda, a primeira table, e as tuplas correspondentes da direita 
-- assim ele mostrará todas as tuplas da esquerda mesmo que não tenha correspondencia na direita
--nesse caso irá mostra null

select prod.id, vend.status
from produtos prod 
    left join vendas vend 
        on prod.id = vend.id_prod

-- irá retornar todos os produtos mesmo quenão tenham vendas.