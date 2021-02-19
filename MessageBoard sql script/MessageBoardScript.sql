--DROP SCHEMA public CASCADE;
--CREATE SCHEMA public;

create table user_roles (
	id 		serial primary key,
	name	varchar(20) unique not null
);

create table app_users (
	id					serial primary key,
	username			varchar(25) unique not null,
	password			varchar(256) not null,
	first_name			varchar(25) not null,
	last_name			varchar(25) not null,
	email				varchar(256) unique not null,
	register_datetime	timestamp default current_timestamp,
	is_active			boolean default false,
	role_id				int not null,

	constraint user_roles_fk
	foreign key(role_id)
	references user_roles(id)
);

create table messages (
	id				serial primary key,
	subject			varchar(35) not null,
	body			text not null,
	send_datetime	timestamp default current_timestamp,
	creator_id		int not null,
	
	constraint app_users_fk
	foreign key(creator_id)
	references app_users(id)
);

create table message_recipients(
	message_id		int not null,
	recipient_id	int not null,
	
	constraint message_recipients_pk
	primary key (message_id, recipient_id),
	
	constraint messages_fk
	foreign key(message_id)
	references messages(id),
	
	constraint app_users_fk
	foreign key(recipient_id)
	references app_users(id)
);

create table boards (
	id			serial primary key,
	name		varchar(35) not null,
	description	text not null,
	creator_id	int not null,
	
	constraint app_users_fk
	foreign key(creator_id)
	references app_users(id)
);

create table board_moderators (
	board_id		int not null,
	moderator_id	int not null,
	
	constraint board_moderators_pk
	primary key (board_id, moderator_id),
	
	constraint boards_fk
	foreign key(board_id)
	references boards(id),
	
	constraint app_users_fk
	foreign key(moderator_id)
	references app_users(id)
);

create table threads (
	id				serial primary key,
	title			varchar(35) not null,
	created_time	timestamp default current_timestamp,
	up_votes		int default 0,
	down_votes		int default 0,
	is_locked		boolean default false,
	is_sticky		boolean default false,
	board_id		int not null,
	creator_id		int not null,
	
	constraint boards_fk
	foreign key(board_id)
	references boards(id),
	
	constraint app_users_fk
	foreign key(creator_id)
	references app_users(id)
);

create table thread_followers (
	user_id		int not null,
	thread_id	int not null,
	
	constraint app_users_fk
	foreign key(user_id)
	references app_users(id),
	
	constraint threads_fk
	foreign key(thread_id)
	references threads(id)
);

create table thread_votes (
	user_id		int not null,
	thread_id	int not null,
	vote		bit not null,
	
	constraint app_users_fk
	foreign key(user_id)
	references app_users(id),
	
	constraint threads_fk
	foreign key(thread_id)
	references threads(id)
);

create table posts (
	id				serial primary key,
	body			varchar(2056) not null,
	created_time	timestamp default current_timestamp,
	up_votes		int default 0,
	down_votes		int	default 0,
	replying_to		int not null,
	thread_id		int not null,
	poster_id		int not null,
	
	constraint app_users_reply_fk
	foreign key(replying_to)
	references app_users(id),
	
	constraint app_users_poster_fk
	foreign key(poster_id)
	references app_users(id),
	
	constraint threads_fk
	foreign key(thread_id)
	references threads(id)
);

create table post_votes (
	user_id		int not null,
	post_id		int not null,
	vote		bit not null,
	
	constraint post_votes_pk
	primary key (user_id, post_id),
	
	constraint app_users_fk
	foreign key(user_id)
	references app_users(id),
	
	constraint posts_fk
	foreign key(post_id)
	references posts(id)
);


