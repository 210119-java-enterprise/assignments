
--Reset
drop table if exists post_votes;
drop table if exists posts;
drop table if exists thread_followers;
drop table if exists thread_votes;
drop table if exists threads;
drop table if exists board_moderators;
drop table if exists boards;
drop table if exists message_recipients;
drop table if exists messages;
DROP TABLE IF EXISTS app_users;
DROP TABLE IF EXISTS user_roles;

--Table Creation
CREATE TABLE user_roles (
	id 					serial CONSTRAINT user_roles_pk PRIMARY KEY,
	name				varchar(20) UNIQUE NOT NULL
);

CREATE TABLE app_users (
	id 					serial CONSTRAINT app_users_pk PRIMARY KEY, 
	username			varchar(25) UNIQUE NOT NULL, 
	password			varchar(256) NOT NULL, 
	first_name			varchar(25) NOT NULL, 
	last_name			varchar(25) NOT NULL, 
	email				varchar(256) UNIQUE NOT NULL, 
	register_datetime	timestamp DEFAULT current_timestamp, 
	is_active			boolean DEFAULT TRUE,
	role_id				int,
	
	FOREIGN KEY (role_id) REFERENCES user_roles(id)
);

create table messages (
	id 					serial constraint messages_pk primary key,
	subject 			varchar(35) not null ,
	body 				text not NULL,
	send_datetime 		timestamp default current_timestamp,
	creator_id 			int,
	
	foreign key (creator_id) references app_users(id)
);

create table message_reipients( 
	message_id			int,
	recipient_id 		int ,
	
	constraint message_receipts_pk primary key (message_id, recipient_id),
	foreign key (message_id) references messages(id),
	foreign key (recipient_id) references app_users(id)
);

create table boards (
	id					serial constraint boards_pk primary key, 
	name 				varchar(25) not null, 
	description 		text not null, 
	creator_id			int,
	
	foreign key (creator_id) references app_users(id)	
);

create table board_moderators ( 
	board_id			int, 
	moderator_id 		int,
	
	constraint board_moderators_pk primary key (board_id, moderator_id),
	foreign key (board_id) references boards(id), 
	foreign key (moderator_id) references app_users(id) 
);

create table threads( 
	id 					serial constraint threads_pk primary key,
	title				varchar(35) not null,
	created_time		timestamp default current_timestamp,
	up_votes			int default 0, 
	down_votes 			int default 0, 
	is_locked 			boolean default false,
	is_sticky 			boolean default false, 
	board_id 			int, 
	creator_id 			int, 
	
	foreign key (board_id) references boards(id), 
	foreign key (creator_id) references app_users(id) 
);

create table thread_votes ( 
	user_id 			int, 
	thread_id 			int, 
	vote				bit not null, 
	
	constraint thread_votes_pk primary key (user_id, thread_id),
	foreign key (user_id) references app_users(id), 
	foreign key (thread_id) references threads(id) 
);

create table thread_followers ( 
	user_id 			int, 
	thread_id			int,
	
	constraint thread_followers_pk primary key (user_id, thread_id),
	foreign key (user_id) references app_users(id), 
	foreign key (thread_id) references threads(id) 	
);

create table posts ( 
	id 					serial constraint posts_pk primary key,
	body 				varchar(2056) not null, 
	created_time 		timestamp default current_timestamp,
	up_votes			int default 0,
	down_votes			int default 0, 
	replying_to			int, 
	thread_id			int, 
	poster_id			int,
	
	foreign key (poster_id) references app_users(id), 
	foreign key (thread_id) references threads(id), 
	foreign key (replying_to) references posts(id)
);

create table post_votes( 
	user_id 			int, 
	post_id 			int, 
	vote				bit not null, 
	
	constraint post_votes_pk primary key (user_id, post_id),
	foreign key (user_id) references app_users(id), 
	foreign key (post_id) references posts(id)
);

commit;

