-- Insira os seguintes registros na tabela PESSOA:
-- num_pessoa               nome_email
--78360                     rst.marcondes@smail.com
-- 78361                    jcc.meirelles@jmail.com
-- 78362                    mjk.amadeus@imail.com
-- Confirme as inserções realizadas no Exercício 1.
             
CREATE TABLE pessoas (
  num_pessoa INT NOT NULL,
  nome_email VARCHAR(100) NOT NULL,
  PRIMARY KEY (num_pessoa)
);

INSERT INTO pessoas
(num_pessoa, nome_email)
VALUES
(78360, 'rst.marcondes@smail.com'),
(78361, 'jcc.meirelles@jmail.com'),
(78362, 'mjk.amadeus@imail.com');




CREATE TABLE PESSOA_FISICA (
  num_pessoa_pf INT NOT NULL,
  nom_pessoa VARCHAR(100) NOT NULL,
  num_CPF VARCHAR(11) NOT NULL,
  num_documento_identidade VARCHAR(20) NOT NULL,
  nom_orgao_emissor_doc_ident VARCHAR(50) NOT NULL,
  dat_nascimento DATE NOT NULL,
  idt_sexo CHAR(1) NOT NULL,
  cod_estado_civil INT NOT NULL,
  PRIMARY KEY (num_pessoa_pf)
);
INSERT INTO PESSOA_FISICA
(num_pessoa_pf, nom_pessoa, num_CPF, num_documento_identidade, nom_orgao_emissor_doc_ident, dat_nascimento, idt_sexo, cod_estado_civil)
VALUES
(78360, 'Roberto Marcondes', '99911122233', '19999888', 'SSP', '1988-03-15', 'M', 1),
(78361, 'Julio Meirellies', '99811233134', '18888999', 'SSP', '1975-02-17', 'M', 1),
(78362, 'Maria Rita Amadeu', '99711333235', '17777888', 'SSP', '1980-12-23', 'F', 1);


update PESSOA_FISICA set nom_pessoa = 'Júlio Meirelles', cod_estado_civil = 2 where num_pessoa_pf = 78361;


--4 - Confirme as inserções realizadas no Exercício 3.


--5 - Na tabela PESSOA_FISICA, altere o nome da pessoa física com código 78361 para “Júlio Meirelles” e o seu estado civil para 2.

--6 - Consulte a alteração realizada no Exercício 5.


--7 - Desfaça a operação (transação) do Exercício 5.


--8 - Consulte novamente o registro da tabela PESSOA_FISICA cujo código da pessoa seja igual a 78361.

--9 -  Qual foi o resultado da operação realizada no Exercício 8? Justifique.
-- resultou nos dados da pessoa fisica julio meirellies com codigo de estado civil = 1, pois 
-- no exercicio 7 era pra desfazer com um rollback as modificações então voltou ao que era, antes de fazer um commit.

--11 -  Exclua, da tabela PESSOA_FISICA, o registro com código de pessoa igual a 78362.

delete from PESSOA_FISICA where num_pessoa_pf = 78362;

rollback;

-- 13 - Altere o campo data de nascimento, da tabela PESSOA_FISICA,
--  cujo código da pessoa seja 78362, para 13/01/1998.

update PESSOA_FISICA set dat_nascimento = '1998-01-13' where num_pessoa_pf = 78362;

-- 14 - Altere o campo número do RG, da tabela PESSOA_FISICA, 
-- cujo código da pessoa seja 78362, para 13321142.

update PESSOA_FISICA set num_documento_identidade = 13321142 where num_pessoa_pf = 78362;

update PESSOA_FISICA SET num_documento_identidade = 13321142, dat_nascimento = '1998-01-13' where num_pessoa_pf = 78362;

--  16- As transações realizadas nos Exercícios 13 e 14 poderiam ser 
-- realizadas em uma única operação? Escreva a instrução para isso e 
-- confirme a transação.

