# Sistema de Gerenciamento Médico

Este código implementa um modelo de banco de dados para um sistema de gerenciamento de consultórios médicos, abrangendo desde o cadastro de pacientes e médicos até o gerenciamento de consultas, exames e prescrições de medicamentos. A estrutura foi projetada para facilitar o controle de atendimentos médicos, o acompanhamento de exames e a emissão de receitas médicas.

## Estrutura do Banco de Dados

O banco de dados é composto por 7 tabelas principais:

### 1. **Tabela de Pacientes (`pacientes`)**
Armazena as informações dos pacientes que são atendidos no consultório.

- **id**: Identificador único do paciente (chave primária).
- **nome**: Nome completo do paciente.
- **data_nascimento**: Data de nascimento do paciente.
- **cpf**: CPF do paciente (único).
- **telefone**: Número de telefone do paciente.
- **endereco**: Endereço residencial do paciente.

### 2. **Tabela de Médicos (`medicos`)**
Armazena as informações dos médicos que atendem no consultório.

- **id**: Identificador único do médico (chave primária).
- **nome**: Nome completo do médico.
- **crm**: Número do CRM (único).
- **especialidade**: Especialidade médica do profissional (ex.: Clínico Geral, Pediatra, etc.).
- **telefone**: Número de telefone do médico.

### 3. **Tabela de Consultas (`consultas`)**
Armazena informações sobre as consultas realizadas, vinculando pacientes a médicos.

- **id**: Identificador único da consulta (chave primária).
- **data_hora**: Data e hora da consulta.
- **paciente_id**: Relacionamento com o paciente que fez a consulta (chave estrangeira referenciando `pacientes`).
- **medico_id**: Relacionamento com o médico responsável pela consulta (chave estrangeira referenciando `medicos`).
- **observacoes**: Observações sobre o atendimento realizado.

### 4. **Tabela de Medicamentos (`medicamentos`)**
Armazena informações sobre os medicamentos disponíveis nas prescrições médicas.

- **id**: Identificador único do medicamento (chave primária).
- **nome**: Nome do medicamento.
- **principio_ativo**: Substância ativa do medicamento.
- **fabricante**: Nome do fabricante do medicamento.
- **lote**: Número do lote de fabricação do medicamento.
- **validade**: Data de validade do medicamento.

### 5. **Tabela de Receitas Médicas (`receitas_medicas`)**
Armazena as receitas médicas prescritas durante as consultas, associando os medicamentos a cada consulta.

- **id**: Identificador único da receita médica (chave primária).
- **consulta_id**: Relacionamento com a consulta em que a receita foi gerada (chave estrangeira referenciando `consultas`).
- **medicamento_id**: Relacionamento com o medicamento prescrito (chave estrangeira referenciando `medicamentos`).
- **posologia**: Instrução sobre como tomar o medicamento (ex.: "Tomar 1 comprimido a cada 8 horas").
- **quantidade**: Quantidade de unidades do medicamento prescritas.

### 6. **Tabela de Exames (`exames`)**
Armazena os exames solicitados pelo médico durante as consultas.

- **id**: Identificador único do exame (chave primária).
- **nome**: Nome do exame (ex.: Hemograma, Glicemia).
- **descricao**: Descrição do exame realizado.

### 7. **Tabela Consultas_Exames (`consultas_exames`)**
Tabela intermediária que gerencia o relacionamento N:N entre as consultas e os exames solicitados.

- **consulta_id**: Relacionamento com a consulta (chave estrangeira referenciando `consultas`).
- **exame_id**: Relacionamento com o exame solicitado (chave estrangeira referenciando `exames`).
- **data_solicitacao**: Data em que o exame foi solicitado.
- **data_resultado**: Data de entrega do resultado do exame.
- **resultado**: Resultado do exame realizado.

## Funcionalidades

### 1. **Cadastro de Pacientes**
Permite cadastrar novos pacientes, incluindo seus dados pessoais (nome, data de nascimento, CPF, telefone e endereço).

