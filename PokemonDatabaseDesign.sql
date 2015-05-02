DROP VIEW IF EXISTS twoTypes;
DROP VIEW IF EXISTS nicknameMoves;
DROP VIEW IF EXISTS trainerpokemonnames;
DROP VIEW IF EXISTS moveInfo;
DROP TABLE IF EXISTS trainerBadges;
DROP TABLE IF EXISTS trainerItems;
DROP TABLE IF EXISTS items;
DROP TABLE IF EXISTS badges;
DROP TABLE IF EXISTS gyms;
DROP TABLE IF EXISTS towns;
DROP TABLE IF EXISTS trainerPkmn;
DROP TABLE IF EXISTS trainers;
DROP TABLE IF EXISTS pkmnMoves;
DROP TABLE IF EXISTS pokemon;
DROP TABLE IF EXISTS moveTypes;
DROP TABLE IF EXISTS moves;
DROP TABLE IF EXISTS pokeTypes;
DROP TABLE IF EXISTS typeStrengths;
DROP TABLE IF EXISTS elementTypes;
DROP TABLE IF EXISTS evolutions;
DROP TABLE IF EXISTS pokedex;

-------Tables--------

CREATE TABLE pokedex(
   pkmnName        text          NOT NULL UNIQUE,
   dexHeightMeters decimal(5,2),
   dexWeightKG     decimal(8,2),
   description     text,
   primary key(pkmnName)
);

CREATE TABLE evolutions(
   pkmnName     text  NOT NULL,
   evolveName   text  NOT NULL,
   requirements text,
   primary key(evolveName),
   foreign key(pkmnName) references pokedex(pkmnName),
   foreign key(evolveName) references pokedex(pkmnName)
);

CREATE TABLE elementTypes(
   typeName  text NOT NULL UNIQUE,
   trivia    text,
   primary key(typeName)
);

CREATE TABLE typeStrengths(
   typeName    text NOT NULL,
   goodAgainst text NOT NULL,
   primary key(typeName, goodAgainst),
   foreign key(typeName) references elementTypes(typeName)
);

CREATE TABLE pokeTypes(
  pkmnName  text NOT NULL,
  typeName text NOT NULL,
  primary key(pkmnName, typeName),
  foreign key(pkmnName) references pokedex(pkmnName),
  foreign key(typeName) references elementTypes(typeName)
);

CREATE TABLE moves(
  moveName    text NOT NULL UNIQUE,
  pp          integer,
  description text,
  primary key(moveName)
);

CREATE TABLE moveTypes(
  moveName text NOT NULL,
  typeName text NOT NULL,
  primary key (moveName, typeName),
  foreign key(typeName) references elementTypes(typeName),
  foreign key(moveName) references moves(moveName)
);


CREATE TABLE pokemon(
  pkmnid     integer NOT NULL UNIQUE,
  pkmnName   text    NOT NULL,
  pkmnLevel  integer,
  totalHP    integer,
  primary key (pkmnid),
  foreign key (pkmnName) references pokedex(pkmnName)  
);


CREATE TABLE pkmnMoves(
  pkmnid   integer NOT NULL,
  moveName text NOT NULL,
  primary key(pkmnid, moveName),
  foreign key(pkmnid) references pokemon(pkmnid),
  foreign key(moveName) references moves(moveName)
);

CREATE TABLE trainers(
  tid      integer NOT NULL UNIQUE,
  tName    text,
  cashYen  decimal(8,2),
  primary key (tid)
);

CREATE TABLE trainerPkmn(
  pkmnid   integer NOT NULL UNIQUE,
  tid      integer NOT NULL,
  nickname text,
  primary key(pkmnid),
  foreign key(pkmnid) references pokemon(pkmnid),
  foreign key(tid) references trainers(tid)
);

CREATE TABLE towns(
  townName   text NOT NULL UNIQUE,
  regionName text,
  primary key(townName)
);

CREATE TABLE gyms(
  gymName text NOT NULL UNIQUE,
  typeName  text,
  tid       integer,
  townName  text,
  primary key(gymName),
  foreign key(tid) references trainers(tid),
  foreign key(typeName) references elementTypes(typeName),
  foreign key(townName) references towns(townName)
);

CREATE TABLE badges(
  badgeName text NOT NULL UNIQUE,
  gymName text,
  primary key(badgeName),
  foreign key(gymName) references gyms(gymName)
);


