CREATE DATABASE IF NOT EXISTS ecommerce;
USE ecommerce;

# Tabela de cliente pessoa fisica
CREATE TABLE IF NOT EXISTS ClientFP (
	IdClientFP INT AUTO_INCREMENT PRIMARY KEY,
    Fname VARCHAR(45) NOT NULL,
    InitMname CHAR NOT NULL,
    Lname VARCHAR(45) NOT NULL,
    CPF CHAR(11) NOT NULL,
    BirthDate DATE NOT NULL,
    Phone VARCHAR(15) NOT NULL,
    CONSTRAINT clientFP_cpf_unique UNIQUE (CPF),
    CONSTRAINT clientFP_phone_unique UNIQUE (Phone),
    CONSTRAINT clientFP_id_unique UNIQUE (IdClientFP)
);

# Tabela de clientes pessoa jurida
CREATE TABLE IF NOT EXISTS ClientJP (
	IdClientJP INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    CorporateName VARCHAR(45) NOT NULL,
    CNPJ CHAR(14) NOT NULL,
    FantasyName VARCHAR(45),
    JuridicPersonName VARCHAR(50) NOT NULL,
    Phone VARCHAR(15) NOT NULL,
    CONSTRAINT clinetJP_corp_name_unique UNIQUE (CorporateName),
    CONSTRAINT clinetJP_cnpj_unique UNIQUE (CNPJ),
    CONSTRAINT clinetJP_phone_unique UNIQUE (Phone)
);

# Tabela de forncedores
CREATE TABLE IF NOT EXISTS Supplier (
	IdSupplier INT AUTO_INCREMENT PRIMARY KEY,
    IdClientJP INT NOT NULL,
    CONSTRAINT fk_supplier_to_clientJP FOREIGN KEY (IdClientJP) REFERENCES ClientJP (IdClientJP)
);

# Tabela de vendedores terceirizados
CREATE TABLE IF NOT EXISTS ThirdPartySeller (
	IdThirdPartySeller INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    IdClientJP INT NOT NULL,
    StartPartnership DATE NOT NULL,
    EndPartnership DATE,
    Status ENUM("Ativo", "Inativo", "Em análise") DEFAULT "Em análise",
    CONSTRAINT fk_thrd_party_sllr_to_clientJP FOREIGN KEY (IdClientJP) REFERENCES ClientJP (IdClientJP)
    ON DELETE CASCADE ON UPDATE CASCADE
);

# Tabela de produtos
CREATE TABLE IF NOT EXISTS Product (
	IdProduct INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Category VARCHAR(45) NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    Description VARCHAR(100)
);

# Tabela de pedidos
CREATE TABLE IF NOT EXISTS PurchaseOrder (
	IdOrder INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Status ENUM("Processando", "Confirmado", "Cancelado", "Enviado", "Entregue") DEFAULT "Processando",
    Description VARCHAR(100),
    IdClientFP INT NOT NULL,
    CONSTRAINT purchase_order_idOrder_unique UNIQUE (IdOrder),
    CONSTRAINT fk_order_to_clientFP FOREIGN KEY (IdClientFP) REFERENCES ClientFP (IdClientFP)
    ON DELETE CASCADE ON UPDATE CASCADE
);

# Tabela de metodos de pagamento
CREATE TABLE IF NOT EXISTS PaymentMethod (
	IdPaymentMethod INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    PaymentMethod ENUM("Cartão de crédito", "Cartão de débito", "Boleto bancário", "Transfêrencia bancária", "Pix"),
    StatusMethod ENUM("Disponível", "Indisponível") DEFAULT "Disponível"
);

# Tabela das transações de pagamento
CREATE TABLE IF NOT EXISTS Payment (
	IdPayment INT NOT NULL AUTO_INCREMENT,
    IdClient INT, 
    IdPaymentMethod INT NOT NULL,
    Status ENUM("Aguardando pagamento", "Processando", "Pagamento confirmado", "Pagamento cancelado") DEFAULT "Aguardando pagamento",
    PaymentValue FLOAT,
    PaymentDate DATETIME DEFAULT now(),
    PRIMARY KEY (IdPayment, IdClient, IdPaymentMethod),
    CONSTRAINT fk_payment_to_payment_method FOREIGN KEY (IdPaymentMethod) REFERENCES PaymentMethod (IdPaymentMethod)
    ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT fk_payment_to_clientFP FOREIGN KEY (IdClient) REFERENCES ClientFP (IdClientFP)
    ON DELETE NO ACTION ON UPDATE CASCADE
);

