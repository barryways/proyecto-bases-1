--Querys

--1. Reporte de cantidad de usuarios por continente
select c.Nombre, count(1) as Personas_Continente from dbo.Usuario u inner join 
Nacionalidad n on (u.ID_Nacionalidad = n.ID_Nacionalidad)
inner join Continente c on (c.ID_Continente = n.ID_Continente)
group by c.Nombre
-------------------------------------------------------------------
--2. Cantidad de partidas por categor�a para un rango de fechas dada
--las fechas inicio empiezan en 2022-10-01 y terminan en 2022-10-25
select ID_Tipo_Partida, COUNT(*) as Cantidad_Partidas from Partida 
WHERE fecha_inicio BETWEEN '2022-10-09T00:00:00' AND '2022-10-22T23:59:59'
group by ID_Tipo_Partida;

-----------------------------------------------------------------------
--3. Cantidad de partidas con menos de 80 jugadores en el �ltimo trimestre

select ID_Partida, count(*) AS CANTIDAD from Historial_Partida
Group by ID_Partida
having Count(*) < 80
ORDER BY CANTIDAD DESC
-------------------------------------------------------------------------
--4. Ranking de jugadores por K/D por continente incluyendo �nicamente a jugadores 
--con 10 o m�s partidas

SELECT 
  u.Nickname, 
  c.Nombre AS Continente,
  COUNT(*) AS No_Partidas, 
  SUM(CASE 
  WHEN Kills > 0 
  THEN 1 ELSE 0 
  END) AS Numero_Bajas, 
  SUM(CASE 
  WHEN Deaths > 0 
  THEN 1 ELSE 
  0 
  END) AS Numero_Muertes,
  CASE 
    WHEN SUM(CASE WHEN Deaths > 0  THEN 1 ELSE 0 END) = 0 THEN NULL 
    ELSE CAST(SUM(CASE WHEN Kills > 0 THEN 1 ELSE 0 END) AS FLOAT) / 
    SUM(CASE WHEN Deaths > 0  THEN 1 ELSE 0 END) 
  END AS kdratio
FROM dbo.Historial_Partida hp
INNER JOIN dbo.Usuario u ON hp.ID_Usuario = u.ID_Usuario
INNER JOIN dbo.Nacionalidad n ON u.ID_Nacionalidad = n.ID_Nacionalidad
INNER JOIN dbo.Continente c ON n.ID_Pais = c.ID_Continente
GROUP BY hp.ID_Usuario, u.Nickname, c.Nombre
HAVING COUNT(*) > 3 AND SUM(CASE WHEN Deaths > 0 THEN 1 ELSE 0 END) > 0
ORDER BY kdratio DESC
--------------------------------------------------------------------------------
--5. Ranking de jugadores por Win ratio por continente incluyendo �nicamente a 
--jugadores con 10 o m�s partidas

SELECT 
  u.Nickname, 
  c.Nombre as Continente,
  COUNT(*) AS No_Partidas, 
  SUM(CASE WHEN Partida_Ganada = '1' THEN 1 ELSE 0 END) AS Partidas_Ganadas, 
  SUM(CASE WHEN Partida_Ganada = '0' THEN 1 ELSE 0 END) AS Partidas_Perdidas,
  CAST(SUM(CASE WHEN Partida_Ganada = '1' THEN 1 ELSE 0 END) AS FLOAT) / COUNT(*) * 100 AS winratio
FROM dbo.Historial_Partida hp
INNER JOIN dbo.Usuario u ON hp.ID_Usuario = u.ID_Usuario
INNER JOIN dbo.Nacionalidad n ON u.ID_Nacionalidad = n.ID_Nacionalidad
INNER JOIN dbo.Continente c ON n.ID_Pais = c.ID_Continente
GROUP BY hp.ID_Usuario, u.Nickname, c.Nombre
HAVING COUNT(*) > 3
ORDER BY winratio DESC

--------------------------------------------------------------------------------
--6. Ranking de cosm�ticos por su utilizaci�n efectiva

select c.Nombre, Count(*) AS Cantidad_Utilizacion from dbo.Historial_Cosmetico hc
inner join dbo.Cosmetico c on (hc.ID_Cosmetico = c.ID_Cosmetico)
group by c.Nombre
order by Cantidad_Utilizacion DESC 

SELECT 
    c.Nombre, 
    COUNT(*) AS Cantidad_Utilizacion, 
    RANK() OVER (ORDER BY COUNT(*) DESC) AS Ranking
FROM dbo.Historial_Cosmetico hc
INNER JOIN dbo.Cosmetico c ON hc.ID_Cosmetico = c.ID_Cosmetico
GROUP BY c.Nombre
ORDER BY Ranking ASC;

--over para calcular totales acumulados
--rank designa un valor para cada fila que encuentra
-------------------------------------------------------------------------------
--7. Listado de partidas que ha ganado un jugador indicando cantidad de kills
--para un solo jugador

