use AdventureWorksLT2019


--Left join, lisab vasakusse tabelisse parema tabeli andmed
select * from SalesLT.Product
left join SalesLT.ProductModel
on SalesLT.Product.ProductModelID = SalesLT.ProductModel.ProductModelID

--right join, lisab paremasse tabelisse vasaku tabeli andmed
select FirstName, MiddleName, LastName, EmailAddress
from SalesLT.Customer
right join SalesLT.CustomerAddress
on SalesLT.CustomerAddress.CustomerID = SalesLT.Customer.CustomerID

--inner join, ühendab tabeli veerud andmed mis on mõlemas tabelis samad
select * from SalesLT.ProductCategory
inner join SalesLT.Product
on SalesLT.ProductCategory.ProductCategoryID = SalesLT.Product.ProductCategoryID

--full outer join, ühendab tabelite andmed mis on erinevad
select * from SalesLT.SalesOrderDetail
full outer join SalesLT.SalesOrderHeader
on SalesLT.SalesOrderDetail.SalesOrderID = SalesLT.SalesOrderHeader.SalesOrderID

--cross join, 
select * from SalesLT.Product
cross join SalesLT.ProductDescription

create table Puuviljad (
FirstName nvarchar(20),
MiddleName nvarchar(20),
LastName nvarchar(20),
ID int not null Primary Key,
Gender nvarchar(20),
Puuvili Nvarchar(20)
)

insert into Puuviljad (FirstName, MiddleName, LastName, ID, Gender, Puuvili) 
values ('Ott', null, 'Simuste', 1, 'Male', 'Õun'),
('Taavi', 'R.', 'Kropp', 2, 'Male', 'Pirn'),
('Riina', null, 'Supp', 3, 'Female', 'Mango'),
('Viktor', 'L.', 'Tuulik', 4, 'Male', 'Banaan'),
('Uudo', null, 'Sepp', 5, 'Male', 'Ananass'),
('Mihkel', 'K.', 'Raud', 6, 'Male', 'Banaan'),
('Kaur', 'Kahuri', 'Kuul', 7, 'Male', 'Õun'),
('Viska', null, 'Leili', 8, 'Male', 'Sidrun'),
('Jaana', null, 'Juurikas', 9, 'Female', 'Pirn'),
('Timo', null, 'Uusmaa', 10, 'Male', 'Ananass')

