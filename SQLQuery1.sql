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


--31.03.2026
select isnull('Sinu Nimi', 'No Manager') as Manager

select COALESCE(null, 'No Manager') as Manager

--NEIL kellel ei ole ülemust, siis paneb neile No Manager teksti
select E.Name as Employee, ISNULL(M.Name, 'No Manager') as Manager
from Employees E
left join Employees M
on E.ManagerId = M.id

--kui Expression on õige, siis paneb väärtuse, mida soovid või
--vastasel juhul paneb No Manager teksti
case when Expression then '' else '' end

--teeme päringu, kus kasutame case-i
--tuleb kasutada ka left join
select E.Name as Employee, case when M.Name is null then 'No Manager'
else M.Name end as Manager
from Employees E
left join Employees M
on E.ManagerId = M.id

--lisame tabelisse uued veerud
alter table Employees
add MiddleName nvarchar(30)
alter table Employees
add LastName nvarchar(30)

--muudame veeru nime koodiga
sp_rename 'Employees.MiddleName', 'Middlename1'
select * from Employees

update Employees
set FirstName = 'Tom', MiddleName = 'Nick', LastName = 'Jones'
where id = 1

update Employees
set FirstName = 'Pam', MiddleName = null, LastName = 'Anderson'
where id = 2

update Employees
set FirstName = 'John', MiddleName = null, LastName = null
where id = 3

update Employees
set FirstName = 'Sam', MiddleName = null, LastName = 'Smith'
where id = 4

update Employees
set FirstName = null, MiddleName = 'Todd', LastName = 'Someone'
where id = 5

update Employees
set FirstName = 'Ben', MiddleName = 'Ten', LastName = 'Sven'
where id = 6

update Employees
set FirstName = 'Sara', MiddleName = null, LastName = 'Connor'
where id = 7

update Employees
set FirstName = 'Valarie', MiddleName = 'Balerine', LastName = null
where id = 8

update Employees
set FirstName = 'James', MiddleName = '007', LastName = 'Bond'
where id = 9

update Employees
set FirstName = 'Russell', MiddleName = null, LastName = 'Crowe'
where id = 10

select * from Employees

--igast reast võtab esimesena mitte nulli väärtuse ja paneb Name veergu
--kasutada coalsece

select id, coalesce(FirstName, MiddleName, LastName) as Name
from Employees

create table IndianCustomers
(
Id int identity(1,1),
Name nvarchar(25),
Email nvarchar(25)
)

create table UKCustomers
(
Id int identity(1,1),
Name nvarchar(25),
Email nvarchar(25)
)

insert into IndianCustomers (Name, Email)
values ('Raj', 'R@R.com'),
('Sam', 'S@S.com')

insert into UKCustomers (Name, Email)
values ('Ben', 'B@B.com'),
('Sam', 'S@S.com')

select * from IndianCustomers
select * from UKCustomers

--kasutate union all
--kahe tabeli andmete vaatamiseks
--näitab kõiki read mõlemast tabelist
select Id, Name, Email from IndianCustomers
union all 
select Id, Name, Email from UKCustomers

--korduvate väärtuste eemaldamiseks kasutame union
select Id, Name, Email from IndianCustomers
union
select Id, Name, Email from UKCustomers

--kuidas tulemust sorteerida nime järgi
--kasutage union all-i
select Id, Name, Email from IndianCustomers
union all 
select Id, Name, Email from UKCustomers
order by Name

--stored procedures
--salvestatud protseduurid on SQL-i koodid, mis on salvestatud
--andmebaasis ja mida saab käivitada,
--et teha mingi kindel töö ära

create procedure spGetEmployees
as begin
	select FirstName, GenderId from Employees
end


--nüüd saaame kasuatada spGetEmployees
spGetEmployees
exec spGetEmployees
execute spGetEmployees

--
create proc spGetEmployeesByGenderAndDepartment
@Gender nvarchar(10),
@DepartmentId int 
as begin
	select FirstName, GenderId, DepartmentId from Employees
	where GenderId = @Gender and DepartmentId = @DepartmentId
end

--miks saab veateate
spGetEmployeesByGenderAndDepartment
--õige variant
spGetEmployeesByGenderAndDepartment 'male', 1
--kuidas minna sp järjekorrast mööda parameetrite sisestamisel
spGetEmployeesByGenderAndDepartment @DepartmentId = 1, @Gender = 'Male'

sp_helptext spGetEmployeesByGenderAndDepartment