SELECT hp.ID_Partida, u.Nickname, 
SUM(CAST(Partida_Ganada AS INT)) AS Partidas_Ganadas, hp.Kills
FROM dbo.Historial_Partida hp 
inner join dbo.Usuario u on (hp.ID_Usuario=u.ID_Usuario)
WHERE hp.ID_Usuario = 413 AND Partida_Ganada = 1
GROUP BY hp.ID_Partida, Kills, u.Nickname
<<<<<<< HEAD
order by Kills desc

=======
order by kills desc
>>>>>>> a1f775c72b00e2db41438058c1bac1077d634a75

--------------------------------------------------------------------------------
--8. Listado de jugadores rivales y grado de rivalidad: se define que dos jugadores son 
--rivales si han participado en una misma partida 5 o m�s veces y el grado de rivalidad 
--es la cantidad de partidas que han jugado juntos
SELECT j1.Nickname AS Jugador1, j2.Nickname AS Jugador2, COUNT(*) AS Grado_Rivalidad
FROM Historial_Partida hp1
INNER JOIN Historial_Partida hp2 ON hp1.ID_Partida = hp2.ID_Partida AND hp1.ID_Usuario < hp2.ID_Usuario
INNER JOIN Usuario j1 ON hp1.ID_Usuario = j1.ID_Usuario
INNER JOIN Usuario j2 ON hp2.ID_Usuario = j2.ID_Usuario
group by J1.Nickname, J2.Nickname
HAVING COUNT(*) >= 5;


--- PRUEBA DE ESTE QUERY PARA DENOTAR QUE Si funciona
SELECT u1.Nickname AS Jugador1, u2.Nickname AS Jugador2, COUNT(*) AS Cantidad_Partidas_Juntos
FROM Historial_Partida AS h1
INNER JOIN Historial_Partida AS h2 ON h1.ID_Partida = h2.ID_Partida AND h1.ID_Usuario <> h2.ID_Usuario
INNER JOIN Usuario AS u1 ON h1.ID_Usuario = u1.ID_Usuario
INNER JOIN Usuario AS u2 ON h2.ID_Usuario = u2.ID_Usuario
where u1.Nickname = 'William184'
GROUP BY u1.Nickname, u2.Nickname
HAVING COUNT(*) >1



--------------------------------------------------------------------------------
--9. Promedio de tiempo efectivo de juego por pa�s

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
--Am�rica y que uno de estos haya ganado la partida
Select count(DISTINCT hp.ID_Partida) AS Cantidad_Partida from Historial_Partida hp
inner join Usuario as us on(us.ID_Usuario = hp.ID_Usuario)
inner join Nacionalidad as na on(na.ID_Nacionalidad = us.ID_Nacionalidad)
inner join Continente as con on(con.ID_Continente=na.ID_Continente)
where Partida_Ganada =1 
and con.ID_Continente= 3

--------------------------------------------------------------------------------
--11. Cantidad de partidas en las que el ganador tenga 0 kills y alg�n jugador tenga 10 o 
--m�s kills
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
--12. Listado de cosm�ticos ordenados por tipo, categor�a y cantidad de partidas ganadas 
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
--13. Cantidad de partidas por tiempo de duraci�n en minutos
SELECT tmp.Duracion, COUNT(*) AS CantidadPartidas
FROM Partida p
INNER JOIN Tipo_Partida tp ON (p.ID_Tipo_Partida = tp.ID_Tipo_Partida)
INNER JOIN Tiempo_Partida tmp ON (tp.ID_Tiempo_Partida = tmp.ID_Tiempo_Partida)
GROUP BY tmp.Duracion


----------------------------------------------------------------------------------
--14. Top 10 jugadores con más tiempo de juego

SELECT TOP 10
  u.ID_Usuario, 
  SUM(DATEDIFF(minute, Fecha_Inicio, Fecha_Fin)) AS DuracionTotalMinutos,
  CONCAT(
    FLOOR(SUM(DATEDIFF(minute, Fecha_Inicio, Fecha_Fin)) / 60), 'h ',
    SUM(DATEDIFF(minute, Fecha_Inicio, Fecha_Fin)) % 60, 'm'
  ) AS DuracionTotalHoras
FROM Partida p
INNER JOIN Historial_Partida hsp ON (p.ID_Partida = hsp.ID_Partida)
INNER JOIN Usuario u ON (hsp.ID_Usuario = u.ID_Usuario)
GROUP BY u.ID_Usuario
ORDER BY DuracionTotalMinutos DESC