CREATE TABLE items(
  itemName    text NOT NULL UNIQUE,
  itemCostYen decimal(8,2),
  itemSellYen decimal(8,2),
  description text,
  primary key (itemName)
);

CREATE TABLE trainerItems(
  tid       integer NOT NULL,
  itemName  text NOT NULL,
  quantity integer,
  primary key(tid, itemName),
  foreign key(tid) references trainers(tid),
  foreign key(itemName) references items(itemName)
);

CREATE TABLE trainerBadges(
  tid       integer NOT NULL,
  badgeName text NOT NULL,
  primary key(tid, badgeName),
  foreign key(tid) references trainers(tid),
  foreign key(badgeName) references badges(badgeName)
);


------Sample Data--------

INSERT INTO Pokedex( pkmnName, dexHeightMeters, dexWeightKg, description)
  VALUES ('Bulbasaur', 0.7, 6.9, 'A strange seed was planted on its back at birth. The plant sprouts and grows with this Pokémon.');

INSERT INTO Pokedex( pkmnName, dexHeightMeters, dexWeightKg, description)
  VALUES ('Ivysaur', 1, 13, 'When the bulb on its back grows large, it appears to lose the ability to stand on its hind legs.');

INSERT INTO Pokedex( pkmnName, dexHeightMeters, dexWeightKg, description)
  VALUES ('Venusaur', 2, 100, 'The plant blooms when it is absorbing solar energy. It stays on the move to seek sunlight.');

INSERT INTO Pokedex( pkmnName, dexHeightMeters, dexWeightKg, description)
  VALUES ('Charmander', 0.6, 8.5, 'Obviously prefers hot places. When it rains, steam is said to spout from the tip of its tail.');

INSERT INTO Pokedex( pkmnName, dexHeightMeters, dexWeightKg, description)
  VALUES ('Charmeleon', 1.1, 19, 'When it swings its burning tail, it elevates the temperature to unbearably high levels.');

INSERT INTO Pokedex( pkmnName, dexHeightMeters, dexWeightKg, description)
  VALUES ('Charizard', 1.7, 90.5, 'Spits fire that is hot enough to melt boulders. Known to cause forest fires unintentionally.');  

INSERT INTO Pokedex( pkmnName, dexHeightMeters, dexWeightKg, description)
  VALUES ('Squirtle', 0.5, 9, 'After birth, its back swells and hardens into a shell. Powerfully sprays foam from its mouth.');

INSERT INTO Pokedex( pkmnName, dexHeightMeters, dexWeightKg, description)
  VALUES ('Wartortle', 1, 22.5, 'Often hides in water to stalk unwary prey. For swimming fast, it moves its ears to maintain balance.');

INSERT INTO Pokedex( pkmnName, dexHeightMeters, dexWeightKg, description)
  VALUES ('Blastoise', 1.6, 85.5, 'A brutal Pokémon with pressurized water jets on its shell. They are used for high speed tackles.');

INSERT INTO Pokedex( pkmnName, dexHeightMeters, dexWeightKg, description)
  VALUES ('Pichu', 0.3, 2, 'It is not yet skilled at storing electricity. It may send out a jolt if amused or startled.');

INSERT INTO Pokedex( pkmnName, dexHeightMeters, dexWeightKg, description)
  VALUES ('Pikachu', 0.4, 6, 'When several of these Pokémon gather, their electricity could build and cause lightning storms.');
  
INSERT INTO Pokedex( pkmnName, dexHeightMeters, dexWeightKg, description)
  VALUES ('Raichu', 0.8, 30, 'Its long tail serves as a ground to protect itself from its own high voltage power.');
  
INSERT INTO Pokedex( pkmnName, dexHeightMeters, dexWeightKg, description)
  VALUES ('Mawile', 0.6, 11.5, 'It uses its docile-looking face to lull foes into complacency, then bites with its huge, relentless jaws.');
  
INSERT INTO Pokedex( pkmnName, dexHeightMeters, dexWeightKg, description)
  VALUES ('Eevee', 0.3, 6.5, 'Its genetic code is unstable, so it could evolve in a variety of ways. There are only a few alive.');
  
INSERT INTO Pokedex( pkmnName, dexHeightMeters, dexWeightKg, description)
  VALUES ('Vaporeon', 1, 29, 'Lives close to water. Its long tail is ridged with a fin which is often mistaken for a mermaid.');
  
INSERT INTO Pokedex( pkmnName, dexHeightMeters, dexWeightKg, description)
  VALUES ('Espeon', 0.9, 25.6, 'By reading air currents, it can predict things such as the weather or its foes next move.');
  
