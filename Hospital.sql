CREATE DATABASE hospital;

USE hospital;

CREATE TABLE paciente (
    id_pac INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nome_pac VARCHAR(100) NOT NULL,
    cpf_pac INT(11) NOT NULL UNIQUE,
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