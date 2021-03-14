/*
 * Creation DB for VKontakte
 */

drop database if exists vk;
create database vk;

use vk;

drop table if exists user;
create table users(
	id bigint unsigned not null auto_increment primary key,
	firstname varchar(100),
	lastname varchar(100),
	email varchar(120) unique,
	password_hash varchar(100),
	phone bigint unsigned unique,
	
	index user_firstname_lastname_idx(firstname, lastname)
);

drop table if exists profiles;
create table profiles(
	user_id bigint unsigned not null unique,
	gender char(1),
	birthday date,
	hometown varchar(50),
	photo_id bigint unsigned,
	created_at datetime default now()
);

alter table profiles add constraint fk_user_id
	foreign key(user_id) references users(id)
	on update cascade
	on delete restrict;

drop table if exists messages;
create table messages(
# serial = bigint unsigned not null auto_increment 	
	id serial, 
	from_user_id bigint unsigned not null,
	to_user_id bigint unsigned not null,
	body text,
	created_at datetime default now(),
	
	foreign key(from_user_id) references users(id),
	foreign key(to_user_id) references users(id)
);

/*создание таблицы лайков на основании имеющихся данных других таблиц (пока одна)*/
drop table if exists likies;
create table likies (
	id serial, 
	user_id bigint unsigned not null,
	created_at datetime default now()
);




