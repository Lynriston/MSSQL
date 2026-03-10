--Tablei tegemin
create table Gender
(
id int not null primary key,
Gender nvarchar(10) not null
)

--andmete sisestamine
insert into Gender (Id, Gender)
values (2,'Male'),
(1, 'Female'),
(3, 'Unkown')

--Tabeli sisu vaatamine
select * from Gender

--Tehke tabel nimega Person
--id int, not null, primary key
--Name nvarchar 30
--Email nvarchar 30
--GenderId int
create table Person
(
id int not null primary key,
Name nvarchar(30),
Email nvarchar(30),
GenderId int
)

--andmete sisestamine
insert into Person (id, Name, Email, GenderId)
values (1,'Superman', 's@s.com', 2),
(2, 'Wonderwoman', 'w@w.com', 1),
(3, 'Batman', 'b@b.com', 2),
(4, 'Aquaman', 'a@a.com', 2),
(5, 'Catwoman', 'cat@cat.com', 1),
(6, 'Antman', 'ant@ant.com', 2),
(8, NULL, NULL, 2)


--Soovime näha Person tabeli sisus
select * from Person

--võõrvõtme ühenduse loomine kahe tabeli vahel
alter table Person add constraint tblPerson_GenderId_FK
foreign key (Gender) references Gender(id)

--kui sisestatud uue rea andmed ja ei ole sisestatud genderId alla väärtus, siis
--see automataatselt sisestab sellele reale väärtuse 3 e mis meil on unkown
alter table Person
add constraint DF_Person_GenderId
default 3 for GenderId

insert into Person (id, Name, Email, GenderId)
values (7, 'Flash', 'f@f.com', NULL)

insert into Person (id, Name, Email)
values (9, 'Black Panter', 'p@p.com', 2)

select * from Person

--kustutada DF_Persons_GenderID piirang koodiga
alter table Person
drop constraint DF_Person_GenderID

--lisame koodiga veeru
alter table Person
add Age nvarchar(10)

--lisame nr piirangu vanuse sisestamisel
alter table Person
add constraint CK_Person_Age check (Age > 0 and Age < 155)

--kui sa tead veergude järjekorda peast 
--siis ei pea neid sisestama
insert into Person
Values (10, 'Green Arrow', 'g@g.com', 2, 154)

--constrainti kustutamine
alter table Person
drop constraint CK_Person_Age

alter table Person
add constraint CK_Person_Age check (Age > 0 and Age < 130)

--kustutame rea 
delete from Person where id = 10

--kuidas uuendada andmeid koodiga 
--id 3 uus vanus on 50
update Person
set Age = 50
where id = 3

--lisame Person tabelisse veeru City ja nvarchar 50
alter table Person
add City nvarchar(50)

--kõik, kes elavad Gothami linnas
select * from Person where City = 'Gotham'
--kõik, kes EI ela Gothamis
select * from Person where City != 'Gotham'
select * from Person where City <> 'Gotham'
select * from Person where not City = 'Gotham'

--näitab teatud vanusega inimesi
--35, 42, 23
select * from Person where Age = 35
select * from Person where Age = 42
select * from Person where Age = 23
select * from Person where Age = 35 or Age = 42 or Age = 23
select * from Person where Age in (35, 42, 23)

--näitab teatud vanusevahemikus olevaid isikuid 22 kuni 39
select * from Person where Age > 21 and Age < 40
select * from Person where Age between 22 and 39

--wildcardi kasutamine
--näitab kõik g-tähega algavad linnad
select * from Person where City like 'G%'
--näitab kõik g-tähega lõppevad linnad
select * from Person where City like '%G'

--email, kus on @ märk sees
select * from Person where Email like '%@%'

--näitab kellel on emailis ees ja peale @ ainult 1 täht ja omakorda .com 
select * from Person where Email like '_@_.com'

--kõik, kellel on nimes esimene täht W, A, S
select * from Person where Name like 'W%' or name like 'A%' or name like 'S%'
select * from Person where Name like '[WAS]%'
--kõik, mis ei alga tähtetega W,A,S
select * from Person where Name like '[^WAS]%'

