-- quais produtos foram vendidos no mes de fevereiro 
select distinct p.id,p.nome
from vendas v 
        inner join venda_produtos vp
            on v.id=vp.id_venda
        inner join produtos p
            on p.id=vp.id_produto
where v.data >= '2023-02-01' and '2023-02-28'


-- mostra tambem o total de vendas de cada produto

select p.id as codigo, p.nome as produto, sum(vp.preco * vp.qtd) as valor_total
from vendas v 
        inner join venda_produtos vp
            on v.id=vp.id_venda
        inner join produtos p
            on p.id=vp.id_produto
where v.data >= '2023-02-01' and '2023-02-28'
group by p.id

-- pega somente os produtos onde o total das vendas é maior que 1000

select p.id as codigo, p.nome as produto, sum(vp.preco * vp.qtd) as valor_total
from vendas v 
        inner join venda_produtos vp
            on v.id=vp.id_venda
        inner join produtos p
            on p.id=vp.id_produto
where v.data >= '2023-02-01' and '2023-02-28'
group by p.id
having total > 1000
order by total desc   -- os mais vendidos 
limit 5                 -- o top 5 


-- desse 5   somente os que custam mais que 100
--  adiciona um where    ' and vp.valor_unit > 100