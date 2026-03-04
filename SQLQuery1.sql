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