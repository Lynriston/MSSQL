--H7--

Create database ExampleDB;
go

alter database ExampleDB
set recovery full
go

backup database ExampleDB
to disk = 'C:\Program Files\Microsoft SQL Server\MSSQL17.MSSQLSERVER\MSSQL\Backup\ExampleDB.bak'
with format
go


BACKUP DATABASE ExampleDB
TO DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL17.MSSQLSERVER\MSSQL\Backup\ExampleDB.bak'
WITH FORMAT,
NAME = 'ExampleDB Backup'
GO

backup database ExampleDB
to disk = 'C:\Program Files\Microsoft SQL Server\MSSQL17.MSSQLSERVER\MSSQL\Backup\ExampleDB.bak'
with format,
Medianame = 'ExampleDB Backup',
name = 'ExampleDB FORMAT Backup',
description = 'Full backup of ExampleDB'
go

create database TestDB;
go
alter database TestDB
set recovery full
go
select name, recovery_model_desc
from sys.databases
where name = 'TestDB'
go