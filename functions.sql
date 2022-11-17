create view free_places (place_floor, place_number, parking_number, parking_place) as 
select pp.floor, pp."number", p."name", p.address from parking_place pp full outer join parking p on pp.parking_id = p.id where p.id is null;

select * from free_places fp where fp.place_number = 12;

select pp.floor, pp."number" as parking_place_number, pp.car_id,  p."name", p.address, c.model, c."number" as car_number from parking_place pp 
	full outer join parking p on pp.parking_id = p.id 
	full outer join car c on pp.car_id = c.id 
	where p.id is null;
	

create function select_some(integer) returns car as
'select * from car where car.id = $1;'
language sql;

select select_some(1);

create or replace function update_order(inout ord orders) as
$$select ord.date_to + INTERVAL '1 DAY';
select ord;$$
language sql;

select update_order(row(o.id, null, null, null, o.date_to, null)) from orders o;

create or replace function update_overtime() returns setof orders as 
$BODY$
declare
	"order" orders;
begin
	for "order" in select * from orders o where o.date_to < now() 
	loop 
		update orders set overtime = true where id = "order".id;
		return next "order";
	end loop;
end;
$BODY$
language plpgsql;

select update_overtime();