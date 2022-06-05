task13 (lesson3)
--������������ �����: ������� ������ ���� ��������� � ������������� � ��������� ���� �������� (pc, printer, laptop). �������: model, maker, type

select p.model, maker, type 
from product
join pc p 
on p.model = product.model 
union all 
select p2.model, maker, p2.type
from product p2 
join printer p3 
on p2.model = p3.model 
union all 
select p2.model, maker, p2.type
from product p2 
join laptop l 
on p2.model = l.model

--task14 (lesson3)
--������������ �����: ��� ������ ���� �������� �� ������� printer ������������� ������� ��� ���, � ���� ���� ����� ������� PC - "1", � ��������� - "0"

select *,
case when
price > (select avg(price) from pc p2 )
then 1
else 0
end flag
from printer


--task15 (lesson3)
--�������: ������� ������ ��������, � ������� class ����������� (IS NULL)

select name, s.class from ships s 
where s.class is null
union 
select ship, class
from classes c2 
join outcomes o 
on c2.class = o.ship 
where c2.class is null




--task16 (lesson3)
--�������: ������� ��������, ������� ��������� � ����, �� ����������� �� � ����� �� ����� ������ �������� �� ����.

select name
from battles
where year(date) not in (select launched from ships
Where launched is not null)

      
--task17 (lesson3)
--�������: ������� ��������, � ������� ����������� ������� ������ Kongo �� ������� Ships.
select battle from outcomes
where ship in (select name
from ships
where class = 'Kongo')



--task1  (lesson4)
-- ������������ �����: ������� view (�������� all_products_flag_300) ��� ���� ������� (pc, printer, laptop) � ������, ���� ��������� ������ > 300. �� view ��� �������: model, price, flag


create view all_products_flag_300 as
with all_products_flag_300 as
(select model, price,
case when price>300
then 1
else 0
end flag
from pc
union 
select model, price,
case when price>300
then 1
else 0
end flag
from printer
union 
select model, price,
case when price>300
then 1
else 0
end flag
from laptop)
select * 
from all_products_flag_300



--task2  (lesson4)
-- ������������ �����: ������� view (�������� all_products_flag_avg_price) ��� ���� ������� (pc, printer, laptop) � ������, ���� ��������� ������ c������ . �� view ��� �������: model, price, flag

create view all_products_flag_avg_price as
with all_products_flag_avg_price as
(select pc.model, price,
case when price> (select avg(price) from pc)
then 1
else 0
end flag
from pc
union 
select model, price,
case when price>(select avg(price) from printer)
then 1
else 0
end flag
from printer
union 
select model, price,
case when price>(select avg(price) from laptop)
then 1
else 0
end flag
from laptop)
select * 
from all_products_flag_avg_price

--task3  (lesson4)
-- ������������ �����: ������� ��� �������� ������������� = 'A' �� ���������� ���� ������� �� ��������� ������������� = 'D' � 'C'. ������� model

select p.model
from printer p 
join product p2 
on p.model = p2.model
where maker = 'A'
and 
price > (select avg(price) from printer
join product p2 
on printer.model = p2.model
where maker = 'D' or maker = 'C')


--task4 (lesson4)
-- ������������ �����: ������� ��� ������ ������������� = 'A' �� ���������� ���� ������� �� ��������� ������������� = 'D' � 'C'. ������� model

select p.model
from product p
join printer p2
on p.model = p2.model
where maker = 'A'
and
price > (select avg(price) from printer
join product p2 
on printer.model = p2.model
where maker = 'D' or maker = 'C')
union all
select p.model
from product p
join pc p3
on p.model = p3.model
where maker = 'A'
and
price > (select avg(price) from printer
join product p2 
on printer.model = p2.model
where maker = 'D' or maker = 'C')
union all
select p.model
from product p
join laptop l
on p.model = l.model
where maker = 'A'
and
price > (select avg(price) from printer
join product p2 
on printer.model = p2.model
where maker = 'D' or maker = 'C')

