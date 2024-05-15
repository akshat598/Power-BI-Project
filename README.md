#  Project : Sales Insights of Data Analysis-Byteforce Hardware
## Table of Contents:

- [Problem Statement]
- [Data Discovery]
- [Data Cleaning using MySQL ]
- [Data Cleaning and ETL (Extract, Transform, Load)]
- [Data Modeling]
- [Data Analysis (DAX)]
- [Build Dashboard Or a Report]
- [Tools, Software and Libraries]



## Problem Statement :

Byte force hardware has been witnessing declining profits over the years,this project aims to analyse the various costs,and hence help introduce cost cutting measures

## Data Discovery :

- #### Project Planning using AIMS Grid -

  It is a project management tool which consists of four components-
  
     - Purpose - (What to do exactly)
     - Stackholder - (Who will be involved)
     - End result - (What do you want to achieve)
     - Success Criteria - (Cost optimization and time save)
 - #### AIMS Grid -
     **1. Purpose :-** To unlock sales insights that are not visible before for the sales them for decision support and automate them to reduced manual time spent in data gathering.
     
     **2. Stakeholders :-** 
     - Sales Director
     - Marketing Team 
     - Customer Service Team
     - Data and Analytics Team
     - IT 
     
     **3. End result :-** An automated dashboard providing quick and latest sights in order to support Data driven decision making.
     
     **4. Success Criteria :-**
     - Dahboard uncovering sales order insights with latest data available
     - Sales team able to take better decisions and prove 10% cost saving of total spend.
     - Sales analysis stop data gathering manually in order to save 20% business time andreinvest it value added activity.
   

## Data CLeaning using MySQL :
sql query for customer table 
```sql
 > select * from customers where customer_code IS NULL;
 > select * from customers;
```
no null values in the customer table

sql query for date table
 > select * from date where date IS NULL;
no null value is in this table
 > select * from date;

sql query for markets table
 > select * from markets;
zone is not mentioned for two entries Mark097 and Mark999
 > UPDATE markets SET zone = 'usa' WHERE markets_code = 'Mark097';
 > UPDATE markets SET zone = 'france' WHERE markets_code = 'Mark999';

sql query for products table
 > select * from products;
 > select * from products where product_code IS NULL;
no null values in the customer table

sql query for transactions table
 > select * from transactions where sales_amount <= 0;
 > select count(*) from transactions  where sales_amount <= 0; /* there are 1611 such entries */
we will delete them
 > delete from transactions where sales_amount <= 0;
 > select count(*) from transactions  where sales_qty <= 0; /* there are no such entries */

data filtring
 > select count(*) from transactions  where sales_qty <= 0; /* there are no such entries */
 > select count(*) from transactions where currency = 'INR\r';/* amount is 148393 */
 > select count(*) from transactions where currency = 'INR';     /* amount is 275,we will ignore this value this is duplicate */
 > delete from transactions where currency = 'INR';
 > select count(*) from transactions where currency = 'USD\r'; /* amount is 2 */
 > select count(*) from transactions where currency = 'USD'; /* amount is 2 */
 > delete from transactions where currency  = 'USD';
we will take INR\r and USD\r


## Data Modeling:

The sales insights data tables as show below:

![Screenshot (14)](https://user-images.githubusercontent.com/118357991/234016242-369bd02e-1ddf-4047-9be4-324c83bd8761.png)

## Data Analysis  (DAX):

Measures used in all visualization are:

Key Measures:
    
  - Profit Margin % = `DIVIDE([Total Profit Margin],[Revenue],0)` 
  - Profit Margin Contribution % = `DIVIDE([Total Profit Margin],CALCULATE([Total Profit Margin],ALL('sales products'),ALL('sales customers'),ALL('sales markets')))`
  - Revenue = `SUM('sales transactions'[sales_amount])`
  - Revenue Contribution % = `DIVIDE([Revenue],CALCULATE([Revenue],ALL('sales products'),ALL('sales customers'),ALL('sales markets')))`
  - Revenue LY = `CALCULATE([Revenue],SAMEPERIODLASTYEAR('sales date'[date]))`
  - sales quntity = `SUM('sales transactions'[sales_qty])`
  - Total Profit Margin = `SUM('Sales transactions'[Profit_Margin])`

Profit Target:
  
  - Profit Target1 = `GENERATESERIES(-0.05, 0.15, 0.01)`
  - Profit Target Value = `SELECTEDVALUE('Profit Target1'[Profit Target])`
  - Target Diff = `[Profit Margin %]-'Profit Target1'[Profit Target Value]`
  
## Build Dashboard Or a Report:

Data visualization for the data analysis (DAX) was done in Microsoft Power BI Desktop:

Shows visualizations from Sales insights :

| Key Insights |
| ----------- |
|![Sales Insights data analysis-AtliQ_page-0001](https://user-images.githubusercontent.com/118357991/234025264-f5f1d7af-2ead-4d9a-b8ae-7524d200b7dd.jpg)|


| Profit Analysis |
| ----------- |
|![Sales Insights data analysis-AtliQ_page-0002](https://user-images.githubusercontent.com/118357991/234025629-3c2e3dcf-77fb-4c20-acdb-3f92604d1292.jpg)|

| Profit Analysis |
| ----------- |
|![Sales Insights data analysis-AtliQ_page-0003](https://user-images.githubusercontent.com/118357991/234025913-3a09f076-e1c7-40a1-9983-d2c8767f252c.jpg)|

## Tools, Software and Libraries :

1.MySQL

2.Microsoft Power BI

3.Power Query Editor

3.DAX Language 

## References :
https://codebasics.io/panel/webinars/purchases

https://www.sqlbi.com/learn/introducing-dax-video-course/0/

https://dev.mysql.com/doc/

---
