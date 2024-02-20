CREATE TABLE secretarias (
	id INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(50),
	criado_em DATETIME,
	modificado_em DATETIME,
	criado_por INT,
	modificado_por INT,
	ativo_flag BOOLEAN DEFAULT TRUE
);

CREATE TABLE pessoas (
	id INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(255),
	cpf NUMERIC(11),
	data_nasc DATE,
	endereco VARCHAR(255),
	sexo VARCHAR(50),
	nome_social VARCHAR(255),
	criado_em DATETIME,
	modificado_em DATETIME,
	deletado_em DATETIME,
	criado_por INT,
	modificado_por INT,
	deletado_por INT,
	ativo_flag BOOLEAN DEFAULT TRUE
);

CREATE TABLE alunos (
	id INT PRIMARY KEY AUTO_INCREMENT,
	ra VARCHAR(50),
	status BOOLEAN DEFAULT TRUE,
	id_pessoa INT,
	id_secretaria INT,
	criado_em DATETIME,
	modificado_em DATETIME,
	deletado_em DATETIME,
	criado_por INT,
	modificado_por INT,
	deletado_por INT,
	ativo_flag BOOLEAN DEFAULT TRUE,
	CONSTRAINT fk_aluno_pessoa_id FOREIGN KEY (id_pessoa) REFERENCES pessoas(id),
	CONSTRAINT fk_aluno_secretaria_id FOREIGN KEY (id_secretaria) REFERENCES secretarias(id)
);

CREATE TABLE professores (
	id INT PRIMARY KEY AUTO_INCREMENT,
	status BOOLEAN,
	id_pessoa INT,
	id_secretaria INT,
	criado_em DATETIME,
	modificado_em DATETIME,
	deletado_em DATETIME,
	criado_por INT,
	modificado_por INT,
	deletado_por INT,
	ativo_flag BOOLEAN DEFAULT TRUE,
	CONSTRAINT fk_professor_pessoa_id FOREIGN KEY (id_pessoa) REFERENCES pessoas(id),
	CONSTRAINT fk_professor_secretaria_id FOREIGN KEY (id_secretaria) REFERENCES secretarias(id)
);

CREATE TABLE inscricoes (
	id INT PRIMARY KEY AUTO_INCREMENT,
	status BOOLEAN,
	id_aluno INT,
	id_secretaria INT,
	criado_em DATETIME,
	modificado_em DATETIME,
	deletado_em DATETIME,
	criado_por INT,
	modificado_por INT,
	deletado_por INT,
	ativo_flag BOOLEAN DEFAULT TRUE,
	CONSTRAINT fk_incricao_aluno_id FOREIGN KEY (id_aluno) REFERENCES alunos(id),
	CONSTRAINT fk_incricao_secretaria_id FOREIGN KEY (id_secretaria) REFERENCES secretarias(id)
);

CREATE TABLE cursos (
	id INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(50),
	descricao TEXT,
	id_secretaria INT,
	criado_em DATETIME,
	modificado_em DATETIME,
	deletado_em DATETIME,
	criado_por INT,
	modificado_por INT,
	deletado_por INT,
	ativo_flag BOOLEAN DEFAULT TRUE,
	CONSTRAINT fk_curso_secretaria_id FOREIGN KEY (id_secretaria) REFERENCES secretarias(id)
);

CREATE TABLE turmas (
	id INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(50),
	descricao TEXT,
	capacidade INT,
	data_inicio DATE,
	data_fim DATE,
	id_curso INT,
	criado_em DATETIME,
	modificado_em DATETIME,
	deletado_em DATETIME,
	criado_por INT,
	modificado_por INT,
	deletado_por INT,
	ativo_flag BOOLEAN DEFAULT TRUE,
	CONSTRAINT fk_turma_curso_id FOREIGN KEY (id_curso) REFERENCES cursos(id)
);

CREATE TABLE turmas_professores (
	id INT PRIMARY KEY AUTO_INCREMENT,
	data_inicio DATE,
	data_fim DATE,
	id_professor INT,
	id_turma INT,
	criado_em DATETIME,
	modificado_em DATETIME,
	deletado_em DATETIME,
	criado_por INT,
	modificado_por INT,
	deletado_por INT,
	ativo_flag BOOLEAN DEFAULT TRUE,
	CONSTRAINT fk_turma_professor_id FOREIGN KEY (id_professor) REFERENCES professores(id),
	CONSTRAINT fk_turma_turma_id FOREIGN KEY (id_turma) REFERENCES turmas(id)
);

