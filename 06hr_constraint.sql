-- 무결성 제약조건(not null, unique, primary key, check, foreign key)

-- 1.not null
-- 2.unique 제약조건 == primary key 제약조건과 똑같다.(다른것: null 허용)

-- emp02 생성한다(employees복사)
CREATE TABLE emp02
as
SELECT * FROM employees;

desc emp02;
-- 제약조건설정 employee_id primary key 제약조건을 설정한다.
-- 제약조건설정 phone_number unique 제약조건을 설정한다.
ALTER TABLE emp02
    add CONSTRAINT pk_emp02_id primary key(employee_id);
    
ALTER TABLE emp02
    add CONSTRAINT uk_emp02_phone UNIQUE(phone_number);
    
-- phone_number not null 제약조건을 설정한다
ALTER TABLE emp02
    MODIFY phone_number VARCHAR2(20) NOT NULL;

-- phone_number not null 제약조건을 삭제
ALTER TABLE emp02
    drop CONSTRAINT nn_emp02_phone;

-- 데이터 딕셔너리(dba_, all_, user_ : user_tables, user_constraints, user_cons_columns)
SELECT * FROM user_constraints WHERE table_name = 'EMP02';
SELECT * FROM user_cons_columns WHERE table_name = 'EMP02';
SELECT * FROM user_tables;

-- 테이블 emp03 생성
CREATE TABLE emp03 (
    empno NUMBER(4),
    empname VARCHAR2(20) NOT NULL,
    job VARCHAR2(20),
    CONSTRAINT uk_emp03_no UNIQUE(empno)
);

INSERT INTO emp03 VALUES (null,'홍길동','programmer');
INSERT INTO emp03 VALUES (1234,'홍길동','programmer');
INSERT INTO emp03 VALUES (null,'홍길동2','db developer');
DELETE FROM emp03 WHERE job = 'db developer';
SELECT * FROM emp03;

UPDATE emp03 SET empno = 0 WHERE empno is null;

ALTER TABLE emp03
    MODIFY empno NUMBER(4) NOT NULL;

-- 3. primary key(null 허용없음, 중복허용하지 않음) == 자동 인덱스설정

-- 4. foreign key(참조 무결성 제약조건)

-- 테이블설계 부서(dept) 설계테이블(부서번호:deptno pk,부서명:deptname unique, 지역명:deptloc not null)
-- 제약조건이름(pk:pk_table_colome ,not null, unique:uk)

drop table emp;
SELECT * FROM user_tables where table_name = 'EMP';

CREATE TABLE dept(
    deptno NUMBER(4),
    deptname VARCHAR2(20),
    deptloc VARCHAR2(20) NOT NULL,
    CONSTRAINT pk_dept_no PRIMARY KEY(deptno),
    CONSTRAINT uk_dept_name UNIQUE(deptname)
);
INSERT INTO dept VALUES (10,'관리과','서울');
INSERT INTO dept VALUES (20,'관리과2','서울2');
INSERT INTO dept VALUES (30,'관리과3','서울3');
INSERT INTO dept VALUES (40,'관리과4','서울4');
SELECT * FROM dept;

DELETE from dept WHERE deptno = 40;
-- 사원테이블(emp) dept 참조테이블로 설정(사원번호 empid, 사원명 empname, 직급 job, 급여 salary,부서번호 deptno(FK))
CREATE TABLE emp(
    empid NUMBER(4),
    empname CHAR(5) NOT NULL,
    job VARCHAR2(20),
    salary NUMBER(20),
    deptno NUMBER(4),
    CONSTRAINT pk_emp_id PRIMARY KEY(empid),
    CONSTRAINT fk_emp_dept_no FOREIGN KEY(deptno) REFERENCES dept(deptno)
);

-- 제약조건수정(fk_emp_dept_no 삭제후, 다시 재설정)
-- ON DELETE CASCADE: on update cascade(없다-> 트리거를 통해서 처리해야된다.)
ALTER TABLE emp
    drop CONSTRAINT fk_emp_dept_no;
