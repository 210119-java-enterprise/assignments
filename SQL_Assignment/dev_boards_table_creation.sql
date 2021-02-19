create table user_roles (
	id			serial,
	name		varchar(20) unique not null,
	
	constraint user_roles_pk primary key (id)
);

create table app_users (
	id					serial,
	username			varchar(25) unique not null,
	password			varchar(256) not null,
	first_name			varchar(25) not null,
	last_name			varchar(25) not null,
	email				varchar(256) unique not null,
	register_datetime	timestamp default CURRENT_TIMESTAMP,
	is_active			boolean default false,
	role_id				int,
	
	constraint app_users_pk primary key (id),
	foreign key (role_id) references user_roles (id)
);

create table messages (
	id				serial,
	subject			varchar(35) not null,
	body			text not null,
	send_datetime	timestamp default CURRENT_TIMESTAMP,
	creator_id		int,
	
	constraint messages_pk primary key (id),
	foreign key (creator_id) references app_users (id)
);

create table message_recipients (

	message_id		int,
	recipient_id	int,
	
	constraint message_recipients_pk primary key (message_id, recipient_id),
	foreign key (message_id) references messages (id) on delete cascade,
	foreign key (recipient_id) references app_users (id)
);

create table boards (
	id				serial,
	name			varchar(35) not null,
	description		text not null,
	creator_id		int,
	
	constraint boards_pk primary key (id),
	foreign key (creator_id) references app_users (id)
);

create table board_moderators (
	board_id		int,
	moderator_id	int,

	constraint board_moderators_pk primary key (board_id, moderator_id),
	foreign key (board_id) references boards (id) on delete cascade,
	foreign key (moderator_id) references app_users (id) on delete cascade
);

create table threads (
	id				serial,
	title			varchar(35) not null,
	created_time	timestamp default CURRENT_TIMESTAMP,
	up_votes		int default 0,
	down_votes		int default 0,
	is_locked		boolean default false,
	is_sticky		boolean default false,
	board_id		int,
	creator_id		int,
	
	constraint threads_pk primary key (id),
	foreign key (board_id) references boards (id) on delete cascade,
	foreign key (creator_id) references app_users (id)
);

create table thread_followers (
	user_id		int,
	thread_id	int,
	
	constraint thread_followers_pk primary key (user_id, thread_id),
	foreign key (user_id) references app_users (id) on delete cascade,
	foreign key (thread_id) references threads (id) on delete cascade
);

create table thread_votes (
	user_id		int,
	thread_id	int,
	vote		bit not null,
	
	constraint thread_votes_pk primary key (user_id, thread_id),
	foreign key (user_id) references app_users (id) on delete cascade,
	foreign key (thread_id) references threads (id) on delete cascade
);

create table posts (
	id				serial,
	body			varchar(2056) not null,
	created_time	timestamp default CURRENT_TIMESTAMP,
	up_votes		int default 0,
	down_votes		int default 0,
	replying_to		int,
	thread_id		int,
	poster_id		int,
	
	constraint posts_pk primary key (id),
	foreign key (replying_to) references posts (id),
	foreign key (thread_id) references threads (id) on delete cascade,
	foreign key (poster_id) references app_users (id)
);

create table post_votes (
	user_id		int,
	post_id		int,
	vote		bit not null,
	
	constraint post_votes_pk primary key (user_id, post_id),
	foreign key (user_id) references app_users (id) on delete cascade,
	foreign key (post_id) references posts (id) on delete cascade
);

/*
drop table post_votes;
drop table posts;
drop table thread_followers;
drop table thread_votes;
drop table threads;
drop table board_moderators;
drop table boards;
drop table message_recipients;
drop table messages;
drop table app_users;
drop table user_roles;

/*
NOTES: 
We wouldn't want to cascade delete boards, threads, and posts just because we deleted the user that started them.
Would want business logic to update them to a specific user (admin role?) or a deleted user tag.
However if a board was deleted, we would want to delete the threads inside of that board.