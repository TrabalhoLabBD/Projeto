CREATE DATABASE hospital;
-- DROP DATABASE hospital;

USE hospital;

CREATE TABLE paciente (
    id_pac INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nome_pac VARCHAR(100) NOT NULL,
    cpf_pac CHAR(11) NOT NULL UNIQUE,
    idade_pac INT(3) NOT NULL,
    sexo_pac VARCHAR(9) NOT NULL,
    altura_pac FLOAT(1) NOT NULL,
    peso_pac FLOAT(3) NOT NULL,
    CHECK (idade_pac >= 0 AND idade_pac <= 120),
    CHECK (sexo_pac = 'masculino'
        OR sexo_pac = 'feminino'
        OR sexo_pac = 'outro'),
    CHECK (altura_pac > 0 AND altura_pac < 3),
    CHECK (peso_pac > 0 AND peso_pac < 600)
);

CREATE TABLE plano_de_saude (
    id_pds INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    id_pds_pac INT NOT NULL UNIQUE,
    nome_pds VARCHAR(50) NOT NULL,
    categoria_pds VARCHAR(11) NOT NULL,
    valor_pds FLOAT(5) NOT NULL,
    cobertura_pds VARCHAR(8) NOT NULL,
    classificacao_pds ENUM('básico', 'normal', 'premium') NOT NULL	,
    CHECK (categoria_pds = 'individual'
        OR categoria_pds = 'familiar'
        OR categoria_pds = 'empresarial'),
    CHECK (valor_pds >= 0),
    CHECK (cobertura_pds = 'nacional'
        OR cobertura_pds = 'estadual'),
    CONSTRAINT FOREIGN KEY (id_pds_pac)
        REFERENCES paciente (id_pac)
);

CREATE TABLE atendimento (
    id_atd INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nome_atd VARCHAR(100) NOT NULL,
    classe_atd ENUM('vermelho', 'laranja', 'amarelo', 'verde', 'azul') NOT NULL,
    ala_atd VARCHAR(30) NOT NULL
);

CREATE TABLE medico (
    id_med INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nome_med VARCHAR(100) NOT NULL,
    crm_med INT(9) UNIQUE NOT NULL,
    especializacao_med VARCHAR(30) NOT NULL,
    id_med_atd INT UNIQUE NOT NULL,
    CONSTRAINT FOREIGN KEY (id_med_atd)
        REFERENCES atendimento (id_atd)
);

CREATE TABLE enfermeiro (
    id_enf INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nome_enf VARCHAR(100) NOT NULL,
    coren_enf INT(9) UNIQUE NOT NULL,
    especializacao_enf VARCHAR(30) DEFAULT 'Sem especialização' NOT NULL,
    id_enf_atd INT UNIQUE NOT NULL,
    CONSTRAINT FOREIGN KEY (id_enf_atd)
        REFERENCES atendimento (id_atd)
);

CREATE TABLE equipamento (
    id_eqp INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nome_eqp VARCHAR(50) NOT NULL,
    classe_eqp VARCHAR(20) NOT NULL
    CHECK (classe_eqp = 'diagnostico'
        OR classe_eqp = 'tratamento'
        OR classe_eqp = 'suporte a vida'
        OR classe_eqp = 'medico duravel')
);

CREATE TABLE financeiro (
    id_fin INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    validade_plano BOOL NOT NULL,
    valor_atendimento FLOAT NOT NULL,
    gastos_atendimento FLOAT NOT NULL,
    CHECK (valor_atendimento >= 0),
    CHECK (gastos_atendimento >= 0)
);

