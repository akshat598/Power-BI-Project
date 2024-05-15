#  Project : Sales Insights of Data Analysis-Byteforce Hardware
## Table of Contents:

- [Problem Statement](https://github.com/akshat598/Power-BI-Project?tab=readme-ov-file#data-cleaning-using-mysql-)
- [Data Discovery]
- [Data Cleaning using MySQL ]
- [Data Analysis using MySQL]
- [Data Modeling]
- [Data Analysis (DAX)]
- [Report]
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
select * from customers where customer_code IS NULL;
select * from customers;
```
no null values in the customer table

sql query for date table
```sql
select * from date where date IS NULL;
```
no null value is in this table
```sql
select * from date;
```

sql query for markets table
```sql
select * from markets;
```
zone is not mentioned for two entries Mark097 and Mark999
```sql
UPDATE markets SET zone = 'usa' WHERE markets_code = 'Mark097';
UPDATE markets SET zone = 'france' WHERE markets_code = 'Mark999';
```


sql query for products table
```sql
select * from products;
select * from products where product_code IS NULL;
```
no null values in the customer table

sql query for transactions table
```sql
select * from transactions where sales_amount <= 0;
select count(*) from transactions  where sales_amount <= 0; /* there are 1611 such entries */
```
we will delete them
```sql
delete from transactions where sales_amount <= 0;
select count(*) from transactions  where sales_qty <= 0; /* there are no such entries */
```

data filtring
```sql
select count(*) from transactions  where sales_qty <= 0; /* there are no such entries */
select count(*) from transactions where currency = 'INR\r';/* amount is 148393 */
select count(*) from transactions where currency = 'INR';     /* amount is 275,we will ignore this value this is duplicate */
delete from transactions where currency = 'INR';
select count(*) from transactions where currency = 'USD\r'; /* amount is 2 */
select count(*) from transactions where currency = 'USD'; /* amount is 2 */
delete from transactions where currency  = 'USD';
```
we will take INR\r and USD\r

## Data analysis using mysql
```sql
/*Show all date records*/
SELECT * FROM sales.date;

/*Show transactions in 2020 join by date table*/
SELECT sales.transactions.*, sales.date.* FROM sales.transactions INNER JOIN sales.date ON sales.transactions.order_date=sales.date.date where sales.date.year=2020;

/*Show transactions in 2019 join by date table*/
SELECT sales.transactions.*, sales.date.* FROM sales.transactions INNER JOIN sales.date ON sales.transactions.order_date=sales.date.date where sales.date.year=2019;

/*Show total revenue in year 2020,*/
SELECT SUM(sales.transactions.sales_amount) FROM sales.transactions INNER JOIN sales.date ON sales.transactions.order_date=sales.date.date 
where sales.date.year=2020 and sales.transactions.currency='INR\r' or sales.transactions.currency='USD\r';

/*Show total revenue in year 2019,*/
SELECT SUM(sales.transactions.sales_amount) FROM sales.transactions INNER JOIN sales.date ON sales.transactions.order_date=sales.date.date 
where sales.date.year=2019 and sales.transactions.currency='INR\r' or sales.transactions.currency='USD\r';

/*Show  avarage in year 2020,*/
SELECT AVG(sales.transactions.sales_amount) FROM sales.transactions INNER JOIN sales.date ON sales.transactions.order_date=sales.date.date 
where sales.date.year=2020 and sales.transactions.currency='INR\r' or sales.transactions.currency='USD\r';

/*Show  avarage in year 2019,*/
SELECT AVG(sales.transactions.sales_amount) FROM sales.transactions INNER JOIN sales.date ON sales.transactions.order_date=sales.date.date 
where sales.date.year=2019 and sales.transactions.currency='INR\r' or sales.transactions.currency='USD\r';

/*Show  max sales amount in year 2019,*/
SELECT MAX(sales.transactions.sales_amount) FROM sales.transactions INNER JOIN sales.date ON sales.transactions.order_date=sales.date.date 
where sales.date.year=2019 and sales.transactions.currency='INR\r' or sales.transactions.currency='USD\r';

/*Show total revenue in year 2020, January Month,*/
SELECT SUM(transactions.sales_amount) FROM sales.transactions INNER JOIN sales.date ON sales.transactions.order_date=sales.date.date 
where sales.date.year=2020 and sales.date.month_name='January' 
and (sales.transactions.currency='INR\r' or sales.transactions.currency='USD\r');

/*Show total revenue in year 2020, February Month,*/
SELECT SUM(transactions.sales_amount) FROM sales.transactions INNER JOIN sales.date ON sales.transactions.order_date=sales.date.date 
where sales.date.year=2020 and sales.date.month_name='February' 
and (sales.transactions.currency='INR\r' or sales.transactions.currency='USD\r');

/*Show total revenue in year 2019, January Month,*/
SELECT SUM(transactions.sales_amount) FROM sales.transactions INNER JOIN sales.date ON sales.transactions.order_date=sales.date.date 
where sales.date.year=2019 and sales.date.month_name='January' 
and (sales.transactions.currency='INR\r' or sales.transactions.currency='USD\r');

/*Show total revenue in year 2019, February Month,*/
SELECT SUM(transactions.sales_amount) FROM sales.transactions INNER JOIN sales.date ON sales.transactions.order_date=sales.date.date 
where sales.date.year=2019 and sales.date.month_name='February' 
and (sales.transactions.currency='INR\r' or sales.transactions.currency='USD\r');

/*Show total revenue in year 2020 in Chennai*/
SELECT SUM(sales.transactions.sales_amount) FROM sales.transactions INNER JOIN sales.date ON sales.transactions.order_date=sales.date.date 
where sales.date.year=2020 and sales.transactions.market_code="Mark001";

/*Show total revenue in year 2020 in Mumbai*/
SELECT SUM(sales.transactions.sales_amount) FROM sales.transactions INNER JOIN sales.date ON sales.transactions.order_date=sales.date.date 
where sales.date.year=2020 and sales.transactions.market_code="Mark002";

/*show the distinct product channai*/
SELECT distinct product_code from sales.transactions where market_code='Mark001';

/*show the distinct product Mumbai*/
SELECT distinct product_code from sales.transactions where market_code='Mark002';

/*Show total revenue in year 2020, January Month, in channai*/
SELECT SUM(transactions.sales_amount) FROM sales.transactions INNER JOIN sales.date ON sales.transactions.order_date=sales.date.date 
where sales.date.year=2020 and sales.date.month_name='January' 
and (sales.transactions.currency='INR\r' or sales.transactions.currency='USD\r') and sales.transactions.market_code="Mark001";

/*Show total revenue in year 2020, February Month, channai*/
SELECT SUM(transactions.sales_amount) FROM sales.transactions INNER JOIN sales.date ON sales.transactions.order_date=sales.date.date 
where sales.date.year=2020 and sales.date.month_name='February' 
and (sales.transactions.currency='INR\r' or sales.transactions.currency='USD\r') and sales.transactions.market_code="Mark001";

/*Show total revenue in year 2020, January Month, in mumbai*/
SELECT SUM(transactions.sales_amount) FROM sales.transactions INNER JOIN sales.date ON sales.transactions.order_date=sales.date.date 
where sales.date.year=2020 and sales.date.month_name='January' 
and (sales.transactions.currency='INR\r' or sales.transactions.currency='USD\r') and sales.transactions.market_code="Mark002";

/*Show total revenue in year 2020, February Month, mumbai*/
SELECT SUM(transactions.sales_amount) FROM sales.transactions INNER JOIN sales.date ON sales.transactions.order_date=sales.date.date 
where sales.date.year=2020 and sales.date.month_name='February' 
and (sales.transactions.currency='INR\r' or sales.transactions.currency='USD\r') and sales.transactions.market_code="Mark002";
```
## Data Modeling:

The sales insights data tables as show below:

![data_model](https://github.com/akshat598/Power-BI-Project/assets/97584314/4cea268f-1e42-4a42-9b28-cbca2768a8c2)


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
  
## Report:

Data visualization for the data analysis (DAX) was done in Microsoft Power BI Desktop:

![report_screenshot](https://github.com/akshat598/Power-BI-Project/assets/97584314/58b94ca4-e4ad-4816-80c2-90a97d713191)

## Tools, Software and Libraries :

1.MySQL

2.Microsoft Power BI

3.Power Query Editor

3.DAX Language 

---
