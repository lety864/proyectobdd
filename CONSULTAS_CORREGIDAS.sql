/*Consulta A - Dterminar el total de las ventas de los productos de la categoria que se provea como agrupamiento de entrada en la consulta,
  para cada uno de los territorios registrados en la base de datos o para cada una de las regiones (atributo group de SalesTerritory) segun
  se especifique como agrupamiento de entrada
*/


go
create procedure Consulta_A (@cat nvarchar(5))/*1 - 4*/
as
begin

declare @srtsql nvarchar (1000)

set @srtsql =N'select soh.TerritoryID, sum(sod.linetotal) as total
from [SALESAW].[SalesAW].sales.SalesOrderDetail sod
inner join [SALESAW].[SalesAW].sales.SalesOrderHeader soh
on sod.SalesOrderID = soh.SalesOrderID
where sod.ProductID in (
    select ProductID
    from [PRODUCTIONAW].[ProductionAW].Production.Product
    where ProductSubcategoryID in (
         select ProductSubcategoryID
         from [PRODUCTIONAW].[ProductionAW].Production.ProductSubcategory
         where ProductCategoryID = '+@cat+'
       )
    )
group by soh.TerritoryID'
execute (@srtsql)

end
go

execute Consulta_A @cat = '2'




/*Consulta B - Dterminar el producto mas solicitado para la region (atributo group de sales territory) que se especifique como agrupamiento 
  de entrada y en que territorio de la region tiene la mayor demanda
*/

go 
create procedure Consulta_B (@territorio nvarchar (10)) /*1-10*/
as
begin

declare @strsql nvarchar(1000)
 
set @strsql = N'select t.[Group], sod.ProductID, count(sod.ProductID) as solicitud
from [SALESAW].[SalesAW].sales.SalesOrderDetail sod
inner join [SALESAW].[SalesAW].sales.SalesOrderHeader soh
on sod.SalesOrderID = soh.SalesOrderID
inner join [SALESAW].[SalesAW].sales.SalesTerritory t
on '+@territorio+' = t.TerritoryID
group by t.[Group], sod.ProductID
--Subrutina
having count(sod.ProductID) = (select max(solicitud) 
                               from (select t.[Group], sod.ProductID, count(sod.ProductID) as solicitud
							   from [SALESAW].[SalesAW].sales.SalesOrderDetail sod
							   inner join [SALESAW].[SalesAW].sales.SalesOrderHeader soh
							   on sod.SalesOrderID = soh.SalesOrderID
                               inner join [SALESAW].[SalesAW].sales.SalesTerritory t
							   on '+@territorio+' = t.TerritoryID
							   group by t.[Group], sod.ProductID) as TT)'

execute(@strsql)
end
go

execute Consulta_B @territorio = '1'




/*Consulta C - Actualizar el stock disponible en un 5% de los productos de la categoria que se provea como argumento de entrada, 
  en una localidad que tambien se provea como argumento de entrada en la instruccion de actualizacion
*/

go
create procedure Consulta_C (@loc nvarchar (10), @cat nvarchar (10)) --@loc = N'10' /* DE 1,2,3,4,5,6,7,10,20,30,40,45,50,60*/, @cat = N'2' /* DE 1 A 4*/
as
begin

update Production.ProductInventory 
set Quantity=Quantity*0.05 
where LocationID=@loc and  ProductID in ( 
    select ProductID 
	from [PRODUCTIONAW].[ProductionAW].Production.Product 
    where ProductSubcategoryID in (
        select ProductSubcategoryID 
		from [PRODUCTIONAW].[ProductionAW].Production.ProductSubcategory 
        where ProductCategoryID=@cat))



select * from Production.ProductInventory
where LocationID=@loc and  ProductID in ( 
    select ProductID 
	from [PRODUCTIONAW].[ProductionAW].Production.Product 
    where ProductSubcategoryID in (
        select ProductSubcategoryID 
		from [PRODUCTIONAW].[ProductionAW].Production.ProductSubcategory 
        where ProductCategoryID=@cat))

end
go

execute Consulta_C @loc = '1', @cat = '2'






------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Consulta d)   Determinar si hay clientes de un territorio que se especifique como argumento de entrada, 
--que realizan ordenes en territorios diferentes al que se encuentran.

go
create procedure Consulta_D (@IDterritorio NVARCHAR)
as
begin

select SC.CustomerID
from [SALESAW].[SalesAW].Sales.Customer as SC
inner join [SALESAW].[SalesAW].Sales.SalesOrderHeader  AS SO
on SC.TerritoryID != SO.TerritoryID
and SC.CustomerID = SO.CustomerID
where SC.TerritoryID=@IDterritorio

end
go

exec Consulta_D @IDterritorio='4'





--Consulta e) Actualizar  la  cantidad  de  productos  de  una  orden  que  se  provea  como 
--argumento en la instrucción de actualización.


	go 
	create procedure Consulta_E (@IDorder nvarchar (20), @IDproduct nvarchar (20), @cantidad nvarchar (20))
	as
	begin 
		update [SALESAW].[SalesAW].Sales.SalesOrderDetail set OrderQty =@cantidad
			where SalesOrderID=@IDorder and ProductID = @IDproduct

		select * from [SALESAW].[SalesAW].Sales.SalesOrderDetail  where SalesOrderID=@IDorder and ProductID = @IDproduct
		
	end
	go

	exec Consulta_E	@IDproduct ='776', @IDorder='43659', @cantidad ='1'



