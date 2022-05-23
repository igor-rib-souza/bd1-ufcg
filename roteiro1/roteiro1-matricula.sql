--QUESTÃO 1
/*
AUTOMOVEL{
	placa
	ano_fabricacao
	quilometragem
	cor_carro
	renavam
	volume_tanque_combustivel
	proprietario_cpf
	modelo_automovel
}

SEGURADO{
	nome
	cpf
	rg
	data_nascimento
	endereco
	telefone
	plano_seguro
}

PERITO{
	nome
	cpf
	rg
	telefone
	data_nascimento
}

OFICINA{
	cnpj
	razao_social
	telefone
	numero_empregados
	proprietario
	data_abertura_cnpj
}

SEGURO{
	id
	titular
	cpf_titular
	data_inicio
	data_fim
	valor
	tipo
}

SINISTRO{
	id
	tipo
	hora_acidente
	relatorio
}

PERICIA{
	id
	cpf_perito
	data_inicio
	data_fim
}

REPARO{
	id
	valor
	data_inicio
	data_fim
}
*/



--QUESTÃO 2


--Sobre o automovel
CREATE TABLE AUTOMOVEL (
placa VARCHAR(10),
ano_fabricacao INTEGER,
quilometragem INTEGER,
cor_carro VARCHAR(15),
renavam VARCHAR(11),
volume_tanque_combustivel INTEGER,
proprietario_cpf INTEGER,
modelo_automovel VARCHAR(20)
);


CREATE TABLE SEGURADO (
nome VARCHAR(100),
cpf INTEGER,
rg INTEGER,
data_nascimento DATE,
endereco VARCHAR(200),
telefone VARCHAR(20),
plano_seguro VARCHAR(15)
);

CREATE TABLE PERITO (
nome VARCHAR(100),
cpf INTEGER,
rg INTEGER,
telefone VARCHAR(20),
data_nascimento DATE
);

CREATE TABLE OFICINA(
cnpj INTEGER,
razao_social VARCHAR(50),
telefone VARCHAR(20),
numero_empregados INTEGER,
proprietario VARCHAR(100),
data_abertura_cnpj DATE
);


CREATE TABLE SEGURO (
id INTEGER,
titular VARCHAR(100),
cpf_titular INTEGER,
data_inicio DATE,
data_fim DATE,
valor NUMERIC,
tipo VARCHAR(30)
);

CREATE TABLE SINISTRO (
id INTEGER,
tipo VARCHAR(30),
hora_acidente TIMESTAMP,
relatorio TEXT
);

CREATE TABLE PERICIA (
id INTEGER,
cpf_perito INTEGER,
data_inicio TIMESTAMP,
data_fim TIMESTAMP
);

CREATE TABLE REPARO (
id INTEGER,
valor NUMERIC,
data_inicio TIMESTAMP,
data_fim TIMESTAMP
);

-- QUESTÃO 3

ALTER TABLE AUTOMOVEL ADD PRIMARY KEY (placa);
ALTER TABLE SEGURADO ADD PRIMARY KEY (cpf);
ALTER TABLE PERITO ADD PRIMARY KEY (cpf);
ALTER TABLE OFICINA ADD PRIMARY KEY (cnpj);
ALTER TABLE SEGURO ADD PRIMARY KEY (id);
ALTER TABLE SINISTRO ADD PRIMARY KEY (id);
ALTER TABLE PERICIA ADD PRIMARY KEY (id);
ALTER TABLE REPARO ADD PRIMARY KEY (id);

-- QUESTÃO 4

ALTER TABLE SEGURO ADD FOREIGN KEY (cpf_titular) REFERENCES SEGURADO (cpf);

ALTER TABLE PERICIA ADD FOREIGN KEY (cpf_perito) REFERENCES PERITO (cpf);


-- QUESTÃO 5

