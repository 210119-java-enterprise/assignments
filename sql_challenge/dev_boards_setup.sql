drop table if exists post_votes;
drop table if exists posts;
drop table if exists thread_votes;
drop table if exists thread_followers;
drop table if exists threads;
drop table if exists board_moderators;
drop table if exists boards;
drop table if exists message_recipients;
drop table if exists messages;
drop table if exists app_users;
drop table if exists user_roles;


create table user_roles (
	id			serial			constraint user_roles_PK primary key,
	name 		varchar(20)		unique not null
);

create table app_users (
	id					serial			constraint app_users_PK primary key,
	username			varchar(25)		unique not null,
	password			varchar(256)	not null,
	first_name			varchar(25)		not null,
	last_name			varchar(25)		not null,
	email				varchar(256)	unique not null,
	register_datetime	timestamp		default current_timestamp,
	is_active			boolean			default false,
	role_id				int,
	
	constraint app_user_role_FK foreign key (role_id) references user_roles
);

create table messages (
	id 					serial			constraint messages_PK primary key,
	subject				varchar(35)		not null,
	body				text			not null,
	send_datetime		timestamp		default current_timestamp,
	creator_id			int,
	
	constraint app_user_message_FK foreign key (creator_id) references app_users
);

create table message_recipients (
	message_id			int,
	recipient_id		int,
	
	constraint message_recipient_message_FK foreign key (message_id) references messages,
	constraint app_user_message_recipient_FK foreign key (recipient_id) references app_users
);

create table boards (
	id 					serial			constraint boards_PK primary key,
	name 				varchar(35)		not null,
	description			text			not null,
	creator_id			int,
	
	constraint app_user_board_FK foreign key (creator_id) references app_users
);

create table board_moderators (
	board_id 			int,
	moderator_id		int,
	
	constraint board_moderators_PK primary key (board_id, moderator_id),
	constraint board_moderator_board_FK foreign key (board_id) references boards,
	constraint board_moderator_app_user_FK foreign key (moderator_id) references app_users
);

create table threads (
	id 					serial			constraint threads_PK primary key,
	title 				varchar(35)		not null,
	created_time		timestamp		default current_timestamp,
	up_votes			int				default 0,
	down_votes			int				default 0,
	is_locked			boolean			default false,
	is_sticky			boolean			default false,
	board_id			int,
	creator_id			int,
	
	constraint thread_board_FK foreign key (board_id) references boards,
	constraint app_user_thread_FK foreign key (creator_id) references app_users
);

create table thread_followers (
	user_id 			int,
	thread_id 			int,
	
	constraint thread_follower_app_user_FK foreign key (user_id) references app_users,
	constraint thread_follower_thread_FK foreign key (thread_id) references threads
);

create table thread_votes (
	user_id 			int,
	thread_id 			int,
	vote 				bit				not null,
	
	constraint thread_vote_app_user_FK foreign key (user_id) references app_users,
	constraint thread_vote_thread_FK foreign key (thread_id) references threads
);

create table posts (
	id 					serial			constraint posts_PK primary key,
	body				varchar(2056)	not null,
	created_time		timestamp		default current_timestamp,
	up_votes			int				default 0,
	down_votes			int				default 0,
	replying_to			int,
	thread_id			int,
	poster_id			int,
	
	constraint post_reply_FK foreign key (replying_to) references posts,
	constraint post_thread_FK foreign key (thread_id) references threads,
	constraint post_app_user_FK foreign key (poster_id) references app_users
);

create table post_votes (
	user_id 			int,
	post_id 			int,
	vote 				bit				not null,
	
	constraint post_votes_PK primary key (user_id, post_id),
	constraint post_votes_post_FK foreign key (post_id) references posts,
	constraint post_votes_app_user_FK foreign key (user_id) references app_users
);






-- Testing with inserts
--insert into user_roles (name) values
--('admin'),
--('default'),
--('dev');
--insert into app_users (username, password, first_name, last_name, email, role_id) values 
--('ngamble', 'pass', 'Nate', 'Gamble', 'nathan.gamble@revature.net', 3),
--('gandalf', 'mellon', 'Mithrandir', 'Greybeard', 'whatsthis@middleearth.com', 2);
--insert into messages (subject, body, creator_id) values
--('Real?', 'Are you really Gandalf from Middle Earth?', 1);
--insert into message_recipients values
--(1, 2);
--insert into boards (name, description, creator_id) values 
--('Middle Earth RPG', 'We are roleplayers who love the world of Middle Earth and create new stories that take place in the universe of Middle Earth.', 2);
--insert into board_moderators values
--(1, 2);
--insert into threads (title, board_id, creator_id) values 
--('The blue wizards', 1, 2);
--insert into thread_followers values 
--(2, 1),
--(1, 1);
--insert into thread_votes values
--(2, 1, B'1');
--insert into posts (body, replying_to, thread_id, poster_id) values 
--('The blue wizards were often overlooked, pushed to the side of history. But this is their tale.', 1, 1, 2);
--insert into post_votes values
--(2, 1, B'1');
--
--
--
--select * from user_roles ;
--select * from app_users ;
--select * from messages;
--select * from message_recipients;
--select * from boards;
--select * from board_moderators ;
--select * from threads;
--select * from thread_followers ;
--select * from thread_votes ;
--select * from posts;
--select * from post_votes;

