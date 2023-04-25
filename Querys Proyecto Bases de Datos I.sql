--querys
--Query 1
select c.Nombre, count(1) as Personas_Continente from dbo.Usuario u inner join 
Nacionalidad n on (u.ID_Nacionalidad = n.ID_Nacionalidad)
inner join Continente c on (c.ID_Continente = n.ID_Continente)
group by c.Nombre
--Query 7
select u.Nickname, count(1) as Cantidad_Ganadas from historial_partida hp
inner join Usuario u on (hp.ID_Usuario = u.ID_Usuario)
where hp.partida_ganada = 1
group by u.Nickname
order by Cantidad_Ganadas desc