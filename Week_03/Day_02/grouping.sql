--find the number OF employees WITHIN EACH department OF the corp

SELECT 
count(id) AS num_employees,
department 
FROM employees 
GROUP BY department --- anything IN the GROUP BY can be IN the SELECT 
ORDER BY count(id);


SELECT 
count(id) AS num_employees,
country,
department 
FROM employees 
GROUP BY country, department  
ORDER BY count(id);


SELECT 
count(id) AS num_employ,
department,
fte_hours 
FROM employees
WHERE fte_hours BETWEEN 0.25 AND 0.5
GROUP BY department, fte_hours; 

SELECT 
  department, 
  COUNT(id) AS num_fte_quarter_half 
FROM employees 
WHERE fte_hours BETWEEN 0.25 AND 0.5 
GROUP BY department;
-- this just count all 0.25 and 0.5 

--WHERE fte_hours IN (0.25, 0.5)


--see how null affects 
--counts can  exist without a group by if no other col is present
SELECT 
count(id),---counting PRIMARY id 
count(first_name),--doesn't INCLUDE NULLS 
count(*) ---counting everything
FROM employees;


--find the longest seerving in each department 
--agrgate fun - sum/avg/max/min
--now(), gives todays date and time 
SELECT
now()- min(start_date)AS time_served,
first_name,
last_name,
department,
round( EXTRACT (DAY FROM now()-min(start_date))/365)
FROM employees
GROUP BY department, first_name , last_name
ORDER BY time_served DESC NULLS LAST;

/*
 * from
 * where
 * group by
 * having
 * select
 * order by
 * limit 
 */



SELECT
first_name,
last_name,
department,
round( EXTRACT (DAY FROM now()-min(start_date))/365) AS time_served
FROM employees
GROUP BY department, first_name , last_name
ORDER BY department, time_served DESC NULLS LAST;
--LIMIT 1;


/*
1. "How many employees in each department are enrolled in the pension scheme?"

2. "Perform a breakdown by country of the number of employees that do not have a stored first name."
 */

SELECT 
count(id)AS pension_count,
department 
FROM employees
WHERE pension_enrol = TRUE AND pension_enrol IS NOT NULL 
GROUP BY department;


SELECT 
country,
count(first_name IS NULL)
FROM employees
GROUP BY country;


--at least 40 work 0.25 to 0.5
--where clause for group by is called having 

SELECT
count(id),
department 
FROM employees 
WHERE fte_hours BETWEEN 0.25 AND 0.5
GROUP BY department
HAVING count(id) >= 40;-- only worked with aggergates  

--show any country in which the mini salary amongst pension enrolled employees is less than 21,000

SELECT country, 
salary 
FROM employees 
WHERE pension_enrol = TRUE AND salary <= 21000;

--better one 


SELECT country, 
min(salary) 
FROM employees 
WHERE pension_enrol = TRUE
GROUP BY  country 
HAVING min(salary) <= 21000;



SELECT country, 
min(salary),
department 
FROM employees 
WHERE pension_enrol = TRUE
GROUP BY  country ,department 
HAVING min(salary) <= 21000
ORDER BY min(salary), country, department;



SELECT count(id),
country, 
min(salary),
department 
FROM employees 
WHERE pension_enrol = TRUE
GROUP BY  country ,department 
HAVING min(salary) <= 21000
ORDER BY min(salary), country, department;----IF GROUP BY country ONLY GET one ROW back AS MORE GROUPS created 


--show department eariest satrt date among grade 1 employees is prior to 1991

SELECT
min(start_date),
department
FROM employees
WHERE grade = 1
GROUP BY department 
HAVING min(start_date) <= '1991-01-01';

--“Find all the employees in Japan who earn over the company-wide average salary.”

SELECT* 
FROM employees 
WHERE country = 'Japan'
AND salary > (
               SELECT avg(salary)
               FROM employees
              );

--“Find all the employees in Legal who earn less than the mean salary in that same department.”
SELECT *
FROM employees 
WHERE department = 'Legal'
AND 
salary < (
           SELECT avg(salary)
           FROM employees 
           WHERE department = 'Legal'
);

--“Find all the employees in the United States who work the most common full-time equivalent hours across the corporation.”

SELECT *
FROM employees 
WHERE fte_hours = (
                   
                   );
                   
SELECT fte_hours
FROM employees
GROUP BY fte_hours
ORDER BY COUNT(*) DESC
LIMIT 1;


SELECT
count(fte_hours)
FROM employees
GROUP BY fte_hours 
ORDER BY count(fte_hours) DESC 
LIMIT 1;



SELECT
count(fte_hours)
FROM employees
ORDER BY count(fte_hours) DESC 
LIMIT 1;
