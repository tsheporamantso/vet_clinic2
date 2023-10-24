/* Day 1 create animals table */

CREATE TABLE animals (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    date_of_birth DATE NOT NULL,
    escape_attempts INTEGER DEFAULT 0,
    neutered BOOLEAN DEFAULT FALSE,
    weight_kg DECIMAL(5,2) NOT NULL
);

/**
* ! Day 2 Query and Update animals table
*/

ALTER TABLE animals
ADD COLUMN species VARCHAR(50);