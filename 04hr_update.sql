-- insert문
-- INSERT INTO table_name (column_value, …) VALUES(column_value, …)
-- 주의: 컬럼명,컬럼명갯수와 values갯수가 맞아야한다.
-- 컬럼명타입과 values타입이 같아야한다.
-- not null, primary key 제약조건을 체크할것

CREATE TABLE DEPT(
    DEPTNO NUMBER(2) PRIMARY KEY,
    DNAME VARCHAR2(14),
    LOC VARCHAR2(13) NOT NULL
);

-- 칼럼 DEPTNO에 10번 부서, DNAME에는 ‘ACCOUNTING’을, LOC에는 ‘NEW YORK’을 추가하자
INSERT INTO dept(deptno,dname,loc) VALUES (10,'accounting','new york');
INSERT INTO dept VALUES (11,'accounting2','new york2');
INSERT INTO dept VALUES (13,null,'new york4');
INSERT INTO dept VALUES (14,'','new york5');
INSERT INTO dept(dname,loc) VALUES ('accounting3','new york3');

SELECT * FROM dept;
-- drop table tb_customer;
 
SELECT * FROM TAB WHERE tname = 'dept';

-- 컬럼 deptno 사이즈 4로변경, dname을 not null로 변경하세요.
alter table dept
    modify(deptno number(4),dname varchar2(30) not null);

update dept set dname='임시값'where dname is null;

CREATE TABLE tb_customer(
    CUSTOMER_CD NUMBER(10) PRIMARY KEY,
    CUSTOMER_NM VARCHAR2(20) NOT NULL,
    MW_FLG CHAR(2) NOT NULL,
    BIRTH_DAY DATE NOT NULL,
    PHONE_NUMBER VARCHAR2(20),
    EMAIL VARCHAR2(20),
    TOTAL_POINT NUMBER(10) NOT NULL,
    REG_DTTM DATE NOT NULL
);

SELECT * FROM tb_customer;

INSERT INTO tb_customer VALUES (
    '2017042', '강원진', 'M',  DATE '1981-06-03', '010-8202-8790', 'wjgang@navi.com', 280300, TIMESTAMP '2017-01-23 13:24:32'
);
INSERT INTO TB_CUSTOMER VALUES (
    '2017053', '나경숙', 'W',  DATE '1989-12-25', '010-4509-0043', 'ksna@boram.co.kr', 4500, TIMESTAMP '2017-02-10 18:09:30'
);
INSERT INTO TB_CUSTOMER VALUES (
    '2017108', '박승대', 'M', DATE '1971-04-30' , ' NULL', 'sdpark@haso.com', 23450, TIMESTAMP '2017-05-08 20:34:50'
);

-- update
-- UPDATE table_name
-- SET column_name1 = value1, column_name2 = value2, … WHERE conditions;

-- employees 테이블을 emp 복사
CREATE TABLE emp2
as
SELECT * FROM employees;

desc emp;
SELECT * FROM emp;

-- 제약조건넣고 해제하는기능
-- emp employee_id pk 제약조건입력
alter table emp
    add CONSTRAINT pk_emp_id PRIMARY KEY(employee_id);

alter table emp
    DROP CONSTRAINT pk_emp_id; 

-- phone number not null 제약조건
alter TABLE emp
    MODIFY phone_number varchar(20) CONSTRAINT nn_emp_phone NOT NULL;

alter TABLE emp
    DROP CONSTRAINT nn_emp_phone;

SELECT * FROM user_constraints WHERE table_name = 'EMP';


-- 모든 사원(emp)의 부서번호를 30번으로 수정하자.
desc emp;
UPDATE emp SET department_id = 30;
select department_id from emp;

-- DML (select,delate,update,insert) => 롤백,커밋이 대상이 된다.
commit;
rollback;

-- 모든사원의(emp) 급여를 10% 인상한다.
desc emp;
SELECT salary FROM emp2;
UPDATE emp SET salary = salary * 1.1;


-- salary_copy 컬럼을 생성을 하고, salary를 복사를 진행한다.
ALTER TABLE emp
    add salary_copy number(8,2);
    
UPDATE emp SET salary_copy = salary;

-- emp에서 입사일을 오늘날짜 수정(오라클 오늘날짜: sysdate)
UPDATE emp SET HIRE_DATE = sysdate;

-- emp2테이블 부서번호가 10번 사원의 부서번호를 30번으로 수정
UPDATE emp2 SET department_id = 30 WHERE department_id = 10;

-- emp2테이블 급여가 3000달러 이상인 사원만 급여를 10% 인상
UPDATE emp2 SET salary = salary * 1.1 where salary >= 3000;

-- 2007년에 입사한 사원의 입사일을 오늘로 수정한다.
-- substr(03/06/17, 1,2)
SELECT * FROM emp2 WHERE last_name = 'Russell';
UPDATE emp2 SET hire_date = sysdate WHERE substr(hire_date,1,2) = '07';

-- LAST_NAME이 Russell인 사원의 급여를 17000로, 커미션 비율이 0.45로 인상된다.
UPDATE emp2 SET salary = 17000, commission_pct = 0.45 where last_name = 'Russell';



