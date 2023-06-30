@C:\Users\User\Desktop\학교수업\OracleDB\OracleSQL\20230331.sql;

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

-- SELF JOIN

-- Ellen의 Manager의 이름을 찾는법
-- 사원 테이블에서 first_name이 Ellen인 데이터 검색(emp.first_name = 'Ellen')
-- 사원 테이블에서 Ellen의 manager_id 검색
-- 관리자 테이블에서 사원테이블의 manager_id에 해당되는 employee_id 검색
-- 관리자 테이블에서 employee_id에 해당하는 first_name 조회

SELECT emp.employee_id 사원번호, emp.first_name 사원명, emp.manager_id 관리자번호, man.first_name 관리자명
FROM employees emp, employees man
WHERE emp.manager_id = man.employee_id(+);
-- manager가 null인 사람도 띄워라(그럼 emp 테이블이 다 나와야하니까 man 테이블에 +)

-- 사원명 뒤에 '관리자는' 문자열을 결합하여 관리자명(관리자정보)이 나오도록 조회(관리자가 없는 사원도 결과에 나오도록 한다)하여 사원명 순으로 정렬
-- 두 개의 열이름 사이에 ||를 작성해주거나 문자 사이에 ||를 작성 해줌으로써 두 개 이상의 문자열을 합쳐서 출력 가능
SELECT emp.first_name || ' 관리자는 ' || man.first_name 관리자정보
FROM employees emp, employees man
WHERE emp.manager_id = man.employee_id(+)
ORDER BY emp.first_name;












