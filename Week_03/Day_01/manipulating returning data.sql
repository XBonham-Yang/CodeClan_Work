/*
*manipulating returned DATA
*
*
*speciying col aliases using as 
*using distinct()
*
*sort records 
*use some aggregate function
*limit the number of records returned 
*/


--we can manipulate the data this is returned by a query by 
--altering thr select statement.


SELECT
id,
first_name ,
last_name 
FROM employees 
WHERE department = 'Accounting';


-- col aliases 
-- get a liist of all emplyees first and last name as one col - full name 


--concat works with strings too
-- , ,,,, , 
SELECT
first_name ,
last_name, 
concat(first_name, ' ', last_name) AS full_name
FROM  employees; 


--filter out null in names
/*Task - 2 mins
Add a WHERE clause to the query above to filter out any rows that don’t have both a first and second name.
*/

SELECT
first_name ,
last_name, 
concat(first_name, ' ', last_name) AS full_name
FROM  employees
WHERE first_name IS NOT NULL AND last_name IS NOT NULL;


/*
 * distinct()
 */

SELECT DISTINCT (department)
FROM employees; 

-- all the differnt values within the department col 

/*
 * aggregate functions 
 */
 
--how many started in 2001

SELECT 
count(*) AS 'started_in_2001'
FROM employees 
WHERE start_date  BETWEEN '2001-01-01' AND '2001-12-31';

--returns 36 

--sum()
--avg()
--min()
--max()


/*
 * Design queries using aggregate functions and what you have learned so far to answer the following questions:


1. “What are the maximum and minimum salaries of all employees?”

2. “What is the average salary of employees in the Human Resources department?”

3. “How much does the corporation spend on the salaries of employees hired in 2018?”
 */

SELECT 
max(salary) AS highest_pay
FROM employees;

SELECT 
min(salary) AS lowest_pay
FROM employees;


SELECT 
avg(salary)AS mean_hr
FROM employees 
WHERE department = 'Human Resources';


SELECT 
sum(salary) AS pay_2018
FROM employees 
WHERE start_date BETWEEN '2018-01-01' AND '2018-12-31';

/*
*sorting RESULT 
--order by
*/

--order by 
--sort the return of a query either desc or asc 
--thing to note order by comes after where 

-- employees details for who earns the min salary 

SELECT *
FROM employees 
WHERE salary IS NOT NULL 
ORDER BY salary  ASC
LIMIT 1;

-- limit gives you  1 rows, eg, 5 for 5 rows
 

-- if we want to put null at the end 
--use NULLS LAST;  eg: order by salary desc nulls last 

SELECT *
FROM employees 
WHERE salary IS NOT NULL 
ORDER BY salary  DESC 
LIMIT 1;


--we can perform multi-level sorts  

--employees details ordered by full time equivalent hours then alphabetically by last-NAME

SELECT *
FROM employees 
ORDER BY 
    fte_hours  DESC NULLS LAST,
    last_name ASC NULLS LAST;    
   
/*
 * Write queries to answer the following questions using the operators introduced in this section.


1. “Get the details of the longest-serving employee of the corporation.”

2. “Get the details of the highest paid employee of the corporation in Libya.”
 */



SELECT *
FROM employees 
ORDER BY start_date ASC
LIMIT 1;


SELECT *
FROM employees 
WHERE country = 'Libya'
ORDER BY salary DESC NULLS LAST;


--a note on ties 
--ties can happen when ordering 
--limit 1 will just return 1 row 


SELECT 
id,
first_name,
last_name,
concat(first_name, ' ', last_name) AS full_name
FROM employees 
WHERE full_name LIKE 'A%';

--this gives a error oder of definition != order of execution 
--select happens later than we think 









