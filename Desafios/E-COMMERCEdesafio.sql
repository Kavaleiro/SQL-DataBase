 -- CRIAÇÃO DO BANCO DE DADOS E-COMMERCE
 CREATE DATABASE ECOMMERCE;
 USE ECOMMERCE;
 
 -- CRIANDO AS TABELAS 
 
 CREATE TABLE CLIENTE(
	IDCLIENTE INT AUTO_INCREMENT PRIMARY KEY,
    FNAME VARCHAR(10),
    MINIT VARCHAR(10),
    LNAME VARCHAR(10),
    CPF CHAR(11) NOT NULL,
    CONSTRAINT UNIQUE_CPF_CLIENTE UNIQUE(CPF),
    ENDERECO VARCHAR(50)
    );
ALTER TABLE CLIENTE AUTO_INCREMENT = 1;

    -- CRIANDO A TABELA PRODUTO
CREATE TABLE PRODUTO(
	IDPRODUTO INT AUTO_INCREMENT PRIMARY KEY,
    PNAME VARCHAR(10) NOT NULL,
	CLASSIFICACAO_KIDS BOOL DEFAULT FALSE,
    CATEGORIA ENUM("ELETRONICO", "ROUPAS", "BRINQUEDOS", "ALIMENTOS"),
    RATING FLOAT DEFAULT 0,
    SIZE VARCHAR(10)
    -- CONSTRAINT UNIQUE_CPF_CLIENTE UNIQUE(CPF)
    );
    
-- CRIANDO A TABELA PEDIDO
CREATE TABLE PEDIDO(
	IDPEDIDO INT AUTO_INCREMENT PRIMARY KEY,
    PRODUTOID_PEDIDO INT NOT NULL,
    CLIENTEID_PEDIDO INT NOT NULL,
    PEDIDOSTATUS ENUM("CANCELADO", "CONFIRMADO", "PROCESSANDO") DEFAULT "PROCESSANDO",
    PEDIDODESCRICAO VARCHAR(255),
    VALORFRETE FLOAT DEFAULT 10,
    PAGAMENTO ENUM("CARTÃO", "DINHEIRO", "PIX") NOT NULL, -- ACRÉSCIMO PARA DEPOIS
    CONSTRAINT FK_PEDIDO_PRODUTO FOREIGN KEY (PRODUTOID_PEDIDO) REFERENCES PRODUTO(IDPRODUTO),
    CONSTRAINT FK_PEDIDO_CLIENTE FOREIGN KEY (CLIENTEID_PEDIDO) REFERENCES CLIENTE(IDCLIENTE)
    );
    -- CRIAR A TABELA DE PAGAMENTO
CREATE TABLE PAGAMENTO(
	IDPAGAMENTO INT AUTO_INCREMENT PRIMARY KEY,
    IDPEDIDO INT NOT NULL,
    TIPO_PAGAMENTO ENUM("CARTÃO", "DINHEIRO", "PIX") NOT NULL,
    TIPO_CARTAO ENUM ("DÉBITO", "CRÉDITO") NULL,
    VALOR_TOTAL FLOAT NOT NULL,
    DATA_PAGAMENTO DATE NOT NULL,
    CONSTRAINT FK_PAGAMENTO_PEDIDO FOREIGN KEY (IDPEDIDO) REFERENCES PEDIDO(IDPEDIDO)
);
-- DROP TABLE PAGAMENTO;
    
-- CRIAND A TABELA DE ESTOQUE 
CREATE TABLE ESTOQUE(
	IDESTOQUE INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    QUANTIDADE INT NOT NULL DEFAULT 0,
    LOCALESTOQUE VARCHAR(255)
);

-- CRIANDO A TABELA FORNECEDOR
CREATE TABLE FORNECEDOR(
	IDFORNECEDOR INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    RAZAOSOCIAL VARCHAR(255) NOT NULL,
    CNPJ CHAR(15) NOT NULL, -- SEPARAR CNPJ DO SOCIAL
    CONTATO CHAR(11) NOT NULL,
    CONSTRAINT UNIQUE_FORNECEDOR UNIQUE(CNPJ)
    );

-- CRIANDO A TABELA VENDEDOR 
CREATE TABLE VENDEDOR(
	IDVENDEDOR INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    NOMESOCIAL VARCHAR(255) NOT NULL,
    NOMEABSTRATO VARCHAR(255),
    CNPJ CHAR(15), -- SEPARAR CNPJ DO SOCIAL
    CPF CHAR(9),
    LOCALIZACAO VARCHAR(255),
    CONTATO CHAR(11) NOT NULL,
    CONSTRAINT UNIQUE_CNPJ_VENDEDOR UNIQUE(CNPJ),
    CONSTRAINT UNIQUE_CPF_VENDEDOR UNIQUE(CPF)
    );
    
    -- CRIANDO A TABELA DE PRODUTOS DO VENDEDOR
CREATE TABLE PRODUTOVENDEDOR(
		IDPVENDEDOR INT,
        IDPPRODUTO INT,
        QUANTIDADE INT DEFAULT 1,
        PRIMARY KEY (IDPVENDEDOR, IDPPRODUTO),
        CONSTRAINT FK_PRODUTO_VENDEDOR FOREIGN KEY (IDPVENDEDOR) REFERENCES VENDEDOR(IDVENDEDOR),
        CONSTRAINT FK_PRODUTO_PRODUTO FOREIGN KEY (IDPPRODUTO) REFERENCES PRODUTO(IDPRODUTO)
        );
        
-- CRIANDO A TABELA PRODUTO PEDIDO 
CREATE TABLE PRODUTOPEDIDO(
	IDPPRODUTO INT, 
    IDPPEDIDO INT,
    PQUANTIDADE INT DEFAULT 1,
    PSTATUS ENUM("DISPONÍVEL", "INDISPONÍVEL") DEFAULT "DISPONÍVEL",
    PRIMARY KEY (IDPPRODUTO, IDPPEDIDO),
    CONSTRAINT FK_PRODUTOPEDIDO_PRODUTO FOREIGN KEY (IDPPRODUTO) REFERENCES PRODUTO(IDPRODUTO),
    CONSTRAINT FK_PRODUTOPEDIDO_PEDIDO FOREIGN KEY(IDPPEDIDO) REFERENCES PEDIDO(IDPEDIDO)
    );
    
    -- CRIANDO A TABELA ESTOQUE E PRODUTO
CREATE TABLE ESTOQUELOCALIZACAO(
	IDLPRODUTO INT,
    IDLESTOQUE INT,
    LOCALIZACAO VARCHAR(255) NOT NULL,
    PRIMARY KEY (IDLPRODUTO, IDLESTOQUE),
    CONSTRAINT FK_ESTOQUELOCALIZACAO_PRODUTO FOREIGN KEY (IDLPRODUTO) REFERENCES PRODUTO(IDPRODUTO),
    CONSTRAINT FK_ESTOQUELOCALIZACAO_ESTOQUE FOREIGN KEY (IDLESTOQUE) REFERENCES ESTOQUE(IDESTOQUE)
    );
    

SHOW TABLES;
DESC CLIENTE;
SELECT * FROM CLIENTE;
 