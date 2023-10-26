/*Queries that provide answers to the questions from all projects.
Day 1
*/

SELECT * FROM animals
WHERE name LIKE '%mon'; 

SELECT name
FROM animals
WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

SELECT name
FROM animals
WHERE neutered = true 
AND escape_attempts < 3;

SELECT date_of_birth
FROM animals
WHERE name IN ('Agumon', 'Pikachu');

SELECT name, escape_attempts
FROM animals
WHERE weight_kg > 10.5;

SELECT * 
FROM animals
WHERE neutered = true;

SELECT *
FROM animals
WHERE name != 'Gabumon';

SELECT *
FROM animals
WHERE weight_kg BETWEEN 10.4 AND 17.3;

/**
* ! Day 2 SQL Transctions, to safely delete and update records.
*/

BEGIN;
UPDATE animals
SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon%';
UPDATE animals SET species = 'pokemon' WHERE species = '';
COMMIT;
SELECT * FROM animals;

UPDATE animals
SET species = 'pokemon'
WHERE id = 3;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';

SAVEPOINT sp1;

UPDATE animals SET weight_kg = -1 * weight_kg;

ROLLBACK TO SAVEPOINT sp1;

UPDATE animals SET weight_kg = -1 * weight_kg WHERE weight_kg < 0;

COMMIT;
SELECT * FROM animals;

/**
* ! Day 2 Aggregates in conjunction with Group By
*/

SELECT COUNT(*) FROM animals;

SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

SELECT AVG(weight_kg) FROM animals;

SELECT neutered, SUM(escape_attempts) AS total_escape_attempts
FROM animals
GROUP BY neutered
ORDER BY total_escape_attempts DESC
LIMIT 1;

SELECT species, MIN(weight_kg), MAX(weight_kg)
FROM animals
GROUP BY species;

SELECT species, AVG(escape_attempts) AS avg_escape_attempts
FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;

/**
* ! Day 3 Query multiple tables using JOIN
*/

SELECT animals.name
FROM animals
JOIN owners
ON animals.owners_id = owners.id
WHERE owners.full_name = 'Melody Pond';

SELECT animals.name
FROM animals
JOIN species
ON animals.species_id = species.id
WHERE species.name = 'Pokemon';

SELECT owners.full_name, animals.name
FROM owners
LEFT JOIN animals
ON owners.id = animals.owners_id;

SELECT species.name, COUNT(animals.id)
FROM species
JOIN animals
ON species.id = animals.species_id
GROUP BY species.name;

SELECT animals.name
FROM animals
JOIN owners ON animals.owners_id = owners.id
JOIN species ON animals.species_id = species.id
WHERE owners.full_name = 'Jennifer Orwell' AND species.name = 'Digimon';

SELECT * FROM animals 
WHERE owners_id = 5
AND escape_attempts = 0;

SELECT owners.full_name, COUNT(animals.id) AS NUMB_ANIMALS
FROM owners
JOIN animals
ON owners.id = animals.owners_id
GROUP BY owners.full_name
ORDER BY NUMB_ANIMALS DESC
LIMIT 1;

/**
* ! Day 4 Query Join tables
*/

SELECT animals.name
FROM animals
JOIN visits ON animals.id = visits.animal_id
JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'William Tatcher'
ORDER BY visits.visit_date DESC
LIMIT 1;

SELECT COUNT(DISTINCT a.id)
FROM animals a
JOIN visits v ON v.animal_id = a.id
JOIN vets vt ON vt.id = v.vet_id
WHERE vt.name = 'Stephanie Mendez';

SELECT v.name, s.name AS specialty
FROM vets v
LEFT JOIN specializations sp ON sp.vet_id = v.id
LEFT JOIN species s ON s.id = sp.species_id
ORDER BY v.name;

SELECT a.name
FROM animals a
JOIN visits v ON v.animal_id = a.id
JOIN vets vt ON vt.id = v.vet_id
WHERE vt.name = 'Stephanie Mendez'
AND v.visit_date BETWEEN '2020-04-01' AND '2020-08-30';

SELECT a.name, COUNT(*) AS num_visits
FROM animals a
JOIN visits v ON v.animal_id = a.id
GROUP BY a.id
ORDER BY num_visits DESC
LIMIT 1;

SELECT owners.full_name AS owner_name, animals.name AS animal_name, visits.visit_date
FROM visits
JOIN vets ON visits.vet_id = vets.id
JOIN animals ON visits.animal_id = animals.id
JOIN owners ON animals.owners_id = owners.id
WHERE vets.name = 'Maisy Smith'
ORDER BY visits.visit_date ASC
LIMIT 1;

SELECT a.name AS animal_name, v.name AS vet_name, vt.visit_date
FROM visits vt
JOIN animals a ON a.id = vt.animal_id
JOIN vets v ON v.id = vt.vet_id
ORDER BY vt.visit_date DESC
LIMIT 1;

SELECT COUNT(*) 
FROM visits v
JOIN animals a ON a.id = v.animal_id
JOIN vets vt ON vt.id = v.vet_id
LEFT JOIN specializations sp ON sp.vet_id = vt.id AND sp.species_id = a.species_id
WHERE sp.vet_id IS NULL;

SELECT s.name AS recommended_specialty
FROM animals a
JOIN species s ON s.id = a.species_id
JOIN visits v ON v.animal_id = a.id
JOIN vets vt ON vt.id = v.vet_id
JOIN owners o ON o.id = a.owners_id
WHERE o.full_name = 'Maisy Smith'
GROUP BY s.id
ORDER BY COUNT(*) DESC
LIMIT 1;