CREATE TABLE administrativo (
    id_adm INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    id_adm_fin INT UNIQUE NOT NULL,
    id_adm_eqp INT UNIQUE NOT NULL,
    id_adm_atd INT UNIQUE NOT NULL,
    id_adm_pac INT UNIQUE NOT NULL,
    CONSTRAINT FOREIGN KEY (id_adm_fin)
        REFERENCES financeiro (id_fin),
    CONSTRAINT FOREIGN KEY (id_adm_eqp)
        REFERENCES equipamento (id_eqp),
    CONSTRAINT FOREIGN KEY (id_adm_atd)
        REFERENCES atendimento (id_atd),
    CONSTRAINT FOREIGN KEY (id_adm_pac)
        REFERENCES paciente (id_pac)
);

INSERT INTO financeiro VALUES (1, 7,1505,4873);
INSERT INTO financeiro VALUES (2, 3,3030,3752);
INSERT INTO financeiro VALUES (3, 4,1344,4768);
INSERT INTO financeiro VALUES (4, 5,1974,4207);
INSERT INTO financeiro VALUES (5,2,1956,1241);

INSERT INTO paciente VALUES (0, "Marcelo", 19855448391, 19, "Masculino", 1.78, 70.00);
INSERT INTO paciente VALUES (1, "Maicon", 20304448573, 30, "Masculino", 1.67, 69.25);
INSERT INTO paciente VALUES (2, "André", 29384445038, 55, "Masculino", 1.77, 68.40);
INSERT INTO paciente VALUES (3, "Luisa", 72938884736, 15, "Feminino", 1.64, 55.00);
INSERT INTO paciente VALUES (6,"Marielly", 42039448574, 20, "Feminino", 1.60, 52.00);
INSERT INTO paciente VALUES (5, "Mauro", 98598667423, 21, "Masculino", 1.79, 52.00);

INSERT INTO equipamento VALUES (1, "Mascara", "tratamento");
INSERT INTO equipamento VALUES (2, "Agulha", "diagnostico");
INSERT INTO equipamento VALUES (3, "Maca", "suporte a vida");
INSERT INTO equipamento VALUES (4, "Agulha", "diagnostico");
INSERT INTO equipamento VALUES (5, "eletrocardiogrago", "diagnostico");

INSERT INTO atendimento VALUES (1, "Traumatismo crâniano", "vermelho", "ALA 1");
INSERT INTO atendimento VALUES (2, "torção no tornoselo", "verde", "ALA 2");
INSERT INTO atendimento VALUES (3, "Dor de cabeça", "verde", "ALA 3");
INSERT INTO atendimento VALUES (4,"Falta de ar","vermelho","ALA 1");
INSERT INTO atendimento VALUES (5,"Dores no peito","amarelo","ALA 2");
INSERT INTO atendimento VALUES (6,"Fratura mo pé","verde","ALA 2");
INSERT INTO atendimento VALUES (7,"Desmaio repentino","azul","ALA 3");
INSERT INTO atendimento VALUES (8,"Náusea e tontira","azul","ALA 3");

INSERT INTO enfermeiro VALUES (1,"Natasha",422124322, "",1);
INSERT INTO enfermeiro VALUES (2,"Sasha",123342212,"" ,3);
INSERT INTO enfermeiro VALUES (3,"Jennifer",324322324,"",2);
INSERT INTO enfermeiro VALUES (3,"João",458852365,"",5);
INSERT INTO enfermeiro VALUES (3,"Fernando",236858741,"",4);

INSERT INTO plano_de_saude VALUES (1,5,"VIDA",,,,);
INSERT INTO plano_de_saude VALUES (2,4,"LIFE",,,,);
INSERT INTO plano_de_saude VALUES (3,3,,,,,);
INSERT INTO plano_de_saude VALUES (4,2,,,,,);
INSERT INTO plano_de_saude VALUES (5,1,,,,,);

INSERT INTO administrativo VALUES (1,2,3,4,5); 
INSERT INTO administrativo VALUES (2,4,5,1,3);
INSERT INTO administrativo VALUES (4,5,2,1,3);
INSERT INTO administrativo VALUES (1,2,4,5,1);



SELECT * from paciente;	
