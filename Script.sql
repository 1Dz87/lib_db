-- Создание таблицы автора
create table if not exists author (
	id bigserial primary key,
	first_name varchar(32),
	last_name varchar(32),
	middle_name varchar(32),
	birthdate date
);

-- Создание таблицы стихов
create table if not exists poem (
	id bigserial primary key,
	name varchar(128),
	content text,
	date timestamp,
	a_id int8,
	constraint a_id_fk foreign key (a_id) references author(id)
);

-- Создание таблицы КНИГА
create table if not exists book (
	id bigserial primary key,
	name varchar(128),
	producer varchar(64),
	date date,
	number int4,
	a_id int8,
	constraint a_id_fk foreign key (a_id) references author(id)
);

-- Создание таблицы ПОЛКА
create table shelf (
	id bigserial primary key,
	number int4
);

-- Создание таблицы ШКАФ
create table book_case (
	id bigserial primary key,
	number int4
);

-- Создание таблицы ХРАНИЛИЦЕ
create table archive (
	id bigserial primary key,
	number int4
);

alter table poem add column b_id int8;
alter table poem add constraint b_id_fk foreign key (b_id) references book(id);

alter table book add column s_id int8;
alter table book add constraint s_id_fk foreign key (s_id) references shelf(id);

alter table shelf add column bc_id int8;
alter table shelf add constraint bc_id_fk foreign key (bc_id) references book_case(id);

alter table book_case add column ar_id int8;
alter table book_case add constraint ar_id_fk foreign key (ar_id) references archive(id);

alter table book_case drop column ar_id cascade;

alter table archive alter column number set not null;

alter table book_case alter column number set not null;
alter table book_case alter column ar_id set not null;

alter table shelf alter column number set not null;
alter table shelf alter column bc_id set not null;

alter table book alter column number set not null;
alter table book alter column name set not null;
alter table book alter column a_id set not null;
alter table book alter column s_id set not null;

alter table poem alter column content set not null;

alter table author alter column last_name set not null;

insert into author values (nextval('author_id_seq'), 'Лев', 'Толстой', 'Николаевич', '09.09.1828');
insert into author (last_name) values ('Народ');

insert into poem (name, content, date, a_id) values ('Анна Каренина', 'Ann Carenina', '24.02.1870', 1);