--muudame sp-d ja võti peale, et keegi teine ei saaks seda muuta
alter procedure spGetEmployeesByGenderAndDepartment
@Gender nvarchar(10),
@DepartmentId int
with encryption
as begin
	select FirstName, GenderId, DepartmentId from Employees
	where GenderId = @Gender and DepartmentId = @DepartmentId
end

--
create proc spGetEmployeeCountByGender
@Gender nvarchar(10),
--output on parameeter mis võimaldab meil salvestada protseduuri
--sees tehtud arvutuse tulemuse ja kasutada seda väljaspool protseduuri
@EmployeeCount int output
as begin
	select @EmployeeCount = count(id) from Employees
	where GenderId = @Gender
end

--annab tulemuse, kus loendab ära nõuetele vasatavad read
--prindib tulemuse, mis on parameetris @EmployeeCount
declare @TotalCount int
exec spGetEmployeeCountByGender 'Female', @TotalCount out
if(@TotalCount = 0)
	print '@TotalCount is null'
else
	print '@TotalCount is not null'
print @TotalCount

--näitab ära, et mitu rida vastab nõuetele
declare @TotalCount int
execute spGetEmployeeCountByGender
--mis on out?
--out on parameeter, mis võimaldab meil salvestada proteduuri
@EmployeeCount = @TotalCount out, @Gender = 'Male'
print @TotalCount

--sp sisu vaatamine
sp_help spGetEmployeeCountByGender
--tabeli info
sp_help Employees
--kui soovid sp teksti näha
sp_helptext spGetEmployeeCountByGender

--vaatame, millest sõltub see sp
sp_depends spGetEmployeeCountByGender
--vaatame tabelit sp_depends-ga
sp_depends Employees

--
create proc spGetNameById
@Id int,
@Name nvarchar(30) output
as begin
	select @Id = id, @Name = FirstName from Employees
end

--tahame näha kogu tabelite ridade arvu
--count kasutada
create proc spTotalRowCount
@TotalCount int output
as begin
	select @TotalCount = count(id) from Employees
end

--saame teada, et mitu rida on tabelis
declare @TotalEmployees int
execute spTotalRowCount @TotalEmployees output
select @TotalEmployees

--mis id all on keegi nime järgi
create proc spGetIdByName1
@ID int,
@FirstName nvarchar(30) output
as begin
	select @FirstName = FirstName from Employees where @Id = id
end

--annab tulemuse, kus id 1 real on keegi koos nimega
declare @FirstName nvarchar(30)
execute spGetIdByName1 1, @FirstName output
print 'Name of the employee = ' + @FirstName

--
declare @FirstName nvarchar(30)
execute spGetNameById 1, @FirstName output
print 'Name of the employee = ' + @FirstName
--ei anna tulemust, sest sp-s on loogika viga
--sp-s on viga, sest @Id on parameeter
--mis on mõeldud selleks, et me saaksime sisestada id-d
--ja saada nime, aga sp-s on loogika viga, sest see
--üritab määrata @Id väärtuseks Id veeru väärtust, mis on vale

sp_help spGetNameByIt

create proc spGetNameByIt2
@Id int
as begin
	return (select FirstName from Employees where Id = @Id)
end

declare @employeeName nvarchar(30)
execute @employeeName = spGetNameByIt2 'Tom'
print 'name of the employee = ' + @EmployeeName

alter proc spGetNameByIt2
    @Id int,
    @EmployeeName nvarchar(30) OUTPUT
as
begin
    select @EmployeeName = FirstName 
    from Employees 
    where Id = @Id
end

declare @employeeName nvarchar(30)

execute spGetNameByIt2 1, @employeeName OUTPUT

print 'name of the employee = ' + @employeeName

--return annab ainult int tüüpi väärtust,
--seega ei saa kasutadaa returni, et tagasatada nime
--mis on nvarchar tüüpi

--sisseehitatud string funktsioon
--see konverteerib ASCII tähe väärtuse numbriks
select ASCII('A')
--kuvab A-tähe
select char(65)

--prindime kogu tähestiku välja A-st Z-ni
--kasutame while tsüklit
declare @Start int
set @Start = 65

while (@Start = 122)
begin
	print char(@Start)
	set @Start = @Start + 1
end

--eemaldame tühjad kohadd sulgudes
select ltrim('         Hello')

--tühikute eemaldamine sõnas
select ltrim(FirstName) as FirstName, MiddleName, LastName 
from Employees

select rtrim('          Hello           ')

