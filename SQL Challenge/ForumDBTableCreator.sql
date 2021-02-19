/*
 *  user_roles
 * 		- id serial PK
 * 		- name varchar(20) unique not null
	app_users
		- id serial (auto incrementing) PK
		- username varchar(25) unique not null
		- password varchar(256) not null
		- first_name varchar(25) not null
		- last_name varchar(25) not null
		- email varchar(256) unique not null
		- register_datetime timestamp default(now)
		- is_active boolean default(false)
		- role_id int FK is the id PK of user_roles
	messages
		- id serial PK
		- subject varchar(35) not null
		- body text not null
		- send_datetime timestamp default(now)
		- creator_id int FK is the id PK of app_users
	message_recipients
		- message_id int PK/FK is the id PK of messages
		- recipient_id int PK/FK is the id PK of app_users
	boards
		- id serial PK
		- name varchar(35) not null
		- description text not null
		- creator_id int FK is the id PK of app_users
	board_moderators
		- board_id int PK/FK is the id PK of boards
		- moderator_id int PK/FK is the id PK of app_users
	threads
		- id serial PK
		- title varchar(35) not null
		- created_time timestamp default(now)
		- up_votes int default(0)
		- down_votes int default(0)
		- is_locked boolean default(false)
		- is_sticky boolean default(false)
		- board_id int FK is the id PK of boards
		- creator_id int FK is the id PK of app_users
	thread_followers
		- user_id int PK/FK is the id PK of app_users
		- thread_id int PK/FK is the id PK of threads
	thread_votes
		- user_id int PK/FK is the id PK of app_users
		- thread_id int PK/FK is the id PK of threads
		- vote bit not null
	posts
		- id serial PK
		- body varchar(2056) not null
		- created_time timestamp default(now)
		- up_votes int default(0)
		- down_votes int default(0)
		- replying_to int FK is the id PK of app_users
		- thread_id int FK is the id PK of threads
		- poster_id int FK is the id PK of app_users
	post_votes
		- user_id int PK/FK is the id PK of app_users
		- post_id int PK/FK is the id PK of posts
		- vote bit not null
	 
*/
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



create table user_roles(

  		 id serial,
  		 name varchar(20) unique not null,
  		 
  		 constraint user_roles_pk primary key (id)
  		 
);
create table app_users(
		 id serial,
		 username varchar(25) unique not null,
		 password varchar(256) not null,
		 first_name varchar(25) not null,
		 last_name varchar(25) not null,
		 email varchar(256) unique not null,
		 register_datetime timestamp default CURRENT_TIMESTAMP,
		 is_active boolean default(false),
		 role_id int,
		
		constraint app_users_pk primary key (id),
		constraint app_users_fk foreign key (role_id) references user_roles
);
create table messages(
		 id serial,
		 subject varchar(35) not null,
		 body text not null,
		 send_datetime timestamp default CURRENT_TIMESTAMP,
		 creator_id int,
		
		constraint messages_pk primary key (id),
		constraint messages_fk foreign key (creator_id) references app_users
);
create table message_recipients(
		 message_id int,
		 recipient_id int,
		 
		 constraint message_recipients_ck primary key (message_id, recipient_id),
		 constraint message_recipients_fk1 foreign key (message_id) references messages,
		 constraint message_recipients_fk2 foreign key (recipient_id) references app_users
);
create table boards(
		 id serial,
		 name varchar(35) not null,
		 description text not null,
		 creator_id int,
		 
		 constraint boards_pk primary key (id),
		 constraint boards_fk foreign key (creator_id) references app_users

);
create table board_moderators(
		 board_id int,
		 moderator_id int,
		
		constraint board_moderators_ck primary key (board_id, moderator_id),
		constraint board_moderators_fk1 foreign key (board_id) references boards,
		constraint board_moderators_fk2 foreign key (moderator_id) references app_users
);
create table threads(
		 id serial,
		 title varchar(35) not null,
		 created_time timestamp default CURRENT_TIMESTAMP,
		 up_votes int default(0),
		 down_votes int default(0),
		 is_locked boolean default(false),
		 is_sticky boolean default(false),
		 board_id int,
		 creator_id int,
		
		constraint threads_pk primary key (id),
		constraint threads_fk1 foreign key (board_id) references boards,
		constraint threads_fk2 foreign key (creator_id) references app_users
);
create table thread_followers(
		 user_id int,
		 thread_id int,
		
		constraint thread_followers_ck primary key (user_id, thread_id),
		constraint thread_followers_fk1 foreign key (user_id) references app_users,
		constraint thread_followers_fk2 foreign key (thread_id) references threads

);
create table thread_votes(
		 user_id int,
		 thread_id int,
		 vote bit not null,
		
		constraint thread_votes_ck primary key (user_id, thread_id),
		constraint thread_votes_fk1 foreign key (user_id) references app_users,
		constraint thread_votes_fk2 foreign key (thread_id) references threads

);
create table posts(
		 id serial,
		 body varchar(2056) not null,
		 created_time timestamp default CURRENT_TIMESTAMP,
		 up_votes int default(0),
		 down_votes int default(0),
		 replying_to int,
		 thread_id int,
		 poster_id int,
		
		constraint posts_pk primary key (id),
		constraint posts_fk1 foreign key (replying_to) references posts,
		constraint posts_fk2 foreign key (thread_id) references threads,
		constraint posts_fk3 foreign key (poster_id) references app_users
);
create table post_votes(
		 user_id int,
		 post_id int,
		 vote bit not null,
		
		constraint post_votes_ck primary key (user_id, post_id),
		constraint post_votes_fk1 foreign key (user_id) references app_users,
		constraint post_votes_fk2 foreign key (post_id) references posts
);

commit;