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
FROm employees emp CROSS JOIN departments dept;

---------------------------------- GO TO DEEP ----------------------------------

-- NATURAL JOIN
SELECT * FROM jobs NATURAL JOIN job_history;

-- ex 1
SELECT first_name 사원명, department_id 부서번호, department_name 부서명 
FROM employees NATURAL JOIN departments 
ORDER BY first_name;
