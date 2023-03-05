-- 1- A ordem correta é  Cidade,Filial,Empregado,Produto e Vende           
--------------------------------------------------------------------------
-- 3 a)Criar as tabelas vende e filial.

CREATE TABLE Filial(
    codfilial INT PRIMARY KEY NOT NULL,
    nome VARCHAR(100) NOT NULL,
    endereco VARCHAR(100) NOT NULL,
    codcid VAR(4) NOT NULL,
        CONSTRAINT filial_fk_cidade
            FOREIGN KEY (codcid) REFERENCES cidade (codcid)
            ON UPDATE CASCADE
            ON DELETE RESTRICT
);

CREATE TABLE Vende(
    id INT PRIMARY KEY AUTO-INCREMENT,
    codprod VARCHAR(5) NOT NULL,
         CONSTRAINT Vende_fk_prod
            FOREIGN KEY (codprod) REFERENCES Produtos (cod)
            ON DELETE RESTRICT
            ON UPDATE CASCADE,
    codfilial VAR(4) NOT NULL,
        CONSTRAINT Vende_fk_filial
            FOREIGN KEY (codfilial) REFERENCES Filial (cod)
            ON DELETE RESTRICT
            ON UPDATE CASCADE
);

--------------------------------------------------------------------------
-- 3 b)Listar o valor do produto mais caro.

SELECT max(preco) as maior_valor
FROM Produtos

--------------------------------------------------------------------------
-- 3 c)Obter a média dos preços dos produtos.

SELECT avg(preco) as media_valor
FROM Produtos

--------------------------------------------------------------------------
-- 3 d)Listar o nome dos produtos vendidos pela filial “f3”.(joins)

SELECT prod.descricao
FROM Produtos prod
        inner join Vende 
            on prod.codprod = Vende.codprod
        inner join Filial fil
            on Vende.codfilial = fil.codfilial
where fil.codfilial = 'f3'
group by prod.codprod

--------------------------------------------------------------------------
-- 3 e)Listar os nomes e números de RG dos funcionários que moram 
-- no Rio Grande do Sul e tem salário superior a R$ 500,00.(joins)

SELECT empr.nome,empr.rg
FROM Empregado empr 
        inner join Cidade cid 
            on empr.codcid = cid.codcid
where cid.uf = 'RS'
group by empr.codemp
having empr.salario > 500

--------------------------------------------------------------------------
--4 Defina a sintaxe SQL para a criação das tabelas LIVRO e 
--CATEGORIA. Na criação das tabelas especifique a seguinte 
--restrição: “Quando uma categoria for excluída, todos os livros 
--da categoria em questão também serão excluídos.” 

CREATE TABLE Categoria (
    codcat int primary key auto_increment,
    nome varchar(50) not null,
    descricao varchar(100) not null
);

CREATE TABLE Livro(
    codlivro int primary key auto_increment,
    titulo varchar(50) not null,
    nfolhas int not null,
    editora varchar(50) not null,
    valor decimal(6,2) not null,
    codcat int ,
        constraint Livro_fk_categoria
            foreign key (codcat) references Categoria(codcat)
            on delete cascade
            on update cascade,
    codautor int ,
        constraint Livro_fk_autor
            foreign key (codautor) references Autor(codautor)
        on delete restrict
        on update cascade
);

--------------------------------------------------------------------------
-- 5 a)Mostrar o número total de vendas realizadas. 

SELECT count(quantidade)
FROM Venda

--------------------------------------------------------------------------
-- 5 b)Listar os títulos e valores dos livros da categoria “banco de Dados’.
-- Mostra também o nome da categoria. 

SELECT liv.titulo, liv.valor, cat.nome
FROM Livro liv
        inner join Categoria cat
            on liv.codcat = cat.codcat
where cat.nome LIKE '%anco de %ado%'

--------------------------------------------------------------------------
-- 5 c)Listar os  títulos e nome dos autores dos livros que custam mais que
-- R$ 300,00.Listar os nomes dos clientes juntamente com o nome da cidade 
-- onde moram e UF.

SELECT liv.titulo, aut.nome as nome_autor, cli.nome as nome_cliente, cid.nome as nome_cidade, cid.uf
FROM Venda vend 
        inner join Livro liv    
            on vend.codlivro = liv.codlivro
        inner join Cliente cli 
            on vend.codcliente = cli.codcliente
        inner join Autor aut 
            on liv.codautor = aut.codautor
        inner join Cidade cid
            on cli.codcid = cid.codcid
where liv.valor > 300
group by cli.codcliente

--------------------------------------------------------------------------
-- 5 d)Listar os nomes dos clientes juntamente com os nomes de todos os 
-- livros comprados por ele.

SELECT cli.nome as nome_cliente, liv.nome as nome_livros
FROM Vendas vend
        inner join Livros liv
            on vend.codlivro = liv.codlivro
        inner join Cliente cli 
            on vend.codcliente = cli.codcliente
order by cli.nome

--------------------------------------------------------------------------
-- 5 e)Listar o código do livro, o tilulo, o nome do autor, dos livros que
-- foram vendidos no mês de março de 2021. (join)

SELECT liv.codlivro as codigo_livro, liv.titulo, aut.nome as nome_autor
FROM Livro liv 
        inner join Autor aut 
            on liv.codautor = aut.codautor 
        inner join Venda vend 
            on liv.codlivro = vend.codlivro 
where vend.data between '2021-03-01' and '2021-03-31'

--------------------------------------------------------------------------
-- 5 f)Listar o título e o autor dos 5 livros mais vendidos do mês de janeiro.

SELECT liv.tilulo, aut.nome, sum(vend.quantidade) as quantidade
FROM Livro liv 
        inner join Autor aut 
            on liv.codautor = aut.codautor 
        inner join Venda vend 
            on liv.codlivro = vend.codlivro 
where vend.data between '2023-01-01' and '2023-01-31'
order by quantidade desc
limit 5

--------------------------------------------------------------------------
-- 5 g)Mostrar o nome do cliente que comprou o livro com o título
--  ‘Banco de dados powerful’).

SELECT cli.nome
FROM Vendas vend
        inner join Livros liv
            on vend.codlivro = liv.codlivro
        inner join Cliente cli 
            on vend.codcliente = cli.codcliente
where liv.tilulo LIKE 'Banco de dados powerful'


