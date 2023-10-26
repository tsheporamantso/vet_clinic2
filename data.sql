/* Populate database with sample data. 
Day 1
*/

INSERT INTO animals(name, date_of_birth,escape_attempts, neutered, weight_kg)
VALUES('Agumon', '2020-02-03', 0, true, 10.23),
('Gabumon', '2018-11-15', 2, true, 8),
('Pikachu', '2021-01-07', 1, false, 15.04),
('Devimon', '2017-05-12', 5, true, 11);

/**
* ! Day 2 Query and Update animals table
*/

INSERT INTO animals(name, date_of_birth, escape_attempts, neutered, weight_kg, species)
VALUES('Charmander','2020-02-08', 0, false, -11.0, ''),
('Plantmon', '2021-11-15', 2, true, -5.7, ''),
('Squirtle', '1993-04-02', 3, false,-12.13, ''),
('Angemon', '2005-06-12', 1, true, -45.0, ''),
('Boarmon', '2005-06-07', 7, true, 20.4, ''),
('Blossom', '1998-10-13', 3, true, 17.0, ''),
('Ditto', '2022-05-14', 4, true, 22.0, '');

/**
* ! Day 3 Query multiple tables
*/

INSERT INTO owners(full_name, age)
VALUES
('Sam Smith', 34),
('Jennifer Orwell', 19),
('Bob', 45),
('Melody Pond', 77),
('Dean Winchester', 14),
('Jodie Whittaker', 38);

INSERT INTO species(name)
VALUES
('Pokemon'),
('Digimon');

UPDATE animals
SET species_id = (CASE
WHEN name LIKE '%mon' THEN (
    SELECT id FROM species WHERE name = 'Digimon'
) ELSE (
    SELECT id FROM species WHERE name = 'Pokemon'
)
END);

UPDATE animals
SET owners_id = (CASE 
WHEN name IN ('Agumon') THEN (SELECT id FROM owners WHERE full_name = 'Sam Smith')
WHEN name IN ('Gabumon', 'Pikachu') THEN (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell')
WHEN name IN ('Devimon', 'Plantmon') THEN (SELECT id FROM owners WHERE full_name = 'Bob')
WHEN name IN ('Charmander', 'Squirtle', 'Blossom') THEN (SELECT id FROM owners WHERE full_name = 'Melody Pond')
WHEN name IN ('Angemon', 'Boarmon') THEN (SELECT id FROM owners WHERE full_name = 'Dean Winchester')
END);

/**
* ! Day 4 Join table for visits
*/

INSERT INTO vets(name, age, date_of_graduation)
VALUES
('William Tatche', 45, '2000-04-23'),
('Maisy Smith', 26, '2019-01-17'),
('Stephanie Mendez', 64, '1981-05-04'),
('Jack Harkness', 38, '2008-06-08');

/* Correcting name misspelled*/
UPDATE vets
SET name = 'William Tatcher'
WHERE id = 1; 
/* Correcting name misspelled end here*/

INSERT INTO specializations (vet_id, species_id)
VALUES
((SELECT id FROM vets WHERE name = 'William Tatcher'),(SELECT id FROM species WHERE name = 'Pokemon')),