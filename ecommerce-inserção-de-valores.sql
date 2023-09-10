use ecommerce;

INSERT INTO ClientFP (Fname, InitMname, Lname, CPF, BirthDate, Phone)
VALUES
    ('João', 'S', 'Silva', '12345678901', '1990-01-15', '(11) 98765-4321'),
    ('Maria', 'A', 'Santos', '98765432101', '1985-03-20', '(21) 12345-6789'),
    ('Pedro', 'R', 'Oliveira', '45678901201', '1992-07-10', '(31) 55555-5555'),
    ('Ana', 'M', 'Rocha', '78901234501', '1980-05-05', '(41) 99999-9999'),
    ('Lucas', 'C', 'Alves', '23456789001', '1998-11-30', '(51) 77777-7777'),
    ('Carla', 'B', 'Ferreira', '56789012301', '1995-04-22', '(61) 33333-3333'),
    ('Paulo', 'P', 'Costa', '67890123401', '1987-09-18', '(71) 88888-8888'),
    ('Julia', 'K', 'Pereira', '34567890101', '1993-02-14', '(81) 22222-2222'),
    ('Marcos', 'L', 'Sousa', '89012345601', '1996-08-25', '(91) 44444-4444'),
    ('Larissa', 'E', 'Ribeiro', '01234567801', '1982-12-08', '(01) 66666-6666');

select * from ClientFP;

INSERT INTO ClientJP (CorporateName, CNPJ, FantasyName, JuridicPersonName, Phone)
VALUES
    ('Empresa ABC Ltda.', '12345678901234', 'ABC Ltda.', 'José da Silva', '(11) 1111-1111'),
    ('Empresa XYZ S.A.', '98765432101234', 'XYZ S.A.', 'Maria Pereira', '(21) 2222-2222'),
    ('Comércio Rápido Ltda.', '23456789012345', 'Comércio Rápido', 'Pedro Santos', '(31) 3333-3333'),
    ('Indústria Tech S.A.', '34567890123456', 'Tech S.A.', 'Ana Rocha', '(41) 4444-4444'),
    ('Supermercado Bom Preço Ltda.', '45678901234567', 'Bom Preço Ltda.', 'Lucas Alves', '(51) 5555-5555'),
    ('Consultoria Soluções Ltda.', '56789012345678', 'Soluções Ltda.', 'Carla Ferreira', '(61) 6666-6666'),
    ('Transportadora Veloz S.A.', '67890123456789', 'Veloz S.A.', 'Paulo Costa', '(71) 7777-7777'),
    ('Editora Livro Novo Ltda.', '78901234567890', 'Livro Novo Ltda.', 'Julia Pereira', '(81) 8888-8888'),
    ('Construtora Obras Prontas Ltda.', '89012345678901', 'Obras Prontas', 'Marcos Sousa', '(91) 9999-9999'),
    ('Farmácia Saúde Total Ltda.', '90123456789012', 'Saúde Total Ltda.', 'Larissa Ribeiro', '(01) 1010-1010');

select * from ClientJP;

INSERT INTO Supplier (IdClientJP)
VALUES (1), (2), (3), (4), (5), (6), (7), (8), (9), (10);

select * from Supplier;

INSERT INTO ThirdPartySeller (IdClientJP, StartPartnership, Status)
VALUES
    (1, '2023-01-15', 'Ativo'),
    (2, '2023-02-20', 'Ativo'),
    (3, '2023-03-25', 'Ativo'),
    (4, '2023-04-30', 'Inativo'),
    (5, '2023-05-05', 'Inativo'),
    (6, '2023-06-10', 'Em análise'),
    (7, '2023-07-15', 'Em análise'),
    (8, '2023-08-20', 'Ativo'),
    (9, '2023-09-25', 'Ativo'),
    (10, '2023-10-30', 'Ativo');

select * from ThirdPartySeller;

INSERT INTO Product (Category, Price, Description)
VALUES
    ('Eletrônicos', 799.99, 'Smartphone modelo X'),
    ('Roupas', 49.99, 'Camiseta branca tamanho M'),
    ('Eletrônicos', 1299.99, 'Notebook ultrafino'),
    ('Alimentos', 5.99, 'Pacote de arroz 1kg'),
    ('Móveis', 299.99, 'Cadeira de escritório'),
    ('Eletrodomésticos', 399.99, 'Liquidificador potente'),
    ('Roupas', 29.99, 'Calça jeans azul tamanho L'),
    ('Alimentos', 2.99, 'Lata de sopa de tomate'),
    ('Eletrônicos', 999.99, 'Fone de ouvido sem fio'),
    ('Móveis', 199.99, 'Mesa de jantar redonda');