----------------------------------------------------------------------------------
--15. Ranking de jugadores seg�n su K/D por rango de edad (13 a 15, 16 a 20, 21 a 25, 
--26 a 30 y mayores de 30)
SELECT 
    u.ID_Usuario,
  SUM(CASE WHEN hsp.Kills > 0 THEN 1 ELSE 0 END) AS Numero_Bajas, 
  SUM(CASE WHEN hsp.Deaths > 0 THEN 1 ELSE 0 END) AS Numero_Muertes,
  SUM(hsp.Deaths) AS Muertes_Totales,
  CASE 
    WHEN SUM(CASE WHEN hsp.Deaths > 0 THEN 1 ELSE 0 END) = 0 THEN NULL 
    ELSE CAST(SUM(CASE WHEN hsp.Kills > 0 THEN 1 ELSE 0 END) AS FLOAT) / SUM(CASE WHEN hsp.Deaths > 0 THEN 1 ELSE 0 END) 
  END AS KD,
  CASE 
    WHEN (DATEDIFF(YEAR, u.Fecha_Nacimiento, GETDATE())) BETWEEN 13 AND 15 THEN '13-15'
    WHEN (DATEDIFF(YEAR, u.Fecha_Nacimiento, GETDATE())) BETWEEN 16 AND 20 THEN '16-20'
    WHEN (DATEDIFF(YEAR, u.Fecha_Nacimiento, GETDATE())) BETWEEN 21 AND 25 THEN '21-25'
    WHEN (DATEDIFF(YEAR, u.Fecha_Nacimiento,GETDATE())) BETWEEN 26 AND 30 THEN '26-30'
    ELSE 'Mayor de 30'
  END AS RangoEdad
FROM 
  Usuario u
  INNER JOIN Historial_Partida hsp ON (u.ID_Usuario = hsp.ID_Usuario)
GROUP BY 
  CASE 
    WHEN (DATEDIFF(YEAR, u.Fecha_Nacimiento, GETDATE())) BETWEEN 13 AND 15 THEN '13-15'
    WHEN (DATEDIFF(YEAR, u.Fecha_Nacimiento, GETDATE())) BETWEEN 16 AND 20 THEN '16-20'
    WHEN (DATEDIFF(YEAR, u.Fecha_Nacimiento, GETDATE())) BETWEEN 21 AND 25 THEN '21-25'
    WHEN (DATEDIFF(YEAR, u.Fecha_Nacimiento,GETDATE())) BETWEEN 26 AND 30 THEN '26-30'
    ELSE 'Mayor de 30'
  END, U.ID_Usuario
ORDER BY 
  RangoEdad ASC

--------------------------------------------------------------------------------
--KPI--

--� K/D de un jugador: kills/deaths

SELECT 
  u.Nickname,
  SUM(CASE 
  WHEN Kills > 0 
  THEN 1 ELSE 0 
  END) AS Numero_Bajas, 
  SUM(CASE 
  WHEN Deaths > 0 
  THEN 1 ELSE 
  0 
  END) AS Numero_Muertes,
  CASE 
    WHEN SUM(CASE WHEN Deaths > 0  THEN 1 ELSE 0 END) = 0 THEN NULL 
    ELSE CAST(SUM(CASE WHEN Kills > 0 THEN 1 ELSE 0 END) AS FLOAT) / 
    SUM(CASE WHEN Deaths > 0  THEN 1 ELSE 0 END) 
  END AS KD
FROM dbo.Historial_Partida hp
INNER JOIN dbo.Usuario u ON hp.ID_Usuario = u.ID_Usuario
GROUP BY hp.ID_Usuario, u.Nickname
HAVING COUNT(*) > 3 AND SUM(CASE WHEN Deaths > 0 THEN 1 ELSE 0 END) > 0
ORDER BY KD DESC

----------------------------------------------------------------------------------
--� Tiempo efectivo de juego: cantidad de tiempo en partida / cantidad de tiempo en la 
--plataforma

<<<<<<< HEAD
SELECT SUM(DATEDIFF(MINUTE, pa.Fecha_Inicio, pa.Fecha_Fin))*100 / 
       SUM(DATEDIFF(MINUTE, R.Tiempo_Inicio, R.Tiempo_Final)) AS Tiempo_Efectivo_de_Juego
=======
SELECT SUM(DATEDIFF(MINUTE, pa.Fecha_Inicio, pa.Fecha_Fin))*10 / 
       SUM(DATEDIFF(MINUTE, R.Tiempo_Inicio, R.Tiempo_Final))  AS Tiempo_Efectivo_de_Juego
>>>>>>> a1f775c72b00e2db41438058c1bac1077d634a75
FROM Historial_Partida hp
INNER JOIN Partida pa ON hp.ID_Partida = pa.ID_Partida
INNER JOIN Registro_Usuario R ON hp.ID_Usuario = r.ID_Usuario

