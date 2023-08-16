create database Assesment4Db 
use  Assesment4Db
create table Products
(
PId int identity(500,1) primary key ,
PName nvarchar(50) not null,
PPrice float ,
PTax as PPrice*0.10 persisted,
PCompany nvarchar(50),
PQty int Default 10,
constraint PQty check (PQty>=1),
constraint PCompany check (PCompany in  ('Samsung','Apple','Redmi','HTC','RealMe','Xiomi'))
)
insert into Products(PName,PPrice,PCompany) values ('EarPods',800,'Samsung')
insert into Products(PName,PPrice,PCompany) values('Screen gaurd',1200,'Apple')
insert into Products(PName,PPrice,PCompany) values('Phone case',300,'Redmi')
insert into Products(PName,PPrice,PCompany,PQty) values ('Addapter',500,'HTC',2)
insert into Products(PName,PPrice,PCompany,PQty) values('Charge cable',200,'Xiomi',5)
insert into Products(PName,PPrice,PCompany,PQty) values('Ipad',30000,'Apple',1)
insert into Products(PName,PPrice,PCompany) values ('RealMe note 3',28000,'RealMe')
insert into Products(PName,PPrice,PCompany) values ('Screen gaurd',200,'Samsung')
insert into Products(PName,PPrice,PCompany) values ('Phone case',500,'HTC')
insert into Products(PName,PPrice,PCompany,PQty) values ('Mouse',15000,'Apple',2)
	
select * from Products
----------------------------------------------------------------------
create proc GetTotalPrice
with encryption
as 
begin
select PId,PName,PPrice+PTax as PriceWithTax,PCompany,(PQty*(PPrice+PTax)) as TotalPrice from Products
end

exec GetTotalPrice
--------------------------------------------------------------------------
create proc GetTotalTax
@company varchar(50),
@TotalTax float output
with encryption
as 
select @TotalTax=sum(PTax) from Products where PCompany=@company


declare @TaxCount float
exec GetTotalTax 'Apple',@TaxCount output
print @TaxCount