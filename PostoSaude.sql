-- Tabela Pacientes
CREATE TABLE pacientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    data_nascimento DATE NOT NULL,
    cpf VARCHAR(14) UNIQUE NOT NULL,
    telefone VARCHAR(15),
    endereco VARCHAR(255) NOT NULL
);

-- Tabela Médicos
CREATE TABLE medicos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    crm VARCHAR(15) UNIQUE NOT NULL,
    especialidade VARCHAR(100) NOT NULL,
    telefone VARCHAR(15)
);

-- Tabela Consultas
CREATE TABLE consultas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    data_hora DATETIME NOT NULL,
    paciente_id INT NOT NULL,
    medico_id INT NOT NULL,
    observacoes TEXT,
    FOREIGN KEY (paciente_id) REFERENCES pacientes (id),
    FOREIGN KEY (medico_id) REFERENCES medicos (id)
);

-- Tabela Medicamentos
CREATE TABLE medicamentos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    principio_ativo VARCHAR(100) NOT NULL,
    fabricante VARCHAR(100) NOT NULL,
    lote VARCHAR(20) NOT NULL,
    validade DATE NOT NULL
);

-- Tabela Receitas Médicas
CREATE TABLE receitas_medicas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    consulta_id INT NOT NULL,
    medicamento_id INT NOT NULL,
    posologia TEXT NOT NULL,
    quantidade INT NOT NULL,
    FOREIGN KEY (consulta_id) REFERENCES consultas (id),
    FOREIGN KEY (medicamento_id) REFERENCES medicamentos (id)
);

-- Tabela Exames
CREATE TABLE exames (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT NOT NULL
);

-- Tabela Consultas_Exames (tabela intermediária para relacionamento N:N entre Consultas e Exames)
CREATE TABLE consultas_exames (
    consulta_id INT NOT NULL,
    exame_id INT NOT NULL,
    data_solicitacao DATE NOT NULL,
    data_resultado DATE,
    resultado TEXT,
    PRIMARY KEY (consulta_id, exame_id),
    FOREIGN KEY (consulta_id) REFERENCES consultas (id),
    FOREIGN KEY (exame_id) REFERENCES exames (id)
);
-- Inserir dados na tabela Pacientes
INSERT INTO pacientes (nome, data_nascimento, cpf, telefone, endereco) VALUES
('João Silva', '1985-07-10', '111.222.333-44', '(11) 91234-5678', 'Rua das Flores, 123, São Paulo'),
('Maria Souza', '1992-02-28', '222.333.444-55', '(11) 92345-6789', 'Rua das Pedras, 456, São Paulo');

-- Inserir dados na tabela Médicos
INSERT INTO medicos (nome, crm, especialidade, telefone) VALUES
('Dr. Pedro Ferreira', '12345-SP', 'Clínico Geral', '(11) 93456-7890'),
('Dra. Ana Oliveira', '67890-SP', 'Pediatra', '(11) 94567-8901');

-- Inserir dados na tabela Consultas
INSERT INTO consultas (data_hora, paciente_id, medico_id, observacoes) VALUES
('2023-03-15 09:00:00', 1, 1, 'Paciente com dores de cabeça frequentes.'),
('2023-03-15 10:00:00', 2, 2, 'Consulta de rotina para criança.');

-- Inserir dados na tabela Medicamentos
INSERT INTO medicamentos (nome, principio_ativo, fabricante, lote, validade) VALUES
('Dorflex', 'Dipirona Monoidratada + Cafeína + Orfenadrina', 'Sanofi', 'A123B456', '2023-12-31'),
('Paracetamol', 'Paracetamol', 'Genéricos', 'X789Y1011', '2024-06-30');

-- Inserir dados na tabela Receitas Médicas
INSERT INTO receitas_medicas (consulta_id, medicamento_id, posologia, quantidade) VALUES
(1, 1, 'Tomar 1 comprimido a cada 6 horas em caso de dor.', 10),
(1, 2, 'Tomar 1 comprimido a cada 8 horas em caso de febre.', 10);

-- Inserir dados na tabela Exames
INSERT INTO exames (nome, descricao) VALUES
('Hemograma completo', 'Exame de sangue que avalia as células sanguíneas.'),
('Glicemia em jejum', 'Exame de sangue que mede a taxa de glicose na corrente sanguínea.');

-- Inserir dados na tabela Consultas_Exames
INSERT INTO consultas_exames (consulta_id, exame_id, data_solicitacao, data_resultado, resultado) VALUES
(1, 1, '2023-03-15', '2023-03-17', 'Resultados normais.'),
(1, 2, '2023-03-15', '2023-03-17', 'Glicemia: 95 mg/dL.');