-- 인덱스 설정
-- 장점: 검색 속도가 빨라진다. 
--       시스템에 걸리는 부하를 줄여서 시스템 전체 성능을 향상시킨다. 
-- 단점: 인덱스를 위한 추가적인 공간이 필요하다. 
--       인덱스를 생성하는데 시간이 걸린다. 
--       데이터의 변경 작업(INSERT/UPDATE/DELETE)이 자주 일어날 경우에는 오히려 성능이 저하된다. 

-- emp01 테이블생성
DROP TABLE emp01;

CREATE TABLE emp01
as
SELECT * FROM employees;

-- 인덱스테이블 내용을 조사(데이터 딕셔너리 확인 체크)
SELECT * FROM user_indexes WHERE table_name = 'EMP01';

-- 인덱스 성능을 체크
SELECT * FROM emp01;

SELECT * FROM emp01 WHERE employee_id = 100;

-- emp01 employee_id pk 설정
ALTER TABLE emp01
    add CONSTRAINT pk_emp01_id PRIMARY KEY(employee_id);

-- first_name 성능체크
SELECT * FROM emp01 WHERE email like 'A%';

-- email 인덱스 설정
-- CREATE UNIQUE INDEX index_name 
-- ON table_name (column_name); 

CREATE UNIQUE INDEX ix_emp01_email
ON emp01(email);

-- 인덱스 삭제기능
-- DROP INDEX index_name; 
DROP INDEX ix_emp01_email;

-- 인덱스 생성시 고려사항
-- 일반적으로 테이블 전체 로우 수의 15%이하의 데이터를 조회할 때 인덱스를 생성한다. 
-- 테이블 건수가 적다면 굳이 인덱스를 만들 필요가 없다. 
-- NULL을 많이 포함된 컬럼은 인덱스 컬럼으로 만들기 적당치 않다. 
-- 테이블에 만들 수 있는 인덱스 수의 제한은 없으나, 너무 많이 만들면 오히려 성능 저하가 발생한다.

