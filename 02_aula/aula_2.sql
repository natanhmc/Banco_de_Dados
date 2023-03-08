-- quais produtos foram vendidos no mesde fevereiro 
select p.id,p.nome
from vendas v 
        inner join venda_produtos vp
            on v.id=vp.id_venda
        inner join produtos p
            on p.id=vp.id_produto
where v.data >= '2023-02-01' and '2023-02-28'
