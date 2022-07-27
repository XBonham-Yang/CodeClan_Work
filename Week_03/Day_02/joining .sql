--one TO one 
--one to many 
--many to many 

--if more than one frogein key, it's many to many table 


--join

--inner joining -at lease- one to one or one to many 

SELECT *
FROM animals 
INNER JOIN diets ON animals.diet_id = diets.id;



SELECT animals.*,
       diets.*
FROM animals 
INNER JOIN diets ON animals.diet_id = diets.id;


SELECT animals.*,
       diets.*
FROM animals AS A
INNER JOIN diets AS D ON A.diet_id = D.id;


SELECT A.name , A.age,
       D.diet_type 
FROM animals AS A
INNER JOIN diets AS D ON A.diet_id = D.id --- ONLY keeps the selected cols AND joined them 
WHERE A.age > 4;


--lets count the animals by diet type
 SELECT
 count(a.id),
 d.diet_type
 FROM animals AS a 
 INNER JOIN diets  AS d ON a.diet_id = d.id
 GROUP BY d.diet_type;

--modify the above to return all herbi  only 

 SELECT
 count(a.id),
 d.diet_type 
 FROM animals AS a 
 INNER JOIN diets  AS d ON a.diet_id = d.id
 WHERE d.diet_type = 'herbivore'
 GROUP BY d.diet_type;

 SELECT
 count(a.id), a.species,
 d.diet_type 
 FROM animals AS a 
 INNER JOIN diets  AS d ON a.diet_id = d.id
 WHERE d.diet_type = 'herbivore'
 GROUP BY d.diet_type, a.species;


SELECT A.name , A.age, A.species,
       D.diet_type 
FROM animals AS A
LEFT JOIN diets AS D ON A.diet_id = D.id;

--LEFT JOIN, BRINGS ALLL LEFT TABLE 

SELECT A.name , A.age, A.species,
       D.diet_type 
FROM animals AS A
RIGHT JOIN diets AS D ON A.diet_id = D.id;



SELECT count(A.id),
       D.diet_type 
FROM animals AS A
RIGHT JOIN diets AS D ON A.diet_id = D.id
GROUP BY D.diet_type ;


-- return how many animals have a matching diet 
SELECT count(A.id),
       D.diet_type 
FROM animals AS A
LEFT JOIN diets AS D ON A.diet_id = D.id
GROUP BY D.diet_type ;



--full join , rings back all records in both 
SELECT A.name, A.species, A.age,
D.diet_type 
FROM animals AS A
full JOIN diets AS D ON A.diet_id = D.id;


--“Get a rota for the keepers and the animals they look after, ordered first by animal name, and then by day.”

SELECT a."name" , a.species , cs."day" , k."name" 
FROM animals AS a 
INNER JOIN care_schedule AS cs ON a.id = cs.animal_id 
INNER JOIN keepers AS k ON k.id = cs.keeper_id
ORDER BY a."name" , cs."day"; -- there's a ORDER here BETWEEN the two things 


-- keep fro e the snack 
SELECT a."name" , a.species , cs."day" , k."name" 
FROM animals AS a 
INNER JOIN care_schedule AS cs ON a.id = cs.animal_id 
INNER JOIN keepers AS k ON k.id = cs.keeper_id
WHERE a."name" = 'Ernest' AND a.species = 'Snake' -- WHERE has TO be here 
ORDER BY a."name" , cs."day";


/*
 * Various animals feature on various tours around the zoo (this is another example of a many-to-many relationship).

Identify the join table linking the animals and tours table and reacquaint yourself with its contents.
Obtain a table showing 
animal name and species, the tour name on which they feature(d), along with the start date and end 
date (if stored) of their involvement. 

Order the table by tour name, and then by animal name.
[Harder] - can you limit the table to just those animals currently featuring on tours. 
Perhaps the NOW() function might help? Assume an animal with a start date in the past 
and either no stored end date or an end date in the future is currently active on a tour.
 */


SELECT a."name" , a.species , a.id,
a_t.tour_id, a_t.animal_id, a_t.start_date, a_t.end_date,
t.id, t."name" 
FROM animals AS a 
INNER JOIN animals_tours AS a_t ON a.id = a_t.animal_id 
INNER JOIN tours AS t ON a_t.tour_id  = t.id 
ORDER BY t."name" , a."name";


SELECT a."name" , a.species, 
a_t.start_date, a_t.end_date,
t."name" 
FROM animals AS a 
INNER JOIN animals_tours AS a_t ON a.id = a_t.animal_id 
INNER JOIN tours AS t ON a_t.tour_id  = t.id 
--WHERE now() < a_t.end_date  AND  now() > a_t.start_date 
ORDER BY t."name" , a."name"; 

--- okay so don't have TO SELECT anything FOR it TO run. just who i want AT the END 


SELECT keepers."name" AS keeper_name,
managers.name AS manager_name
FROM keepers
INNER JOIN keepers AS managers ON keepers.manager_id = managers.id;



SELECT * FROM animals 
UNION 
SELECT * FROM animals 




























