create table if not exists parking_user (
	id bigserial primary key,
	login varchar(64) not null,
	password varchar(256) not null,
	first_name varchar(32),
	last_name varchar(32),
	middle_name varchar(32),
	phone_number varchar(16),
	role varchar(32) not null
);

create table if not exists parking (
	id serial primary key,
	type varchar(64) not null,
	name varchar(64),
	address varchar(256)
);

create table if not exists car (
	id serial primary key,
	model varchar(64),
	number varchar(16) not null,
	weight float4 not null,
	user_id int4 not null,
	foreign key (user_id) references parking_user (id)
);


create table if not exists parking_place (
	floor int4 not null,
	number int4 not null,
	cost int4 not null,
	car_id int4,
	parking_id int4,
	foreign key (car_id) references car (id),
	foreign key (parking_id) references parking (id),
	primary key (floor, number)
);

create table if not exists orders (
	id bigserial primary key,
	pp_floor int4 not null,
	pp_number int4 not null,
	date_from timestamp,
	date_to timestamp,
	overtime bool not null,
	foreign key (pp_floor, pp_number) references parking_place (floor, number)
);

