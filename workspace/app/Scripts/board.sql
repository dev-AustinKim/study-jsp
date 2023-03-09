use app;

create table tbl_board(
	board_id int unsigned auto_increment primary key,
	board_title varchar(500) not null,
	board_content varchar(500) not null,
	board_register_date datetime default now(),
	board_update_date datetime default now(),
	board_read_count int unsigned default 0,
	member_id int unsigned not null,
	constraint fk_board_member foreign key(member_id) 
	references tbl_member(member_id)
);

select * from tbl_board order by board_id desc;

update tbl_board
set board_read_count = 25
where board_id = 16535;

insert into tbl_board
(board_title, board_content, member_id)
values('테스트 제목1', '테스트 내용1', 5);
insert into tbl_board
(board_title, board_content, member_id)
values('테스트 제목2', '테스트 내용2', 5);
insert into tbl_board
(board_title, board_content, member_id)
values('테스트 제목3', '테스트 내용3', 5);
insert into tbl_board
(board_title, board_content, member_id)
values('테스트 제목4', '테스트 내용4', 5);
insert into tbl_board
(board_title, board_content, member_id)
values('테스트 제목5', '테스트 내용5', 5);
insert into tbl_board
(board_title, board_content, member_id)
values('한동석', '자바 재밌어', 5);

insert into tbl_board (board_title, board_content, member_id)
(select board_title, board_content, member_id from tbl_board);

create view view_board as
(
	select board_id, board_title, board_content, board_register_date, 
	board_update_date, board_read_count, member_name
	from tbl_member m join tbl_board b
	on m.member_id = b.member_id
);

select * from view_board;








