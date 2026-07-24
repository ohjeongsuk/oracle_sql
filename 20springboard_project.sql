CREATE TABLE board(
    boardNo NUMBER,
	title VARCHAR2(200) NOT NULL,
    content VARCHAR2(1000),
	writer VARCHAR2(100) NOT NULL,
	regDate DATE DEFAULT sysdate NOT NULL,
    
    CONSTRAINT pk_board_no PRIMARY KEY(boardNo)
);

create sequence board_seq
start with 1
increment by 1
NOCYCLE
CACHE 2;

INSERT INTO board(boardNo,title,content,writer) VALUES (board_seq.nextval,'title','content','zeus');
SELECT * FROM board;
rollback;

SELECT * FROM board WHERE boardno > 0 ORDER BY regdate desc;

UPDATE board SET title = 'aaa', content = 'aaa', writer = 'aaaaaa' WHERE boardno = 5;

-- jpa
-- jpaboard
drop table jpaboard;
CREATE TABLE jpaboard(
    board_no NUMBER,
	title VARCHAR2(200) NOT NULL,
    content VARCHAR2(1000),
	writer VARCHAR2(100) NOT NULL,
	reg_date DATE DEFAULT sysdate NOT NULL,
    CONSTRAINT pk_jpaboard_no PRIMARY KEY(board_no)
);

desc jpaboard;

create sequence jpaboard_seq
start with 1
increment by 1;


CREATE TABLE mybatisboard(
    board_no NUMBER,
    title VARCHAR2(100) NOT NULL,
    content VARCHAR2(500) NULL,
    writer VARCHAR2(50) NOT NULL,
    reg_date DATE DEFAULT SYSDATE,
    CONSTRAINT pk_mybatisboard_no PRIMARY KEY(board_no)
);

SELECT board_no, title, content, writer, reg_date 
FROM mybatisboard WHERE board_no > 0
AND title LIKE '%d%'
ORDER BY board_no DESC, reg_date DESC;

create sequence mybatisboard_seq
    start with 1
    increment by 1;
    
SELECT * FROM mybatisboard; 


CREATE TABLE mybatismember( 
    user_no NUMBER, 
    user_id VARCHAR2(50) NOT NULL, 
    user_pw VARCHAR2(50) NOT NULL, 
    user_name VARCHAR2(100) NOT NULL, 
    coin NUMBER(10) DEFAULT 0, 
    reg_date DATE DEFAULT SYSDATE, 
    upd_date DATE DEFAULT SYSDATE, 
    enabled CHAR(1) DEFAULT '1', 
    constraint pk_member_no PRIMARY KEY(user_no) 
);
-- 권한: 권한없음, 회원권한, 관리자권한
CREATE TABLE mybatismember_auth(
    user_no NUMBER NOT NULL,
    auth VARCHAR2(50) NOT NULL 
);

--
ALTER TABLE mybatismember_auth
    add CONSTRAINT fk_member_auth_no FOREIGN KEY(user_no)
    REFERENCES mybatismember(user_no) on DELETE CASCADE;

ALTER TABLE mybatismember_auth
drop CONSTRAINT fk_member_auth_no;


CREATE SEQUENCE MYBATISMEMBER_SEQ
    start with 1
    increment by 1;
 
SELECT * FROM mybatismember;
SELECT * FROM mybatismember_auth;

SELECT user_no,	user_id, user_pw, user_name, reg_date
		FROM mybatismember ORDER BY reg_date DESC;
        
UPDATE mybatismember SET user_name = 'jss' WHERE user_no = 2;
DELETE FROM mybatismember WHERE user_no = 8;
DELETE FROM mybatismember_auth WHERE user_no = 13;

rollback;

INSERT INTO mybatismember_auth VALUES (5,'ROLE_MEMBER');
INSERT INTO mybatismember_auth VALUES (5,'ROLE_ADMIN');
INSERT INTO mybatismember_auth VALUES (6,'ROLE_MEMBER');
COMMIT;

SELECT M.user_no, user_id, user_pw, user_name, reg_date, upd_date, auth
FROM mybatismember M INNER JOIN mybatismember_auth A ON	M.user_no = A.user_no
WHERE M.user_no = 5;

--******************************************************--

CREATE TABLE item( 
    item_id NUMBER(5),
    item_name VARCHAR2(20),
    price NUMBER(6),
    description VARCHAR2(50),
    picture_url VARCHAR2(200),
    CONSTRAINT pk_item_id PRIMARY KEY (item_id)
);

create sequence item_seq
start with 1
increment by 1;

select mybatismember_seq.NEXTVAL FROM DUAL;

INSERT INTO item(item_id, item_name, price, description, picture_url)
VALUES(item_seq.nextval, '홍길동', 1000, '고객의 그림', 'picture.jpg');

SELECT * FROM item;
rollback;

SELECT item_id,	item_name, price, description, picture_url
FROM item WHERE item_id = 2;

UPDATE item SET 
item_name = '고객2',
price = 2000, 
description = '고객그림2', 
picture_url = 'picture2.jpg'
WHERE item_id = 4;

DELETE FROM item WHERE item_id = 7;

