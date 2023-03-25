-- Crie uma view chamada "livros_mais_vendidos" que exiba o título, autor, preço
-- e a quantidade de vezes que cada livro foi vendido.

create view livros_mais_vedidos as
select liv.titulo, aut.nome as nome_autor, liv.valor_unit as preco, count(vend_liv.qtd)as qtd_total
from Autores aut
        inner join Autores_livros a_l
            on aut.id = a_l.id_autor
        inner join Livros liv 
            on a_l.id_livro = liv.id
        inner join vendas_livros vend_liv
            on liv.id = vend_liv.id_livro
group by liv.id
order by qtd_total desc

--Crie uma view que lista os autores que nunca venderam livros.
create view autores_sem_vendas as
select nome
from Autores
where id in(select Autores_livros.id_autor
            from Autores_livros 
                    left join vendas_livros
                        on Autores_livros.id_livro = vendas_livros.id_livro
            where vendas_livros.id_livro is null);



-- clientes que ganharam mais desconto, nome, valor real do livro e valor do desconto
-- teria que ter a FK id_venda na tabela vendas_livros

select cli.nome as nome_cliente, liv.valor_unit as valor_livro, (liv.valor_unit - vend_liv.valor_unit)as disconto
from Cliente cli
        inner join Vendas vend 
            on cli.id = vend.id_cliente
        inner join vendas_livros vend_liv 
            on vend.id = vend_liv.id_venda
        inner join Livros liv 
            on vend_liv.id_livro = liv.id 
where vend_liv.valor_unit < liv.valor_unit
order by disconto desc