### 2. **Cadastro de Médicos**
Permite cadastrar médicos no sistema, incluindo informações como nome, CRM, especialidade e telefone.

### 3. **Agendamento de Consultas**
As consultas são agendadas e associadas tanto aos pacientes quanto aos médicos. Durante o agendamento, é possível adicionar observações sobre o atendimento.

### 4. **Prescrição de Medicamentos**
Durante uma consulta, o médico pode prescrever medicamentos ao paciente. A prescrição é registrada, incluindo a posologia e a quantidade do medicamento.

### 5. **Solicitação de Exames**
O médico pode solicitar exames para os pacientes, que são registrados no sistema com a data de solicitação, o resultado e outras informações relevantes.

### 6. **Geração de Receitas Médicas**
Após uma consulta, o médico pode gerar receitas médicas com os medicamentos prescritos para o paciente. Cada receita é associada à consulta e aos medicamentos prescritos.

### 7. **Relacionamento entre Consultas e Exames**
O sistema permite associar exames às consultas de forma eficiente, registrando tanto a data de solicitação quanto os resultados dos exames realizados.

## Exemplo de Uso

### Inserindo Pacientes

```sql
INSERT INTO pacientes (nome, data_nascimento, cpf, telefone, endereco) VALUES
('João Silva', '1985-07-10', '111.222.333-44', '(11) 91234-5678', 'Rua das Flores, 123, São Paulo'),
('Maria Souza', '1992-02-28', '222.333.444-55', '(11) 92345-6789', 'Rua das Pedras, 456, São Paulo');
```

### Inserindo Médicos

```sql
INSERT INTO medicos (nome, crm, especialidade, telefone) VALUES
('Dr. Pedro Ferreira', '12345-SP', 'Clínico Geral', '(11) 93456-7890'),
('Dra. Ana Oliveira', '67890-SP', 'Pediatra', '(11) 94567-8901');
```

### Inserindo Consultas

```sql
INSERT INTO consultas (data_hora, paciente_id, medico_id, observacoes) VALUES
('2023-03-15 09:00:00', 1, 1, 'Paciente com dores de cabeça frequentes.'),
('2023-03-15 10:00:00', 2, 2, 'Consulta de rotina para criança.');
```

### Inserindo Medicamentos

```sql
INSERT INTO medicamentos (nome, principio_ativo, fabricante, lote, validade) VALUES
('Dorflex', 'Dipirona Monoidratada + Cafeína + Orfenadrina', 'Sanofi', 'A123B456', '2023-12-31'),
('Paracetamol', 'Paracetamol', 'Genéricos', 'X789Y1011', '2024-06-30');
```

### Inserindo Receitas Médicas

```sql
INSERT INTO receitas_medicas (consulta_id, medicamento_id, posologia, quantidade) VALUES
(1, 1, 'Tomar 1 comprimido a cada 6 horas em caso de dor.', 10),
(1, 2, 'Tomar 1 comprimido a cada 8 horas em caso de febre.', 10);
```

### Inserindo Exames

```sql
INSERT INTO exames (nome, descricao) VALUES
('Hemograma completo', 'Exame de sangue que avalia as células sanguíneas.'),
('Glicemia em jejum', 'Exame de sangue que mede a taxa de glicose na corrente sanguínea.');
```

### Inserindo Exames nas Consultas

```sql
INSERT INTO consultas_exames (consulta_id, exame_id, data_solicitacao, data_resultado, resultado) VALUES
(1, 1, '2023-03-15', '2023-03-17', 'Resultados normais.'),
(1, 2, '2023-03-15', '2023-03-17', 'Glicemia: 95 mg/dL.');
```

## Conclusão

Este sistema de banco de dados oferece uma solução integrada para a gestão de consultas médicas, com funcionalidades que vão desde o cadastro de pacientes e médicos até o controle de exames e receitas médicas. Ele facilita o processo de agendamento de consultas, a prescrição de medicamentos, a solicitação de exames e o acompanhamento dos resultados, garantindo um atendimento mais eficiente e organizado para os pacientes.
