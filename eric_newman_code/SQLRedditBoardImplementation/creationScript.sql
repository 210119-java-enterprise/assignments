create table user_roles (
	id	serial,
	name	varchar(20) unique not null,
	constraint user_roles_pk primary key (id)
);

create table app_users (
	id		serial,
	username	varchar(25) unique not null,
	password	varchar(256)	not null,
	first_name	varchar(25) not null,
	last_name	varchar(25) not null,
	email	    varchar(256) unique not null,
	register_datetime timestamp default CURRENT_TIMESTAMP,
	is_active   boolean default false,
	role_id		int not null,
	constraint app_users_pk primary key (id),
	constraint app_user_role_fk foreign key (role_id) references user_roles(id)
);

create table messages (
	id	serial,
	subject varchar(35) not null,
	body text not null, 
	send_datetime timestamp default CURRENT_TIMESTAMP,
	creator_id int,
	constraint messages_pk primary key (id),
	constraint messages_creator_fk foreign key (creator_id) references app_users(id)
);
create table message_recipients (
	message_id	int,
	recipient_id	int,
	constraint msg_recipients_msg_pk primary key (message_id, recipient_id),
	constraint msg_recipients_msg_fk foreign key (message_id) references messages(id),
	constraint msg_recipients_user_fk foreign key (recipient_id) references app_users(id)
);
create table boards (
	id	serial,
	name varchar(35) not null,
	description text not null, 
	creator_id int,
	constraint boards_pk primary key (id),
	constraint boards_creator_fk foreign key (creator_id) references app_users(id)
);
create table board_moderators (
	board_id	int,
	moderator_id	int,
	constraint board_moderators_pk primary key (board_id, moderator_id),
	constraint board_moderators_board_fk foreign key (board_id) references boards(id),
	constraint board_moderators_user_fk foreign key (moderator_id) references app_users(id)
);
create table threads (
	id		serial,
	title	varchar(35) not null,
	created_time	timestamp	default CURRENT_TIMESTAMP,
	up_votes	int default 0,
	down_votes	int default 0,
	is_locked boolean default false,
	is_sticky boolean default false,
	is_active   boolean default false,
	board_id		int,
	creator_id      int,
	constraint threads_pk primary key (id),
	constraint thread_board_fk foreign key (board_id) references boards(id),
	constraint thread_creator_fk foreign key (creator_id) references app_users(id)

);
create table thread_followers (
	user_id	int,
	thread_id	int,
	constraint thread_followers_pk primary key (user_id, thread_id),
	constraint thread_followers_user_fk foreign key (user_id) references app_users(id),
	constraint thread_followers_thread_fk foreign key (thread_id) references threads(id)
);
create table thread_votes (
	user_id	int,
	thread_id	int,
	vote bit not null,
	constraint thread_votes_pk primary key (user_id, thread_id),
	constraint thread_votes_user_fk foreign key (user_id) references app_users(id),
	constraint thread_votes_thread_fk foreign key (thread_id) references threads(id)

);
create table posts (
	id		serial,
	body varchar(2056) not null,
	created_time	timestamp	default CURRENT_TIMESTAMP,
	up_votes	int default 0,
	down_votes	int default 0,
	replying_to		int,
	thread_id		int,
	poster_id      int,
	constraint posts_pk primary key (id),
	constraint posts_replypost_fk foreign key (replying_to) references posts(id),
	constraint posts_thread_fk foreign key (thread_id) references threads(id),
	constraint posts_user_fk foreign key (poster_id) references app_users(id)
);
create table post_votes (
	user_id	int,
	post_id	int,
	vote bit not null,
	constraint post_votes_pk primary key (user_id, post_id),
	constraint post_votes_user_fk foreign key (user_id) references app_users(id),
	constraint post_votes_post_fk foreign key (post_id) references posts(id)

);










