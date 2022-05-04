/* Populate database with sample data. */

INSERT INTO animals(name,date_of_birth,escape_attempts,neutered,weight_kg) VALUES('Agumon','2020/02/03',0,TRUE,10.23);
INSERT INTO animals(name,date_of_birth,escape_attempts,neutered,weight_kg) VALUES('Gabumon','2018/11/15',2,TRUE,8.0);
INSERT INTO animals(name,date_of_birth,escape_attempts,neutered,weight_kg) VALUES('Pikachu','2021/01/07',1,FALSE,15.04);
INSERT INTO animals(name,date_of_birth,escape_attempts,neutered,weight_kg) VALUES('Devimon','2017/05/12',5,TRUE,11.0);
INSERT INTO animals(name,date_of_birth,escape_attempts,neutered,weight_kg) VALUES('Charmander','2020/02/08',0,FALSE,-11.0);
INSERT INTO animals(name,date_of_birth,escape_attempts,neutered,weight_kg) VALUES('Plantmon','2021/11/15',2,TRUE,-5.7);
INSERT INTO animals(name,date_of_birth,escape_attempts,neutered,weight_kg) VALUES('Squirtle','1993/04/02',3,FALSE,-12.3);
INSERT INTO animals(name,date_of_birth,escape_attempts,neutered,weight_kg) VALUES('Angemon','2005/06/12',1,TRUE,-45.0);
INSERT INTO animals(name,date_of_birth,escape_attempts,neutered,weight_kg) VALUES('Boarmon','2005/06/07',7,TRUE,20.4);
INSERT INTO animals(name,date_of_birth,escape_attempts,neutered,weight_kg) VALUES('Blossom','1998/10/13',3,TRUE,17.0);
INSERT INTO animals(name,date_of_birth,escape_attempts,neutered,weight_kg) VALUES('Ditto','2022/05/14',4,TRUE,22.0);

INSERT INTO species(name) VALUES('Pokemon');
INSERT INTO species(name) VALUES('Digimon');


INSERT INTO owners(full_name,age) VALUES('Jodie Whittaker',38);
INSERT INTO owners(full_name,age) VALUES('Dean Winchester',14);
INSERT INTO owners(full_name,age) VALUES('Melody Pond',77);
INSERT INTO owners(full_name,age) VALUES('Bob',45);
INSERT INTO owners(full_name,age) VALUES('Jennifer Orwell',19);
INSERT INTO owners(full_name,age) VALUES('Sam Smith',34);


-- Modify your inserted animals so it includes the species_id value:
-- If the name ends in "mon" it will be Digimon
-- All other animals are Pokemon

UPDATE animals SET species_id = (SELECT id FROM species WHERE name = 'Digimon') WHERE name LIKE '%mon';
UPDATE animals SET species_id = (SELECT id FROM species WHERE name='Pokemon') WHERE name NOT LIKE '%mon';

-- Modify your inserted animals to include owner information (owner_id):
-- Sam Smith owns Agumon.
-- Jennifer Orwell owns Gabumon and Pikachu.

-- Bob owns Devimon and Plantmon.
-- Melody Pond owns Charmander, Squirtle, and Blossom.
-- Dean Winchester owns Angemon and Boarmon.

UPDATE animals SET owner_id=(SELECT id from owners WHERE full_name='Sam Smith') WHERE name='Agumon';
UPDATE animals SET owner_id=(SELECT id from owners WHERE full_name='Jennifer Orwell') WHERE name='Gabumon';
UPDATE animals SET owner_id=(SELECT id from owners WHERE full_name='Jennifer Orwell') WHERE name='Pikachu';
UPDATE animals SET owner_id=(SELECT id from owners WHERE full_name='Bob') WHERE name='Devimon';
UPDATE animals SET owner_id=(SELECT id from owners WHERE full_name='Bob') WHERE name='Plantmon';
UPDATE animals SET owner_id=(SELECT id from owners WHERE full_name='Melody Pond') WHERE name='Charmander';
UPDATE animals SET owner_id=(SELECT id from owners WHERE full_name='Melody Pond') WHERE name='Squirtle';
UPDATE animals SET owner_id=(SELECT id from owners WHERE full_name='Melody Pond') WHERE name='Blossom';
UPDATE animals SET owner_id=(SELECT id from owners WHERE full_name='Dean Winchester') WHERE name='Angemon';
UPDATE animals SET owner_id=(SELECT id from owners WHERE full_name='Dean Winchester') WHERE name='Boarmon';

-- Insert the following data for vets:
INSERT INTO vets(name,age,date_of_graduation) VALUES('William Tatcher',45,'2000/04/23');
INSERT INTO vets(name,age,date_of_graduation) VALUES('Maisy Smith',26,'2019/01/17');
INSERT INTO vets(name,age,date_of_graduation) VALUES('Stephanie Mendez',64,'1981/05/04');
INSERT INTO vets(name,age,date_of_graduation) VALUES('Jack Harkness',38,'2008/06/08');

