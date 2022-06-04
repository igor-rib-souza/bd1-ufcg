----Questão 1

CREATE TABLE tarefas (
id INTEGER,
descricao TEXT,
codigo CHAR(11),
numero SMALLINT,
tipo CHAR(1)
);


--Inputs que devem funcionar:

INSERT INTO tarefas VALUES(2147483646,'limpar chão do corredor central','98765432111',0,'F');
INSERT INTO tarefas VALUES(2147483647,'limpar janelas da sala 203','98765432122',1,'F');
INSERT INTO tarefas VALUES(null,null,null,null,null);


--Inputs que NÃO devem funcionar:

INSERT INTO tarefas VALUES(2147483644,'limpar chão do corredor superior','987654323211',0,'F');
INSERT INTO tarefas VALUES(2147483643,'limpar chão do corredor superior','98765432321',0,'FF');







----Questão 2

INSERT INTO tarefas VALUES(2147483648,'limpar portas do térreo','32323232955',4,
'A');


--Isso causará um erro, solução a seguir:

ALTER TABLE tarefas ALTER COLUMN id TYPE BIGINT;

--Então realizar a inserção:

INSERT INTO tarefas VALUES(2147483648,'limpar portas do térreo','32323232955',4,
'A');





----Questão 3

/*
A tabela já havia sido criada com o tipo SMALLINT, ent não foi necessária nenhuma alteração
nessa etapa
*/

--Comandos que NÃO devem funcionar:

INSERT INTO tarefas VALUES(2147483649,'limpar portas da entrada principal','32322525199',32768,'A');
INSERT INTO tarefas VALUES(2147483650,'limpar janelas da entrada principal','32333233288',32769,'A');


--Comandos que DEVEM funcionar 

INSERT INTO tarefas VALUES(2147483651,'limpar portas do 1o andar','32323232911',32767,'A');
INSERT INTO tarefas VALUES(2147483652,'limpar portas do 2o andar','32323232911',32766,'A');




---Questão 4

--Removendo as tuplas que contém valores NULL para evitar erros
DELETE FROM tarefas WHERE id IS NULL OR descricao IS NULL OR codigo IS NULL OR numero IS NULL OR tipo IS NULL;

--Alterando a tabela igual a questão 4 pediu:

ALTER TABLE tarefas ALTER COLUMN id SET NOT NULL;

ALTER TABLE tarefas ALTER COLUMN descricao SET NOT NULL;

ALTER TABLE tarefas ALTER COLUMN codigo SET NOT NULL;
ALTER TABLE tarefas RENAME COLUMN codigo TO func_resp_cpf;

ALTER TABLE tarefas ALTER COLUMN numero SET NOT NULL;
ALTER TABLE tarefas RENAME COLUMN numero TO prioridade;

ALTER TABLE tarefas ALTER COLUMN tipo SET NOT NULL;
ALTER TABLE tarefas RENAME COLUMN tipo TO status;




---Questão 5

--Adicionando uma primary key para resolver o pedido na questão:

ALTER TABLE tarefas ADD PRIMARY KEY (id);


--DEVE funcionar normalmente:

INSERT INTO tarefas VALUES(2147483653,'limpar portas do 1o andar','32323232911',2,'A');

--NÃO deve funcionar após a inserção anterior ter sido executada:
--DEVE retornar o erro: ¨ERROR: duplicate key values violates unique constraint ¨tarefas_pkey¨

INSERT INTO tarefas VALUES(2147483653,'aparar a grama da área frontal','32323232911',3,'A');




---Questão 6

--6 - A: 

ALTER TABLE tarefas ADD CHECK (LENGTH(func_resp_cpf) = 11);

--testes:
--cpf com 4 caracteres

INSERT INTO tarefas VALUES (0000000000, 'limpar', '1111', 2, 'A'); -- inserção não realizada

--6 - B: 

-- Atualizar valores

UPDATE tarefas SET status = 'P' WHERE status = 'A'; 
UPDATE tarefas SET status = 'E' WHERE status = 'R'; 
UPDATE tarefas SET status = 'C' WHERE status = 'F'; 

-- Adicionando o check pedido na questão
ALTER TABLE tarefas ADD CHECK (status IN ('P','E','C'));




--- Questão 7

-- Removendo as tuplas com prioridade maior que 5
UPDATE tarefas SET prioridade = 5 WHERE prioridade > 5;

-- Adicionando o pedido da questão
ALTER TABLE tarefas ADD CHECK (prioridade >= 0 AND prioridade <= 5);




