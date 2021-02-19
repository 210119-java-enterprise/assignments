drop table if exists post_votes cascade;
drop table if exists posts cascade;
drop table if exists thread_votes cascade;
drop table if exists thread_followers cascade;
drop table if exists threads cascade;
drop table if exists message_recipients cascade;
drop table if exists messages cascade;
drop table if exists board_mods cascade;
drop table if exists boards cascade;
drop table if exists app_users cascade;
drop table if exists user_roles cascade;









create table user_roles(
	id serial,
	name varchar(20) unique not null,

	constraint roles_pk
	primary key (id)
);

create table app_users(
	id serial,
	username varchar(25) unique not null,	
	password varchar(25) not null,
	first_name varchar(25) not null,
	last_name varchar(25) not null,
	registration_datetime timestamp default current_timestamp,
	is_active boolean default false,
	email varchar(256) unique not null,
	role_id int not null,


	constraint users_pk
    primary key (id),

    constraint users_role_fk
    foreign key (role_id)
    references user_roles(id)
);





create table boards(
	id serial,
	name varchar(25)  not null,
	description varchar(512) not null,
	creator_id int not null,

	constraint board_pk
	primary key (id)

);





create table messages(
    id serial,
    creator_id int not null,
    subject varchar(35) not null,
    body text not null,
    send_datetime timestamp default current_timestamp,

	constraint messages_pk
    primary key (id),

    constraint users_messages_fk
    foreign key (creator_id)
    references app_users(id)


);


create table message_recipients(
    message_id int not null,
    recipient_id int not null,
    unique(message_id, recipient_id),

    constraint messages_message_fk
    Foreign key (message_id)
    references messages(id),

    constraint users_recipients_fk
    foreign key (recipient_id)
    references app_users(id)
);





create table board_moderators(
	moderator_id int not null,
	board_id int not null,
    unique(moderator_id, board_id),

    constraint users_mod_fk
    Foreign key (moderator_id)
    references app_users(id),

    constraint board_mod_fk
    foreign key (board_id)
    references boards(id)
);






create table threads(
	id serial,
	created_time timestamp default current_timestamp,
	title varchar(256) not null,
	up_votes int default 0,
    down_votes int default 0,
	is_locked boolean default false,
	is_sticky boolean default false,
	creator_id int not null,
	board_id int not null,
	

	constraint thread_pk
	primary key (id),

	constraint thread_users_fk
	foreign key (creator_id)
	references app_users(id),

	constraint thread_board_fk
	foreign key (board_id)
	references boards(id)

);


create table thread_votes(
	user_id int not null,
	thread_id int not null,
	vote bit not null,
    unique(user_id, thread_id),

    constraint users_thread_vote_fk
    Foreign key (user_id)
    references app_users(id),

    constraint threads_voted_fk
    foreign key (thread_id)
    references threads(id)
);

create table thread_followers(
	user_id int not null,
	thread_id int not null,
    unique(user_id, thread_id),

    constraint users_following_fk
    foreign key (user_id)
    references app_users(id),

    constraint threads_followed_fk
    foreign key (thread_id)
    references threads(id)
);




create table posts(
	id serial,
	thread_id int not null,
	poster_id int not null,
	replying_to int,
	body varchar(2056) not null,
	up_votes int default 0,
	down_votes int default 0,
	created_time timestamp default current_timestamp,

	constraint post_pk
	primary key (id),

	constraint post_users_fk
	foreign key (poster_id)
	references app_users(id),

	constraint post_reply_fk
    foreign key (replying_to)
    references posts(id),

	constraint post_thread_fk
	foreign key (thread_id)
	references threads(id)

);




create table post_votes(
	user_id int not null,
	post_id int not null,
	vote bit not null,
    unique(user_id, post_id),

    constraint users_post_vote_fk
    Foreign key (user_id)
    references app_users(id),

    constraint posts_voted_fk
    foreign key (post_id)
    references posts(id)
);