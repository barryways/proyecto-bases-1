--************************************************************
--CARLOS DANIEL BARRIENTOS CASTILLO -1040121
--DIEGO ANDRÉ CORDÓN HERNÁNDEZ -1094021
--LUIS ALFONSO PERALTA CHACÓN -1231721
--************************************************************
--CREACION BASE DE DATOS
CREATE DATABASE ProyectoFinalBD1_CDL;
USE ProyectoFinalBD1_CDL;
--SCRIPTS DE CREACION DE BASE DE DATOS (DDL)
CREATE TABLE Continente(
	ID_Continente int primary key identity(1,1),
	Nombre varchar(10) NOT NULL
);
CREATE TABLE Pais(
	ID_Pais int primary key identity(1,1),
	Nombre varchar(100) NOT NULL,
	ID_Continente int foreign key references Continente(ID_Continente)
);
CREATE TABLE Nacionalidad(
	ID_Nacionalidad int primary key identity(1,1),
	ID_Pais int foreign key references Pais(ID_Pais) NOT NULL
);
CREATE TABLE Usuario(
	ID_Usuario int primary key identity(1,1),
	Nickname varchar(50) unique,
	Nombre_1 varchar(50) NOT NULL,
	Nombre_2 varchar(50) NULL,
	Nombre_3 varchar(50) NULL,
	Apellido_1 varchar(100) NOT NULL,
	Apellido_2 varchar(100) NULL,
	Fecha_Nacimiento Date NOT NULL,
	Correo varchar(100) NOT NULL,
	Clave varchar(100) NOT NULL,
	Fecha_Ingreso datetime DEFAULT GETDATE(),
	ID_Nacionalidad int foreign key references Nacionalidad(ID_Nacionalidad) NOT NULL,
	Ultimo_Cambio Date,
	CONSTRAINT Nickname check (DATEDIFF(MONTH,GETDATE(),Ultimo_Cambio) >= 3 OR Ultimo_Cambio is null),
	CONSTRAINT CK_ValidarEdad CHECK (DATEDIFF(YEAR, Fecha_Nacimiento, GETDATE()) >= 13),
	CONSTRAINT CK_ValidarClave CHECK (clave >=8)
);
CREATE TABLE Registro_Usuario(
	ID_RegistroUsuario int primary key identity(1,1),
	ID_Usuario int foreign key references Usuario(ID_Usuario) NOT NULL,
	Tiempo_Inicio datetime default getdate(),
	Tiempo_Final datetime null
);
--Cosmeticos
CREATE TABLE Categoria (
	ID_Categoria  int primary key identity(1,1),
	Nombre Varchar(50) not null,
)
CREATE TABLE Tipo(
	ID_Tipo int primary key identity(1,1),
	Nombre Varchar(50) not null
)
CREATE TABLE Cosmetico (
   ID_Cosmetico int primary key identity(1,1),
   Precio MONEY,
   Nombre Varchar(50) not null,
   ID_Categoria int foreign key references Categoria(ID_Categoria) NOT NULL,
   ID_Tipo int foreign key references Tipo(ID_Tipo) NOT NULL,
   CONSTRAINT CK_PrecioSkin_Positive CHECK (Precio >= 0),
   ID_Usuario int foreign key references Usuario(ID_Usuario) NOT NULL
)
CREATE TABLE Cosmetico_Usuario(
	ID_Cosmetico_Usuario int primary key identity(1,1),
	ID_Cosmetico int foreign key references Cosmetico(ID_Cosmetico) NOT NULL,
	ID_Usuario int foreign key references Usuario(ID_Usuario) NOT NULL
)


--Fin Cosmeticos --

--Partidas--



CREATE TABLE Tiempo_Partida (
	ID_Tiempo_Partida int primary key identity(1,1),
	Duracion TIME NOT NULL,
)

CREATE TABLE Velocidad (
	ID_Velocidad int primary key identity(1,1),
	Velocidad int NOT NULL,
	Distancia_Inicial int NOT NULL,
	Distancia_Final int NOT NULL
)

CREATE TABLE Tipo_Partida (
	ID_Tipo_Partida int primary key identity(1,1), 
	Nombre varchar(50) NOT NULL,
	ID_Velocidad int foreign key references Velocidad(ID_Velocidad) NOT NULL,
	ID_Tiempo_Partida int foreign key references Tiempo_Partida(ID_Tiempo_Partida) NOT NULL
	
)

CREATE TABLE Partida (
	ID_Partida int primary key identity(1,1), 
	Fecha_Inicio DATETIME DEFAULT GETDATE() NOT NULL,
	Fecha_Fin DATETIME NOT NULL,
	ID_Tipo_Partida int foreign key references Tipo_Partida(ID_Tipo_Partida) NOT NULL

)

CREATE TABLE Historial_Partida (
	ID_Historial_Partida int primary key identity(1,1),
	Kills int not null default 0,
	Deaths int not null default 0,
	Partida_Ganada BIT NOT NULL,
	ID_Partida int foreign key references Partida(ID_Partida) NOT NULL,
	ID_Usuario int foreign key references Usuario(ID_Usuario) NOT NULL,
	
)
CREATE TABLE Historial_Cosmetico(
	ID_Historial_Cosmetico int primary key identity(1,1),
	ID_Historial_Partida int foreign key references Historial_Partida(ID_Historial_Partida) NOT NULL,
	ID_Cosmetico int foreign key references Cosmetico(ID_Cosmetico)
)


--SCRIPTS DE MANIPULACION E INCERSION DE DATOS (DML)




--INSERCION DE DATOS
-- Insertar datos en la tabla Continente
INSERT INTO Continente (Nombre)
VALUES ('América'),
       ('Europa'),
       ('Asia'),
       ('África'),
       ('Oceanía');

-- Insertar datos en la tabla Pais
INSERT INTO Pais (Nombre, ID_Continente)
VALUES ('Estados Unidos', 1),
       ('Canadá', 1),
       ('México', 1),
       ('España', 2),
       ('Francia', 2),
       ('Italia', 2),
       ('China', 3),
       ('Japón', 3),
       ('India', 3),
       ('Nigeria', 4),
       ('Sudáfrica', 4),
       ('Egipto', 4),
       ('Australia', 5),
       ('Nueva Zelanda', 5);

-- Insertar datos en la tabla Nacionalidad
INSERT INTO Nacionalidad (ID_Pais)
VALUES (1),
       (1),
       (1),
       (4),
       (4),
       (4),
       (7),
       (7),
       (7),
       (10),
       (10),
       (10),
       (13),
       (13);
