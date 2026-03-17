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

--17.02.2026

--teeme left join päringu

select Location, sum(cast(Salary as int)) as TotalSalary
from Employees
left join Department
on Employees.DepartmentId = Department.Id
group by Location --ühe kuu palgafond linnade lõikes

--teeme veeru nimega City Employees tabelisse
--nvarchar 30
alter table Employees
add City nvarchar(30)

select * from Employees

--peale selecti tulevad veergude nimed
select City, GenderId, sum(cast(Salary as int)) as TotalSalary 
--tabelist nimega Employees ja mis on grupitatud City ja Gender järgi
from Employees group by City, GenderId

--oleks vaja, et linnad oleksid tähestikulises järjekorras
select City, GenderId, sum(cast(Salary as int)) as TotalSalary 
from Employees group by City, GenderId 
order by City

--order by järjestab Linnad tähestikulises järjekorras
--aga kui on nullid, siis need tulevad kõige ette

--loeb ära mitu rida on tabelis employees
--* asemel võib panna ka veeru nime, 
--aga siis loeb ainult selle veeru väärtused, mis ei ole nullid
select count(*) from Employees

--mitu töötajat on soo ja linna kaupa
select GenderId, City, sum(cast(Salary as int)) as TotalSum,
count(id) as [Total Employee(s)]
from Employees 
group by City, GenderId

--kuvab ainult kõik mehed linnade kaupa

select GenderId, City, sum(cast(Salary as int)) as TotalSum,
count(id) as [Total Employee(s)]
from Employees where GenderId = 'Male'
group by City, GenderId

--kuvab ainult kõik naised linnade kaupa

select GenderId, City, sum(cast(Salary as int)) as TotalSum,
count(id) as [Total Employee(s)]
from Employees where GenderId = 'Female'
group by City, GenderId

--sama tulemus aga kasutage having klausit
select GenderId, City, sum(cast(Salary as int)) as TotalSum,
count(id) as [Total Employee(s)]
from Employees 
group by City, GenderId
having GenderId = 'Male'

select GenderId, City, sum(cast(Salary as int)) as TotalSum,
count(id) as [Total Employee(s)]
from Employees 
group by City, GenderId
having GenderId = 'Female'

--näitab meile ainult need töötajad, kellel on palga summa üle 4000
select Name, City, GenderId, sum(cast(Salary as int)) as TotalSalary,
count(id) as [Total Employee(s)]
from Employees
group by Name, GenderId, City, Salary
having sum(cast(Salary as int)) > 4000

--loome tabeli, milles hakatakse automaatselt nummerdama Id-d
create table Test1
(
id int identity(1,1) primary key,
Value nvarchar(30)
)

insert into Test1 values('X')
select * from Test1

-- kustutame veeru nimega City Employees tabelist
alter table Employees
drop column City

--inner join
--kuvab neid, kellel on DepartmentName all olemas väärtus
select Name, GenderId, Salary, DepartmentName
from Employees
inner join Department
on Employees.DepartmentId = Department.id

--left join
--kuvab kõik read Employees tabelis'
--aga DepartmentName näitab ainult siis, kui on olemas
--kui DepartmentId on null, siis DepartmentName on nulli

select Name, GenderId, Salary, DepartmentName
from Employees
left join Department
on Employees.DepartmentId = Department.id

--right join
--kuvab k'ik read Fepartment tabelis,
--aga Name näitab ainult siis, kui on olemas väärtus DepartmentId-s, mis on sama 
--mis Department tabelis Id.
select Name, GenderId, Salary, DepartmentName
from Employees
right join Department
on Employees.DepartmentId = Department.id

--full outer join ja full join on sama asi
--kuvab kõik read mõlemast reast
--aga kui ei ole vastet, siis näitab nulli
select Name, GenderId, Salary, DepartmentName
from Employees
full outer join Department
on Employees.DepartmentId = Department.id

--cross join
--kuvab küik read mõlemast tabelist, aga ei võta aluseks mingit veergu
--vaid lihtsalt kombineerib kõik read omavahel
--kasutatakse harva, aga kui on vaja kombineerida kõiki
--võimalikke kombinatsioone kahe tabeli vahel, siis võib kasutada cross join
select Name, GenderId, Salary, DepartmentName
from Employees
cross join Department
where Employees.DepartmentId = Department.id

--päeringu sisu
select ColumnList
from LeftTable
joinType RightTable
on JoinCondition

select Name, GenderId, Salary, DepartmentName
from Employees
inner join Department
on Department.id = Employees.DepartmentId

--kuidas kuvada ainult need isikud, kellel on DepartmentName NULL
select Name, GenderId, Salary, DepartmentName
from Employees
left join Department
on Employees.DepartmentId = Employees.DepartmentId
where Employees.DepartmentId is null

select Name, GenderId, Salary, DepartmentName
from Employees
left join Department
on Employees.DepartmentId = Employees.DepartmentId
where Employees.Id is null

--kuidas saame department tabelis oleva rea, kus on null
select Name, GenderId, Salary, DepartmentName
from Employees
right join Department
on Employees.DepartmentId = Department.id
Where Employees.DepartmentId is null

--full join 
--kus on vaja kuvada kõik read mõlemast tabelist
--millel ei ole vastet
select Name, GenderId, Salary, DepartmentName
from Employees
full join Department
on Employees.DepartmentId = Department.id
where Employees.DepartmentId is null
or DepartmentId is null

--tabeli nimetusi muutmine koodiga
sp_rename 'Employees1', 'Employees'

--kasutame Employees tabeli asemel lühendit E ja M
--aga enne seda lisame uue veeru nimega ManagerId ja see on int
alter table Employees
add ManagerId int

--antud juhul E on Employees tabeli lühend ja M
--on samuti Employees tabeli lühend, aga me kasutame
--seda, et näidata, et see on manageri tabel
select E.Name as Employee, M.Name as Manager
from Employees E
left join Employees M
on E.ManagerId = M.Id

select FirstName, LastName, Phone, AddressId, AddressType
from SalesLT.CustomerAddress CA --Lühend
left join SalesLT.Customer C --Lühend
on CA.CustomerID = C.CustomerID

--teha päring kus kasutate ProductModel ja Product tableit,
--et näha, millised tooted on millise mudeliga seotud
select PM.Name as ProductModel, PName as Product
from SalesLT.Product P
left join SalesLT.ProductModel PM
on PM.ProductModelID = P.ProductModelID