create database RetailData
use RetailData

--Create Core Calculations

--We calculate Revenue, Cost, Profit directly in SQL using your real columns:
SELECT 
    [Order_No],
    [Product_Name],
    [Product_Category],
    [Order_Quantity],
    [Retail_Price],
    [Cost_Price],

    -- Revenue
    ([Order_Quantity] * [Retail_Price]) AS Revenue,

    -- Cost
    ([Order_Quantity] * [Cost_Price]) AS Cost,

    -- Profit
    ([Order_Quantity] * [Retail_Price]) - 
    ([Order_Quantity] * [Cost_Price]) AS Profit

FROM Retail;
--Total KPIs (Dashboard Essentials)

--These total metrics are what you’ll use for KPI cards in Power BI:

SELECT 
    SUM([Order_Quantity] * [Retail_Price]) AS Total_Revenue,
    SUM([Order_Quantity] * [Cost_Price]) AS Total_Cost,
    SUM(([Order_Quantity] * [Retail_Price]) - 
        ([Order_Quantity] * [Cost_Price])) AS Total_Profit,
    COUNT([Order_No]) AS Total_Orders
FROM Retail;

--Revenue by Product Category
SELECT 
    [Product_Category],
    SUM([Order_Quantity] * [Retail_Price]) AS Revenue
FROM Retail
GROUP BY [Product_Category]
ORDER BY Revenue DESC;

--Revenue Trend (Time Analysis)
SELECT 
    YEAR([Order_Date]) AS Year,
    MONTH([Order_Date]) AS Month,
    SUM([Order_Quantity] * [Retail_Price]) AS Revenue
FROM Retail
GROUP BY YEAR([Order_Date]), MONTH([Order_Date])
ORDER BY Year, Month;

--Revenue by State (Geography)
SELECT 
    [State],
    SUM([Order_Quantity] * [Retail_Price]) AS Revenue
FROM Retail
GROUP BY [State]
ORDER BY Revenue DESC;

--Customer Analysis
SELECT 
    [Customer_Type],
    SUM([Order_Quantity] * [Retail_Price]) AS Revenue
FROM Retail
GROUP BY [Customer_Type]
ORDER BY Revenue DESC;

--Delivery Performance (BONUS)
SELECT 
    [Ship_Mode],
    AVG(DATEDIFF(DAY, [Order_Date], [Ship_Date])) AS Avg_Delivery_Days
FROM Retail
GROUP BY [Ship_Mode];


CREATE VIEW vw_Retail_Clean AS
SELECT
    [Order_No],
    [Product_Name],
    [Product_Category],
    [Order_Quantity],
    [Retail_Price],
    [Cost_Price],
    ([Order_Quantity] * [Retail_Price]) AS Revenue,
    ([Order_Quantity] * [Cost_Price]) AS Cost,
    ([Order_Quantity] * [Retail_Price]) - ([Order_Quantity] * [Cost_Price]) AS Profit,
    [State],
    [Customer_Type],
    [Ship_Mode],
    [Order_Date],
    [Ship_Date]
FROM Retail;