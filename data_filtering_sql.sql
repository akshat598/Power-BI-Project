/* sql query for customer table */
select * from customers where customer_code IS NULL;
select * from customers;
/* no null values in the customer table */

/* sql query for date table */
select * from date where date IS NULL;
/* no null value is in this table */
select * from date;

/* sql query for markets table */
select * from markets;
/* zone is not mentioned for two entries Mark097 and Mark999*/
UPDATE markets SET zone = 'usa' WHERE markets_code = 'Mark097';
UPDATE markets SET zone = 'france' WHERE markets_code = 'Mark999';

/* sql query for products table */
select * from products;
select * from products where product_code IS NULL;
/* no null values in the customer table */

/* sql query for transactions table */
select * from transactions where sales_amount <= 0;
select count(*) from transactions  where sales_amount <= 0; /* there are 1611 such entries */
/* we will delete them */
delete from transactions where sales_amount <= 0;
select count(*) from transactions  where sales_qty <= 0; /* there are no such entries */

/* data filtring */
select count(*) from transactions  where sales_qty <= 0; /* there are no such entries */
select count(*) from transactions where currency = 'INR\r';/* amount is 148393 */
select count(*) from transactions where currency = 'INR';     /* amount is 275,we will ignore this value this is duplicate */
delete from transactions where currency = 'INR';
select count(*) from transactions where currency = 'USD\r'; /* amount is 2 */
select count(*) from transactions where currency = 'USD'; /* amount is 2 */
delete from transactions where currency  = 'USD';
/* we will take INR\r and USD\r */