/*
select * from Registro_Usuario where Tiempo_Inicio = null
SELECT CAST(SUM(DATEDIFF(MINUTE, pa.Fecha_Inicio, pa.Fecha_Fin)) AS DECIMAL(18, 2)) * 10 / 
       CAST(SUM(DATEDIFF(MINUTE, R.Tiempo_Inicio, R.Tiempo_Final)) AS DECIMAL(18, 2)) AS Tiempo_Efectivo_de_Juego
FROM Historial_Partida hp
INNER JOIN Partida pa ON hp.ID_Partida = pa.ID_Partida
INNER JOIN Registro_Usuario R ON hp.ID_Usuario = r.ID_Usuario

SELECT (DATEDIFF(MINUTE, pa.Fecha_Inicio, pa.Fecha_Fin)) as tiempo_tal,
       (DATEDIFF(MINUTE, R.Tiempo_Inicio, R.Tiempo_Final))  AS Tiempo_Efectivo_de_Juego
FROM Historial_Partida hp
INNER JOIN Partida pa ON hp.ID_Partida = pa.ID_Partida
INNER JOIN Registro_Usuario R ON hp.ID_Usuario = r.ID_Usuario
where r.ID_Usuario=15


select * from Registro_Usuario r
DELETE FROM Partida
WHERE Fecha_Fin IS NULL;


select SUM(DATEDIFF(MINUTE,R.Tiempo_Inicio,R.Tiempo_Final)) 
from Historial_Partida hp
inner join Registro_Usuario R on (hp.ID_Usuario = R.ID_Usuario)

SELECT 
  SUM(
    CASE WHEN R.Tiempo_Final IS NULL OR R.Tiempo_Inicio = NULL
         THEN 0
         ELSE DATEDIFF(MINUTE,R.Tiempo_Inicio,R.Tiempo_Final)
    END
  ) AS Tiempo_Total
FROM 
  Historial_Partida hp
  INNER JOIN Registro_Usuario R ON (hp.ID_Usuario = R.ID_Usuario)

  DELETE FROM Partida
WHERE Fecha_Fin IS NULL OR Fecha_Inicio IS NULL;


select SUM(DATEDIFF(MINUTE, pa.Fecha_Inicio, pa.Fecha_Fin))  from Historial_Partida hp
INNER JOIN Partida pa ON hp.ID_Partida = pa.ID_Partida

select * from Registro_Usuario
select 
select * from Historial_Partida


--ARREGHLART
*/

select SUM(DATEDIFF(MINUTE, pa.Fecha_Inicio, pa.Fecha_Fin))  from Historial_Partida hp
INNER JOIN Partida pa ON hp.ID_Partida = pa.ID_Partida

select SUM(DATEDIFF(MINUTE,R.Tiempo_Inicio,R.Tiempo_Final)) from Historial_Partida hp
inner join Registro_Usuario R on (hp.ID_Usuario = R.ID_Usuario)

SELECT cast(SUM(DATEDIFF(MINUTE, pa.Fecha_Inicio, pa.Fecha_Fin)) as float) / 
       cast(SUM(DATEDIFF(MINUTE, R.Tiempo_Inicio, R.Tiempo_Final))as float) AS Tiempo_Efectivo_de_Juego
FROM Historial_Partida hp
INNER JOIN Partida pa ON hp.ID_Partida = pa.ID_Partida
INNER JOIN Registro_Usuario R ON hp.ID_Usuario = r.ID_Usuario

----------------------------------------------------------------------------------
--� Utilizaci�n efectiva de un cosm�tico: cantidad de usuarios que lo han utilizado en 
--una partida / cantidad de usuarios que lo han comprado
SELECT cosm.Nombre, COUNT(*) AS CantidadUsuario,
  COUNT(*) / (SELECT COUNT(*) FROM Cosmetico_Usuario WHERE ID_Cosmetico = cosm.ID_Cosmetico) AS UtilizacionEfectiva
FROM Historial_Cosmetico hcosm
INNER JOIN Historial_Partida hp ON hp.ID_Historial_Partida = hcosm.ID_Historial_Partida
INNER JOIN Cosmetico cosm ON cosm.ID_Cosmetico = hcosm.ID_Cosmetico
GROUP BY cosm.ID_Cosmetico, cosm.Nombre;



----------------------------------------------------------------------------------
--� Win ratio: cantidad de partidas ganadas / cantidad de partidas totales
SELECT 
  u.ID_Usuario,
  u.Nickname,
  CAST(SUM(CASE WHEN hsp.Partida_Ganada = 1 THEN 1 ELSE 0 END) AS FLOAT) / CAST(COUNT(*) AS FLOAT) AS WinRatio
FROM 
  Usuario u
  INNER JOIN Historial_Partida hsp ON (u.ID_Usuario = hsp.ID_Usuario)
GROUP BY 
  u.ID_Usuario,
  u.Nickname
ORDER BY u.ID_Usuario ASC
--------------------------------------------------------------------------------