CREATE TABLE matriculas (
	id INT PRIMARY KEY AUTO_INCREMENT,
	data_inicio DATE,
	data_fim DATE,
	id_turma INT,
	id_inscricao INT,
	criado_em DATETIME,
	modificado_em DATETIME,
	deletado_em DATETIME,
	criado_por INT,
	modificado_por INT,
	deletado_por INT,
	ativo_flag BOOLEAN DEFAULT TRUE,
	CONSTRAINT fk_matricula_turma_id FOREIGN KEY (id_turma) REFERENCES turmas(id),
	CONSTRAINT fk_matricula_inscricao_id FOREIGN KEY (id_inscricao) REFERENCES inscricoes(id)
);

CREATE TABLE planos (
	id INT PRIMARY KEY AUTO_INCREMENT,
	data DATE,
	conteudo VARCHAR(255),
	id_turma INT,
	criado_em DATETIME,
	modificado_em DATETIME,
	deletado_em DATETIME,
	criado_por INT,
	modificado_por INT,
	deletado_por INT,
	ativo_flag BOOLEAN DEFAULT TRUE,
	CONSTRAINT fk_plano_turma_id FOREIGN KEY (id_turma) REFERENCES turmas(id)
);

CREATE TABLE faltas (
	id INT PRIMARY KEY AUTO_INCREMENT,
	falta BOOLEAN DEFAULT TRUE,
	justificativa VARCHAR(255),
	id_plano INT,
	id_matricula INT,
	criado_em DATETIME,
	modificado_em DATETIME,
	criado_por INT,
	modificado_por INT,
	CONSTRAINT fk_falta_plano_id FOREIGN KEY (id_plano) REFERENCES planos(id),
	CONSTRAINT fk_falta_matricula_id FOREIGN KEY (id_matricula) REFERENCES matriculas(id)
);


INSERT INTO secretarias (nome) VALUES 
('Secretaria de Ciências Humanas'),
('Secretaria de Ciências Exatas'),
('Secretaria de Ciências da Saúde');

INSERT INTO pessoas (nome, cpf, data_nasc, endereco, sexo, nome_social) VALUES
('João Silva', '12345678901', '1990-05-15', 'Rua A, 123', 'M', NULL),
('Maria Oliveira', '98765432109', '1985-08-20', 'Avenida B, 456', 'F', 'Mariana'),
('Pedro Santos', '56789012345', '1992-03-10', 'Rua C, 789', 'M', NULL),
('Ana Souza', '45678901234', '1988-10-25', 'Rua D, 321', 'F', NULL),
('Carlos Lima', '32109876543', '1995-06-15', 'Avenida E, 654', 'M', NULL);

INSERT INTO alunos (ra, status, id_pessoa, id_secretaria) VALUES
('RA001', true, 1, 1),
('RA002', true, 2, 2),
('RA003', true, 3, 1);

INSERT INTO professores (status, id_pessoa, id_secretaria) VALUES
(true, 6, 1),
(true, 5, 1);

INSERT INTO inscricoes (status, id_aluno, id_secretaria) VALUES
(true, 1, 1),
(true, 2, 2),
(true, 3, 1);

INSERT INTO cursos (nome, id_secretaria) VALUES
('Ciências Sociais', 1),
('Matemática', 2),
('Medicina', 2);

INSERT INTO turmas (nome, data_inicio, data_fim, id_curso) VALUES
('Turma 1', '2024-03-01', '2024-06-30', 1),
('Turma 2', '2024-04-01', '2024-07-31', 2),
('Turma 3', '2024-05-01', '2024-08-31', 3);

INSERT INTO turmas_professores (id_professor, id_turma) VALUES
(1, 1),
(2, 2),
(2, 3);

INSERT INTO matriculas (data_inicio, data_fim, id_aluno, id_turma, id_inscricao) VALUES
('2024-03-01', '2024-06-30', 1, 1, 1),
('2024-04-01', '2024-07-31', 2, 2, 2),
('2024-05-01', '2024-08-31', 3, 3, 3);

INSERT INTO planos (data, conteudo, id_turma) VALUES
('2024-03-01', 'Plano de aulas de Ciências Sociais', 1),
('2024-04-01', 'Plano de aulas de Matemática', 2),
('2024-05-01', 'Plano de aulas de Medicina', 3);

INSERT INTO faltas (falta, id_plano, id_matricula) VALUES
(true, 1, 1),
(false, 2, 2),
(true, 3, 3);

DELETE FROM faltas;
DELETE FROM planos;
DELETE FROM matriculas;
DELETE FROM turmas_professores;
DELETE FROM turmas;
DELETE FROM cursos;
DELETE FROM inscricoes;
DELETE FROM alunos;
DELETE FROM professores;
DELETE FROM pessoas;
DELETE FROM secretarias;


SET SQL_SAFE_UPDATES = 0;


SELECT alunos.id, pessoas.nome
FROM alunos
JOIN pessoas ON alunos.id_pessoa = pessoas.id
LEFT JOIN matriculas ON alunos.id = matriculas.id_aluno
WHERE matriculas.id IS NULL;



drop database cursodb;




