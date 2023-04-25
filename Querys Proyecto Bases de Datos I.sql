--Querys

--1. Reporte de cantidad de usuarios por continente
select c.Nombre, count(1) as Personas_Continente from dbo.Usuario u inner join 
Nacionalidad n on (u.ID_Nacionalidad = n.ID_Nacionalidad)
inner join Continente c on (c.ID_Continente = n.ID_Continente)
group by c.Nombre
-------------------------------------------------------------------
--2. Cantidad de partidas por categoría para un rango de fechas dada
-----------------------------------------------------------------------
--3. Cantidad de partidas con menos de 80 jugadores en el último trimestre
-------------------------------------------------------------------------
--4. Ranking de jugadores por K/D por continente incluyendo únicamente a jugadores 
--con 10 o más partidas
--------------------------------------------------------------------------------
--5. Ranking de jugadores por Win ratio por continente incluyendo únicamente a 
--jugadores con 10 o más partidas
--------------------------------------------------------------------------------
--6. Ranking de cosméticos por su utilización efectiva
-------------------------------------------------------------------------------
--7. Listado de partidas que ha ganado un jugador indicando cantidad de kills

select u.Nickname, count(1) as Cantidad_Ganadas from historial_partida hp
inner join Usuario u on (hp.ID_Usuario = u.ID_Usuario)
where hp.partida_ganada = 1
group by u.Nickname
order by Cantidad_Ganadas desc
--------------------------------------------------------------------------------
--8. Listado de jugadores rivales y grado de rivalidad: se define que dos jugadores son 
--rivales si han participado en una misma partida 5 o más veces y el grado de rivalidad 
--es la cantidad de partidas que han jugado juntos
--------------------------------------------------------------------------------
--9. Promedio de tiempo efectivo de juego por país

select * from Registro_Usuario --(Usuario y Tiempos)
select * from Usuario -- (Usuario y Pais)
select * from Nacionalidad 
select * from Pais  --

SELECT P.Nombre AS Pais, AVG(DATEDIFF(HOUR, R.Tiempo_Inicio, R.Tiempo_Final))  AS Promedio_Tiempo_Efectivo
FROM Registro_Usuario AS R
inner JOIN Usuario AS U ON R.ID_Usuario = U.ID_Usuario
inner JOIN Nacionalidad AS N ON U.ID_Nacionalidad = N.ID_Nacionalidad
inner JOIN Pais AS P ON N.ID_Pais = P.ID_Pais
GROUP BY P.Nombre

--------------------------------------------------------------------------------
--10. Cantidad de partidas en las cuales ha habido al menos un jugador de Asia y uno de 
--América y que uno de estos haya ganado la partida
--------------------------------------------------------------------------------
--11. Cantidad de partidas en las que el ganador tenga 0 kills y algún jugador tenga 10 o 
--más kills
Select * from Historial_Partida --(kills)

SELECT COUNT(*) AS Cantidad_Partidas
FROM Historial_Partida
WHERE Partida_Ganada = 1
AND Kills = 0
AND ID_Partida IN (
	SELECT ID_Partida
	FROM Historial_Partida
	WHERE Kills >= 10
);
--------------------------------------------------------------------------------
--12. Listado de cosméticos ordenados por tipo, categoría y cantidad de partidas ganadas 
SELECT c.Nombre AS Nombre_Cosmetico, ca.Nombre AS Nombre_Categoria, t.Nombre AS Nombre_Tipo, 
COUNT(hp.ID_Historial_Partida) AS Cantidad_Partidas_Ganadas 
FROM Cosmetico c 
INNER JOIN Categoria ca ON c.ID_Categoria = ca.ID_Categoria 
INNER JOIN Tipo t ON c.ID_Tipo = t.ID_Tipo 
INNER JOIN Cosmetico_Usuario cu ON c.ID_Cosmetico = cu.ID_Cosmetico 
INNER JOIN Historial_Partida hp ON cu.ID_Usuario = hp.ID_Usuario 
INNER JOIN Historial_Cosmetico hc ON hp.ID_Historial_Partida = hc.ID_Historial_Partida AND c.ID_Cosmetico = hc.ID_Cosmetico 
WHERE hp.Partida_Ganada = 1 
GROUP BY c.Nombre, ca.Nombre, t.Nombre 
ORDER BY t.Nombre, ca.Nombre, COUNT(hp.ID_Historial_Partida) DESC;

--------------------------------------------------------------------------------
--13. Cantidad de partidas por tiempo de duración en minutos
----------------------------------------------------------------------------------
--14. Top 10 jugadores con más tiempo de juego
----------------------------------------------------------------------------------
--15. Ranking de jugadores según su K/D por rango de edad (13 a 15, 16 a 20, 21 a 25, 
--26 a 30 y mayores de 30)
--------------------------------------------------------------------------------
--KPI--

--• K/D de un jugador: kills/deaths
----------------------------------------------------------------------------------
--• Tiempo efectivo de juego: cantidad de tiempo en partida / cantidad de tiempo en la 
--plataforma
----------------------------------------------------------------------------------
--• Utilización efectiva de un cosmético: cantidad de usuarios que lo han utilizado en 
--una partida / cantidad de usuarios que lo han comprado
----------------------------------------------------------------------------------
--• Win ratio: cantidad de partidas ganadas / cantidad de partidas totales
--------------------------------------------------------------------------------