--keerab kooloni sees olevad andmed vastupidiseks
--vastavalt upper ja lower-ga saan muuta märkide suurust
--reverse funktsioon keerab stringi tagurpidi
select reverse(upper(ltrim(FirstName))) as FirstName, MiddleName,
LastName, LOWER(LastName), RTRIM(LTRIM(FirstName)) + ' ' +
MiddleName + ' ' + LastName as FullName
from Employees

--left, right, substring
--left võtab stringi vasakult poolt neli esimest tähte
select LEFT('ABCDEF', 4)
--right võtab stringi paremalt poolt neli esimest tähte
select RIGHT('ABCDEF', 4)

--kuvab @tähtmärgi asetust
select charindex('@', 'sara@aaa.com')

--alates viiendast tähemärgist võtab kaks tähte
select substring('leo@bbb.com', 5, 2)

-- @-märgist kuvab kolm tähemärki. Viimase nr saab
--määrata pikkus
select substring('leo@bbb.com', CHARINDEX('@', 'leo@bbb.com')
+ 1, 3)

--peale @-märki reguleerin tähemärkide pikkuse näitamist
select SUBSTRING('leo@bbb.com', charindex('@', 'leo@bbb.com') + 2,
len('leo') - CHARINDEX('@', 'pam@bbb.com'))

--saame teada domeeninimed emailides
--kasutame Person tabelit ja substringi, len ja charindexi
select SUBSTRING(email, charindex('@', email) + 1,
len(Email) - charindex('@', Email)) as DomainName
from Person

alter table Employees
add Email nvarchar(20)

select * from Employees

update Employees
set Email = 'Tom@aaa.com'
where Id = 1
update Employees
set Email = 'Pam@bbb.com'
where Id = 2
update Employees
set Email = 'John@aaa.com'
where Id = 3
update Employees
set Email = 'Sam@bbb.com'
where Id = 4
update Employees
set Email = 'Todd@bbb.com'
where Id = 5
update Employees
set Email = 'Ben@ccc.com'
where Id = 6
update Employees
set Email = 'Sara@ccc.com'
where Id = 7
update Employees
set Email = 'Valarie@aaa.com'
where Id = 8
update Employees
set Email = 'James@bbb.com'
where Id = 9
update Employees
set Email = 'Russell@bbb.com'
where Id = 10

--lisame *-märgi alates teatud kohast
select FirstName, LastName,
	SUBSTRING(Email, 1, 2) + REPLICATE('*', 5) +
	--peale teist tähemärki paneb viis tärni
	SUBSTRING(Email, CHARINDEX('*', Email), len (Email)
	- CHARINDEX('@', Email) + 1) as MaskedEmail
	--kuni @-märgini paneb tärni ja siis jätkab emaili näitamist
	--on dünaamiline, sest kui email pikkus on erinev,
	--siis paneb vastavalt tärne
from Employees

--kolm korda näitab stringi olevat väärtust
select REPLICATE('Hello', 3)

--kuidas sisestada tühikut kahe nime vahele
--fasutada funktsiooni
select space(5)

--võtame tabeli Employees ja kuvame eesnime ja perekonnnanime vahele tühiku
select FirstName + space(1) + LastName as FullName
From Employees

--PATINDEX
--sama, mis charindex, aga patindex võimaldab kasutada wildcardi
--kasutame tabelit Employees ja leiame kõik read, kus emaili lõpus on aaa.com
select Email, patindex('%aaa.com%', Email) as Position
from Employees
where patindex('%@aaa.com%', Email) > 0
--leian kõik read, kus emaili lõppus on aaa.com või bbb.com


--asendame emaili lõpus olevat demeeninimed 
--.com asemel .net-iga, kasutage replace funktsiooni
select replace(Email, '.com', '.net')
from Employees

--soovin asendada peale esimest märki olevad tähed viie tärniga
select FirstName, LastName, Email,
	stuff(Email, 2, 3, '*****') as StuffedEmail
from Employees

--ajaga seotud andmetüübid
create table DateTest
(
c_time time,
c_date time,
c_smalldatetime smalldatetime,
c_datetime datetime,
c_datetime2 datetime2,
c_datetimeoffset datetimeoffset
)

select * from DateTest

--sinu masina kellaaeg
select getdate() as CurrentDateTime

insert into DateTest
values (getdate(), getdate(), getdate(), getdate(), getdate(), getdate())
select * from DateTest

update DateTest set c_datetimeoffset = '2026-04-07 17:14:02.8600000 +02:00'
where c_datetimeoffset = '2026-04-07 17:14:00 +02:00'

