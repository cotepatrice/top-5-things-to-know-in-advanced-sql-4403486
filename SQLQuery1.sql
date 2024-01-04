USE [RedTech30]
GO

-- SELECT * FROM RedTech30.dbo.SessionInfo$

/* SELECT * FROM OnlineRetailSales$ 
WHERE [Order Total] >= (SELECT AVG([Order Total]) FROM dbo.OnlineRetailSales$)

SELECT *, (SELECT AVG([Order Total]) FROM dbo.OnlineRetailSales$) AS AverageTotal FROM OnlineRetailSales$ 
WHERE [Order Total] >= (SELECT AVG([Order Total]) FROM dbo.OnlineRetailSales$) */

--SELECT * FROM dbo.SessionInfo$
--SELECT * FROM dbo.SpeakerInfo$

-- UNCORRELATED subquery
--SELECT [Speaker Name], [Session Name], [Start Date], [End Date], [Room Name] FROM dbo.SessionInfo$
--WHERE [Speaker Name] IN 
--	(SELECT [Name] FROM dbo.SpeakerInfo$
--	WHERE [Organization] = 'Two Trees Olive Oil')

--SELECT SESS.[Speaker Name], SESS.[Session Name], SESS.[Start Date], SESS.[End Date], SESS.[Room Name] 
--FROM dbo.SessionInfo$ AS SESS
--	INNER JOIN (SELECT [Name] FROM dbo.SpeakerInfo$
--		WHERE [Organization] = 'Two Trees Olive Oil') AS SPEAK
--	ON SESS.[Speaker Name] = SPEAK.Name

-- CORRELATED subquery
--SELECT [First Name], [Last Name], [State], Email, [Phone Number] FROM ConventionAttendees$ AS ATT 
--WHERE NOT EXISTS (SELECT CustState FROM OnlineRetailSales$ AS SAL
--					WHERE ATT.State = SAL.CustState)

--SELECT ProdCategory, ProdNumber, ProdName, [In Stock] FROM dbo.Inventory$
--WHERE [In Stock] < (SELECT AVG([In Stock]) FROM dbo.Inventory$)


WITH DirectReports AS (
						SELECT [EmployeeId], [First Name], [Last Name], [Manager]
						FROM dbo.EmployeeDirectory$
						WHERE [EmployeeId] = 42
						UNION ALL
						SELECT e.[EmployeeId], e.[First Name], e.[Last Name], e.[Manager]
						FROM dbo.EmployeeDirectory$ AS e
						INNER JOIN DirectReports AS d ON e.[Manager] = d.[EmployeeId]
					)
				
SELECT COUNT(*) as Direct_Reports
FROM DirectReports as d
WHERE d.EmployeeId != 42