INSERT INTO Pokedex( pkmnName, dexHeightMeters, dexWeightKg, description)
  VALUES ('Leafeon', 1.0, 25.5, 'Just like a plant, it uses photosynthesis. As a result, it is always enveloped in clean air.');
  
INSERT INTO Pokedex( pkmnName, dexHeightMeters, dexWeightKg, description)
  VALUES ('Rattata', 0.3, 3.5, '');
--Select * from pokedex;


INSERT INTO Evolutions(pkmnName, evolveName, requirements)
  Values('Bulbasaur', 'Ivysaur', 'Level 16');
  
INSERT INTO Evolutions(pkmnName, evolveName, requirements)
  Values('Ivysaur', 'Venusaur', 'Level 32');
  
INSERT INTO Evolutions(pkmnName, evolveName, requirements)
  Values('Charmander', 'Charmeleon', 'Level 16');
  
INSERT INTO Evolutions(pkmnName, evolveName, requirements)
  Values('Charmeleon', 'Charizard', 'Level 32');
  
INSERT INTO Evolutions(pkmnName, evolveName, requirements)
  Values('Squirtle', 'Wartortle', 'Level 16');
  
INSERT INTO Evolutions(pkmnName, evolveName, requirements)
  Values('Wartortle', 'Blastoise', 'Level 32');
  
INSERT INTO Evolutions(pkmnName, evolveName, requirements)
  Values('Pichu', 'Pikachu', 'Friendship');

  
INSERT INTO Evolutions(pkmnName, evolveName, requirements)
  Values('Pikachu', 'Raichu', 'Thunder Stone');

  
INSERT INTO Evolutions(pkmnName, evolveName, requirements)
  Values('Eevee', 'Vaporeon', 'Water Stone');
  
INSERT INTO Evolutions(pkmnName, evolveName, requirements)
  Values('Eevee', 'Espeon', 'Friendship (Day)');

INSERT INTO Evolutions(pkmnName, evolveName, requirements)
  Values('Eevee', 'Leafeon', 'Level up near Moss Rock');

--Select * from Evolutions;

INSERT INTO ElementTypes(typeName, trivia)
 Values('grass', '1/3 of all starter pokemon are grass type');

INSERT INTO ElementTypes(typeName, trivia)
 Values('fire', '1/3 of all starter pokemon are fire type');

INSERT INTO ElementTypes(typeName, trivia)
 Values('water', '1/3 of all starter pokemon are water type');

INSERT INTO ElementTypes(typeName, trivia)
 Values('poison', 'Team Rocket uses a lot of poison types');

INSERT INTO ElementTypes(typeName, trivia)
 Values('flying', 'Most flying types can use the move Fly');
 
INSERT INTO ElementTypes(typeName, trivia)
 Values('electric', 'Pikachu is the only electric starter pokemon');
 
INSERT INTO ElementTypes(typeName, trivia)
 Values('steel', 'Steel type was introduced in the second generation');
 
INSERT INTO ElementTypes(typeName, trivia)
 Values('fairy', 'Fairy is the newest type, and is immune to dragon');

INSERT INTO ElementTypes(typeName, trivia)
 Values('dragon', 'Dragon has been weakened over serveral games');
 
INSERT INTO ElementTypes(typeName, trivia)
 Values('psychic', 'Psychic is weak against what people are afraid of, such as bugs');

INSERT INTO ElementTypes(typeName, trivia)
 Values('bug', 'Misty, a gym leader, is afraid of bug pokemon');

INSERT INTO ElementTypes(typeName, trivia)
 Values('normal', 'Normal seems boring, but they tend to be cute pokemon');

 --Select * from ElementTypes;

 INSERT INTO typeStrengths(typeName, goodAgainst)
   Values('grass', 'water');

INSERT INTO typeStrengths(typeName, goodAgainst)
   Values('fire', 'grass');  

INSERT INTO typeStrengths(typeName, goodAgainst)
   Values('fire', 'steel');

INSERT INTO typeStrengths(typeName, goodAgainst)
   Values('fire', 'fairy');

INSERT INTO typeStrengths(typeName, goodAgainst)
   Values('water', 'fire');

INSERT INTO typeStrengths(typeName, goodAgainst)
   Values('poison', 'fairy');
   
INSERT INTO typeStrengths(typeName, goodAgainst)
   Values('flying', 'bug');

INSERT INTO typeStrengths(typeName, goodAgainst)
   Values('flying', 'grass');