--- Questão 8
CREATE TABLE funcionario (
  cpf CHAR(11) PRIMARY KEY,
  data_nasc DATE NOT NULL,
  nome VARCHAR(100) NOT NULL,
  funcao VARCHAR(11) NOT NULL,
  nivel CHAR(1) NOT NULL,
  superior_cpf CHAR(11) REFERENCES funcionario (cpf),
  CHECK (funcao = 'SUP_LIMPEZA' OR (funcao = 'LIMPEZA' AND superior_cpf IS NOT NULL)),
  CHECK (nivel IN ('J', 'P', 'S'))
);

-- Inserções que DEVEM funcionar
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES
('12345678911', '1980-05-07', 'Pedro da Silva', 'SUP_LIMPEZA', 'S', null); 

INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES
('12345678912', '1980-03-08', 'Jose da Silva', 'LIMPEZA', 'J', '12345678911'); 

--NÃO deve funcionar
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES






--- Questão 9
-- Realizando a inserção de 10 exemplos
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) 
VALUES
  ('12345678913', '1985-02-04', 'Fulano da Cunha', 'SUP_LIMPEZA', 'S', null),
  ('12345678914', '1992-11-12', 'Cicrano da Silva', 'SUP_LIMPEZA', 'S', '12345678913'),
  ('12345678915', '1989-04-06', 'Vilela Nela', 'SUP_LIMPEZA', 'P', null),
  ('12345678916', '2001-08-17', 'Micaela Panela', 'LIMPEZA', 'J', '12345678914'),
  ('12345678917', '1999-12-01', 'Brono Diorno', 'SUP_LIMPEZA', 'J', null),
  ('12345678918', '1992-08-24', 'Mara Vilha', 'LIMPEZA', 'P', '12345678913'),
  ('12345678919', '1980-06-18', 'Paula Dente', 'SUP_LIMPEZA', 'S', null),
  ('12345678920', '1983-02-09', 'Roberto Carlos', 'LIMPEZA', 'P', '12345678919'),
  ('12345678921', '1996-07-26', 'Samuka Duarte', 'SUP_LIMPEZA', 'P', null),
  ('12345678922', '1988-03-08', 'Adolfo Ritchstofen', 'SUP_LIMPEZA', 'J', '12345678919'); 
  
-- 10 exemplos de inserções que não funcionam

-- nivel = 'A' não é permitido, só são permitidos os valores 'J', 'P' ou 'S'
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES
('12345678923', '1985-02-19', 'Tomas Shelby', 'SUP_LIMPEZA', 'A', null); -- inserção não realizada 

-- funcao = 'LIMPEZA', mas superior_cpf = null, o que não é permitido
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES
('12345678924', '1982-11-11', 'Jhon Shelby', 'LIMPEZA', 'S', null); -- inserção não realizada

-- a chave estrangeira, superio_cpf, aponta para um funcionário que não existe, o que não é permitido
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES
('12345678925', '1986-05-08', 'Arthur Shelby', 'LIMPEZA', 'J', '12345675820');
-- a chave primária, cpf, é igual a chave primária de outro funcionário, o que não é permitido
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES
('12345678913', '1986-04-13', 'Graze Massafera', 'SUP_LIMPEZA', 'P', null); 
-- funcao = 'GERENTE' não é permitido, só são permitidos os valores 'SUP_LIMPEZA' ou 'LIMPEZA'
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES
('12345678932', '1987-01-02', 'Caua Raymond', 'GERENTE', 'J', null);
-- a chave primária, cpf, não pode ser null
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES
(null, '1992-03-11', 'Fausto Silva', 'SUP_LIMPEZA', 'S', null);

-- a coluna data_nasc não pode ser null
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES
('12345678928', null, 'Edson Arantes', 'SUP_LIMPEZA', 'P', null);
-- a coluna nome não pode ser null
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES
('12345678929', '1999-10-03', null, 'SUP_LIMPEZA', 'P', null);
-- a coluna funcao não pode ser null
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES
('12345678930', '1986-06-16', 'Caldeirão doHulk', null, 'J', null); 
-- a coluna nivel não pode ser null
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES
('12345678931', '1987-07-18', 'Red Sete', 'SUP_LIMPEZA', null, null); 
 



--- Questão 10
--- (OPÇÃO 1) ON DELETE CASCADE

--chave estrangeira de acordo com a OPÇÃO 1
-- funciona após executar o código da solução
ALTER TABLE tarefas ADD FOREIGN KEY (func_resp_cpf) REFERENCES funcionario (cpf) ON DELETE CASCADE;

-- Erro exibido

ERROR:  insert or update on table 'tarefas' violates foreign key constraint 'tarefas_func_resp_cpf_fkey'
DETAIL:  Key (func_resp_cpf)=(32323232955) is not present in table 'funcionario'.


