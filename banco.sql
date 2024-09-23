CREATE DATABASE sistema_kanban_ti;
USE sistema_kanban_ti;

-- Cria o banco de dados e usa-o
CREATE DATABASE IF NOT EXISTS sistema_kanban_ti;
USE sistema_kanban_ti;

-- Tabela de Setores (certifique-se que seja criada antes)
CREATE TABLE setores (
	id INT AUTO_INCREMENT PRIMARY KEY,
	nome_setor VARCHAR(50) NOT NULL UNIQUE
);

-- Tabela de Usuários (setor_id como chave estrangeira)
CREATE TABLE usuarios (
	id INT AUTO_INCREMENT PRIMARY KEY,
	nome_completo VARCHAR(100) NOT NULL,
	senha VARCHAR(255) NOT NULL,
	email VARCHAR(100) NOT NULL UNIQUE,
	instituicao VARCHAR(100) NOT NULL,
	ocupacao VARCHAR(50) NOT NULL,
	setor_id INT,
	FOREIGN KEY (setor_id) REFERENCES setores(id) ON DELETE SET NULL
);


CREATE TABLE blocos (
	id INT AUTO_INCREMENT PRIMARY KEY,
	nome_bloco VARCHAR(50) NOT NULL
);

CREATE TABLE salas (
	id INT AUTO_INCREMENT PRIMARY KEY,
	numero_sala VARCHAR(10) NOT NULL,
	bloco_id INT NOT NULL,
	FOREIGN KEY (bloco_id) REFERENCES blocos(id) ON DELETE CASCADE
);

CREATE TABLE maquinas (
	id INT AUTO_INCREMENT PRIMARY KEY,
	numero_maquina VARCHAR(50) NOT NULL,
	sala_id INT NOT NULL,
	FOREIGN KEY (sala_id) REFERENCES salas(id) ON DELETE CASCADE
);

-- Tabela de Problemas
CREATE TABLE problemas (
	id INT AUTO_INCREMENT PRIMARY KEY,
	descricao VARCHAR(255) NOT NULL
);

-- Tabela de Chamados (atualizada)
CREATE TABLE chamados (
	id INT AUTO_INCREMENT PRIMARY KEY,
	usuario_id INT NOT NULL,
	problema_id INT NOT NULL, -- Referência para a nova tabela de problemas
	descricao TEXT,
	status VARCHAR(50) NOT NULL DEFAULT 'Aceitar',
	criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE,
	FOREIGN KEY (problema_id) REFERENCES problemas(id) ON DELETE CASCADE
);

CREATE TABLE chamados_maquinas (
	id INT AUTO_INCREMENT PRIMARY KEY,
	chamado_id INT NOT NULL,
	maquina_id INT NOT NULL,
	FOREIGN KEY (chamado_id) REFERENCES chamados(id) ON DELETE CASCADE,
	FOREIGN KEY (maquina_id) REFERENCES maquinas(id) ON DELETE CASCADE
);

CREATE TABLE atribuidos (
	id INT AUTO_INCREMENT PRIMARY KEY,
	chamado_id INT NOT NULL,
	setor_id INT NOT NULL,
	data_atribuicao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY (chamado_id) REFERENCES chamados(id) ON DELETE CASCADE,
	FOREIGN KEY (setor_id) REFERENCES setores(id) ON DELETE CASCADE
);

CREATE TABLE logs (
	id INT AUTO_INCREMENT PRIMARY KEY,
	chamado_id INT NOT NULL,
	usuario_id INT NOT NULL,
	acao VARCHAR(255) NOT NULL,
	data_log TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	data_atualizacao TIMESTAMP NULL,
	data_exclusao TIMESTAMP NULL,
	FOREIGN KEY (chamado_id) REFERENCES chamados(id) ON DELETE CASCADE,
	FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE
);


INSERT INTO blocos (nome_bloco) VALUES ('Bloco A');
INSERT INTO blocos (nome_bloco) VALUES ('Bloco B');
INSERT INTO blocos (nome_bloco) VALUES ('Bloco C');
INSERT INTO blocos (nome_bloco) VALUES ('Bloco D');


-- Supondo que os IDs dos blocos inseridos sejam 1, 2, 3 e 4 respectivamente
INSERT INTO salas (numero_sala, bloco_id) VALUES ('101', 1);
INSERT INTO salas (numero_sala, bloco_id) VALUES ('102', 1);
INSERT INTO salas (numero_sala, bloco_id) VALUES ('201', 2);
INSERT INTO salas (numero_sala, bloco_id) VALUES ('202', 2);
INSERT INTO salas (numero_sala, bloco_id) VALUES ('301', 3);
INSERT INTO salas (numero_sala, bloco_id) VALUES ('302', 3);
INSERT INTO salas (numero_sala, bloco_id) VALUES ('401', 4);
INSERT INTO salas (numero_sala, bloco_id) VALUES ('402', 4);