INSERT INTO typeStrengths(typeName, goodAgainst)
   Values('electric', 'water');

INSERT INTO typeStrengths(typeName, goodAgainst)
   Values('electric', 'flying');

INSERT INTO typeStrengths(typeName, goodAgainst)
   Values('steel', 'psychic');

INSERT INTO typeStrengths(typeName, goodAgainst)
   Values('steel', 'fairy');

INSERT INTO typeStrengths(typeName, goodAgainst)
   Values('steel', 'normal');

INSERT INTO typeStrengths(typeName, goodAgainst)
   Values('fairy', 'dragon');

INSERT INTO typeStrengths(typeName, goodAgainst)
   Values('dragon', 'dragon');

INSERT INTO typeStrengths(typeName, goodAgainst)
   Values('psychic', 'poison');

INSERT INTO typeStrengths(typeName, goodAgainst)
   Values('bug', 'psychic');

INSERT INTO typeStrengths(typeName, goodAgainst)
   Values('bug', 'grass');

--Select * from typeStrengths;

INSERT INTO PokeTypes(pkmnName, typeName)
  Values('Bulbasaur', 'grass');

INSERT INTO PokeTypes(pkmnName, typeName)
  Values('Bulbasaur', 'poison');

INSERT INTO PokeTypes(pkmnName, typeName)
  Values('Ivysaur', 'grass');

INSERT INTO PokeTypes(pkmnName, typeName)
  Values('Ivysaur', 'poison');

INSERT INTO PokeTypes(pkmnName, typeName)
  Values('Venusaur', 'grass');

INSERT INTO PokeTypes(pkmnName, typeName)
  Values('Venusaur', 'poison');

INSERT INTO PokeTypes(pkmnName, typeName)
  Values('Charmander', 'fire');

INSERT INTO PokeTypes(pkmnName, typeName)
  Values('Charmeleon', 'fire');

INSERT INTO PokeTypes(pkmnName, typeName)
  Values('Charizard', 'flying');

INSERT INTO PokeTypes(pkmnName, typeName)
  Values('Squirtle', 'water');  

INSERT INTO PokeTypes(pkmnName, typeName)
  Values('Wartortle', 'water'); 

INSERT INTO PokeTypes(pkmnName, typeName)
  Values('Blastoise', 'water'); 

INSERT INTO PokeTypes(pkmnName, typeName)
  Values('Pichu', 'electric'); 
  
INSERT INTO PokeTypes(pkmnName, typeName)
  Values('Pikachu', 'electric');

INSERT INTO PokeTypes(pkmnName, typeName)
  Values('Raichu', 'electric');  

INSERT INTO PokeTypes(pkmnName, typeName)
  Values('Mawile', 'steel'); 

INSERT INTO PokeTypes(pkmnName, typeName)
  Values('Mawile', 'fairy'); 

INSERT INTO PokeTypes(pkmnName, typeName)
  Values('Eevee', 'normal'); 

INSERT INTO PokeTypes(pkmnName, typeName)
  Values('Vaporeon', 'water'); 
  
INSERT INTO PokeTypes(pkmnName, typeName)
  Values('Espeon', 'psychic'); 

INSERT INTO PokeTypes(pkmnName, typeName)
  Values('Leafeon', 'grass'); 

INSERT INTO PokeTypes(pkmnName, typeName)
  Values('Rattata', 'normal');

--Select * from pokeTypes;

INSERT INTO Moves(moveName, pp, description)
  Values ('Dragon Dance', 20, 'A mystical dance that ups Attack and Speed.');

INSERT INTO MOVES(moveName, pp, description)
  Values ('Fury Cutter', 20, 'The target is slashed with scythes or claws. Its power increases if it hits in succession.');

INSERT INTO MOVES(moveName, pp, description)
  Values ('Tackle', 35, 'A full-body charge attack.');

INSERT INTO MOVES(moveName, pp, description)
  Values ('Volt Tackle', 15, 'A life-risking tackle that slightly hurts the user.');

INSERT INTO MOVES(moveName, pp, description)
  Values ('Dragon Claw', 15, 'The user slashes the target with huge, sharp claws.');

INSERT INTO MOVES(moveName, pp, description)
  Values ('Leech Seed', 10, 'Steals HP from the foe on every turn.');
  
INSERT INTO MOVES(moveName, pp, description)
  Values ('Fly', 15, 'A 2-turn move that hits on the 2nd turn. Use it to fly to any known town.');