-- Solução: 
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) 
VALUES
  ('32323232955', '1985-02-19', 'Sara Ramos', 'SUP_LIMPEZA', 'S', null),
  ('32323232911', '1982-11-11', 'Ariana Mendes', 'SUP_LIMPEZA', 'S', '12345678911'),
  ('98765432111', '1986-05-08', 'Milene Solano', 'LIMPEZA', 'J', '12345678911'),
  ('98765432122', '1986-04-13', 'Afonso Barbosa', 'SUP_LIMPEZA', 'P', null); -- inserção realizada

-- Realizando a remoção do funcionário com o 'menor' cpf que possui alguma tarefa

-- 1° Passo
-- Executando um SQL para encontrar o funcionário requisitado
SELECT f.* FROM funcionario f INNER JOIN tarefas t ON
f.cpf = t.func_resp_cpf GROUP BY f.cpf ORDER BY CAST(f.cpf AS DECIMAL) LIMIT 1;

-- Resultado exibido da consulta realizada no 1° Passo
"""       
     cpf     | data_nasc  |     nome      |   funcao    | nivel | superior_cpf
-------------+------------+---------------+-------------+-------+--------------
 32323232911 | 1982-11-11 | Ariana Mendes | SUP_LIMPEZA | S     | 12345678911
"""

-- 2° Passo
-- Executando um SQL para deletar o funcionário encontrado no 1° Passo
DELETE FROM funcionario f WHERE f.cpf = '32323232911'; -- delete realizado


--- (OPÇÃO 2) ON DELETE RESTRICT

-- Adicionando a chave estrangeira de acordo com a OPÇÃO 2
ALTER TABLE tarefas DROP CONSTRAINT tarefas_func_resp_cpf_fkey;
ALTER TABLE tarefas ADD FOREIGN KEY (func_resp_cpf) REFERENCES funcionario (cpf) ON DELETE RESTRICT;

-- Executando um comando DELETE que seja bloqueado pela constraint adicionada 

-- Tentar remover algum funcionário que possui alguma tarefa
-- Executando um SQL para encontrar os funcionários requisitados
SELECT f.* FROM funcionario f INNER JOIN tarefas t ON
f.cpf = t.func_resp_cpf GROUP BY f.cpf;

-- Resultado da consulta realizada

     cpf     | data_nasc  |      nome      |   funcao    | nivel | superior_cpf
-------------+------------+----------------+-------------+-------+--------------
 32323232955 | 1985-02-19 | Sara Ramos     | SUP_LIMPEZA | S     |
 98765432111 | 1986-05-08 | Milene Solano  | LIMPEZA     | J     | 12345678911
 98765432122 | 1986-04-13 | Afonso Barbosa | SUP_LIMPEZA | P     |


-- Executando um SQL para deletar o funcionário escolhido, Afonso Barbosa
DELETE FROM funcionario f WHERE f.cpf = '98765432122';

-- Erro exibido

ERROR:  update or delete on table 'funcionario' violates foreign key constraint 'tarefas_func_resp_cpf_fkey' on table 'tarefas'
DETAIL:  Key (cpf)=(98765432122) is still referenced from table 'tarefas'.



--- Questão 11 


-- Removendo da tabela tarefas o NOT NULL da coluna func_resp_cpf
ALTER TABLE tarefas ALTER COLUMN func_resp_cpf DROP NOT NULL;

-- A coluna func_resp_cpf pode ser NULL somente se status for igual a 'P'

-- Removendo a constraint existente da coluna status para adicionala novamente acrescentando a condição imposta na coluna func_resp_cpf
ALTER TABLE tarefas DROP CONSTRAINT tarefas_status_check;
-- Adicionando a constraint pedida na questão
ALTER TABLE tarefas ADD CHECK ((status IN ('E', 'C') AND func_resp_cpf IS NOT NULL) OR status = 'P');

-- Realizando os testes da constraint

-- Inserções que NÃO devem funcionar
-- func_resp_cpf = '12345678921', status = 'A'
INSERT INTO tarefas VALUES (2200000000, 'limpar portas do 3o andar', '12345678921', 3, 'A'); -- inserção não realizada
-- func_resp_cpf = '12345678921', status = 'R'
INSERT INTO tarefas VALUES (2300000000, 'limpar portas do 4o andar', '12345678921', 3, 'R'); -- inserção não realizada
-- func_resp_cpf = '12345678921', status = 'F'
INSERT INTO tarefas VALUES (2400000000, 'limpar portas do 5o andar', '12345678921', 3, 'F'); -- inserção não realizada
-- func_resp_cpf = '12345678921', status = 'T'
INSERT INTO tarefas VALUES (2500000000, 'limpar portas do 6o andar', '12345678921', 3, 'T'); -- inserção não realizada
-- func_resp_cpf = null, status = 'E'
INSERT INTO tarefas VALUES (2600000000, 'limpar portas do 3o andar', null, 5, 'E'); -- inserção não realizada
-- func_resp_cpf = null, status = 'C'
INSERT INTO tarefas VALUES (2700000000, 'limpar portas do 3o andar', null, 5, 'C'); -- inserção não realizada

