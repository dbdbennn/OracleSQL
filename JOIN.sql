-- EQJOIN

SELECT employees.first_name, employees.department_id, departments.department_id, departments.department_name 
FROM employees, departments;

SELECT * FROM departments; -- 27개
SELECT * FROM employees; -- 111개의 데이터
--> 2997개의 결과
-- 카티시안 발생 이유 -> WHERE절 없음

SELECT employees.first_name, employees.department_id, departments.department_id, departments.department_name 
FROM employees, departments
WHERE employees.department_id = departments.department_id; -- 두 테이블일 때엔 WHERE은 조건문은 하나.

SELECT * FROM employees WHERE department_id IS NULL; -- 회장님

-- 업무코드가 FI_MGR
SELECT employees.employee_id, employees.first_name, employees.salary, employees.department_id, departments.location_id
FROM employees, departments
WHERE job_id = 'FI_MGR' and employees.department_id = departments.department_id;

-- 사원명, 부서명, 급여, 근무도시명 조회
SELECT employees.first_name, departments.department_name, employees.salary, locations.city
FROM employees, departments, locations
WHERE employees.department_id = departments.department_id and departments.location_id = locations.location_id;

-- Seatttle에 근무하는 사원 중 급여 5000 이상인 사원
SELECT employees.first_name NAME, employees.salary SALARY, jobs.job_title JOB, employees.hire_date HIREDATE, employees.commission_pct BONUS,
departments.department_id DEPT, locations.city CITY
FROM employees, locations, departments, jobs
WHERE employees.salary >= 5000 
and locations.city = 'Seattle' 
and employees.department_id = departments.department_id 
and departments.location_id = locations.location_id
and jobs.job_id = employees.job_id
ORDER BY NAME;

-- 업무명의 뒤에 Manager가 붙어있는 사람 조회
SELECT departments.department_name, employees.first_name, jobs.job_title
FROM employees, departments, jobs
WHERE employees.department_id = departments.department_id 
and jobs.job_id = employees.job_id
and job_title LIKE '%Manager';