INSERT INTO MOVES(moveName, pp, description)
  Values ('Fire Blast', 5, 'The foe is hit with an intense flame. It may leave the target with a burn.');

INSERT INTO MOVES(moveName, pp, description)
  Values ('Bubble Beam', 20, 'An attack that may lower Speed.');

INSERT INTO MOVES(moveName, pp, description)
  Values ('Psybeam', 20, 'An attack that may confuse the foe.');

INSERT INTO MOVES(moveName, pp, description)
  Values ('Poison Sting', 35, 'An attack that may poison the foe.');

INSERT INTO MOVES(moveName, pp, description)
  Values ('Leer', 30, 'Frightens the foe with a leer to lower Defense.');

--Select * from Moves;

INSERT INTO MoveTypes(moveName, typeName)
  Values('Dragon Dance', 'dragon');
  
INSERT INTO MoveTypes(moveName, typeName)
  Values('Fury Cutter', 'bug');  
  
INSERT INTO MoveTypes(moveName, typeName)
  Values('Tackle', 'normal');
  
INSERT INTO MoveTypes(moveName, typeName)
  Values('Volt Tackle', 'electric');
  
INSERT INTO MoveTypes(moveName, typeName)
  Values('Dragon Claw', 'dragon');

INSERT INTO MoveTypes(moveName, typeName)
  Values('Leech Seed', 'grass');
  
INSERT INTO MoveTypes(moveName, typeName)
  Values('Fly', 'flying');
  
INSERT INTO MoveTypes(moveName, typeName)
  Values('Fire Blast', 'fire');

INSERT INTO MoveTypes(moveName, typeName)
  Values('Bubble Beam', 'water');

INSERT INTO MoveTypes(moveName, typeName)
  Values('Psybeam', 'psychic');

INSERT INTO MoveTypes(moveName, typeName)
  Values('Poison Sting', 'poison');

INSERT INTO MoveTypes(moveName, typeName)
  Values('Leer', 'normal');

--select * from movetypes;

INSERT INTO Pokemon(pkmnid, pkmnName, pkmnLevel, totalHP)
  Values(1, 'Pikachu', 30, 70);

INSERT INTO Pokemon(pkmnid, pkmnName, pkmnLevel, totalHP)
  Values(2, 'Mawile', 50, 150);

INSERT INTO Pokemon(pkmnid, pkmnName, pkmnLevel, totalHP)
  Values(3, 'Rattata', 5, 20);

INSERT INTO Pokemon(pkmnid, pkmnName, pkmnLevel, totalHP)
  Values(4, 'Charizard', 40, 100);

INSERT INTO Pokemon(pkmnid, pkmnName, pkmnLevel, totalHP)
  Values(5, 'Pichu', 1, 10);

INSERT INTO Pokemon(pkmnid, pkmnName, pkmnLevel, totalHP)
  Values(6, 'Ivysaur', 30, 60);

INSERT INTO Pokemon(pkmnid, pkmnName, pkmnLevel, totalHP)
  Values(7, 'Eevee', 20, 40);

INSERT INTO Pokemon(pkmnid, pkmnName, pkmnLevel, totalHP)
  Values(8, 'Rattata', 5, 19);

INSERT INTO Pokemon(pkmnid, pkmnName, pkmnLevel, totalHP)
  Values(9, 'Rattata', 5, 18); 

INSERT INTO Pokemon(pkmnid, pkmnName, pkmnLevel, totalHP)
  Values(10, 'Charizard', 40, 100);

INSERT INTO Pokemon(pkmnid, pkmnName, pkmnLevel, totalHP)
  Values(11, 'Blastoise', 40, 100);

INSERT INTO Pokemon(pkmnid, pkmnName, pkmnLevel, totalHP)
  Values(12, 'Espeon', 23, 63);

--Select * from pokemon;

Insert Into PkmnMoves(pkmnid, moveName)
  Values(1, 'Volt Tackle');

Insert Into PkmnMoves(pkmnid, moveName)
  Values(2, 'Tackle');

Insert Into PkmnMoves(pkmnid, moveName)
  Values(2, 'Dragon Claw');

Insert Into PkmnMoves(pkmnid, moveName)
  Values(3, 'Tackle');

Insert Into PkmnMoves(pkmnid, moveName)
  Values(3, 'Fury Cutter');

Insert Into PkmnMoves(pkmnid, moveName)
  Values(3, 'Leer');

Insert Into PkmnMoves(pkmnid, moveName)
  Values(4, 'Fly');

