-- Criação do Banco de Dados
CREATE DATABASE OficinaMecanica;
USE OficinaMecanica;
-- drop database OficinaMecanica;
-- Criação da Tabela Cliente
CREATE TABLE Cliente (
    idCliente INT AUTO_INCREMENT PRIMARY KEY,
    Veiculo VARCHAR(45) NOT NULL
);

-- Criação da Tabela Estoque de Peças (deve ser criada antes de ser referenciada)
CREATE TABLE EstoquePecas (
    idestoque_pecas INT AUTO_INCREMENT PRIMARY KEY,
    quantidade_pecas INT NOT NULL
);

-- Criação da Tabela Ordem de Serviço (após EstoquePecas)
CREATE TABLE OrdemServico (
    idOrdemServico INT AUTO_INCREMENT PRIMARY KEY,
    Cliente_idCliente INT NOT NULL,
    Cliente_Veiculo VARCHAR(45),
    data VARCHAR(45),
    status VARCHAR(45),
    previsao_entrega VARCHAR(45),
    estoque_pecas_idestoque_pecas INT,
    FOREIGN KEY (Cliente_idCliente) REFERENCES Cliente(idCliente),
    FOREIGN KEY (estoque_pecas_idestoque_pecas) REFERENCES EstoquePecas(idestoque_pecas)
);

-- Criação da Tabela Avaliação
CREATE TABLE Avaliacao (
    idAvaliacao INT AUTO_INCREMENT PRIMARY KEY,
    Ordem_de_Servico_idCliente INT NOT NULL,
    Ordem_de_Servico_Cliente_Veiculo VARCHAR(45),
    FOREIGN KEY (Ordem_de_Servico_idCliente) REFERENCES Cliente(idCliente)
);

-- Criação da Tabela Mecânico
CREATE TABLE Mecanico (
    idMecanico INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(45) NOT NULL,
    especialidade VARCHAR(45),
    endereco VARCHAR(45)
);

-- Criação da Tabela Equipe Mecânica
CREATE TABLE EquipeMecanica (
    idEquipeMecanica INT AUTO_INCREMENT PRIMARY KEY,
    Mecanico_idMecanico INT NOT NULL,
    Avaliacao_idAvaliacao INT NOT NULL,
    FOREIGN KEY (Mecanico_idMecanico) REFERENCES Mecanico(idMecanico),
    FOREIGN KEY (Avaliacao_idAvaliacao) REFERENCES Avaliacao(idAvaliacao)
);
