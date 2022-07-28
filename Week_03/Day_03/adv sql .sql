--create your own functions 


--you may not allowed to create based on the bd permission 
--omni user can't create fucntion 

--it's a fun built in and we can't run this, we are read only 

-- 1. use the key word create [or replace is optional] to define functions 
--2. give your fun a name == percent change 
--3. specify the arguments of your functions and thier datatypes 
--4. specify type or data type of the result 
--5 write the code for the function 
--6. additional things, language sql plsql 
--7. immutable means can't be changed 

CREATE OR REPLACE FUNCTION 
percent_change(new_value NUMERIC, old_value NUMERIC, decimals INT DEFAULT 2)
RETURNS NUMERIC AS 
    'SELECT ROUND(100 * (new_value - old_value) / old_value, decimals);'
LANGUAGE SQL
IMMUTABLE
RETURNS NULL ON NULL INPUT;

--8. call your functions, just as any other functions 
SELECT 
percent_change (50,40),
percent_change(100, 99, 4);


/*
 * legal salarries are increasing by $1000 next year 
 * show percent change for each employee's salary in legal 
 */

SELECT id,
first_name ,
salary ,
salary + 1000 AS new_salary, 
percent_change(salary+1000, salary,2)
FROM employees 
WHERE department = 'Legal'
ORDER BY percent_change DESC NULLS LAST;


SELECT 
make_badge(first_name, last_name, department) AS badges 
FROM employees ;


--kind of need to know what function work ahead of time.

/*
 * investigating query performance 
 * 
 * [explain analyze]
 * maybe a queries taking a surprisingly long amount of time to run
 * interview question(how would i speed up a slow running query?)
 */

--geting department avg salary for who works in those countries 

EXPLAIN ANALYZE 
 SELECT department, avg(salary)
 FROM employees 
 WHERE country IN ('Germany', 'France', 'Italy', 'Spain')
 GROUP BY department 
 ORDER BY avg(salary);

--how do we speed up this query 

--index column 

--what index col do is behind -scenes they provide a quick lookupy way of 
--finding rows using the index column 

--searching a phone book 
--1. start at the strat and go through each page until find that person
--look at all the a's , all the b's , ----until we found it (sequential sacn)

--2. useing an index, notice that the surname starts with a C
--go find from c (index scan)

-- this was created with employees and indexes by country 
EXPLAIN ANALYZE 
SELECT department , avg(salary)
FROM employees_indexed
WHERE country IN ('Germany', 'France', 'Italy', 'Spain')
GROUP BY department 
ORDER BY avg(salary); 

--drawbacks
--storage 
--slows down other CRUD operation (insert, update, delect) 

/*
 * common table expressions 
 * 
 * we can create temporary table before the start of our query and access then like tables in 
 * date table 
 */

/*
 * find poeple in legal less than mean salary in the same department 
 */


SELECT *
FROM employees 
WHERE department = 'Legal' AND salary < (
    SELECT avg(salary)
    FROM employees 
    WHERE department = 'Legal');

/*
 * common tables allow you to specify this temporary table 
 * created in our subquery as table in the database
 */

WITH dep_avg AS ( 
    SELECT avg(salary) AS avg_salary
    FROM employees 
    WHERE department = 'Legal')
SELECT *
FROM employees 
WHERE department = 'Legal' AND salary < (
             SELECT avg_salary
             FROM dep_avg);

/*
 * find all the employees in leagl who earn less than mean slary and works fewer than mean ffte 
 *
 */
            
--common table 
WITH dep_avg AS (
SELECT avg(salary) AS avg_sal, avg(fte_hours) AS avg_fte
FROM employees 
WHERE department = 'Legal')
SELECT *
FROM employees 
WHERE department = 'Legal' AND 
salary < (SELECT avg_sal
FROM dep_avg)AND 
fte_hours <(SELECT avg_fte
FROM dep_avg);

-- subquery solution 
SELECT *
FROM employees 
WHERE department = 'Legal' AND salary < (
	SELECT avg(salary)
	FROM employees
	WHERE department = 'Legal'
) AND fte_hours < (
	SELECT avg(fte_hours)
	FROM employees
	WHERE department = 'Legal');


/*
 * salary of each employees
 * first name, last naem, department, country , salary and a comparison of their salary vs 
 * the county tehy work in, and the depatment they work in 
 * empl/dep avg 
 * emp/ country avg 
 */

--1. get avg salary for each department 
--2. get avg salary fro each country 
--3. using these average values calculaet each employee's ratio 
--4.some kinds of joining operation 2
WITH dep_table AS (
SELECT department, avg(salary) AS avg_dep 
FROM employees 
GROUP BY department),
cou_table AS(
SELECT country, avg(salary) AS avg_cou
FROM employees 
GROUP BY country)
SELECT e.first_name,
e.last_name, e.department, e.country , e.salary,
round(e.salary /d.avg_dep,2) AS dep_rate,
round(e.salary/c.avg_cou,2) AS cou_rate
FROM employees AS e INNER JOIN dep_table AS d ON e.department = d.department
INNER JOIN cou_table AS c ON e.country = c.country;


/*
 * window functions 
 */

--show for each employees their salary together with the min and max salary of department 


--over 

SELECT 
first_name,
last_name ,
salary,
department, 
min(salary) OVER (PARTITION BY department),
max(salary) OVER (PARTITION BY department)
FROM employees;

-- commo table 

WITH dep_avg AS (SELECT
department,
min(salary) AS min_salary,
max(salary) AS max_salary
FROM employees 
GROUP BY department 
)
SELECT 
e.first_name,
e.last_name ,
e.salary ,
e.department ,
dep_a.min_salary,
dep_a.max_salary
FROM employees AS e
INNER JOIN dep_avg AS dep_a ON e.department  = dep_a.department;



















