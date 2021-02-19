create table user_roles (
	id serial,
	name varchar(20) not null unique,
	
	constraint user_roles_pk
	primary key (id)
);

create table app_users (
	id serial,
	username varchar(25) not null unique,
	password varchar(256) not null,
	first_name varchar(25) not null,
	last_name varchar(25) not null,
	email varchar(256) not null unique,
	register_datetime timestamp default now(),
	is_active boolean default false,
	role_id int,
	
	constraint app_users_pk
	primary key (id),
	
	constraint app_users_roles_fk
	foreign key (role_id)
	references user_roles
);

create table messages (
	id serial,
	subject varchar(35) not null,
	body text not null,
	send_datetime timestamp default now(),
	creator_id int,
	
	constraint messages_pk
	primary key (id),
	
	constraint messages_app_users_fk
	foreign key (creator_id)
	references app_users
);

create table message_recipients (
	message_id int,
	recipient_id int,
	
	constraint message_recipients_pk 
	primary key (message_id, recipient_id),
	
	constraint message_recipients_message_fk
	foreign key (message_id)
	references messages,
	
	constraint message_recipients_app_user_fk
	foreign key (recipient_id)
	references app_users
);

create table boards (
	id serial,
	name varchar(35) not null,
	description text not null,
	creator_id int,
	
	constraint boards_pk
	primary key (id),
	
	constraint boards_app_users_fk
	foreign key (creator_id)
	references app_users
);

create table board_moderators (
	board_id int,
	moderator_id int,
	
	constraint board_moderators_pk 
	primary key (board_id, moderator_id),
	
	constraint board_moderators_board_fk
	foreign key (board_id)
	references boards,
	
	constraint board_moderators_app_user_fk
	foreign key (moderator_id)
	references app_users
);

create table threads (
	id serial,
	title varchar(35) not null,
	created_time timestamp default now(),
	up_votes int default 0,
	down_votes int default 0,
	is_locked boolean default false,
	is_sticky boolean default false,
	board_id int,
	creator_id int,
	
	constraint threads_pk
	primary key (id),
	
	constraint threads_boards_fk
	foreign key (board_id)
	references boards,
	
	constraint threads_app_users_fk
	foreign key (creator_id)
	references app_users
);

create table thread_followers (
	user_id int,
	thread_id int,
	
	constraint thread_followers_pk 
	primary key (user_id, thread_id),
	
	constraint thread_followers_app_user_fk
	foreign key (user_id)
	references app_users,
	
	constraint thread_followers_thread_fk
	foreign key (thread_id)
	references threads
);

create table thread_votes (
	user_id int,
	thread_id int,
	vote bit not null,
	
	constraint thread_votes_pk 
	primary key (user_id, thread_id),
	
	constraint thread_votes_app_user_fk
	foreign key (user_id)
	references app_users,
	
	constraint thread_votes_thread_fk
	foreign key (thread_id)
	references threads
);

create table posts (
	id serial,
	body varchar(2056) not null,
	created_time timestamp default now(),
	up_votes int default 0,
	down_votes int default 0,
	replying_to int,
	thread_id int,
	poster_id int,
	
	constraint posts_pk
	primary key (id),
	
	constraint posts_replying_app_user_fk
	foreign key (replying_to)
	references posts,
	
	constraint posts_threads_fk
	foreign key (thread_id)
	references threads,
	
	constraint posts_app_users_fk
	foreign key (poster_id)
	references app_users
);

create table post_votes (
	user_id int,
	post_id int,
	vote bit not null,
	
	constraint post_votes_pk 
	primary key (user_id, post_id),
	
	constraint post_votes_app_user_fk
	foreign key (user_id)
	references app_users,
	
	constraint post_votes_post_fk
	foreign key (post_id)
	references posts
);
