USE [RedTech30]
GO

--SELECT AVG([Order Total]) AS AVG_TOTAL 
--							FROM dbo.OnlineRetailSales$

--WITH AVGTOTAL (AVG_TOTAL) AS
--							(SELECT AVG([Order Total]) AS AVG_TOTAL 
--							FROM dbo.OnlineRetailSales$)

--SELECT * FROM dbo.OnlineRetailSales$, AVGTOTAL
--WHERE [Order Total] >= AVG_TOTAL


-- RECURSIVE CTE
--WITH DirectReports AS (
--						SELECT [EmployeeId], [First Name], [Last Name], [Manager]
--						FROM dbo.EmployeeDirectory$
--						WHERE [EmployeeId] = 42
--						UNION ALL
--						SELECT e.[EmployeeId], e.[First Name], e.[Last Name], e.[Manager]
--						FROM dbo.EmployeeDirectory$ AS e
--						INNER JOIN DirectReports AS d ON e.[Manager] = d.[EmployeeId]
--					)
				
--SELECT COUNT(*) as Direct_Reports
--FROM DirectReports as d
--WHERE d.EmployeeId != 42


--CHALLENGE
WITH AVGSTOCK (AVG_STOCK) AS (SELECT AVG([In Stock]) FROM [RedTech30].dbo.Inventory$ AS AVG_STOCK)

SELECT ProdCategory, ProdNumber, ProdName, [In Stock] FROM [RedTech30].dbo.Inventory$, AVGSTOCK
WHERE [In Stock] < AVG_STOCK