--task5 (lesson4)
-- ������������ �����: ����� ������� ���� ����� ���������� ��������� ������������� = 'A' (printer & laptop & pc)


with table_2 as
(select distinct p2.model, price, maker
from product p
join printer p2
on p.model = p2.model
where maker = 'A'
union 
select distinct p3.model, price, maker
from product p
join pc p3
on p.model = p3.model
where maker = 'A'
union
select distinct l.model, price, maker
from product p
join laptop l
on p.model = l.model
where maker = 'A')
select avg(price) 
from table_2 

--task6 (lesson4)
-- ������������ �����: ������� view � ����������� ������� (�������� count_products_by_makers) �� ������� �������������. �� view: maker, count

create view count_products_by_makers as
with count_products_by_makers as
(select maker, count(model)
from product
where maker = 'A'
group by maker
union 
select maker, count(model)
from product
where maker = 'B'
group by maker
union 
select maker, count(model)
from product
where maker = 'C'
group by maker
union 
select maker, count(model)
from product
where maker = 'D'
group by maker
union select maker, count(model)
from product
where maker = 'E'
group by maker)
select * 
from count_products_by_makers



--task7 (lesson4)
-- �� ����������� view (count_products_by_makers) ������� ������ � colab (X: maker, y: count)



--task8 (lesson4)
-- ������������ �����: ������� ����� ������� printer (�������� printer_updated) � ������� �� ��� ��� �������� ������������� 'D'
create table printer_updated as table printer;
DELETE from printer_updated
WHERE model in 
(
select model
from product
where maker = 'D'
);
select *
from printer_updated


--task9 (lesson4)
-- ������������ �����: ������� �� ���� ������� (printer_updated) view � �������������� �������� ������������� (�������� printer_updated_with_makers)

create view printer_updated_with_makers as
with printer_updated_with_makers as
(select code, printer_updated.model, color, printer_updated.type, price, maker
from printer_updated
join product 
on product.model = printer_updated.model)
select *
from printer_updated_with_makers


--task10 (lesson4)
-- �������: ������� view c ����������� ����������� �������� � ������� ������� (�������� sunk_ships_by_classes). �� view: count, class (���� �������� ������ ���/IS NULL, �� �������� �� 0)


create view sunk_ships_by_classes as 
with all_ships as 
(
		select name, class
		from ships
	union all
		select distinct ship, NULL as class
		from Outcomes
		where ship not in (select name from ships) 
)
select class, count(*) from all_ships where name in 
	(
	select ship
	from outcomes
	where result = 'sunk'
	) group by class;

select *
from sunk_ships_by_classes

--task11 (lesson4)
-- �������: �� ����������� view (sunk_ships_by_classes) ������� ������ � colab (X: class, Y: count)

--task12 (lesson4)
-- �������: ������� ����� ������� classes (�������� classes_with_flag) � �������� � ��� flag: ���� ���������� ������ ������ ��� ����� 9 - �� 1, ����� 0

create table classes_with_flag as 
select *,
case 
	when numguns >= 9 then 1
	else 0
end flag
from classes;

select *
from classes_with_flag

--task13 (lesson4)
-- �������: ������� ������ � colab �� ������� classes � ����������� ������� �� ������� (X: country, Y: count)

--task14 (lesson4)
-- �������: ������� ���������� ��������, � ������� �������� ���������� � ����� "O" ��� "M".

with names as
	( 
	select name
	from ships 
	where name like 'O%' or name like 'M%'
	)
select count(*) from names

--task15 (lesson4)
-- �������: ������� ���������� ��������, � ������� �������� ������� �� ���� ����.

with names_1 as
	( 
	select *
	from ships
	where name like '% %'
	)
select count(*) from names_1

--task16 (lesson4)
-- �������: ��������� ������ � ����������� ���������� �� ���� �������� � ����� ������� (X: year, Y: count)