--kes elavad Gothamis ja New Yorkis
select * from Person where (City = 'Gotham' or City = 'New York')
select * from Person where City = 'Gotham' or City = 'New York'

--kes elavad Gothamis ja New Yorkis ja on vanemad kui 29
select * from Person where (City = 'Gotham' or City = 'New York') and Age > 29


--Alates Rida 145
--10.03.2026 tund

--kuvab tähestikulises järjekorras inimesi ja võtab aluseks nime

select * from Person order by Name

--kuvab vastupidises järjekorras inimesi ja võtab aluseks nime
select * from Person order by Name Desc

--Võtab kolm esimest rida person tabelist
select top 3 * from Person

--kolm esimest, aga tabeli järjestu on Age ja siis Name
select * from Person
select top 3 Age, Name from person order by cast(Age as int)

--näita esimesed 50% tabelist
select top 50 PERCENT * from Person

--kõikide isikute koondvanus
select SUM(cast(Age as int)) from Person

--näitab kõige nooremat isikut
select min(cast(Age as int)) from Person

--näitab kõige vanem isikut
select max(cast(Age as int)) from Person

--muudame Age veeru in andmetüübiks
alter table Person
alter column Age int

--näeme konkreetsetes linnades olevate isikute koondvanust
select SUM(Age) from Person where (City = 'Gotham')
select City, sum(Age) as TotalAge from Person group by City

--kuvab esimeses reas välja toodud järjestuses ja kuvab Age TotalAge-ks
--Järjestab City-s olevate nimede järgi ja siis GenderId järgi
select City, GenderId, sum(Age) as TotalAge from Person
group by City, GenderId order by City

--näitab et mitu rida on selles tabelis
select COUNT(*) from Person

--näitab tulemust et mitu inimest on GenderId väärtusega 2 konkreetses linnas
--arvutab vanuse kokku konkreetses linnas
select GenderId, City, sum(Age) as TotalAge, count(id) as [Total Person(s)] from Person where GenderId = '2'
group by GenderId, City order by GenderId

--näitab ära inimeste koondvanus, mis on üle 41 a ja
--kui palju neid igaslinnas elab
--eristab soo järgi
select GenderId, City, sum(Age) as TotalAge, count(id) as [Total Person(s)] from Person
group by GenderId, City having sum(Age) > 41

--loome tabelid Employees ja Department
create table Employees(
id int not null primary key,
Name nvarchar(50),
GenderId nvarchar(50),
Salary nvarchar(50),
DepartmentId int
)

create table Department(
id int not null primary key,
DepartmentName nvarchar(50),
Location nvarchar(50),
DepartmentHead nvarchar(50)
)
insert into Employees(id, Name, GenderId, Salary, DepartmentId)
values (1,'Tom', 'Male', 4000, 1),
(2, 'Pam', 'Female', 3000, 3),
(3, 'John', 'Male', 3500, 1),
(4, 'Sam', 'Male', 4500, 2),
(5, 'Todd', 'Male', 2800, 2),
(6, 'Ben', 'Male', 7000, 1),
(7, 'Sara', 'Female', 4800, 3),
(8, 'Valarie', 'Female', 5500, 1),
(9, 'James', 'Male', 6500, null),
(10, 'Russell', 'Male', 8800, null)

insert into Department(id, DepartmentName, Location, DepartmentHead)
values (1,'IT', 'London', 'Rick'),
(2, 'Payroll', 'Delhi', 'Ron'),
(3, 'HR', 'New York', 'Christie'),
(4, 'Other Department', 'Sydney', 'Cindella')

--
select Name, GenderId, Salary, DepartmentName from Employees
left join Department
on Employees.DepartmentId = Department.id

--arvutame kõikide palgad kokku
select sum(cast(Salary as int)) as TotalSum from Employees
--min palga saaja
select min(Salary) from Employees
--