use ecommerce;
# quais vendedores terceiros estão ativos?
select c.JuridicPersonName, c.CorporateName, c.Phone, c.CNPJ, t.Status from ThirdPartySeller t
	inner join ClientJP c using(IdClientJP)
where t.Status = 'Ativo';

# quantos estão ativos e quantos estão inativos e quantos estão em analise?
select t.Status, count(*) as count
from ThirdPartySeller t
	inner join ClientJP c using(IdClientJP)
    group by t.Status
;

# como estão as vendas dos vendedores terceirizados?
select c.CorporateName as ThrdPartySellerCorp, t.Status, p.IdProduct, p.Quantity, p.SaleAmount from ThirdPartySeller t
	inner join ProductSoldByThirdPartySeller p using(IdThirdPartySeller)
    inner join ClientJP c using (IdClientJP)
    order by p.SaleAmount desc
;

# quais dos que estão ativos venderam acima de R$2000?
select c.CorporateName as ThrdPartySellerCorp, t.Status, p.IdProduct, p.Quantity, p.SaleAmount from ThirdPartySeller t
	inner join ProductSoldByThirdPartySeller p using(IdThirdPartySeller)
    inner join ClientJP c using (IdClientJP)
    where t.Status = 'Ativo'
    group by ThrdPartySellerCorp
    having p.SaleAmount > 2000
;

# quantos produtos foram fornecidos para os vendedores terceirizados e quantos ele vendeu?
select c.CorporateName, c.JuridicPersonName, t.Status, p.Quantity as QtdSoldProducts, p.SaleAmount,
	pstps.Quantity as QtdProductsSupplied, pstps.SupplyCost, (p.SaleAmount - pstps.SupplyCost) as SellerRentability
from ThirdPartySeller t
	inner join ProductSoldByThirdPartySeller p using(IdThirdPartySeller)
    inner join ClientJP c using (IdClientJP)
    inner join ProductSuppliedToThirdPartySeller pstps using(IdThirdPartySeller);

# Quantos pedidos foram feitos por cada cliente?
SELECT concat(c.Fname, ' ', c.Lname) as client_name, count(*) as client_orders 
FROM ClientFP c, PurchaseOrder p
WHERE c.IdClientFP = p.IdClientFP
GROUP BY client_name;

# Algum vendedor também é fornecedor?
select c.IdClientJP, c.JuridicPersonName, c.CorporateName, c.CNPJ, t.Status 
	from ThirdPartySeller t INNER JOIN Supplier s on t.IdClientJP = s.IdClientJP
	     					INNER JOIN ClientJP c on s.IdClientJP = c.IdClientJP
	ORDER BY Status;

# Relação de produtos fornecedores e estoques;
-- iformações de produtos e dos fornecedores nos quais tenho produto armazenado em estoque
select spp.Quantity as QtdSupplyProducts, spp.SupplyValue, ps.Quantity as QtdStocked,
	   p.Category as PdtCategory, (p.Price * ps.Quantity) as ValueInProducts, 
       c.CorporateName as SupplyCorpName, c.CNPJ as SupplyCNPJ, c.Phone as SupplyPhone
from supplierProvidesProducts  spp
	inner join ProductStocked ps using(IdProduct)
	inner join Product p using(IdProduct)
    inner join supplier s using(IdSupplier)
    inner join ClientJP c using(IdClientJP);

# Relação de nomes dos fornecedores e nomes dos produtos;
select c.CorporateName, c.JuridicPersonName, c.CNPJ, p.Category as PdtCategory, p.Description as PdtDescription
from Supplier s 
	INNER JOIN ClientJP c USING(IdClientJP)
    INNER JOIN supplierProvidesProducts spp USING (IdSupplier)
	INNER JOIN Product p USING(IdProduct)
;