# Tabela de funcionario
CREATE TABLE IF NOT EXISTS Employee (
	IdEmployee INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Fname VARCHAR(45) NOT NULL,
    Lname VARCHAR(45) NOT NULL,
    CPF CHAR(11) NOT NULL,
    Phone VARCHAR(15) NOT NULL,
    IdStock INT NOT NULL,
    CONSTRAINT employee_cpf_unique UNIQUE (CPF),
    CONSTRAINT employee_phone_unique UNIQUE (Phone)
);

# Tabela de estoque
CREATE TABLE IF NOT EXISTS Stock (
	IdStock INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    EstablishmentName VARCHAR(45) NOT NULL,
    IdManager INT,
    CONSTRAINT fk_stock_employee_mgr FOREIGN KEY (IdManager) REFERENCES Employee (IdEmployee)
);

# add fk de employee para estoque
ALTER TABLE Employee ADD CONSTRAINT fk_employee_to_stock FOREIGN KEY (IdStock) REFERENCES Stock (IdStock);

# Tabela de endereço
CREATE TABLE IF NOT EXISTS Address (
	IdAddress INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    Street VARCHAR(45) NOT NULL,
    Num SMALLINT UNSIGNED,
    Neighborhood VARCHAR(45) NOT NULL,
    City VARCHAR(45) NOT NULL,
    FederativeUnit CHAR(2) NOT NULL,
    Country VARCHAR(10) NOT NULL,
    CEP CHAR(8),
    Complement VARCHAR(45)
);

# Relação PEDIDO e PRODUTO
CREATE TABLE IF NOT EXISTS OrderToProduct (
	IdOrder INT NOT NULL,
    IdProduct INT NOT NULL,
    Quatity INT NOT NULL DEFAULT 1,
    PRIMARY KEY (IdOrder, IdProduct),
    CONSTRAINT fk_ord_to_prod_to_product FOREIGN KEY (IdProduct) REFERENCES Product (IdProduct)
    ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_ord_to_prod_to_purchase_order FOREIGN KEY (IdOrder) REFERENCES PurchaseOrder (IdOrder)
    ON DELETE CASCADE ON UPDATE CASCADE
);

# Relações PRODUTO para ESTOQUE
CREATE TABLE IF NOT EXISTS ProductStocked (
	IdProduct INT NOT NULL,
    IdStock INT NOT NULL,
    Quantity INT NOT NULL,
    RegiterDate DATE NOT NULL DEFAULT now(),
    PRIMARY KEY (IdProduct, IdStock),
    CONSTRAINT chk_quantity_stocked_biggest_then_0 CHECK (Quantity > 0),
    CONSTRAINT fk_pdt_stocked_to_product FOREIGN KEY (IdProduct) REFERENCES Product (IdProduct)
    ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT fk_pdt_stocked_to_stock FOREIGN KEY (IdStock) REFERENCES Stock (IdStock)
    ON DELETE NO ACTION ON UPDATE CASCADE
);

# Relação PRODUTO para ENTREGA
CREATE TABLE IF NOT EXISTS ProductDelivery (
	IdDelivery INT NOT NULL AUTO_INCREMENT,
    IdProduct INT NOT NULL,
    IdClient INT NOT NULL,
    TrackingCode CHAR(10) NOT NULL,
    Status ENUM("Saindo do local de origem", "A caminho", "Entregue") DEFAULT "Saindo do local de origem" NOT NULL,
    PRIMARY KEY (IdDelivery, IdProduct, IdClient),
    CONSTRAINT product_delivery_tracking_code_unique UNIQUE(TrackingCode),
    CONSTRAINT fk_product_delivery_to_product FOREIGN KEY (IdProduct) REFERENCES Product (IdProduct),
    CONSTRAINT fk_product_delivery_to_clientFP FOREIGN KEY (IdClient) REFERENCES ClientFP (IdClientFP)
);

