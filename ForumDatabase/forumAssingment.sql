create table user_roles (
                            id		serial,
                            name	varchar(25) unique not null,

                            constraint user_roles_pk
                                primary key (id)
);

create table app_users (
                           user_id				serial,
                           username				varchar(25) unique not null,
                           password				varchar(256)	not null,
                           first_name			varchar(25) not null,
                           last_name			varchar(25) not null,
                           email				varchar(256) unique not null, 
                           register_datetime	timestamp default current_timestamp,
                           is_active			boolean default false,
                           role_id 				int,

                           constraint app_users_pk
                               primary key (user_id),

                           constraint app_user_role_fk
                               foreign key (role_id)
                                   references user_roles
);


create table boards (
							id				serial,
							name			varchar(35) not null,
							description		text not null,
							creator_id 		int,
							
							constraint boards_pk
								primary key (id),
								
							constraint boards_fk
								foreign key (creator_id)
									references app_users
)

create table board_moderators (
							board_id 		int,
							moderator_id	int,
							
							constraint board_moderators_pk
								primary key (board_id, moderator_id),
							
							constraint board_id_fk
								foreign key (board_id)
									references boards,
								
							constraint moderator_id_fk
								foreign key (moderator_id)
									references app_users
)

create table threads (
							id				serial,
							title			varchar(35) not null,
							created_time	timestamp default current_timestamp,
							up_votes		int default 0,
							down_votes		int default 0,
							is_locked		boolean default false,
							is_sticky		boolean default false,
							board_id		int,
							creator_id		int,
							
							constraint threads_pk 
								primary key (id),
								
							constraint board_id_fk
								foreign key (board_id)
									references boards,
									
							constraint creator_id_fk
								foreign key (creator_id)
									references app_users
)

create table thread_followers (
							user_id			int,
							thread_id		int,
							
							constraint thread_followers_pk
								primary key (user_id, thread_id),
								
							constraint user_id_fk
								foreign key(user_id)
									references app_users,
									
							constraint thread_id_fk
								foreign key (thread_id)
									references threads
)

create table thread_votes (
							user_id 		int,
							thread_id		int,
							vote			bit not null,
							
							constraint thread_votes_pk
								primary key (user_id, thread_id),
								
							constraint user_id_fk
								foreign key (user_id)
									references app_users,
									
							constraint thread_id_fk
								foreign key (thread_id)
									references threads
)

create table posts (
							id				serial,
							body			varchar(2056) not null,
							created_time	timestamp default current_timestamp,
							up_votes		int default 0,
							down_votes		int default 0,
							replying_to		int,
							thread_id		int,
							poster_id		int,
							
							constraint posts_pk
								primary key (id),
								
							constraint replying_to_fk
								foreign key (replying_to)
									references posts,
							
							constraint thread_id_fk
								foreign key (thread_id)
									references threads,
									
							constraint poster_id_fk
								foreign key (poster_id)
									references app_users
							
)

create table post_votes (
							user_id			int,
							post_id			int,
							vote			bit not null,
						
						constraint post_votes_pk
							primary key (user_id, post_id),
							
						constraint user_id_fk
							foreign key (user_id)
								references app_users,
								
						constraint post_id_fk
							foreign key (post_id)
								references posts	
)


create table messages (
							id				serial,
							subject			varchar(35) not null,
							body 			text not null,
							send_datetime	timestamp default current_timestamp,
							creator_id		int,
							
							constraint messages_pk
								primary key	(id),
								
							constraint messages_fk
								foreign key (creator_id)
									references app_users	
)

create table message_recipients(
							message_id		int,
							recipient_id	int,
							
							constraint message_recipients_pk
								primary key (message_id, recipient_id),
								
							constraint message_id_fk
								foreign key (message_id)
									references messages,
									
							constraint recipient_id_pk
								foreign key (recipient_id)
									references app_users
)


COMMIT;