-- Insert the following data for specialties:
INSERT INTO specializations(vets_id,species_id) VALUES((SELECT id FROM vets WHERE name='William Tatcher'),(SELECT id FROM species WHERE name='Pokemon'));
INSERT INTO specializations(vets_id,species_id) VALUES((SELECT id FROM vets WHERE name='Stephanie Mendez'),(SELECT id FROM species WHERE name='Pokemon'));
INSERT INTO specializations(vets_id,species_id) VALUES((SELECT id FROM vets WHERE name='Stephanie Mendez'),(SELECT id FROM species WHERE name='Digimon'));
INSERT INTO specializations(vets_id,species_id) VALUES((SELECT id FROM vets WHERE name='Jack Harkness'),(SELECT id FROM species WHERE name='Digimon'));

-- Insert the following data for visits

INSERT INTO visits(animals_id, vets_id, visit_date) VALUES((SELECT id from animals WHERE name='Agumon'),(SELECT id from vets WHERE name='William Tatcher'), '2020/05/24');
INSERT INTO visits(animals_id, vets_id, visit_date) VALUES((SELECT id from animals WHERE name='Agumon'),(SELECT id from vets WHERE name='Stephanie Mendez'), '2020/07/22');
INSERT INTO visits(animals_id, vets_id, visit_date) VALUES((SELECT id from animals WHERE name='Gabumon'),(SELECT id from vets WHERE name='Jack Harkness'), '2021/02/02');
INSERT INTO visits(animals_id, vets_id, visit_date) VALUES((SELECT id from animals WHERE name='Pikachu'),(SELECT id from vets WHERE name='Maisy Smith'), '2020/01/05');
INSERT INTO visits(animals_id, vets_id, visit_date) VALUES((SELECT id from animals WHERE name='Pikachu'),(SELECT id from vets WHERE name='Maisy Smith'), '2020/03/08');
INSERT INTO visits(animals_id, vets_id, visit_date) VALUES((SELECT id from animals WHERE name='Pikachu'),(SELECT id from vets WHERE name='Maisy Smith'), '2020/05/14');
INSERT INTO visits(animals_id, vets_id, visit_date) VALUES((SELECT id from animals WHERE name='Devimon'),(SELECT id from vets WHERE name='Stephanie Mendez'), '2021/05/04');
INSERT INTO visits(animals_id, vets_id, visit_date) VALUES((SELECT id from animals WHERE name='Charmander'),(SELECT id from vets WHERE name='Jack Harkness'), '2021/02/24');
INSERT INTO visits(animals_id, vets_id, visit_date) VALUES((SELECT id from animals WHERE name='Plantmon'),(SELECT id from vets WHERE name='Maisy Smith'), '2019/12/21');
INSERT INTO visits(animals_id, vets_id, visit_date) VALUES((SELECT id from animals WHERE name='Plantmon'),(SELECT id from vets WHERE name='William Tatcher'), '2020/08/10');
INSERT INTO visits(animals_id, vets_id, visit_date) VALUES((SELECT id from animals WHERE name='Plantmon'),(SELECT id from vets WHERE name='Maisy Smith'), '2021/04/07');
INSERT INTO visits(animals_id, vets_id, visit_date) VALUES((SELECT id from animals WHERE name='Squirtle'),(SELECT id from vets WHERE name='Stephanie Mendez'), '2019/09/29');
INSERT INTO visits(animals_id, vets_id, visit_date) VALUES((SELECT id from animals WHERE name='Angemon'),(SELECT id from vets WHERE name='Jack Harkness'), '2020/10/03');
INSERT INTO visits(animals_id, vets_id, visit_date) VALUES((SELECT id from animals WHERE name='Angemon'),(SELECT id from vets WHERE name='Jack Harkness'), '2020/11/04');
INSERT INTO visits(animals_id, vets_id, visit_date) VALUES((SELECT id from animals WHERE name='Boarmon'),(SELECT id from vets WHERE name='Maisy Smith'), '2019/01/24');
INSERT INTO visits(animals_id, vets_id, visit_date) VALUES((SELECT id from animals WHERE name='Boarmon'),(SELECT id from vets WHERE name='Maisy Smith'), '2019/05/15');
INSERT INTO visits(animals_id, vets_id, visit_date) VALUES((SELECT id from animals WHERE name='Boarmon'),(SELECT id from vets WHERE name='Maisy Smith'), '2020/02/27');
INSERT INTO visits(animals_id, vets_id, visit_date) VALUES((SELECT id from animals WHERE name='Boarmon'),(SELECT id from vets WHERE name='Maisy Smith'), '2020/08/03');
INSERT INTO visits(animals_id, vets_id, visit_date) VALUES((SELECT id from animals WHERE name='Blossom'),(SELECT id from vets WHERE name='Stephanie Mendez'), '2020/05/24');
INSERT INTO visits(animals_id, vets_id, visit_date) VALUES((SELECT id from animals WHERE name='Blossom'),(SELECT id from vets WHERE name='William Tatcher'), '2021/01/11');

-- This will add 3.594.280 visits considering you have 10 animals, 4 vets, and it will use around ~87.000 timestamps (~4min approx.)
INSERT INTO visits (animals_id, vets_id, visit_date) SELECT * FROM (SELECT id FROM animals) animals_id, (SELECT id FROM vets) vets_id, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

-- This will add 2.500.000 owners with full_name = 'Owner <X>' and email = 'owner_<X>@email.com' (~2min approx.)
insert into owners (full_name, email) select 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';