/*
AUTOMOVEL{
	placa NOT NULL
	ano_fabricacao NOT NULL
	quilometragem
	cor_carro NOT NULL
	renavam NOT NULL
	volume_tanque_combustivel
	proprietario_cpf NOT NULL
	modelo_automovel NOT NULL
}

SEGURADO{
	nome NOT NULL
	cpf NOT NULL
	rg NOT NULL
	data_nascimento NOT NULL
	endereco NOT NULL
	telefone NOT NULL
	plano_seguro NOT NULL
}

PERITO{
	nome NOT NULL
	cpf NOT NULL
	rg NOT NULL
	telefone NOT NULL
	data_nascimento NOT NULL
}

OFICINA{
	cnpj NOT NULL
	razao_social NOT NULL
	telefone NOT NULL
	numero_empregados
	proprietario NOT NULL
	data_abertura_cnpj NOT NULL
}

SEGURO{
	id NOT NULL
	titular NOT NULL
	cpf_titular NOT NULL
	data_inicio NOT NULL
	data_fim NOT NULL
	valor NOT NULL
	tipo NOT NULL
}

SINISTRO{
	id NOT NULL
	tipo NOT NULL
	hora_acidente
	relatorio NOT NULL
}

PERICIA{
	id NOT NULL
	cpf_perito NOT NULL
	data_inicio NOT NULL
	data_fim NOT NULL
}

REPARO{
	id NOT NULL
	valor NOT NULL
	data_inicio NOT NULL
	data_fim
}
*/

-- QUESTÃO 6

DROP TABLE REPARO;
DROP TABLE PERICIA;
DROP TABLE OFICINA;
DROP TABLE SINISTRO;
DROP TABLE SEGURO;
DROP TABLE AUTOMOVEL;
DROP TABLE SEGURADO;
DROP TABLE PERITO;

-- QUESTÃO 7

CREATE TABLE AUTOMOVEL (
placa VARCHAR(10) PRIMARY KEY,
ano_fabricacao INTEGER NOT NULL,
quilometragem INTEGER,
cor_carro VARCHAR(15) NOT NULL,
renavam VARCHAR(11) NOT NULL,
volume_tanque_combustivel INTEGER,
proprietario_cpf INTEGER NOT NULL,
modelo_automovel VARCHAR(20) NOT NULL
);


CREATE TABLE SEGURADO (
nome VARCHAR(100) NOT NULL,
cpf INTEGER PRIMARY KEY,
rg INTEGER NOT NULL,
data_nascimento DATE NOT NULL,
endereco VARCHAR(200) NOT NULL,
telefone VARCHAR(20) NOT NULL,
plano_seguro VARCHAR(15) NOT NULL
);

CREATE TABLE PERITO (
nome VARCHAR(100) NOT NULL,
cpf INTEGER PRIMARY KEY,
rg INTEGER NOT NULL,
telefone VARCHAR(20) NOT NULL,
data_nascimento DATE NOT NULL
);

CREATE TABLE OFICINA(
cnpj INTEGER PRIMARY KEY,
razao_social VARCHAR(50) NOT NULL,
telefone VARCHAR(20) NOT NULL,
numero_empregados INTEGER,
proprietario VARCHAR(100) NOT NULL,
data_abertura_cnpj DATE NOT NULL
);


CREATE TABLE SEGURO (
id INTEGER PRIMARY KEY,
titular VARCHAR(100) NOT NULL,
cpf_titular INTEGER NOT NULL REFERENCES SEGURADO (cpf),
data_inicio DATE NOT NULL,
data_fim DATE NOT NULL,
valor NUMERIC NOT NULL,
tipo VARCHAR(30) NOT NULL
);

CREATE TABLE SINISTRO (
id INTEGER PRIMARY KEY,
tipo VARCHAR(30) NOT NULL,
hora_acidente TIMESTAMP,
relatorio TEXT NOT NULL
);

CREATE TABLE PERICIA (
id INTEGER PRIMARY KEY,
cpf_perito INTEGER NOT NULL REFERENCES PERITO (cpf),
data_inicio TIMESTAMP NOT NULL,
data_fim TIMESTAMP NOT NULL
);

CREATE TABLE REPARO (
id INTEGER PRIMARY KEY NOT NULL,
valor NUMERIC NOT NULL,
data_inicio TIMESTAMP NOT NULL,
data_fim TIMESTAMP
);

-- QUESTÃO 8 

/*
 RODAR OS CÓDIGOS
*/

--QUESTÃO 9

DROP TABLE REPARO;
DROP TABLE PERICIA;
DROP TABLE OFICINA;
DROP TABLE SINISTRO;
DROP TABLE SEGURO;
DROP TABLE AUTOMOVEL;
DROP TABLE SEGURADO;
DROP TABLE PERITO;

-- QUESTÃO 10

CREATE TABLE ENDERECOS (
endereco_titular VARCHAR(200),
endereco_oficina VARCHAR(200),
endereco_perito VARCHAR(200)
);
