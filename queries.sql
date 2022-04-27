/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT * FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered=TRUE AND escape_attempts < 3;
SELECT date_of_birth from animals WHERE name='Agumon' OR name='Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * from animals WHERE neutered=TRUE;
SELECT * from animals WHERE name <> 'Gabumon';
SELECT * from animals WHERE weight_kg >=10.4 and weight_kg <= 17.3;

ALTER TABLE animals ADD species VARCHAR(50);

BEGIN;
update animals set species='unspecified' where species is null;
ROLLBACK;

BEGIN;
UPDATE animals SET species='digimon' WHERE name LIKE '%mon';
UPDATE animals SET species='pokemon' WHERE species is NULL;
COMMIT;

BEGIN;
DELETE * FROM animals
ROLLBACK;