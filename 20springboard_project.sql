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

SELECT * FROM user_tables;
SELECT * FROM user_sequences;
SELECT * FROM user_constraints WHERE table_name = 'MYBATISMEMBER_AUTH';

CREATE SEQUENCE MYBATISMEMBER_SEQ
    start with 1
    increment by 1;
 
select mybatismember_seq.NEXTVAL FROM DUAL;

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
