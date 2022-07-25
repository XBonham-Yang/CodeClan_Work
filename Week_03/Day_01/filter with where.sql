SELECT *
FROM teams
WHERE "name" = 'Risk Team 1'

/*
 * filtering with where
*/

--find the info for employee id = 3

SELECT *
FROM employees 
WHERE id = 3;

/*
*comparison opertators
*!= NOT equal TO 
*= equal to 

*/

--find all employee work 0.5 full time 

SELECT*
FROM employees
WHERE fte_hours >= 0.5;


-- find employee not based in Brazil

SELECT*
FROM employees 
WHERE country != 'Brazil';


/*
 * and and or 
 * 
 */

-- find all employees in china who started working in 2019
SELECT *
FROM employees 
WHERE (country = 'China') AND (start_date >= '2019-01-01' AND start_date <= '2019-12-31');

--be wary of the order of evaluation ..

--find all employees in china started 2019 onwards or enrolled in pension scheme


SELECT *
FROM employees 
WHERE country = 'China' AND (start_date >= '2019-01-01' OR pension_enrol = TRUE);

--WHERE CONDITION 1 AND CONDITION 2

/*
 * between not and in 
 * let you specify a range of values
 */
 

--find all employees who worked 0.25 and 0.5 fte 

SELECT*
FROM employees 
WHERE fte_hours BETWEEN 0.25 AND 0.5;

-- find all emplyoyees whi started working in years other than 2017

SELECT*
FROM employees 
WHERE start_date NOT BETWEEN '2017-01-01' AND '2017-12-31';

--thigns to note
--BETWEEN IS inclusive 

--IN

--find all emplyees based in spain soutj africa ireland or germany 

SELECT*
FROM employees 
WHERE country IN ('Spain', 'South Africa', 'Ireland', 'Germany');

SELECT*
FROM employees 
WHERE country NOT IN ('Spain', 'South Africa', 'Ireland', 'Germany');


--note : can negate WITH NOT 

-- taks find all emplyees who started in 2016 who worjk 0.5 fte or greater 

SELECT *
FROM employees 
WHERE (start_date BETWEEN '2016-01-01' AND '2016-12-31') AND (fte_hours >= 0.5);


/*
 * LIKE wildcards and regx 
 */
SELECT*
FROM employees 
WHERE (country = 'Greece') AND (last_name LIKE 'Mc%'); 

/*
 * wildcards 
 * 
 * % macthes 0 or more 
 * _ single character
 * 
 * it can go inside anythere in the pattern 
 * 
 * '%ere%'
 */


--find last name contains 'ere' 
SELECT*
FROM employees 
WHERE last_name LIKE '%ere%';

/*
 * Like is case sensetive (distinguishes)
 */

SELECT *
FROM employees 
WHERE last_name LIKE 'D%';

--ILIKE to be insensetive to cases 

SELECT *
FROM employees 
WHERE last_name ILIKE 'D%';

-- ~ to define a regx pattern match 
-- find all last name second letter is 'r' or 's', and third letter is a or o 

SELECT*
FROM employees 
WHERE last_name  ~ '^.[rs][ao]';    -- . means ANY char 

-- regx tweaks


/*
 *  ~ --- define a regx
 * ~* --- case insensetive regx
 * !~ --- case sensetive doesn't match 
 * !~*-- case insensetive doesn't match 
 */

SELECT*
FROM employees 
WHERE last_name  !~ '^.[rs][ao]';  

/*
 * IS NULL
 */

-- we need to ensure our emplyee record are up-to-date, find who do not have a email

SELECT *
FROM employees 
WHERE email  IS NULL ;

--have TO use IS NULL, = null won't work similar to is.na()