-- Inserções que devem funcionar 
-- func_resp_cpf = '12345678921', status = 'P'
INSERT INTO tarefas VALUES (2200000000, 'limpar portas do 3o andar', '12345678921', 3, 'P'); 
-- func_resp_cpf = null, status = 'P'
INSERT INTO tarefas VALUES (2300000000, 'limpar portas do 3o andar', null, 5, 'P'); 
-- func_resp_cpf = '12345678921', status = 'E'
INSERT INTO tarefas VALUES (2400000000, 'limpar portas do 4o andar', '12345678921', 3, 'E'); 
-- func_resp_cpf = '12345678921', status = 'C'
INSERT INTO tarefas VALUES (2500000000, 'limpar portas do 5o andar', '12345678921', 3, 'C'); 

-- deletando as tuplas de testes inseridas na tabela
DELETE FROM tarefas WHERE func_resp_cpf = '12345678921' OR func_resp_cpf IS NULL; 

--- ON DELETE SET NULL

-- Adicionando a chave estrangeira de acordo com a questão
ALTER TABLE tarefas DROP CONSTRAINT tarefas_func_resp_cpf_fkey;
ALTER TABLE tarefas ADD FOREIGN KEY (func_resp_cpf) REFERENCES funcionario (cpf) ON DELETE SET NULL;



-- Testanto deletar um funcionário com três tarefas com status diferentes
--tuplas de teste:
INSERT INTO tarefas 
VALUES 
  (2200000000, 'limpar portas do 3o andar', '12345678921', 5, 'P'), 
  (2300000000, 'limpar janelas do 3o andar', '12345678921', 5, 'E'),
  (2400000000, 'limpar piso do 3o andar', '12345678921', 5, 'C'); 

-- Deletando o funcionário
DELETE FROM funcionario WHERE cpf = '12345678921'; -- delete não realizado 

-- Erro exibido
ERROR:  new row for relation 'tarefas' violates check constraint 'tarefas_check'
DETAIL:  Failing row contains (2300000000, limpar janelas do 3o andar, null, 5, E).
CONTEXT:  SQL statement 'UPDATE ONLY 'public'.'tarefas' SET 'func_resp_cpf' = NULL WHERE $1 OPERATOR(pg_catalog.=) 'func_resp_cpf''

-- Testanto deletar 3 funcionários, onde cada um possui uma tarefa de status diferente
-- Atualizando as tuplas de teste
UPDATE tarefas SET func_resp_cpf = '12345678917' WHERE id = 2300000000;
UPDATE tarefas SET func_resp_cpf = '12345678918' WHERE id = 2400000000;

-- deletando o funcionário que está ligado a tarefa com o status igual a 'P'
DELETE FROM funcionario WHERE cpf = '12345678921'; -- delete realizado

-- deletando o funcionário que está ligado a tarefa com o status igual a 'E'
DELETE FROM funcionario WHERE cpf = '12345678917'; -- delete não realizado

-- Erro:
ERROR:  new row for relation 'tarefas' violates check constraint 'tarefas_check'
DETAIL:  Failing row contains (2300000000, limpar janelas do 3o andar, null, 5, E).
CONTEXT:  SQL statement 'UPDATE ONLY 'public'.'tarefas' SET 'func_resp_cpf' = NULL WHERE $1 OPERATOR(pg_catalog.=) 'func_resp_cpf''

-- deletando o funcionário que está ligado a tarefa com o status igual a 'C'
DELETE FROM funcionario WHERE cpf = '12345678918';-- delete não realizado

-- Erro:
ERROR:  new row for relation 'tarefas' violates check constraint 'tarefas_check'
DETAIL:  Failing row contains (2400000000, limpar piso do 3o andar, null, 5, C).
CONTEXT:  SQL statement 'UPDATE ONLY 'public'.'tarefas' SET 'func_resp_cpf' = NULL WHERE $1 OPERATOR(pg_catalog.=) 'func_resp_cpf''


-- deletando as tuplas de testes inseridas na tabela
DELETE FROM tarefas WHERE id = 2200000000 OR id = 2300000000 OR id = 2400000000;
