USE [RedTech30]
GO

-- Windows functions
-- ROW_NUMBERS()

--SELECT CustName, COUNT(DISTINCT OrderNum)
--FROM dbo.OnlineRetailSales$
--GROUP BY CustName

--SELECT [OrderNum], [OrderDate], [CustName], [ProdName], [Quantity], 
--	ROW_NUMBER() OVER(PARTITION BY [CustName] ORDER BY [OrderDate] DESC) as ROW_NUM
--FROM dbo.OnlineRetailSales$

--WITH ROW_NUMBERS AS (SELECT [OrderNum], [OrderDate], [CustName], [ProdName], [Quantity], 
--	ROW_NUMBER() OVER(PARTITION BY [CustName] ORDER BY [OrderDate] DESC) as ROW_NUM
--FROM dbo.OnlineRetailSales$)

--SELECT * FROM ROW_NUMBERS WHERE ROW_NUM = 1

--CHALLENGE
--SELECT [OrderNum], [OrderDate], [CustName], [ProdCategory], [ProdName], [Order Total],
--ROW_NUMBER() OVER(PARTITION BY [ProdCategory] ORDER BY [Order Total] DESC) as ROW_NUM
--FROM dbo.OnlineRetailSales$ WHERE CustName = 'Boehm Inc.'
----ORDER BY ProdCategory, [Order Total] DESC

--WITH ROW_NUMBERS AS (
--						SELECT [OrderNum], [OrderDate], [CustName], [ProdCategory], [ProdName], [Order Total],
--						ROW_NUMBER() OVER(PARTITION BY [ProdCategory] ORDER BY [Order Total] DESC) as ROW_NUM
--						FROM dbo.OnlineRetailSales$ WHERE CustName = 'Boehm Inc.'
--					)


--SELECT * FROM ROW_NUMBERS WHERE ROW_NUM <= 3
--ORDER BY ProdCategory, ROW_NUM


-- LAG AND LEAD
--SELECT [Start Date], [End Date], [Session Name],
--LAG([Session Name], 1) OVER (ORDER BY [Start Date] ASC) AS PreviousSession,
--LAG([Start Date], 1) OVER (ORDER BY [Start Date] ASC) AS PreviousSessionStartTime,
--LEAD([Session Name], 1) OVER (ORDER BY [Start Date] ASC) AS NextSession,
--LEAD([Start Date], 1) OVER (ORDER BY [Start Date] ASC) AS NextSessionStartTime
--FROM dbo.SessionInfo$
--WHERE [Room Name] = 'Room 102'


-- CHALLENGE
--SELECT * FROM dbo.OnlineRetailSales$ WHERE ProdCategory = 'Drones'

--WITH ORDER_BY_DAYS AS (
--						SELECT OrderDate, SUM(Quantity) AS QUANTITY_BY_DAY
--						FROM dbo.OnlineRetailSales$
--						WHERE ProdCategory = 'Drones'
--						GROUP BY OrderDate
--					)

--SELECT OrderDate, QUANTITY_BY_DAY,
--LAG([QUANTITY_BY_DAY],1) OVER(ORDER BY OrderDate) AS LAST_DATE_QUANTITY_1,
--LAG([QUANTITY_BY_DAY],2) OVER(ORDER BY OrderDate) AS LAST_DATE_QUANTITY_2,
--LAG([QUANTITY_BY_DAY],3) OVER(ORDER BY OrderDate) AS LAST_DATE_QUANTITY_3,
--LAG([QUANTITY_BY_DAY],4) OVER(ORDER BY OrderDate) AS LAST_DATE_QUANTITY_4,
--LAG([QUANTITY_BY_DAY],5) OVER(ORDER BY OrderDate) AS LAST_DATE_QUANTITY_5
--FROM ORDER_BY_DAYS

-- RANK, DENSE_RANK
--SELECT *,
--RANK() OVER(ORDER BY [Last Name]) as RANK_,
--DENSE_RANK() OVER(ORDER BY [Last Name]) as DENSE_RANK_
--FROM dbo.EmployeeDirectory$

-- CHALLENGE
WITH RANKED_REGISTRATION AS (
								SELECT *,
								-- RANK() OVER(PARTITION BY [State] ORDER BY [Registration Date]) as RANK_NUM
								DENSE_RANK() OVER(PARTITION BY [State] ORDER BY [Registration Date]) as RANK_NUM
								FROM dbo.ConventionAttendees$
								-- ORDER BY State, [Registration Date] DESC
)

SELECT * FROM RANKED_REGISTRATION WHERE RANK_NUM <= 3