SELECT item_id, item_name, price, description, picture_url 
FROM item WHERE item_id > 0 ORDER BY item_id DESC;

SELECT picture_url FROM item WHERE item_id = 5;

-- **********************************************

CREATE TABLE item2( 
    item_id NUMBER(5),
    item_name VARCHAR2(20),
    price NUMBER(6),
    description VARCHAR2(50),
    picture_url VARCHAR2(200),
    picture_url2 VARCHAR2(200),
    constraint pk_item2_id PRIMARY KEY (item_id)
); 

SELECT * FROM user_tables;
SELECT * FROM user_sequences;
SELECT * FROM user_constraints WHERE table_name = 'MYBATISMEMBER_AUTH';


create sequence item2_seq 
start with 1 
increment by 1;

SELECT * FROM item2;

CREATE TABLE securitymember( 
    user_no NUMBER, 
    user_id VARCHAR2(50) NOT NULL, 
    user_pw VARCHAR2(100) NOT NULL, 
    user_name VARCHAR2(100) NOT NULL, 
    coin NUMBER(10)DEFAULT 0, 
    reg_date DATE DEFAULT SYSDATE, 
    upd_date DATE DEFAULT SYSDATE, 
    enabled CHAR(1) DEFAULT '1', 
    constraint pk_securitymember_no PRIMARY KEY (user_no) 
);


CREATE TABLE securitymember_auth( 
    user_no NUMBER NOT NULL, 
    auth VARCHAR2(50) NOT NULL 
);

ALTER TABLE securitymember_auth 
ADD CONSTRAINT fk_securitymember_auth_no 
FOREIGN KEY (user_no) REFERENCES securitymember(user_no);

create sequence securitymember_seq 
start with 1 
increment by 1;


INSERT INTO securitymember(user_no, user_id, user_pw, user_name) VALUES 
(securitymember_seq.NEXTVAl, 
'member0','$2a$10$ohA1zfwg.el0qEbcUisAtOwfEM/Q0XikaQqzLF4RLvvlQBHjNhkUG','회원 0'); 
INSERT INTO securitymember(user_no, user_id, user_pw, user_name) VALUES 
(securitymember_seq.NEXTVAl, 
'member1','$2a$10$0YeNJZi0ZpHNJ962vF4KbOPbiiAW/FWaIOu8PTypWyzKnqmHDXEbe','회원 1'); 
INSERT INTO securitymember(user_no, user_id, user_pw, user_name) VALUES 
(securitymember_seq.NEXTVAl, 
'member2','$2a$10$q8SAiCddta4vsxze3klZKOWWLoo1qwgwTQ7MdBcN3ZV8oL435vszm','회원 2'); 
INSERT INTO securitymember(user_no, user_id, user_pw, user_name) VALUES 
(securitymember_seq.NEXTVAl, 
'admin3','$2a$10$tu7hm6.6uYkcvMi//ol9A.gLeyGFwezZmtlSnvgUeBhgZ1UaSN1CG','관리자 3'); 
INSERT INTO securitymember(user_no, user_id, user_pw, user_name) VALUES 
(securitymember_seq.NEXTVAl, 
'admin4','$2a$10$SAipGDDRGkCStRyrao.pPeseuMoeBFiifUH0RAFDyyb.p/WG59zuS','관리자 4'); 
 
INSERT INTO securitymember_auth (user_no, auth) VALUES ((SELECT user_no FROM securitymember 
WHERE user_id = 'member0'),'ROLE_MEMBER'); 
INSERT INTO securitymember_auth (user_no, auth) VALUES ((SELECT user_no FROM securitymember 
WHERE user_id = 'member1'),'ROLE_MEMBER'); 
INSERT INTO securitymember_auth (user_no, auth) VALUES ((SELECT user_no FROM securitymember 
WHERE user_id = 'member2'),'ROLE_MEMBER'); 
INSERT INTO securitymember_auth (user_no, auth) VALUES ((SELECT user_no FROM securitymember 
WHERE user_id = 'admin3'),'ROLE_ADMIN'); 
INSERT INTO securitymember_auth (user_no, auth) VALUES ((SELECT user_no FROM securitymember 
WHERE user_id = 'admin4'),'ROLE_ADMIN');
INSERT INTO securitymember_auth (user_no, auth) VALUES ((SELECT user_no FROM securitymember 
WHERE user_id = 'admin4'),'ROLE_MEMBER');

commit;

select * from securitymember;
select * from securitymember_auth;

SELECT m.user_no, m.user_id, m.user_pw, m.user_name, m.enabled, 
		m.reg_date, m.upd_date, a.auth
		FROM securitymember m INNER JOIN securitymember_auth a ON
		m.user_no = a.user_no
		WHERE m.user_id = 'admin4';

--  자동로그인기능
CREATE TABLE persistent_logins ( 
    username VARCHAR2(64) NOT NULL, 
    series VARCHAR2(64) NOT NULL, 
    token VARCHAR2(64) NOT NULL, 
    last_used DATE NOT NULL, 
    PRIMARY KEY (series) 
);

select * from persistent_logins;


















