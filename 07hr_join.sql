-- join
-- 1.cross join (두개의 테이블을 크로스한다)
SELECT COUNT(*) FROM employees; --107
SELECT COUNT(*) FROM departments; --27

SELECT * FROM employees,departments WHERE first_name like '%a%';

-- ANSI cross join
SELECT COUNT(*) FROM employees,departments; --2889
SELECT COUNT(*) FROM employees cross join departments; --2889

-- 2. inner join(employees 테이블과,departments 테이블을 조인해서 보여주시오)
SELECT * FROM employees e,departments d
    WHERE e.department_id = d.department_id;
    
    
-- ANSI inner join
SELECT * FROM employees e INNER JOIN departments d
ON e.department_id = d.department_id;

-- ANSI using을 이용한 조인 조건 지정
SELECT * FROM employees e INNER JOIN departments d
USING(department_id);

    
SELECT * FROM user_cons_columns WHERE table_name = 'EMPLOYEES';
-- pk: Departments.department_id fk: Employees.derpartment_id
-- first_name,email, job_id, 연봉, 부서명, 부서위치를 출력하는 조인문을 작성
-- 배송부서(shipping)와 연봉이 5000달러 이상인 사람을 보여주시오
-- inner join ~~on
SELECT e.first_name, e.email, e.job_id, e.salary, d.department_name, d.location_id 
FROM employees e INNER JOIN departments d 
ON e.department_id = d.department_id
where upper(d.department_name) = 'SHIPPING' AND e.salary >= 5000;


-- right outer join, left outer join
SELECT e.first_name, d.department_id, d.department_name 
FROM employees e, departments d
WHERE e.department_id = d.department_id(+)
order by d.department_id asc;

-- ANSI right outer join
SELECT e.first_name, d.department_id, d.department_name 
FROM employees e right outer join departments d
on e.department_id = d.department_id
order by d.department_id asc;

-- ANSI left outer join
SELECT e.first_name, d.department_id, d.department_name 
FROM employees e left outer join departments d
on e.department_id = d.department_id
order by d.department_id asc;

SELECT * FROM departments ORDER BY department_id asc;

-- self join(한개의 테이블을 두개로 분리시킨다. 한개 pk, 다른한개 fk)
-- employees를 self join를 통해서 사원의 정보와 사원의 사수의 정보를 출력하는 쿼리문 작성

SELECT e1.first_name 사원, e2.first_name 사수, e1.salary 사원연봉, e2.salary 사수연봉
FROM employees e1,employees e2
WHERE e1.manager_id = e2.employee_id;

-- non equl join(두개의 테이블이 아무관계가 없다. fk 가지고 있지 않다)
-- 등급을 나타내는 테이블생성 gradetbl (등급,최소연봉,최대연봉)

CREATE TABLE gradetbl (
    grade NUMBER NOT NULL,
    minsalary NUMBER NOT NULL,
    maxsalary NUMBER NOT NULL,
    CONSTRAINT pk_gradetbl_grade PRIMARY KEY(grade)
);

INSERT INTO gradetbl VALUES (1, 2000, 5000);
INSERT INTO gradetbl VALUES (2, 5001, 10000);
INSERT INTO gradetbl VALUES (3, 10001, 20000);
INSERT INTO gradetbl VALUES (4, 20001, 30000);
INSERT INTO gradetbl VALUES (5, 30001, 50000);

commit;

SELECT * FROM gradetbl;

-- 공통컬럼이 없는 employees 테이블과 gradetbl 조인을 해서 사원의 이름과, 사원의 월급, 사원의 월급등급을 출력하시오.
SELECT e.first_name, e.salary, g.grade 
FROM employees e,gradetbl g
WHERE e.salary >= g.minsalary and e.salary <= g.maxsalary;

SELECT e.first_name, e.salary, g.grade 
FROM employees e,gradetbl g
WHERE e.salary between g.minsalary and g.maxsalary;







