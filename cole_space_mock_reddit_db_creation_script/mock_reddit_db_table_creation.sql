create table user_roles(
	id		serial,
	name	varchar(20) unique not null,
	
	constraint user_roles_pk
	primary key (id)
);

create table app_users(
	id					serial,
	username			varchar(25) unique not null,
	password			varchar(256) not null,
	first_name			varchar(25) not null,
	last_name			varchar(25) not null,
	email				varchar(256) unique not null,
	register_datetime	timestamp default now(),
	is_active			boolean default false,
	role_id				int,
	
	constraint app_users_pk
	primary key (id),
	
	constraint app_users_fk
	foreign key (role_id)
	references user_roles
);

create table messages(
	id				serial,
	subject			varchar(35) not null,
	body			text not null,
	send_datetime	timestamp default now(),
	creator_id		int,
	
	constraint messages_pk
	primary key (id),
	
	constraint messages_fk
	foreign key (creator_id)
	references app_users
);

create table message_recipients(
	message_id		int,
	recipient_id	int,
	
	constraint message_recipients_pk
	primary key (message_id, recipient_id),
	
	constraint message_recipient_message_fk
	foreign key (message_id)
	references messages,
	
	constraint message_recipient_users_fk
	foreign key (recipient_id)
	references app_users
);

create table boards(
	id				serial,
	name			varchar(35) not null,
	description		text not null,
	creator_id		int,
	
	constraint boards_pk
	primary key (id),
	
	constraint boards_fk
	foreign key (creator_id)
	references app_users
);

create table board_members(
	board_id		int,
	moderator_id	int,
	
	constraint board_members_pk
	primary key (board_id, moderator_id),
	
	constraint board_members_board_fk
	foreign key (board_id)
	references boards,
	
	constraint board_members_app_users_fk
	foreign key (moderator_id)
	references app_users
);

create table threads(
	id				serial,
	title			varchar(35) not null,
	created_time	timestamp default now(),
	up_votes		int default 0,
	down_votes		int default 0,
	is_locked		boolean default false,
	is_sticky		boolean default false,
	board_id		int, 
	creator_id		int,
	
	constraint threads_pk
	primary key (id),
	
	constraint threads_board_fk
	foreign key (board_id)
	references boards,
	
	constraint threads_app_users_fk
	foreign key (creator_id)
	references app_users
);

create table thread_followers(
	user_id		int,
	thread_id	int,
	
	constraint thread_followers_pk
	primary key (user_id, thread_id),
	
	constraint thread_followers_app_users_fk
	foreign key (user_id)
	references app_users,
	
	constraint thread_followers_thread_fk
	foreign key (thread_id)
	references threads
);

create table thread_votes(
	user_id		int,
	thread_id	int,
	vote		bit not null,
	
	constraint thread_votes_pk
	primary key (user_id, thread_id),
	
	constraint thread_votes_app_users_fk
	foreign key (user_id)
	references app_users,
	
	constraint thread_votes_thread_fk
	foreign key (thread_id)
	references threads
);

create table posts(
	id				serial,
	body			varchar(2056) not null,
	created_time	timestamp default now(),
	up_votes		int default 0,
	down_votes		int default 0,
	replying_to		int,
	thread_id		int,
	poster_id		int,
	
	constraint posts_pk
	primary key (id),
	
	constraint posts_posts_fk
	foreign key (replying_to)
	references posts,
	
	constraint posts_threads_fk
	foreign key (thread_id)
	references threads,
	
	constraint posts_app_users_fk
	foreign key (poster_id)
	references app_users
);

create table post_votes(
	user_id		int,
	post_id		int,
	vote		bit not null,
	
	constraint post_votes_fk
	primary key (user_id, post_id),
	
	constraint post_votes_app_users_fk
	foreign key (user_id)
	references app_users,
	
	constraint post_votes_posts_fk
	foreign key (post_id)
	references posts
);

--insert into user_roles ("name")
--values 	('ADMIN'),
--		('BASIC_USER'),
--		('PREMIUM_USER');
--	
--select * from user_roles;
--		
--insert into app_users (username, "password", first_name, last_name, email, role_id)
--values 	('test1', 'test1', 'test', 'user', 'test1@test.net', 2),
--		('test2', 'test2', 'test', 'user', 'test2@test.net', 2),
--		('test3', 'test3', 'test', 'user', 'test3@test.net', 3),
--		('admin1', 'test1', 'admin', 'user', 'test@test.net', 1);
--		
--select * from app_users;
--
--insert into messages(subject, body, creator_id)
--values 	('Message1', 'This is the test body of the message', 2),
--		('Message2', 'This is the test body of the message', 2),
--		('Message3', 'This is the test body of the message', 3),
--		('Message4', 'This is the test body of the message', 1);
--		
--select * from messages;
--
--insert into message_recipients
--values 	(1, 3),
--		(2, 1),
--		(3, 2),
--		(4, 3);
--		
--insert into boards ("name", description, creator_id)
--values 	('Board1', 'This is board 1', 1),
--		('Board2', 'This is board 2', 1),
--		('Board3', 'This is board 3', 2),
--		('Board4', 'This is board 4', 3);
--		
--insert into board_members 
--values	(1, 1),
--		(3, 2),
--		(4, 3);
--		
--insert into threads (title, board_id, creator_id)
--values	('Thread1', 1, 1),
--		('Thread1', 2, 1),
--		('Thread2', 1, 2),
--		('Thread1', 3, 3);
--		
--insert into thread_followers 
--values	(1, 1),
--		(1, 2),
--		(2, 3),
--		(3, 4);
--		
--insert into thread_votes 
--values	(1, 1, cast(1 as bit)),
--		(1, 2, cast(1 as bit)),
--		(2, 3, cast(1 as bit)),
--		(3, 4, cast(1 as bit));
--		
--insert into posts (body, thread_id, poster_id)
--values	('Body of post 1', 1, 1),
--		('Body of post 2', 2, 1);
--
--insert into posts (body, replying_to, thread_id, poster_id)
--values ('This is a reply to the post', 1, 1, 2);
--
--insert into post_votes
--values	(1, 1, cast(1 as bit)),
--		(2, 2, cast(1 as bit)),
--		(2, 3, cast(1 as bit));