select CURRENT_TIMESTAMP, 'CURRENT_TIMESTAMP' -- aja päring
select SYSDATETIME(), 'SYSDATETIME()' -- veel täpsem aja päring
select SYSDATETIMEOFFSET(), 'SYSDATETIMEOFFSET()' --tõpsem aja ja ajavööndi päring
select GETUTCDATE(), 'GETUTCDATE' --UTC aja päring

select isdate('asdasd') --tagastab 0, sest see on kehtiv kuupäev
select isdate(getdate()) --tagastab 1, sest on kp
select isdate('2026-04-07 17:14:02.8600000') --tagastab 0, kuna max  3 koma kohta
select isdate('2026-04-07 17:14:02.860') --tagastab 1
select day(getdate()) --annab tänase päeva nr
select day('01/30/2026') --annab stringis oleva kp ja järjestus peab oleva õige
select month(getdate()) --annab jooksva kuu nr
select month('03/29/2026') --annab stringis oleva kuu
select year(getdate()) -- annab jooksva aasta nr
select year('03/29/2026') --annab stringis oleva aasta nr

--14.04.2026 tund

select DATENAME(day, '2026-04-07 17:14:02.860') --annab stringis oleva päeva nime
select DATENAME(weekday, '2026-04-07 17:14:02.860') --annam stringis oleva päeva nime
select DATENAME(MONTH, '2026-04-07 17:14:02.860') --annab stringis oleva kuu nime

create table EmployeesWithDates 
(
	Id nvarchar(2),
	Name nvarchar(20),
	DateOfBirth datetime
)

insert into EmployeesWithDates(Id, Name, DateOfBirth)
values (1, 'Sam', '1980-12-30 00:00:00.000'),
(2, 'Pam', '1982-09-01 12:02:36.260'),
(3, 'John', '1985-08-22 12:03:30.370'),
(4, 'Sara', '1979-11-29 12:59:30.670')

--kuidas võtta ühest veerust andmeid ja selle abil luua uued veerud

select Name, DateOfBirth, datename(weekday, DateOfBirth) as Day, datename(day, DateOfBirth) as MonthNumber, datename(month, DateOfBirth) as MonthName, datename(year, DateOfBirth) as Year
from EmployeesWithDates

select datepart(weekday, '2026-04-07 17:14:02.860') --annab stringis oleva päeva nt, kus 1 on pühapäev
select datepart(month, '2026-04-07 17:14:02.860') --annab stringis oleva kuu nr
select datename(week, '2026-04-07 17:14:02.860')
select dateadd(day, 20, '2026-04-07 17:14:02.860') --annab stringis oleva kuupäeva mis on 20 päeva pärast
select dateadd(day, -20, '2026-04-07 17:14:02.860')--annab stringis oleva kuupäeva mis on 20 päeva enne
select datediff(MONTH, '04/30/2025', '01/31/2026')
select datediff(YEAR, '04/30/2025', '01/31/2026')

create function fnComputeAge(@DOB datetime)
returns nvarchar(50)
as begin
	declare @tempdate datetime, @years int, @months int, @days int
	select @tempdate = @DOB

	select @years = datediff(year, @tempdate, getdate()) - case when (month(@DOB) > month(getdate())) or (month(@DOB))
	= month(getdate()) and day(@DOB) > day(getdate()) then 1 else 0 end
	select @tempdate = dateadd(year, @years, @tempdate)

	select @months = datediff(month, @tempdate, getdate()) - case when day(@DOB) > day(getdate()) then 1 else 0 end
	select @tempdate = dateadd(month, @months, @tempdate)

	select @days = datediff(day, @tempdate, getdate())

	declare @Age nvarchar(50)
		set @Age = cast(@years as nvarchar(10)) + ' years, ' 
		+ cast(@months as nvarchar(10)) + ' months, ' 
		+ cast(@days as nvarchar(10)) + ' days old'
	return @Age
end

--saame vanuse välja arvatada, kui kasutame fnComputeAge funktsiooni
select Name, DateOfBirth, dbo.fnComputeAge(DateOfBirth) as Age
from EmployeesWithDates

--kui kasutame seda funktsiooni, siis saame teada tänase päeva vahet
--stringis olevaga
select dbo.fnComputeAge('03/23/2008')

--nr peale DOB muutujat näitab, 
--et missugusena järjestuses me tahame näidata veeru sisu
select Id, Name, DateOfBirth,
convert(nvarchar, DateOfBirth, 126) as ConvertedDOB
from EmployeesWithDates

--
select Id, Name, Name + ' - ' + cast(Id as nvarchar) as [Name-Id]
from EmployeesWithDates

select cast(getdate() as date) -- tänane kp
select CONVERT(date, getdate()) --tänane kp