alter table emp
    add CONSTRAINT fk_emp_dept_no FOREIGN KEY(deptno) REFERENCES dept(deptno) ON DELETE set null;

INSERT INTO emp VALUES (1,'js','부장',10000000,null);
INSERT INTO emp VALUES (2,'js2',NULL,NULL,10);
UPDATE emp SET deptno = 50 WHERE empid = 1;
SELECT * FROM emp;
DELETE FROM emp WHERE empid = 1; 

-- check 제약조건

-- emp 테이블에 gender char(1) default 'M' 추가하시오
ALTER table emp
    add gender char(1) default 'M';
SELECT * FROM emp;

-- emp 테이블에 gender check 제약조건을 추가(M, F, O)
ALTER table emp
    add CONSTRAINT ck_emp_gender check(gender in('M','F','O'));

desc emp;
SELECT * FROM user_constraints WHERE table_name = 'EMP';
SELECT * FROM user_cons_columns WHERE table_name = 'EMP';

-- emp 테이블에 gender check 제약조건이 작동되는지 확인할것.
SELECT * FROM emp;
-- check 'A' 제약조건에 위배가 된다.
INSERT INTO emp VALUES (3,'js3','부장3',10000000,null,'A');

-- emp 테이블에 score number(4) 여기 체크제약조건을 걸어주시오(0~100)
alter table emp
    add score number(4) CONSTRAINT ck_emp_score CHECK(score BETWEEN 0 and 100);

-- NO ACTION : 참조 테이블에 변화가 있어도 기본 테이블에는 아무 조취를 취하지 않는다.
-- CASCADE : 참조 테이블의 튜플이 삭제되면 기본 테이블의 관련 튜플도 삭제되고, 속성이 변경되면 관련 튜플의 속성 값도 모두 변경된다.
-- SET NULL : 참조 테이블에 변화가 있으면 기본 테이블의관련 튜플의 속성 값을 NULL로 변경한다.
-- SET DEFAULT : 참조 테이블에 변화가 있으면 기본 테이블의 관련 튜플의 속성 값을 기본값으로 변경한다.
-- RESTRICT : 참조 테이블에 변화(삭제,수정)가 있으면 , 기본테이블경우 데이터 삭제나 수정 불가
ALTER TABLE emp
    drop CONSTRAINT fk_emp_dept_no;
alter table emp
    add CONSTRAINT fk_emp_dept_no FOREIGN KEY(deptno) REFERENCES dept(deptno) ON DELETE set null;
    
INSERT INTO emp VALUES (5,'js5','부장5',10000000,40,'F',100);
DELETE FROM dept WHERE deptno = 40;

DROP table lend_return;
DROP table video;
desc lend_return;
SELECT * FROM v_gogek,video,lend_return;

-- 고객,비디오,대여 테이블

CREATE TABLE v_gogek(
    g_code NUMBER(5),
    g_name VARCHAR2(20) not null,
    g_age NUMBER(3),
    g_addr VARCHAR2(50),
    g_tel VARCHAR2(20),
    CONSTRAINT pk_gogek_code PRIMARY KEY(g_code)
);

CREATE TABLE video (
    v_code NUMBER(5),
    v_title VARCHAR2(50) not null,
    v_genre VARCHAR2(30),
    v_pay NUMBER(7) not null,
    v_lend_state NUMBER(1),
    v_make_company VARCHAR2(50),
    v_make_date DATE,
    v_view_age NUMBER(1),
    CONSTRAINT pk_video_code PRIMARY KEY(v_code)
);

CREATE TABLE lend_return(
    lr_code NUMBER(5),
    g_code NUMBER(5) not null,
    v_code NUMBER(5) not null,
    l_date DATE,
    r_plan_date DATE,
    l_total_pay NUMBER(7),
    CONSTRAINT pk_lr_code PRIMARY KEY(lr_code),
    CONSTRAINT fk_lr_gogek_code FOREIGN KEY(g_code) REFERENCES v_gogek(g_code) ON DELETE set null,
    CONSTRAINT fk_lr_video_code FOREIGN KEY(v_code) REFERENCES video(v_code) ON DELETE set null
);