select * from Product;

INSERT INTO PurchaseOrder (Status, Description, IdClientFP)
VALUES
    ('Processando', 'Pedido em andamento', 1),
    ('Confirmado', 'Pedido confirmado', 2),
    ('Processando', 'Aguardando pagamento', 3),
    ('Enviado', 'Pedido enviado', 4),
    ('Entregue', 'Pedido entregue', 5),
    ('Processando', 'Aguardando pagamento', 6),
    ('Cancelado', 'Pedido cancelado', 7),
    ('Confirmado', 'Pedido confirmado', 8),
    ('Processando', 'Aguardando pagamento', 9),
    ('Processando', 'Aguardando pagamento', 10);

select * from PurchaseOrder;

INSERT INTO PaymentMethod (PaymentMethod, StatusMethod)
VALUES
    ('Cartão de crédito', 'Disponível'),
    ('Cartão de débito', 'Disponível'),
    ('Boleto bancário', 'Indisponível'),
    ('Transfêrencia bancária', 'Disponível'),
    ('Pix', 'Disponível');

select * from PaymentMethod;

INSERT INTO Payment (IdClient, IdPaymentMethod, Status, PaymentValue, PaymentDate)
VALUES
    (1, 1, 799.99, default, '2023-01-20 08:30:00'),
    (2, 2, 49.99, default, '2023-02-25 10:15:00'),
    (3, 1, 1299.99, 'Processando', '2023-03-30 14:45:00'),
    (4, 3, 5.99, default, '2023-04-05 16:30:00'),
    (5, 2, 299.99, 'Processando', '2023-05-10 11:20:00'),
    (6, 1, 399.99, 'Processando', '2023-06-15 09:45:00'),
    (7, 4, 29.99, 'Pagamento cancelado', '2023-07-20 12:00:00'),
    (8, 1, 2.99, 'Pagamento confirmado', '2023-08-25 15:10:00'),
    (9, 2, 999.99, 'Pagamento confirmado', '2023-09-30 13:05:00'),
    (10, 5, 199.99, 'Pagamento cancelado', '2023-10-05 17:00:00');

select * from Payment;

INSERT INTO Stock (EstablishmentName, IdManager)
VALUES
    ('Loja 1', null),
    ('Loja 2', null),
    ('Loja 3', null),
    ('Loja 4', null),
    ('Loja 5', null),
    ('Loja 6', null),
    ('Loja 7', null),
    ('Loja 8', null),
    ('Loja 9', null),
    ('Loja 10', null);


INSERT INTO Employee (Fname, Lname, CPF, Phone, IdStock)
VALUES
    ('Marcos', 'Silva', '12345678901', '(11) 1111-1111', 1),
    ('Carla', 'Santos', '98765432101', '(21) 2222-2222', 1),
    ('Paulo', 'Oliveira', '23456789001', '(31) 3333-3333', 3),
    ('Julia', 'Rocha', '34567890101', '(41) 4444-4444', 4),
    ('Lucas', 'Alves', '45678901201', '(51) 5555-5555', 4),
    ('Maria', 'Ferreira', '56789012301', '(61) 6666-6666', 6),
    ('Ana', 'Costa', '67890123401', '(71) 7777-7777', 7),
    ('Pedro', 'Pereira', '78901234501', '(81) 8888-8888', 8),
    ('Larissa', 'Sousa', '89012345601', '(91) 9999-9999', 4),
    ('João', 'Ribeiro', '90123456701', '(01) 1010-1010', 10);

# setando gerentes
update Stock set IdManager = 11 where IdStock = 1;
update Stock set IdManager = 14 where IdStock = 4;

INSERT INTO Address (Street, Num, Neighborhood, City, FederativeUnit, Country, CEP, Complement)
VALUES
    ('Rua A', 123, 'Centro', 'São Paulo', 'SP', 'Brasil', '01234-567', 'Apto. 101'),
    ('Av. B', 456, 'Liberdade', 'Rio de Janeiro', 'RJ', 'Brasil', '02345-678', 'Casa 2'),
    ('Rua C', 789, 'Barra', 'Belo Horizonte', 'MG', 'Brasil', '03456-789', 'Sala 3'),
    ('Av. D', 101, 'Boa Vista', 'Curitiba', 'PR', 'Brasil', '04567-890', 'Apto. 202'),
    ('Rua E', 234, 'Jardim', 'Porto Alegre', 'RS', 'Brasil', '05678-901', 'Casa 4'),
    ('Av. F', 567, 'Vila Nova', 'Brasília', 'DF', 'Brasil', '06789-012', 'Sala 5'),
    ('Rua G', 890, 'Ipanema', 'Salvador', 'BA', 'Brasil', '07890-123', 'Apto. 303'),
    ('Av. H', 112, 'Santos', 'Recife', 'PE', 'Brasil', '08901-234', 'Casa 6'),
    ('Rua I', 345, 'Copacabana', 'Fortaleza', 'CE', 'Brasil', '09012-345', 'Apto. 404'),
    ('Av. J', 678, 'Boa Viagem', 'Belém', 'PA', 'Brasil', '00123-456', 'Sala 7');