----- Consulta F) Actualizar el método de envío de una orden que se reciba como argumento en la instrucción de actualización.


	go 
	create procedure Consulta_F (@IDorder nvarchar (20), @Menvio nvarchar(10))
	as
	begin 

		declare @sql nvarchar(1000)
		declare @sql2 nvarchar(1000)


		set @sql='update [SALESAW].[SalesAW].Sales.SalesOrderHeader 
		set ShipMethodID =' +' ''' + @Menvio + ''' '+
		'where SalesOrderID =' +' ''' + @IDorder + ''' '
		execute(@sql)

		set @sql2='select * from [SALESAW].[SalesAW].Sales.SalesOrderHeader where SalesOrderID =' +' ''' + @IDorder + ''' '
		execute(@sql2)

	end
	go

	exec Consulta_F	 @IDorder='43659', @Menvio ='5'


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/* g. Actualizar el correo electrónico de una cliente que se reciba como argumento - CLIENTE COMO ARGUMENTO en la instrucción de actualización. 
correo electronico cliente Person.EmailAddress (EmailAddress)*/
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

go 
create procedure Consulta_G( @nom nvarchar(30), @ape nvarchar(30), @correonuevo nvarchar(80))
as
begin


UPDATE [OTROSAW].[OtrosAW].Person.EmailAddress
set EmailAddress=@correonuevo
FROM [OTROSAW].[OtrosAW].Person.EmailAddress  AS PE
INNER JOIN [OTROSAW].[OtrosAW].Person.vw_person  AS PP
ON PP.BusinessEntityID = PE.BusinessEntityID 
where PP.PersonType='IN' and PP.FirstName=@nom and PP.LastName=@ape


select PE.BusinessEntityID, 
PP.PersonType, PP.FirstName, PP.LastName, 
PE.EmailAddressID, PE.EmailAddress 
from [OTROSAW].[OtrosAW].Person.vw_person AS PP
inner join  [OTROSAW].[OtrosAW].Person.EmailAddress AS PE
on PP.BusinessEntityID = PE.BusinessEntityID 
where PP.PersonType='IN' and PP.FirstName=@nom and LastName=@ape


end
go

exec Consulta_G @nom = N'David', @ape = N'Robinett', @correonuevo = N'rebecca@gmail.com'



select * from [OTROSAW].[OtrosAW].Person.EmailAddress
select * from [OTROSAW].[OtrosAW].Person.vw_person WHERE PersonType='IN' --in es de customer






-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/* h. Determinar el empleado que atendió más ordenes por territorio/región. */ 
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------


	go 
	create procedure Consulta_H
	as
	begin

	declare @sql nvarchar(1000)

    set @sql= N'select top 1 P.BusinessEntityID, P.FirstName, P.LastName,  count(*) as Ventas_Totales
	from [SALESAW].[SalesAW].Sales.SalesOrderHeader as S join [OTROSAW].[OtrosAW].Person.vw_person as P
	on S.SalesPersonID = P.BusinessEntityID
	GROUP BY  P.BusinessEntityID, P.FirstName, P.LastName order by  Ventas_Totales desc'
	execute (@sql)

	end
	go

	exec Consulta_H	



-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/* i.	Determinar para un rango de fechas establecidas como argumento de entrada, cual es el total de las ventas en cada una de las regiones. */
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------


------------------------- NUEVA CONSULTA CORREGIDA CONSULTA I
----apartir de aqui
go 
create procedure Consulta_I( @mesinicio nvarchar(10), @mesfin nvarchar(10))
as
begin

select T.[Group], count(T.[Group]) as Cantidadventas, 
sum(M.TotalDue) as TotalVentas
from [SALESAW].[SalesAW].Sales.SalesOrderHeader AS M
inner join [SALESAW].[SalesAW].Sales.SalesOrderDetail  AS L
on M.SalesOrderID = L.SalesOrderID
inner join [SALESAW].[SalesAW].sales.SalesTerritory AS T
on M.TerritoryID = T.TerritoryID 
WHERE M.DueDate IS NOT NULL AND MONTH(M.DueDate)>=@mesinicio and MONTH(M.DueDate)<= @mesfin
group by T.[Group]


end
go

exec Consulta_I @mesinicio='8', @mesfin ='12'
---hasta aqui




-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*j.	Determinar los 5 productos menos vendidos en un rango de fecha establecido como argumento de entrada. */
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

---CONSULTA J CORREGIDA
go 
create procedure Consulta_J(@mesinicio nvarchar(30), @mesfin nvarchar(30))
as
begin

SELECT TOP 5 L.ProductID, sum(M.TotalDue) as TotVentaProducto
FROM [SALESAW].[SalesAW].Sales.SalesOrderDetail AS L INNER JOIN [SALESAW].[SalesAW].Sales.SalesOrderHeader AS M
on L.SalesOrderID = M.SalesOrderID 
where M.DueDate IS NOT NULL AND MONTH(M.DueDate)>=@mesinicio and MONTH(M.DueDate)<= @mesfin
GROUP BY ProductID 
ORDER BY TotVentaProducto asc

end
go

exec Consulta_J @mesinicio='6', @mesfin='11'
