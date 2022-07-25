/*
 * mutiline comment 
*/

-- inline comment

--Get a table of all the animal information 


-- slect = col to select.
--from = table/ entitiy to select from 
--; = the end of query 

-- control enter for mac 

SELECT*
FROM animals;
-- read operation 

--get me a table of information about the animal with id=2

SELECT*
FROM animals 
WHERE id = 2;



--task get a table of information about ernest the Snake

SELECT*
FROM animals 
WHERE name = 'Ernest' AND species  = 'Snake';


-- because we're filtering on pk, we only expect 1 row. 
SELECT*
FROM animals 
WHERE id = 7;