select * from address;

INSERT INTO OrderToProduct (IdOrder, IdProduct, Quatity)
VALUES
    (1, 1, 1),
    (2, 2, 2),
    (3, 3, 3),
    (4, 4, 1),
    (5, 5, 2),
    (6, 6, 3),
    (7, 7, 1),
    (8, 8, 2),
    (9, 9, 3),
    (10, 10, 1);

select * from OrderToProduct;

INSERT INTO ProductStocked (IdProduct, IdStock, Quantity)
VALUES
    (1, 1, 50),
    (2, 2, 100),
    (3, 3, 75),
    (4, 4, 200),
    (5, 5, 60),
    (6, 6, 90),
    (7, 7, 40),
    (8, 8, 80),
    (9, 9, 120),
    (10, 10, 30);

select * from ProductStocked;

INSERT INTO ProductSoldByThirdPartySeller (IdThirdPartySeller, IdProduct, Quantity, SaleAmount)
VALUES
    (1, 1, 5, 3999.95),
    (2, 2, 10, 999.90),
    (3, 3, 7, 9099.93),
    (4, 4, 3, 1797.00),
    (5, 5, 8, 2399.92),
    (6, 6, 2, 799.98),
    (7, 7, 6, 179.94),
    (8, 8, 4, 1999.96),
    (9, 9, 9, 899.91),
    (10, 10, 1, 199.99);

select * from ProductSoldByThirdPartySeller;

INSERT INTO ProductSuppliedToThirdPartySeller (IdThirdPartySeller, IdProduct, SupplyCost)
VALUES
    (1, 1, 2999.95),
    (2, 2, 899.90),
    (3, 3, 7999.93),
    (4, 4, 997.00),
    (5, 5, 1399.92),
    (6, 6, 399.98),
    (7, 7, 119.94),
    (8, 8, 1499.96),
    (9, 9, 599.91),
    (10, 10, 99.99);

select * from ProductSuppliedToThirdPartySeller;

INSERT INTO ClientFPLivesIn (IdClientFP, IdAddress)
VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5),
    (6, 6),
    (7, 7),
    (8, 8),
    (9, 9),
    (10, 10);

select * from ClientFPLivesIn;

INSERT INTO ClientJPLivesIn (IdClientJP, IdAddress)
VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5),
    (6, 6),
    (7, 7),
    (8, 8),
    (9, 9),
    (10, 10);
    
select * from ClientJPLivesIn;

INSERT INTO StockLocatedIn (IdStock, IdAddress)
VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5),
    (6, 6),
    (7, 7),
    (8, 8),
    (9, 9),
    (10, 10);

select * from StockLocatedIn;

insert into ProductDelivery (IdProduct, IdClient, TrackingCode) values 
	(1, 1, '1234567890'),
    (2, 1, '1234567123'),
    (1, 2, '1234567550'),
    (3, 3, '1234567111'),
    (4, 4, '1234567689'),
    (5, 5, '1234567888'),
    (1, 6, '1234567777'),
    (2, 7, '1234567444'),
    (1, 8, '1234567999'),
    (3, 9, '1234567222'),
    (4, 10, '1234567666');
    
update ProductDelivery set Status = 'A caminho' where IdClient in (2, 4);
select * from PurchaseOrder;

INSERT INTO SupplierProvidesProducts (IdSupplier, IdProduct, Quantity, SupplyValue, SupplyDate)
VALUES
    (1, 1, 100, 3999.95, '2023-01-15'),
    (2, 2, 200, 899.90, '2023-02-20'),
    (3, 3, 150, 7999.93, '2023-03-25'),
    (4, 4, 300, 997.00, '2023-04-30'),
    (5, 5, 120, 1399.92, '2023-05-05'),
    (6, 6, 180, 399.98, '2023-06-10'),
    (7, 7, 180, 119.94, '2023-07-15'),
    (8, 8, 100, 1499.96, '2023-08-20'),
    (9, 9, 200, 599.91, '2023-09-25'),
    (10, 10,100, 99.99, '2023-10-30');

select * from SupplierProvidesProducts;