Insert Into PkmnMoves(pkmnid, moveName)
  Values(4, 'Fire Blast');

Insert Into PkmnMoves(pkmnid, moveName)
  Values(5, 'Tackle');

Insert Into PkmnMoves(pkmnid, moveName)
  Values(6, 'Leech Seed');

Insert Into PkmnMoves(pkmnid, moveName)
  Values(6, 'Poison Sting');

Insert Into PkmnMoves(pkmnid, moveName)
  Values(7, 'Tackle');  

Insert Into PkmnMoves(pkmnid, moveName)
  Values(8, 'Leer');

Insert Into PkmnMoves(pkmnid, moveName)
  Values(9, 'Tackle');

Insert Into PkmnMoves(pkmnid, moveName)
  Values(10, 'Leer');

Insert Into PkmnMoves(pkmnid, moveName)
  Values(10, 'Fire Blast');

Insert Into PkmnMoves(pkmnid, moveName)
  Values(11, 'Bubble Beam');

Insert Into PkmnMoves(pkmnid, moveName)
  Values(12, 'Psybeam');

--Select * from pkmnmoves;


INSERT INTO trainers(tid, tName, cashYen)
  Values(1, 'Ash', 4500.00);

INSERT INTO trainers(tid, tName, cashYen)
  Values(2, 'Misty', 9000.00);

INSERT INTO trainers(tid, tName, cashYen)
  Values(3, 'Gary', 9999.99);

INSERT INTO trainers(tid, tName, cashYen)
  Values(4, 'Youngster Joey', 500.00);

INSERT INTO trainers(tid, tName, cashYen)
  Values(5, 'Erika', 4500.00);

INSERT INTO trainers(tid, tName, cashYen)
  Values(6, 'Crystal', 4000.00);

INSERT INTO trainers(tid, tName, cashYen)
  Values(7, 'Wattson', 8000.00);

INSERT INTO trainers(tid, tName, cashYen)
  Values(8, 'Gary', 6000.00);

--Select * from trainers;

INSERT INTO TrainerPkmn(pkmnid, tid, nickname)
  Values(1, 1, 'Pikachu');

INSERT INTO TrainerPkmn(pkmnid, tid, nickname)
  Values(4, 1, 'Charizard');

INSERT INTO TrainerPkmn(pkmnid, tid, nickname)
  Values(11, 2, 'Blastie');

INSERT INTO TrainerPkmn(pkmnid, tid, nickname)
  Values(7, 3, 'Eevee');

INSERT INTO TrainerPkmn(pkmnid, tid, nickname)
  Values(10, 3, 'Char');

INSERT INTO TrainerPkmn(pkmnid, tid, nickname)
  Values(3, 4, 'Rattata');

INSERT INTO TrainerPkmn(pkmnid, tid, nickname)
  Values(6, 5, 'Ivy');

INSERT INTO TrainerPkmn(pkmnid, tid, nickname)
  Values(2, 6, 'Marissa');

INSERT INTO TrainerPkmn(pkmnid, tid, nickname)
  Values(12, 6, 'Emily');

INSERT INTO TrainerPkmn(pkmnid, tid, nickname)
  Values(5, 7, 'Piper');

INSERT INTO TrainerPkmn(pkmnid, tid, nickname)
  Values(8, 8, 'Rachel');

Select * from trainerpkmn;

INSERT INTO Towns(townName, regionName)
  Values('Pallet Town', 'Kanto');

INSERT INTO Towns(townName, regionName)
  Values('Cerulean City', 'Kanto');

INSERT INTO Towns(townName, regionName)
  Values('Celadon City', 'Kanto');

INSERT INTO Towns(townName, regionName)
  Values('New Bark Town', 'Johto');

INSERT INTO Towns(townName, regionName)
  Values('Mauville City', 'Hoenn');

--Select * from Towns;

INSERT INTO Gyms(gymName, typeName, tid, townName)
  Values('Cerulean Gym', 'water', 2, 'Cerulean City');

INSERT INTO Gyms(gymName, typeName, tid, townName)
  Values('Celadon Gym', 'grass', 5, 'Celadon City');

INSERT INTO Gyms(gymName, typeName, tid, townName)
  Values('Mauville Gym', 'water', 7, 'Mauville City');

--Select * from Gyms;

INSERT INTO Badges(badgeName, gymName)
  Values('Cascade Badge', 'Cerulean Gym');

INSERT INTO Badges(badgeName, gymName)
  Values('Rainbow Badge', 'Celadon Gym');

