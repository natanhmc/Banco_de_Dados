--Criando a table Pessoas
CREATE TABLE Pessoas (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(255) NOT NULL,
  sexo CHAR(1),
  data_nascimento DATE
);

--Inserts na table Pessoas 

INSERT INTO Pessoas (nome, sexo, data_nascimento)
VALUES
  ('Maria', 'F', '1990-01-01'),
  ('João', 'M', '1991-02-02'),
  ('Pedro', 'M', '1992-03-03'),
  ('Ana', 'F', '1993-04-04'),
  ('Lucas', 'M', '1994-05-05'),
  ('Juliana', 'F', '1995-06-06'),
  ('Fernando', 'M', '1996-07-07'),
  ('Cristina', 'F', '1997-08-08'),
  ('Paulo', 'M', '1998-09-09'),
  ('Carla', 'F', '1999-10-10'),
  ('Gustavo', 'M', '2000-11-11'),
  ('Roberta', 'F', '2001-12-12'),
  ('Thiago', 'M', '2002-01-13'),
  ('Renata', 'F', '2003-02-14'),
  ('Felipe', 'M', '2004-03-15');
--------------------------------------------------------------------------
-- Criando a precedure para adicionar pessoas
-- nesse caso ja é auto increment 

DELIMITER $$
    CREATE PROCEDURE AddPessoa(add_nome VARCHAR(30),add_sexo CHAR(1),add_data DATE)
    BEGIN
        INSERT INTO Pessoas (nome, sexo, data_nascimento)
        VALUES
            (add_nome, add_sexo, add_data);

    END $$
DELIMITER ;

-- neste caso a procedure faz o papel de auto increment

DELIMITER $$
    CREATE PROCEDURE AddPessoaNova(add_nome VARCHAR(30),add_sexo CHAR(1),add_data DATE)
    BEGIN
        declare var_last_id int default 0;
        if((select count(id) from Pessoas) = 0) then
            set var_last_id = 1;
        else
            set var_last_id = ((select max(id) from Pessoas) + 1)
        end if;
        insert into Pessoas values(var_last_id, add_nome, add_sexo, add_data);
        select * from Pessoas where id = var_last_id;

    END $$
DELIMITER ;


-- Chamando a procedure e passando os parametros 

call AddPessoa('Natan', 'M', '1997-02-26');

--------------------------------------------------------------------
-- Criando a precedure para contar pro sexo

DELIMITER $$
    CREATE PROCEDURE ContSex()
    BEGIN
        SELECT COUNT(id) INTO @qtdHomens FROM Pessoas WHERE sexo LIKE 'M';
        SELECT COUNT(id) INTO @qtdMulheres FROM Pessoas WHERE sexo LIKE 'F';
        SELECT @qtdMulheres, @qtdHomens;
    END$$
DELIMITER ;

-- Chamando a procedure
call ContSex;

-----------------------------------------------
-- criando a procedure

DELIMITER $$
CREATE PROCEDURE MeioresMenores()
BEGIN
    SELECT COUNT(id) INTO @qtdHomensMaior FROM Pessoas WHERE sexo LIKE 'M' AND (CURDATE() - data_nascimento) >= 18;
	SELECT COUNT(id) INTO @qtdMulheresMaior FROM Pessoas WHERE sexo LIKE 'F' AND (CURDATE() - data_nascimento) >= 18;
    
    SELECT COUNT(id) INTO @qtdHomensMenor FROM Pessoas WHERE sexo LIKE 'M' AND (CURDATE() - data_nascimento) < 18;
	SELECT COUNT(id) INTO @qtdMulheresMenor FROM Pessoas WHERE sexo LIKE 'F' AND (CURDATE() - data_nascimento) < 18;


    SELECT @qtdHomensMaior, @qtdHomensMenor, @qtdMulheresMaior, @qtdMulheresMenor;
END$$
DELIMITER ;

-- chamando a procedure
call MeioresMenores;
-------------------------------------------------------
-- procedure para calcular os numeros
DELIMITER $$
    CREATE PROCEDURE DoisNumeros(num1 float, num2 float)
    BEGIN
        SELECT CONCAT('a soma dos numeros fica: ', num1+num2);
        SELECT CONCAT('a diferença dos numeros fica: ', num1-num2);
        SELECT CONCAT('a multiplicaçao dos numeros fica: ', num1*num2);
        SELECT CONCAT('a divisao dos numeros fica: ', num1/num2);
    END $$
DELIMITER ;

call DoisNumeros(13,23);