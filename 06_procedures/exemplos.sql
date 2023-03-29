
drop procedure getPersonByName;

DELIMITER $$
CREATE PROCEDURE getPersonByName(name varchar(50))
BEGIN

	select *
    from clientes
    where nome like concat('%',name,'%');
    
END $$
DELIMITER ;

call getDateTime();

call getPersonByName('la');




DELIMITER $$
CREATE PROCEDURE cru_pessoas(p_id int , p_nome varchar(100), oper char(1))
BEGIN

	if(oper = '1') then
		insert into clientes(nome) value(p_nome);
	else if(oper = '2') then
        update clientes set nome = p_nome where id = p_id;
	elseif(oper = '3') then
		-- delete
        delete from clientes where id = p_id;
	else
		select 'insira 1 para insert, 2 para update e 3 para delete';
    end if;
    
END $$
DELIMITER ;

drop procedure cud_pessoas;
DELIMITER $$
CREATE PROCEDURE cud_pessoas(p_id int, p_nome VARCHAR(100), p_oper char(1))
BEGIN

	if(p_oper = '1' )then
		-- insert
        insert into pessoas(name) value(nome);
    elseif(p_oper='2') then
		-- update
        update pessoas set nome = p_nome where id = p_id;
    elseif(p_oper='3') then
		-- delete
        delete from pessoas where id = p_id;
        select concat('pessoa do id',p_id,'deletado com sucesso');
	else
		select 'insira 1 para insert, 2 para update e 3 para delete';
    end if;

END $$
DELIMITER ;

call cud_pessoas(0,'Gisa',1);

-- desafio era fazer uma procedure para fazer uma tabuada e armazenala em uma e tabela tabuada.

--a tabela tabuadas deve ter os campos 
--numero e tabuada


create table tabuada (
	result int,
    tabuada int
    );


drop procedure tabuada;

DELIMITER $$
    CREATE PROCEDURE tabuada(num int )
    BEGIN
    declare i int;
    declare resultado int;
    declare contem int;
    set contem = ( select count(tabuada) from tabuada where tabuada= num);
        if contem = 0 then
            set i = 0;
            while i<=10 do
                set resultado = 0;
                    select concat(num,' x ',i,'=', i*num);
                set resultado = i*num;
                    insert into tabuada(result,tabuada) value (resultado,num);
                set i = i+1;
            end while;
        else 
            select * from tabuada where tabuada = num;
        end if;
    END $$
DELIMITER ;

call tabuada(9);

select * from tabuada;

