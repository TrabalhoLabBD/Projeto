CREATE DATABASE hospital;

USE hospital;

CREATE TABLE plano_de_saude (
    id_pds INT PRIMARY KEY AUTO_INCREMENT,
    nome_pds VARCHAR(50) NOT NULL,
    categoria_pds VARCHAR(11) NOT NULL,
    valor_pds FLOAT(5) NOT NULL,
    cobertura_pds VARCHAR(8) NOT NULL,
    classificacao_pds ENUM('básico', 'normal', 'premium'),
    CHECK (categoria_pds = 'individual'
        OR categoria_pds = 'familiar'
        OR categoria_pds = 'empresarial'),
    CHECK (valor_pds >= 0),
    CHECK (cobertura_pds = 'nacional'
        OR cobertura_pds = 'estadual')
);

CREATE TABLE paciente (
    id_pac INT PRIMARY KEY AUTO_INCREMENT,
    id_pds INT UNIQUE,
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
    CHECK (peso_pac > 0 AND peso_pac < 600),
    CONSTRAINT FK_PACIENTE FOREIGN KEY (id_pds)
        REFERENCES plano_de_saude (id_pds)
);

-- arrumar a fk