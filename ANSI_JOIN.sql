-- NATURAL JOIN : 컬럼명이 같은 모든 데이터를 비교
SELECT * FROM employees NATURAL JOIN departments;

-- 위와 같은 결과가 나온다.
SELECT * 
FROM employees, departments 
WHERE employees.department_id = departments.department_id 
AND employees.manager_id = departments.manager_id;


-- JOIN USING : 해당하는 컬럼명을 이용해 데이터를 비교
SELECT * 
FROM employees 
JOIN departments USING (department_id);

-- 위와 같은 결과가 나온다.
SELECT * 
FROM employees, departments 
WHERE employees.department_id = departments.department_id;


-- JOIN ON
SELECT * 
FROM employees JOIN departments ON
employees.department_id = departments.department_id;

-- 위와 같은 결과가 나온다.
SELECT * 
FROM employees, departments 
WHERE employees.department_id = departments.department_id; 


-- RIGHT OUTER JOIN : 명령어 옆에 있는 테이블의 순서에 따라 좌우 여부 결정.
SELECT * FROM employees RIGHT OUTER JOIN departments ON
-- 조건식의 순서는 상관 없음.
employees.department_id = departments.department_id; 

-- 위와 같은 결과가 나온다.
SELECT * 
FROM employees, departments 
WHERE employees.department_id(+) = departments.department_id;


-- LEFT OUTER JOIN
SELECT * FROM employees LEFT OUTER JOIN departments ON
employees.department_id = departments.department_id; 

-- 위와 같은 결과가 나온다.
SELECT * 
FROM employees, departments 
WHERE employees.department_id = departments.department_id(+);


-- FULL OUTER JOIN
SELECT * FROM employees FULL OUTER JOIN departments ON
employees.department_id = departments.department_id; 

-- 위와 같은 결과가 나온다.
SELECT * 
FROM employees, departments 
WHERE employees.department_id(+) = departments.department_id
    UNION 
SELECT * 
FROM employees, departments 
WHERE employees.department_id = departments.department_id(+);


-- CROSS JOIN
SELECT emp.employee_id, dept.department_name
FROM employees emp CROSS JOIN departments dept;

---------------------------------- GO TO DEEP ----------------------------------

-- NATURAL JOIN
SELECT * FROM jobs NATURAL JOIN job_history;

-- ex 1
SELECT first_name 사원명, department_id 부서번호, department_name 부서명 
FROM employees NATURAL JOIN departments 
ORDER BY first_name;

-- ex 2
SELECT department_id 부서번호, department_name 부서이름, location_id 지역코드, city 근무도시
FROM departments NATURAL JOIN locations 
WHERE department_id IN (10, 30);

-- ex 4
SELECT first_name 사원명, salary 급여, department_id 부서번호, department_name 부서명, city 근무도시
FROM employees NATURAL JOIN locations NATURAL JOIN departments
ORDER BY 1;

-- ex 5
-- 1. create table
CREATE TABLE test_join(
    test varchar2(20),
    no number(2)
);

CREATE TABLE test_natural_join(
    job_id varchar2(10),
    job_title varchar(25) not null,
    test number(10)
);

SELECT * FROM TAB;

-- insert
INSERT INTO test_join values('1000', '20');
INSERT INTO test_natural_join values('10', 'TEST_JOB', 1000);

SELECT * FROM test_join NATURAL JOIN test_natural_join;

INSERT INTO test_join VALUES('ABC', 20);
DELETE FROM test_join WHERE test = 'ABC';

--------------------------------- JOIN ~ USING ---------------------------------

-- ex 1
SELECT first_name 사원명, department_id 부서번호, department_name 부서명
FROM employees JOIN departments USING (department_id);

-- ex 2
SELECT 
    department_id 부서번호,
    department_name 부서명,
    location_id 지역코드,
    city "도시 정보"
FROM departments
    JOIN locations
    USING (location_id)
WHERE 
    department_id IN (20, 50, 80, 110)
ORDER BY department_id;

-- ex 3
SELECT
    employees.first_name 사원명,
    departments.department_name 부서명,
    locations.city 근무도시
FROM employees
    JOIN departments
        USING (department_id)
    JOIN locations
        USING (location_id);

---------------------------------- JOIN ~ ON -----------------------------------

-- ex 1
SELECT 
    e.first_name 사원명,
    e.salary 급여,
    m.first_name 매니저명,
    m.salary 매니저급여
FROM employees e
JOIN employees m
    ON e.manager_id = m.employee_id;

-- ex 2
SELECT 
    e.first_name 사원명, 
    d.department_name 부서명,
    l.city 근무도시
FROM employees e
JOIN departments d
    ON e.department_id = d.department_id
JOIN locations l
    ON d.location_id = l.location_id
WHERE first_name NOT LIKE '%A%'
AND first_name NOT LIKE '%a%'
ORDER BY 1;
    
---------------------------------- OUTER JOIN ----------------------------------

-- ex 1
SELECT 
    d.department_name 부서명,
    d.location_id d_지역코드,
    l.location_id l_지역코드,
    l.city 도시명
FROM departments d
LEFT OUTER JOIN locations l
    ON l.location_id = d.location_id;
    
-- OR

SELECT 
    d.department_name 부서명,
    d.location_id d_지역코드,
    l.location_id l_지역코드,
    l.city 도시명
FROM departments d, locations l
WHERE d.location_id = l.location_id(+);

-- ex 2 (기준 테이블만 변경)

SELECT 
    d.department_name 부서명,
    d.location_id d_지역코드,
    l.location_id l_지역코드,
    l.city 도시명
FROM departments d
RIGHT OUTER JOIN locations l
    ON l.location_id = d.location_id;

-- OR

SELECT 
    d.department_name 부서명,
    d.location_id d_지역코드,
    l.location_id l_지역코드,
    l.city 도시명
FROM departments d, locations l
WHERE d.location_id(+) = l.location_id;

-- ex 3 (모든 테이블 조회)
SELECT 
    d.department_name 부서명,
    d.location_id d_지역코드,
    l.location_id l_지역코드,
    l.city 도시명
FROM departments d
FULL OUTER JOIN locations l
    ON l.location_id = d.location_id;

-- OR

SELECT 
    d.department_name 부서명,
    d.location_id d_지역코드,
    l.location_id l_지역코드,
    l.city 도시명
FROM departments d, locations l
WHERE d.location_id(+) = l.location_id
    UNION
SELECT 
    d.department_name 부서명,
    d.location_id d_지역코드,
    l.location_id l_지역코드,
    l.city 도시명
FROM departments d, locations l
WHERE d.location_id = l.location_id(+);

-- ex 4
SELECT 
    e.first_name 이름,
    e.salary 급여,
    d.department_id 부서번호,
    d.department_name 부서명
FROM departments d
LEFT OUTER JOIN employees e
    ON e.department_id = d.department_id
    -- WHERE를 쓰게 되면 먼저 급여에 null이 걸러짐.
        AND salary > 3000;








