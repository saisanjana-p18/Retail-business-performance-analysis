create database IF NOT EXISTS market_analysis;
use market_analysis;

SELECT COUNT(*) AS total_rows FROM markett;

SELECT * FROM markett LIMIT 10;

#Total Sales and Profit
SELECT
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    ROUND(AVG(Profit), 2) AS Average_Profit
FROM markett;

#Category-wise Sales and Profit
SELECT
    Category,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    ROUND(
        SUM(Profit) / SUM(Sales) * 100,
        2
    ) AS Profit_Margin_Percent
FROM markett
GROUP BY Category
ORDER BY Total_Profit DESC;

#Sub-category Profitability
SELECT
    `Sub Category`,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    ROUND(
        SUM(Profit) / SUM(Sales) * 100,
        2
    ) AS Profit_Margin_Percent
FROM markett
GROUP BY `Sub Category`
ORDER BY Total_Profit DESC;

#impact of discounts on profit
SELECT
    Discount,
    COUNT(*) AS Total_Transactions,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    ROUND(AVG(Profit), 2) AS Average_Profit
FROM markett
GROUP BY Discount
ORDER BY Discount;

#Region-wise profitability
SELECT
    Region,
    COUNT(*) AS Total_Transactions,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    ROUND(
        SUM(Profit) / SUM(Sales) * 100,
        2
    ) AS Profit_Margin_Percent
FROM markett
GROUP BY Region
ORDER BY Total_Profit DESC;

#Top 10 most profitable customers
SELECT
    `Customer Name`,
    COUNT(DISTINCT `Order ID`) AS Total_Orders,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM markett
GROUP BY `Customer Name`
ORDER BY Total_Profit DESC
LIMIT 10;

#loss-making transactions
SELECT
    COUNT(*) AS Loss_Making_Transactions,
    ROUND(SUM(Sales), 2) AS Sales_From_Loss_Rows,
    ROUND(SUM(Profit), 2) AS Total_Loss
FROM markett
WHERE Profit < 0;

#Lowest-profit-margin sub-categories
SELECT
    `Sub Category`,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    ROUND(
        SUM(Profit) / SUM(Sales) * 100,
        2
    ) AS Profit_Margin_Percent
FROM markett
GROUP BY `Sub Category`
ORDER BY Profit_Margin_Percent ASC
LIMIT 5;

#Data summary
SELECT
    COUNT(*) AS Total_Rows,
    COUNT(DISTINCT `Order ID`) AS Unique_Orders,
    COUNT(DISTINCT `Customer Name`) AS Unique_Customers,
    MIN(COALESCE(
        STR_TO_DATE(`Order Date`, '%m-%d-%Y'),
        STR_TO_DATE(`Order Date`, '%c/%e/%Y')
    )) AS First_Order_Date,
    MAX(COALESCE(
        STR_TO_DATE(`Order Date`, '%m-%d-%Y'),
        STR_TO_DATE(`Order Date`, '%c/%e/%Y')
    )) AS Last_Order_Date
FROM markett;

#Yearly Sales and Profit Trend
SELECT
    YEAR(
        COALESCE(
            STR_TO_DATE(`Order Date`, '%m-%d-%Y'),
            STR_TO_DATE(`Order Date`, '%c/%e/%Y')
        )
    ) AS Order_Year,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    ROUND(SUM(Profit) / SUM(Sales) * 100, 2)
        AS Profit_Margin_Percent
FROM markett
GROUP BY Order_Year
ORDER BY Order_Year;

#Monthly sales and profit trend
SELECT
    YEAR(
        COALESCE(
            STR_TO_DATE(`Order Date`, '%m-%d-%Y'),
            STR_TO_DATE(`Order Date`, '%c/%e/%Y')
        )
    ) AS Order_Year,
    MONTH(
        COALESCE(
            STR_TO_DATE(`Order Date`, '%m-%d-%Y'),
            STR_TO_DATE(`Order Date`, '%c/%e/%Y')
        )
    ) AS Order_Month,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM markett
GROUP BY Order_Year, Order_Month
ORDER BY Order_Year, Order_Month;

#City-wise Sales and Profit
SELECT
    City,
    ROUND(SUM(Sales), 2) AS Sales,
    ROUND(SUM(Profit), 2) AS Profit
FROM markett
GROUP BY City
ORDER BY Sales DESC;