--matemaatilised funktsioonid
select abs(-101.5) --absoluutväärtus, tagastab 101.5
select ceiling(101.5) --tagastab 102, ümardab üles
select CEILING(-101.5) --ümardab üles negatiivsema nr poole
select floor(101.5) --ümardab alla
select floor(-101.5) --ümardab alla negatiivsema nr poole
select POWER(2, 4) --tagastab 16, 2 astmes 4
select SQUARE(5) --korrutab iseendaga
select SQRT(25) --võtab arvu ja leiab selle ruutjuure

select rand() -- tagastab suvalise nr 0 - 1
--oleks vaja, et iga kord annab rand meile ühe täisarvu 1 kuni 100
select round(rand()*(100 - 1) + 1, 0)
select floor(rand() * 100 + 1)

--annab juhusliku nr vahemikus 1 kuni 1000
--ja teeb seda 10 korda, et näha erinevaid nr-d
declare @counter int
set @counter = 1
while (@counter <= 10)
begin
	select ceiling (rand() * 1000)
	set @counter = @counter + 1
end

select round(850.556, 2)
select round(850.556, 2, 1)

select round(850.556, 1) --ümardab 850.556 ühe komakohani, tagastab 850.6
select round(850.556, 1, 1)

select round(850.556, -2) --ümardab 850.556 sadade kaupa, tagastab 900
select round(850.556, -1) --ümardab 850.556 kümnete kaupa, tagastab 800

create function dbo.CalculateAge (@DOB date)
returns int
as begin
declare @Age int

set @Age = datediff(year, @DOB, getdate()) - 
	case 
		when (month(@DOB) > month(getdate())) or
			(month(@DOB) = month(getdate()) and day(@DOB) > day(getdate()))
		then 1
		else 0
		end
	return @Age
end
-----
execute CalculateAge '10/25/1980'

--arvutab välja, kui vana on isik ja võtab arvesse,
--kas isiku sünnipäev on juba sel aastal olnud või mitte
--antud juhul näitab, kes on üle 40 aasta vanad
select Id, Name, dbo.CalculateAge(DateOfBirth) as Age
from EmployeesWithDates
where dbo.CalculateAge(DateOfBirth) > 40

--inline table valued functions
--teha EmployeesWithDates tablisse
--uus veerg nimega DepartmentId int
--ja reine veerg on Gender nvarchar(10)
alter table EmployeesWithDates
add DepartmentId int,
Gender nvarchar(10)

--scalar function e skaleeritav funktsioon annab mingis vahemikus olevaid
--väärtusi, aga inline table valued function tagastab tabeli
--ja seal ei kasutata begin ja endi vehele kirjutamist
--vaid lihtsalt kirjutad selecti
create function fn_EmployeesByGender(@Gender nvarchar(10))
returns table
as
return (select Id, Name, DateOfBirth, DepartmentId, Gender from EmployeesWithDates where Gender = @Gender)

--soovime vaadata kõiki naisi EmployeesWithDates tabelist
select * from fn_EmployeesByGender('Female')

--soovin ainult näha Pam ja kasutan funktsiooni fn_EmployeesByGender
select * from fn_EmployeesByGender('Female')
where name = 'Pam'

--kahest erinevast tabelist andmete võtmine ja koos kuvamine
--esimene on funktsioon ja teine on Department tabel
select Name, Gender, DepartmentName
from fn_EmployeesByGender('Male') E
join Department D on D.Id = E.DepartmentId

--inline function
create function fn_GetEmployees()
returns table as
return (select Id, Name, cast(DateOfBirth as date)
		as DOB
		from EmployeesWithDates)

select * from fn_EmployeesByGender

--multi statement table valued function
create function fn_MS_GetEmployees()
returns @Table Table (Id int, Name nvarchar(20), DOB date)
as begin
	insert into @Table
	select Id, Name, cast(DateOfBirth as date) from EmployeesWithDates

	return
end

select * from fn_MS_GetEmployees()

--inline tabeli funktsioonid on paremini töötamas 
--kuna käsitletakse vaatena
--multi statement table valued funktsioonid on nagu tavalised funktsioonid,
--pm on tegemist stored procedurega ja see võib olla aeglasem
--sest see ei saa kasutada vaate optimeerimist e kulutab rohkem ressurssi

select * from EmployeesWithDates
update fn_GetEmployees() set Name = 'Sam1' where Id = 4
select * from EmployeesWithDates

--ei saa muuta andmeid multistate table valued funktsioonis,
--sest see on nagu stored procedure

--