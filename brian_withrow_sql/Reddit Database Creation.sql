create table user_roles(
	id					serial,
	name				varchar(20) unique not null,
	
	constraint pk_user_roles primary key (id)
);

create table app_users (
	id					serial,
	username			varchar(25) unique not null,
	password			varchar(25) not null,
	first_name			varchar(25) not null,
	last_name			varchar(25) not null,
	email				varchar(25)	unique not null,
	register_datetime	timestamp default now(),
	is_active			boolean default (false),
	role_id				int,
	
	constraint pk_app_user primary key (id),
	constraint fk_user_role foreign key (role_id)
	references user_roles (id)
);

create table messages(
	id					serial,
	subject				varchar(35) not null,
	body				text not null,
	send_datetime		timestamp default now(),
	creator_id			int,
	
	constraint pk_messages primary key (id), 
	constraint fk_creator_id foreign key (creator_id)
	references app_users (id)
);

create table message_recipients(
	message_id			int,
	recipient_id		int,
	
	constraint pk_message_recipients primary key (message_id, recipient_id),
	constraint fk_message_id foreign key (message_id)
	references messages(id),
	constraint fk_recipient_id foreign key (recipient_id)
	references app_users (id)
);

create table boards(
	id					serial,
	name				varchar(35) not null,
	description			text,
	creator_id			int,
	
	constraint pk_boards primary key (id) ,
	constraint fk_creator_id foreign key (creator_id) 
	references app_users (id) 
);

create table threads(
	id					serial,
	title				varchar(35) not null,
	created_time		timestamp default now(),
	up_votes			int default 0,
	down_votes			int default 0,
	is_locked			boolean default false,
	is_sticky			boolean default false,
	board_id			int,
	creator_id			int,
	
	constraint pk_thread_id primary key (id),
	constraint fk_board_id foreign key (board_id)
	references boards (id),
	constraint fk_creator_id foreign key (creator_id)
	references app_users (id)
);

create table posts(
	id					serial,
	body				varchar(2056),
	created_time		timestamp default now(),
	up_votes			int default 0,
	down_votes			int default 0,
	replying_to			int,
	thread_id			int,
	poster_id			int,
	
	constraint pk_post_id primary key (id),
	constraint fk_reply_to foreign key (replying_to)
	references posts (id),
	constraint fk_thread_id foreign key (thread_id)
	references threads (id),
	constraint fk_poster_id foreign key (poster_id)
	references app_users (id)
);

create table post_votes(
	user_id				int,
	post_id				int,
	vote				int not null,
	
	constraint pk_user_id primary key (user_id, post_id),
	constraint fk_user_id foreign key (user_id)
	references app_users (id),
	constraint fk_post_id foreign key(post_id)
	references posts (id)
);

create table thread_followers(
	user_id				int,
	thread_id			int,
	
	constraint pk_thread_followers primary key (user_id, thread_id),
	constraint fk_user_id foreign key (user_id)
	references app_users (id),
	constraint fk_thread_id foreign key (thread_id) 
	references threads (id) 
);

create table thread_votes(
	user_id				int,
	thread_id			int,
	vote				int not null,
	
	constraint pk_thread_votes primary key (user_id, thread_id),
	constraint fk_user_id foreign key (user_id)
	references app_users (id) ,
	constraint fk_thread_id foreign key (thread_id) 
	references threads (id) 
);

create table board_moderators(
	board_id 			int,
	moderator_id 		int,
	
	constraint pk_board_moderators primary key (board_id, moderator_id),
	constraint fk_board_id foreign key (board_id) 
	references boards (id),
	constraint fk_moderator_id foreign key (moderator_id) 
	references app_users (id) 
);
