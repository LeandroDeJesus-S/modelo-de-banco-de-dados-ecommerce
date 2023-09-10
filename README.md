# PROJETO MODELAGEM DE BANCO DE DADOS | E-COMMERCE

## Projeto desenvolvido durando Bootcamp na [DIO](https://web.dio.me/) <br> 

<div style="display: flex; justify-content: center; align-items: center">
<img src="https://hermes.dio.me/tracks/f5dba255-da18-427a-a02a-ca11a339c1cd.png" style="max-width: 50"> 
</div>
<p align="center">
Potência Tech powered by iFood | Ciência de Dados
</p>

### O objetivo do projeto éra realizar a modelagem de um banco de dados destinado a um E-commerce. Como tarefa foi desenvolvido o modelo EER (Enhanced Entity Relationship)

O meu modelo EER:
<img src='modelo EER ecommerce 1.png'>

<p style="font-size: 20px">
Como parte do desafio foi proposto fazer a separação de um cliente PF(Pessoa física) e PJ (Pessoa jurídica) onde eu separei a tabela Clientes existente em ClientJP e ClientFP. 
</p>
<p style="font-size: 20px">
A tabela ClientJP possui atributos relacionados a pessoas físicas e se relaciona com as tabelas "Address", "Fornecedor" (Supplier) e "Vendedor terceirizado"(ThirdPartySeller).
A tabela ClientFP esta relacionada aos clientes comuns e se relaciona com "Address", "Pagamentos" (Payments), "Pedido" (PurchaseOrder) e com "Produto é entregue" (ProductDelivery) que possui um atributo de código de rastreio do pedido e o status, que também foi proposto como desafio.
</p>
<p style="font-size: 20px">
Criei um tabela própria para endereço que se relaciona com os clientes PF, PJ e com o fornecedor.
Uma tabela de Funcionários (Employee) que se relaciona com estoque (Stock) o qual pode ter um Employee como Gerente.
E também uma tabela própria para armazenar os métodos de pagamento disponíveis (PaymentMethods), possuindo um atributo para sinalizar se o método está disponível ou indisponível.
</p>