INSERT INTO Badges(badgeName, gymName)
  Values('Dynamo Badge', 'Mauville Gym');

--Select * from Badges;

INSERT INTO Items(itemName, itemCostYen, itemSellYen, description)
  Values('Potion', 300.00, 150.00, 'Restores Pokemon HP by 20.');

INSERT INTO Items(itemName, itemCostYen, itemSellYen, description)
  Values('Hyper Potion', 1200.00, 600.00, 'Restores HP that have been lost in battle by 200 HP.');

INSERT INTO Items(itemName, itemCostYen, itemSellYen, description)
  Values('Water Stone', 2100.00, 1050.00, 'Restores Pokemon HP by 20.');

INSERT INTO Items(itemName, itemCostYen, itemSellYen, description)
  Values('Pokeball', 200.00, 100.00, 'Evolves certain kinds of Pokemon.');

--Select * from items;  

Insert into TrainerItems(tid, itemName, quantity)
  Values(1, 'Pokeball', 10);

Insert into TrainerItems(tid, itemName, quantity)
  Values(6, 'Pokeball', 30);

Insert into TrainerItems(tid, itemName, quantity)
  Values(6, 'Hyper Potion', 20);

Insert into TrainerItems(tid, itemName, quantity)
  Values(2, 'Water Stone', 1);

Insert into TrainerItems(tid, itemName, quantity)
  Values(2, 'Pokeball', 5);

Insert into TrainerItems(tid, itemName, quantity)
  Values(7, 'Hyper Potion', 2);

Insert into TrainerItems(tid, itemName, quantity)
  Values(4, 'Pokeball', 3);

Insert into TrainerItems(tid, itemName, quantity)
  Values(3, 'Pokeball', 30);

--Select * from trainerItems;

INSERT INTO TrainerBadges(tid, badgeName)
  Values(1, 'Rainbow Badge');

INSERT INTO TrainerBadges(tid, badgeName)
  Values(1, 'Cascade Badge');

INSERT INTO TrainerBadges(tid, badgeName)
  Values(1, 'Dynamo Badge');

INSERT INTO TrainerBadges(tid, badgeName)
  Values(3, 'Rainbow Badge');

INSERT INTO TrainerBadges(tid, badgeName)
  Values(3, 'Cascade Badge');

INSERT INTO TrainerBadges(tid, badgeName)
  Values(6, 'Rainbow Badge');

INSERT INTO TrainerBadges(tid, badgeName)
  Values(6, 'Cascade Badge');

INSERT INTO TrainerBadges(tid, badgeName)
  Values(6, 'Dynamo Badge');

--Select * from TrainerBadges;


---------Views--------

Create View TrainerPokemonNames as
  select Trainers.tid, tName, nickname, pkmnLevel, totalHP, pkmnName
  from Trainers inner join(
    select tid, nickname, pkmnName, pkmnLevel, totalHP
    from TrainerPkmn inner join Pokemon
    on TrainerPkmn.pkmnid = Pokemon.pkmnid) tpkmn  
  on tpkmn.tid = Trainers.tid
  order by Trainers.tid asc;

Select * from TrainerPokemonNames;

Create View moveInfo as
  select moveTypes.movename, pp, typeName, description 
  from moveTypes inner join Moves
  on moveTypes.moveName = Moves.moveName
  order by moveTypes.moveName asc;

Select * from moveInfo;


Create View nicknameMoves as
  select TrainerPkmn.pkmnid, nickname, moveName
  from TrainerPkmn inner join(
    select Pokemon.pkmnid, pkmnName, moveName
    from Pokemon inner join PkmnMoves
    on Pokemon.pkmnid = PkmnMoves.pkmnid) namenmoves
  on TrainerPkmn.pkmnid = namenmoves.pkmnid
  order by TrainerPkmn.pkmnid asc;

Select * from nicknameMoves;


Create View twoTypes as
  select distinct(pkmnName), typeName
  from PokeTypes inner join(
    select pkmnName as pktN, typeName as pktT
    from PokeTypes) pktype
  on PokeTypes.pkmnName = pktype.pktN
  where PokeTypes.typeName != pktype.pktT
  order by pkmnName;

Select * from twoTypes;

------Reports------

--What trainers (tid and name) have the most pokemon? --
select Trainers.tid, tName, max as totalPokemonCaught
from Trainers inner join (
  select tid, max
  from (select max(maxpkmn.pokemonCount) as max from 
         (select tid, count(tid) as pokemonCount
          from trainerPkmn
          group by tid) maxpkmn) mm
  inner join
       (select tid, count(tid) as pokemonCount
        from trainerPkmn
        group by tid) pxs
  on mm.max = pxs.pokemonCount) tr
