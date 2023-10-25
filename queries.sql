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
