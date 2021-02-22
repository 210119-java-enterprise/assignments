

create table board_moderators
( 
	board_id int,
	moderator_id int,
	primary key(board_id,moderator_id)
);


create table boards
( 
	id serial,
	name varchar(35) not null,
	description text not null,
	creator_id int,
	primary key(id)
);

create table threads
(
	id serial,
	title varchar(35) not null,
	created_time timestamp default current_timestamp,
	up_voted int default 0,
	down_votes int default 0,
	is_locked boolean default false,
	is_sticky boolean default false,
	board_id int,
	creator_id int,
	primary key(id)
);

create table thread_votes
( 
	user_id int,
	thread_id int,
	vote bit not null,
	primary key(user_id,thread_id)
);

create table thread_followers 
( 
	user_id int,
	thread_id int,
	primary key(user_id,thread_id)
);

create table posts
( 
	id serial,
	body varchar(2056) not null,
	create_time timestamp default current_timestamp,
	up_votes int default 0,
	down_votes int default 0,
	replying_to int,
	thread_id int,
	poster_id int,
	primary key(id)
);


create table post_votes
(
	user_id int,
	post_id int,
	vote bit not null,
	primary key(user_id,post_id)
);


create table message_recipients
(
	message_id int,
	recipient_id int,
	primary key(message_id,recipient_id)
);


create table messages
(
	id serial,
	subject varchar(35) not null,
	body text not null,
	send_datetime timestamp default current_timestamp,
	creator_id int,
	primary key(id)
);

create table user_roles
(
	id serial,
	name varchar(20) unique not null,
	primary key(id)
);



create table app_users
(
	id serial,
	username varchar(25) unique not null,
	password varchar(256) not null,
	first_name varchar(25) not null,
	last_name varchar(25) not null,
	email varchar(256) unique not null,
	register_datetime timestamp default current_timestamp,
	is_active boolean default false,
	role_id int,
	primary key(id)
);

alter table app_users
	add constraint fk_rid foreign key(role_id) references user_roles(id) on delete cascade;

alter table messages 
	add constraint fk_id foreign key(creator_id) references app_users(id) on delete cascade;

alter table message_recipients 
	add constraint fk_mid foreign key(message_id) references messages(id) on delete cascade,
	add constraint fk_rid foreign key(recipient_id) references app_users(id) on delete cascade;

alter table post_votes
	add constraint fk_uid foreign key(user_id) references app_users(id) on delete cascade,
	add constraint fk_pid foreign key(post_id) references posts(id) on delete cascade;

alter table posts
	add constraint fk_pid foreign key(poster_id) references app_users(id) on delete cascade,
	add constraint fk_tid foreign key(thread_id) references threads(id) on delete cascade;

alter table threads
	add constraint fk_cid foreign key(creator_id) references app_users(id) on delete cascade,
	add constraint fk_bid foreign key(board_id) references boards(id);

alter table board_moderators 
	add constraint fk_bid foreign key(board_id) references boards(id) on delete cascade,
	add constraint fk_mid foreign key(moderator_id) references app_users(id) on delete cascade;

alter table boards 
	add constraint fk_cid foreign key(creator_id) references app_users(id) on delete cascade;

alter table thread_votes 
	add constraint fk_uid foreign key(user_id) references app_users(id) on delete cascade,
	add constraint fk_tid foreign key(thread_id) references threads(id) on delete cascade;

alter table thread_followers 
	add constraint fk_uid foreign key(user_id) references app_users(id) on delete cascade,
	add constraint fk_tid foreign key(thread_id) references threads(id) on delete cascade;



