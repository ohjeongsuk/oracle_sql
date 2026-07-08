-- select문 기능

--１．departments　클래스에　몇개의　객체가　있는지　조사
select * from departments;

--　<문제> EMPLOYEES 테이블의 모든 내용 출력
select * from employees;

-- 2. departments 테이블에서 department_id, department_name 항목만 보고싶다.
select department_id, department_name from departments;

-- <문제> 사원의 이름과 급여와 입사일자 만을 출력하는 SQL 문을 작성해보자. 
--힌트 : 사원 정보가 저장된 테이블은 EMPLOYEES이고, 사원이름 칼럼은 FIRST_NAME, LAST_NAME과, 급여 칼럼은 SALARY, 입사일자 칼럼은 HIRE_DATE이다.
select FIRST_NAME, LAST_NAME, SALARY, HIRE_DATE from employees;

-- 3.컬럼이름 별칭부치기
select FIRST_NAME as a, LAST_NAME as b, SALARY as c, HIRE_DATE from employees;
select FIRST_NAME 이름, LAST_NAME b, SALARY c, HIRE_DATE from employees;

-- 연결연산자(concatenation): 자바에서 문자열+숫자
SELECT * FROM employees;
-- 사원번호는 100이고 사원의 이름은 Stenven king 이메일주소는 sking입니다.
SELECT '사원번호는'|| employee_id ||'이고 사원의 이름은 '|| first_name || last_name ||'입니다' as info FROM employees;

-- 5. 중복된 데이터를 한번씩만 출력하는기능(DISTINCT)
SELECT DISTINCT job_id FROM employees;

-- <문제>직원(employees)들이 어떤 부서에 소속되어 있는지 소속 부서번호(DEPARTMENT_ID) 출력하되 중복되지 않고 한번씩 출력하는 쿼리문을 작성하자.
SELECT DISTINCT department_id FROM employees;

-- 6. 조건문(if => where)
-- employees 급여를 3000 이상 받는 직원을 대상
SELECT first_name, salary FROM employees WHERE salary >= 3000;

-- <문제> EMPLOYEES 테이블에서 부서번호가 110번인 직원에 관한 모든 정보만 출력하라.
SELECT * FROM employees WHERE department_id = 110;

-- <문제> EMPLOYEES 테이블에서 급여가 5000미만이 되는 직원의 정보 중에서 사번과 이름, 급여를 출력하라. 
SELECT job_id,first_name,last_name,salary FROM employees WHERE salary < 5000;

-- <예> 이름(FIRST_NAME)이 'Lex'인 직원 
SELECT * FROM employees WHERE first_name = 'Lex';

-- <문제> 이름이 John인 사람의 직원번호와 직원명과 직급을 출력하라.
SELECT employee_id,first_name,last_name,job_id FROM employees WHERE first_name = 'John';

-- 8.날짜 데이터 조회( >, < )
-- <예> 2008년 이후에 입사한 직원 
SELECT * FROM employees WHERE hire_date > '2008/01/01';

-- 9.AND =>  BETWEEN AND 연산자, OR, IN, NOT조건 
-- <예> 부서번호가 100번이고 직급이 FI_MGR인 직원
SELECT * FROM employees WHERE department_id = 100 AND job_id = 'FI_MGR';

-- <문제>급여가 5000에서 10000이하 직원 정보 출력
SELECT * FROM employees WHERE salary >= 5000 AND salary <= 10000;
SELECT * FROM employees WHERE salary BETWEEN 5000 and 10000;

-- <예> 부서번호가 100번이거나 직급이 FI_MGR인 직원
SELECT * FROM employees WHERE department_id = 100 OR job_id = 'FI_MGR';

-- <문제> 직원번호가 134이거나 201이거나 107인 직원 정보 출력
SELECT * FROM employees WHERE employee_id = 134 OR employee_id = 201 OR employee_id = 107;
SELECT * FROM employees WHERE employee_id IN(134,201,107);

-- <예> 부서번호가 100번이 아닌 직원 
SELECT * FROM employees WHERE department_id != 100;
SELECT * FROM employees WHERE department_id <> 100;
SELECT * FROM employees WHERE department_id ^= 100;
SELECT * FROM employees WHERE NOT department_id = 100;

-- <문제> 직급이 FI_MGR가 아닌 직원
SELECT * FROM employees WHERE job_id != 'FI_MGR';

-- <문제> 급여가 2500에서 4500까지의 범위에 속한 직원의 직원번호, 이름, 급여를 출력하라. 
--       (AND 연산자와 BETWEEN AND 연산자 사용 두개모두 사용해서 보여줄것) 
SELECT employee_id,first_name,last_name,salary FROM employees WHERE salary >= 2500 and salary <= 4500;
SELECT employee_id,first_name,last_name,salary FROM employees WHERE salary BETWEEN 2500 and 4500;

-- <문제> 커미션비율이 0.3 이거나 0.05 이거나 0.1 중의 하나인 직원의 직원번호, 이름, 급여, 커미션 비율을 출력하라.
--       (OR 연산자와 IN 연산자 사용 모두 사용해볼것) 
SELECT employee_id, first_name, salary, commission_pct FROM employees WHERE commission_pct = 0.3 OR commission_pct = 0.05 OR commission_pct = 0.1;
SELECT employee_id, first_name, salary, commission_pct FROM employees WHERE commission_pct IN(0.3,0.05,0.1);

-- 10. LIKE 연산자 (_:1글자이고(여기에 무엇이 와도 상관이 없다)) (%: 없거나, 또는1글자이상 무엇이와도 상관이 없다.)
-- <예> K로 시작하는 사원
SELECT * FROM employees WHERE first_name LIKE 'K%';

-- <예> 이름 중에 k을 포함하는 사원 
SELECT * FROM employees WHERE last_name LIKE '%k%';

-- <예> 이름이 k로 끝나는 사원
SELECT * FROM employees WHERE first_name LIKE '%k';

-- <예> 이름의 두 번째 글자가 d인 사원
SELECT * FROM employees WHERE first_name LIKE '_d%';

-- <문제> 이름에 a를 포함하지 않은 직원의 직원번호, 이름을 출력하라. 
SELECT employee_id, first_name FROM employees WHERE upper(first_name) NOT LIKE '%A%';

-- 11. NULL은 연산, 할당, 비교가 불가능하다
-- <예> 커미션을 받지 않는 사원에 대한 검색 (비교안됨 commission_pct = NULL)
SELECT * FROM employees WHERE commission_pct = NULL;
SELECT * FROM employees WHERE commission_pct is NULL;
SELECT * FROM employees WHERE commission_pct is not NULL;

-- 자신의 직속상관이 없는 직원의 전체 이름과 직급과 직원번호을 출력하라 
select * from employees where manager_id IS NULL;

--12 order by asc, order by desc
select * from employees order by employee_id asc;
select * from employees where department_id <>100 order by employee_id asc;

-- <문제> 직원번호, 이름, 급여를 급여가 높은 순으로 출력하라. 
SELECT employee_id, first_name, last_name, salary FROM employees ORDER BY salary DESC;

--<문제> 입사일이 가장 최근인 직원 순으로 직원번호, 이름, 입사일을 출력하라. 
SELECT employee_id, first_name, last_name, hire_date FROM employees ORDER BY hire_date DESC; 