# Relações PRODUTO para VENDEDOR TERCEIRIZADO
-- relação para Vendas dos Vendedores
CREATE TABLE IF NOT EXISTS ProductSoldByThirdPartySeller (
	IdThirdPartySeller INT NOT NULL,
    IdProduct INT NOT NULL,
    Quantity INT NOT NULL,
    SaleAmount DECIMAL(10, 2),
    SaleDate DATE NOT NULL DEFAULT now(),
    PRIMARY KEY (IdThirdPartySeller, IdProduct),
    CONSTRAINT fk_pdt_sold_thrd_party_sllr_to_seller 
    FOREIGN KEY (IdThirdPartySeller) REFERENCES ThirdPartySeller (IdThirdPartySeller)
    ON DELETE NO ACTION,
    CONSTRAINT fk_pdt_sold_thrd_party_sllr_to_product 
    FOREIGN KEY (IdProduct) REFERENCES Product (IdProduct)
    ON DELETE NO ACTION
);

-- relação para fornecimento de Produto aos Vendedores
CREATE TABLE IF NOT EXISTS ProductSuppliedToThirdPartySeller (
	IdThirdPartySeller INT NOT NULL,
    IdProduct INT NOT NULL,
    Quantity INT NOT NULL DEFAULT 100,
    SupplyCost DECIMAL(10, 2),
    SupplyDate DATE NOT NULL DEFAULT now(),
    PRIMARY KEY (IdThirdPartySeller, IdProduct),
    CONSTRAINT chk_quantity_supplied_to_thrd_party_seller CHECK (Quantity >= 100),
    CONSTRAINT fk_pdt_supplied_thrd_party_sllr_to_seller 
    FOREIGN KEY (IdThirdPartySeller) REFERENCES ThirdPartySeller (IdThirdPartySeller)
    ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT fk_pdt_supplied_thrd_party_sllr_to_product 
    FOREIGN KEY (IdProduct) REFERENCES Product (IdProduct)
    ON DELETE NO ACTION ON UPDATE CASCADE
);

# Relação ENDEREÇO para CLINTE PESSOA FISICA e CLIENTE PESSOA JURIDICA
CREATE TABLE IF NOT EXISTS ClientFPLivesIn (
	IdClientFP INT,
    IdAddress INT NOT NULL,
    PRIMARY KEY (IdClientFP, IdAddress),
    CONSTRAINT fk_clientFP_lives_in_to_clientFP FOREIGN KEY (IdClientFP) REFERENCES ClientFP (IdClientFP)
    ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT fk_clientFP_lives_in_to_address FOREIGN KEY (IdAddress) REFERENCES Address (IdAddress)
    ON DELETE NO ACTION ON UPDATE CASCADE
);

# relação cliente PJ para endereço
CREATE TABLE IF NOT EXISTS ClientJPLivesIn (
	IdClientJP INT,
    IdAddress INT NOT NULL,
    PRIMARY KEY (IdAddress, IdClientJP),
    CONSTRAINT fk_clientJP_lives_in_to_clientJP FOREIGN KEY (IdClientJP) REFERENCES ClientJP (IdClientJP)
    ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT fk_clientJP_lives_in_to_address FOREIGN KEY (IdAddress) REFERENCES Address (IdAddress)
    ON DELETE NO ACTION ON UPDATE CASCADE
);

# Relação ENDEREÇO para ESTOQUE
CREATE TABLE IF NOT EXISTS StockLocatedIn (
	IdStock INT NOT NULL,
    IdAddress INT NOT NULL,
    PRIMARY KEY (IdStock, IdAddress),
    CONSTRAINT fk_stock_located_in_to_stock FOREIGN KEY (IdStock) REFERENCES Stock (IdStock)
    ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_stock_located_in_to_address FOREIGN KEY (IdAddress) REFERENCES Address (IdAddress)
    ON DELETE CASCADE ON UPDATE CASCADE
);

# relação FORNECEDOR e PRODUTO
CREATE TABLE IF NOT EXISTS SupplierProvidesProducts (
	IdSupplier INT NOT NULL,
    IdProduct INT NOT NULL,
    Quantity INT NOT NULL,
    SupplyValue DECIMAL(10, 2) NOT NULL,
    SupplyDate DATE NOT NULL DEFAULT now(),
    PRIMARY KEY (IdSupplier, IdProduct),
    CONSTRAINT chk_quantity_SupplierProvidesProducts CHECK (Quantity >= 100),
    CONSTRAINT fk_SupplierProvidesProducts_to_supplier FOREIGN KEY (IdSupplier) REFERENCES Supplier (IdSupplier),
    CONSTRAINT fk_SupplierProvidesProducts_to_product FOREIGN KEY (IdProduct) REFERENCES Product (IdProduct)
);
ducts;