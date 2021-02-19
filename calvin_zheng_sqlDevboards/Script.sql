create table user_roles(
	id serial,
	name varchar(20) unique not null,
	constraint user_roles_PK primary key (id)
);


create table app_users(
		id serial,
		username varchar(25) UNIQUE not NULL,
		password varchar(256) not NULL,
		first_name varchar(25) not NULL,
		last_name varchar(25) not NULL,
		email varchar(25) unique not NULL,
		register_datetime timestamp default CURRENT_TIMESTAMP,
		is_active boolean default false,
		role_id int not NULL,
		constraint app_users_PK primary key (id),
		constraint app_user_role_FK foreign key (role_id) references user_roles
);


create table messages(
	id serial,
	subject varchar(35) not null,
	body text not null,
	send_datetime timestamp default CURRENT_TIMESTAMP,
	creator_id int not NULL,
	constraint messages_PK primary key (id),
	constraint creator_FK foreign key (creator_id) references app_users
);

create table message_recipients(
	message_id int,
	recipient_id int,
	constraint message_recipients_PK primary key (message_id , recipient_id),
	constraint message_id_FK foreign key (message_id) references messages,
	constraint recipient_id_FK foreign key (recipient_id) references messages
);

create table boards(
	id serial,
	name varchar(35) not null,
	description text not null,
	creator_id int not null,
	constraint boards_PK primary key (id),
	constraint creator_id_FK foreign key (creator_id) references app_users
);

create table board_moderators(
	board_id int,
	moderator_id int,
	constraint board_moderators_PK primary key (board_id , moderator_id),
	constraint board_id_FK foreign key (board_id) references boards,
	constraint moderator_id_FK foreign key (moderator_id) references app_users
);

create table threads(
	id serial,
	title varchar(25) not null,
	created_time timestamp default CURRENT_TIMESTAMP,
	upvotes int default 0,
	downvotes int default 0,
	is_locked boolean default false,
	is_sticky boolean default false,
	board_id int not null,
	creator_id int not null,
	constraint threads_id_pk primary key (id),
	constraint board_id_FK foreign key (board_id) references boards,
	constraint creator_id_FK foreign key (creator_id) references app_users
);

create table thread_followers(
	user_id int,
	thread_id int,
	constraint thread_followers_PK primary key (user_id, thread_id),
	constraint user_id_FK foreign key (user_id) references app_users,
	constraint thread_id_FK foreign key (thread_id) references threads
);

create table thread_votes(
	user_id int,
	thread_id int,
	vote bit not NULL, 
	constraint thread_votes_PK primary key (user_id, thread_id),
	constraint user_votes_id_FK foreign key (user_id) references app_users,
	constraint thread_votes_id_FK foreign key (thread_id) references threads
);

create table posts(
	id serial,
	body varchar(2056) not null,
	create_time timestamp default CURRENT_TIMESTAMP,
	up_votes int default 0,
	down_votes int default 0,
	replying_to int not null,
	thread_id int not null,
	poster_id int not null,
	constraint post_id primary key(id),
	constraint replying_to_FK foreign key(replying_to) references posts,
	constraint thread_id_FK foreign key(thread_id) references threads,
	constraint poster_id_FK foreign key (poster_id) references app_users
);

create table post_votes(
	user_id int, 
	post_id int,
	vote bit not null,
	constraint post_votes_PK primary key (user_id, post_id),
	constraint user_votes_id_FK foreign key (user_id) references app_users,
	constraint vote_votes_id_FK foreign key (post_id) references posts
);

