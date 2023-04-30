--INSERCION DE DATOS
-- Insertar datos en la tabla Continente
INSERT INTO Continente (Nombre)
VALUES ('América'),
       ('Europa'),
       ('Asia'),
       ('África'),
       ('Oceanía');

-- Insertar datos en la tabla Pais
INSERT INTO Pais (Nombre)
VALUES ('Estados Unidos'),
       ('Canadá'),
       ('México'),
       ('España'),
       ('Francia'),
       ('Italia'),
       ('China'),
       ('Japón'),
       ('India'),
       ('Nigeria'),
       ('Sudáfrica'),
       ('Egipto'),
       ('Australia'),
	   ('Nueva Zelanda'),
       ('Guatemala'),
	   ('Cuba'),
	   ('Ghana'),
	   ('Senegal'),
	   ('Guinea'),
	   ('Marruecos'),
	   ('Alemania'),
	   ('Portugal'),
	   ('Suecia'),
	   ('Noruega'),
	   ('Eslovenia'),
	   ('Irak'),
	   ('Israel'),
	   ('Palestina'),
	   ('Samoa');

-- Insertar datos en la tabla Nacionalidad
INSERT INTO Nacionalidad (ID_Pais, ID_Continente)
VALUES (1, 1),
       (2, 1),
       (3, 1),
       (4, 2),
       (5, 2),
       (6, 2),
       (7, 3),
       (8, 3),
       (9, 3),
       (10, 4),
       (11, 4),
       (12, 4),
       (13, 5),
       (14, 5),
	   (15,1),
	   (16,1),
	   (17,4),
	   (18,4),
	   (19,4),
	   (20,4),
	   (21,2),
	   (22,2),
	   (23,2),
	   (24,2),
	   (25,2),
	   (26,3),
	   (27,3),
	   (28,3),
	   (29,5);
--insercion de tiempo de la partida
INSERT INTO Tiempo_Partida (Duracion)
VALUES ('00:10:00'),
	('00:20:00');
--insercion de velocida
INSERT INTO velocidad 
VALUES (36,10,1), 
	(45,10,1), 
	(60,10,0);
--insercion de tipo partida
INSERT INTO Tipo_partida 
VALUES('Normal',1,2),
	('Fast',2,1),
	('Killer',3,1);
--insercion de categoria de categoria
INSERT INTO Categoria 
VALUES
	('Común'),
	('Raro'),
	('Legendario');
INSERT INTO Tipo
VALUES ('Personaje'),
	('Arma'),
	('Mochila'),
	('Paracaidas');


INSERT INTO Cosmetico (Precio, Nombre, ID_Categoria, ID_Tipo)
VALUES (100.0, 'Dragon Lore', 3,2),
	(20.0, 'Llamarada de Oxido', 3,2),
	(5.0, 'Mochila Magica', 2,3),
	(0.0, 'Mochila de Aventura', 1,3),
	(4.50, 'Traje Hiperlunar', 2,1),
	(20.0, 'Traje Tony Stark', 3,1),
	(0.0, 'Sombrilla Verde', 1,4),
	(1.50, 'Sombrilla Dorada', 2,4),
	(25.0, 'Globo Aeroestatico', 3,4),
	(20.0, 'Manta del Comedor', 3,4),
	(1.0, 'Traje Hyoerbeast', 1,1),
	(10.0, 'Traje Nave Orbital', 2,1),
	(50.0, 'Traje Bandido', 3,1),
	(0.0, 'Sniper Leak', 1,2),
	(0.0, 'Mustang & Sally', 2,2),
	(35.0, 'El Cañon de la Bestia', 3,2),
	(0.0, 'Mochila de Carreras', 1,3),
	(6.0, 'Mochila de Repartidor de Glovo', 2,3),
	(22.50, 'Maceta', 3,3),
	(0.0, 'Bandera Municipal', 1,4);


--