on tr.tid = Trainers.tid;

--What is the name of the Trainer whose Rattata is in the top percentage of Rattata?---
select tName as trainerName
from Trainers
where Trainers.tid in(
select tid
from TrainerPkmn
where TrainerPkmn.pkmnid in
(select pkmnid
from Pokemon
where Pokemon.pkmnName = 'Rattata'
order by Pokemon.pkmnLevel desc, Pokemon.totalHP desc) limit 1);


-----Stored Procedures---

--Find the pokemon that have the best type advantage over a type---

CREATE OR REPLACE FUNCTION bestPokemonFightingType(text) returns 
TABLE("PokemonChoice" text) as 
$BODY$
BEGIN
  return query
  select Distinct pkmnName
  from PokeTypes
  where PokeTypes.typeName in(
    select typeName
    from typeStrengths 
    where typeStrengths.goodAgainst = $1)
  order by pkmnName asc;
END;
$BODY$
language plpgsql;

select bestPokemonFightingType('dragon');


select bestPokemonFightingType('water');

---Find the trainers who have beaten a gym

CREATE OR REPLACE FUNCTION whoBeatGym(text) returns
TABLE("TrainersWhoBeatGym" text) as
$BODY$
BEGIN
  return query
  select trainers.tname 
  from trainers inner join(
  (select tid
  from trainerBadges inner join(
  select * 
  from badges
  where (gymName = $1)) gymmie
  on gymmie.badgeName = trainerBadges.badgeName)) bgname
  on bgname.tid = trainers.tid;
End;
$BODY$
language plpgsql;

select whoBeatGym('Mauville Gym');


---Decriments yen count of trainer when they buy an item---
--TRIGGER--

CREATE OR REPLACE FUNCTION buy_item() RETURNS TRIGGER as
$BODY$
Declare
  quantDiff  decimal(8,2) := new.quantity - old.quantity;
  itName text := new.itemName;
Begin
  if quantDiff > 0 then 
    UPDATE Trainers
    Set cashYen =  (cashYen - 
       quantdiff*(select itemCostYen
       from Items
       where Items.itemName = itName))
    where Trainers.tid = new.tid;
  End If;
  RETURN NEW;
END;
$BODY$
language plpgsql;

CREATE TRIGGER buy_item
After UPDATE on TrainerItems
For Each Row
Execute Procedure buy_item();

Select * from TrainerItems;
Select * from Trainers;
update TrainerItems
set quantity = quantity +1 
where tid = 4
and itemName = 'Pokeball';

Select * from TrainerItems;
Select * from Trainers;
update TrainerItems
set quantity = quantity +1 
where tid = 4
and itemName = 'Poke';

Select * from TrainerItems;

---Roles---

Create Role data_admin;
Grant all on all tables
in schema public to data_admin;

Create Role pkmnTrainer;
Grant select on all tables in schema public to pkmnTrainer;
Grant insert on Pokemon, PkmnMoves, Trainers, TrainerBadges, TrainerItems to pkmnTrainer;
Grant update on Pokemon, TrainerPkmn, Trainers, PkmnMoves to pkmnTrainer;

Create Role pokeProfessors;
Grant select on all tables in schema public to pokeProfessors;
Grant insert on Pokemon, Pokedex, Evolutions, ElementTypes, TypeStrengths, MoveTypes, Moves, TrainerPkmn,
  Trainers to pokeProfessors;
Grant update on Pokemon, Pokedex, Evolutions, ElementTypes, TypeStrengths, MoveTypes, Moves, TrainerPkmn,
  Trainers, PokeTypes to pokeProfessors;

Create Role gymLeaders;
Grant select on all tables in schema public to gymLeaders;
Grant insert on Badges, Gyms, TrainerPkmn, PkmnMoves, Pokemon, Trainers, TrainerItems to gymLeaders;
Grant update on Badges, Gyms, TrainerPkmn, PkmnMoves, Pokemon, TrainerItems, Trainers to gymLeaders;

Create Role storeKeeper;
Grant select on Items, TrainerItems, Trainers, Badges, Gyms, Pokedex, Moves, Towns to storeKeeper;
Grant insert on Items, TrainerItems to storeKeeper;
Grant update on Items, TrainerItems to storeKeeper;

