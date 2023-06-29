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

-- Michael이라는 이름을 가진 사람의 정보.
SELECT employees.first_name, locations.city, locations.state_province 
FROM employees, locations, departments
WHERE employees.department_id = departments.department_id 
and departments.location_id = locations.location_id
and first_name = 'Michael';

-- 부서명과 부서별 업무코드 및 각 부서별 CLERK 업무코드(_CLERK)를 가진 사람의 수 조회
SELECT departments.department_name, employees.job_id, count(*) 인원수
FROM employees, departments
-- SELECT->FROM->WHERE->GROUP BY
WHERE employees.job_id LIKE '%CLERK'
and employees.department_id = departments.department_id
-- 부서명과 업무코드에 따른 GROUP BY임
GROUP BY (departments.department_name, employees.job_id)
ORDER BY departments.department_name;

-- 테이블 세 개 사용
SELECT departments.department_name, jobs.job_id, count(*) 인원수
FROM employees, departments, jobs
-- SELECT->FROM->WHERE->GROUP BY
WHERE employees.job_id LIKE '%CLERK'
and employees.department_id = departments.department_id
and employees.job_id = jobs.job_id
-- 부서명과 업무코드에 따른 GROUP BY임
GROUP BY (departments.department_name, jobs.job_id)
ORDER BY departments.department_name, jobs.job_id;

-- 각 부서별 평균 급여 조회
SELECT departments.department_name, TRUNC(AVG(employees.salary)) 평균급여
FROM departments, employees
WHERE employees.department_id = departments.department_id
GROUP BY departments.department_name
ORDER BY departments.department_name; 

--------------------------------------------------------------------------------
--NON-EQUI JOIN

SELECT employees.employee_id, employees.first_name, employees.job_id, salary, job_title, min_salary, max_salary
FROM employees, jobs
WHERE employees.salary BETWEEN min_salary AND max_salary
AND employees.job_id = jobs.job_id
ORDER BY job_id;

SELECT employees.employee_id, first_name, employees.job_id, employees.department_id, departments.department_id, departments.department_name
FROM employees, departments
-- departments에 (+) => employees가 기준이 됨.
-- employees에 (+) => departments가 기준이 됨.
WHERE employees.department_id = departments.department_id(+)
ORDER By departments.department_id;

SELECT * FROM departments;

--------------------------------------------------------------------------------

SELECT department_id, department_name, city
FROM departments, locations
WHERE departments.location_id = locations.location_id(+)
ORDER BY 1;

SELECT department_id, department_name, city
FROM departments, locations
WHERE departments.location_id(+) = locations.location_id
ORDER BY 1;

SELECT department_id, department_name, locations.location_id, city
FROM departments, locations
WHERE departments.location_id(+) = locations.location_id
UNION ALL
SELECT department_id, department_name, locations.location_id, city
FROM departments, locations
WHERE departments.location_id = locations.location_id(+) 
ORDER BY 1;

--------------------------------------------------------------------------------

-- 합치기
SELECT employee_id, first_name, job_id, emp.department_id, dept.department_id, department_name
FROM employees emp, departments dept
WHERE emp.department_id = dept.department_id(+)
UNION
SELECT employee_id, first_name, job_id, emp.department_id, dept.department_id, department_name
FROM employees emp, departments dept
WHERE emp.department_id(+) = dept.department_id;

commit;














