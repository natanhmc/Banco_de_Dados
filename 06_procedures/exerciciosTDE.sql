--Escreva uma SP que receba, como parâmetro, o CPF de um autor e retorne a
-- quantidade de livros escrito pelo mesmo.

DELIMITER $$
CREATE PROCEDURE qtd_livros_autores(cpf_aut varchar(14))
BEGIN

	select 
    from clientes
    where nome like concat('%',name,'%');
    
END $$
DELIMITER ;