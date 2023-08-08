------------------------------ Single Row Subquery -----------------------------

-- employee_id가 120인 사원의 job_id와 동일한 job_id를 가진 사원들의 first_name과 job_id 조회
SELECT first_name, job_id 
FROM employees 
WHERE 
    job_id = (SELECT job_id FROM employees WHERE employee_id = 120);

-- 150번보다 급여 많은 사람 조회
SELECT 
    first_name 이름, salary 급여 
FROM 
    employees 
WHERE 
    salary > (SELECT salary FROM employees WHERE employee_id = 150)
ORDER BY salary DESC;

-- 급여 가장 많이 받는 사람
SELECT 
    first_name 이름, department_id 부서번호, salary 급여, hire_date 입사날짜
FROM employees
WHERE 
    salary = (SELECT MAX(salary) FROM employees);
-- WHERE salary = MAX(salary);

-- 평균 급여보다 적은 사원
SELECT 
    employee_id 사원번호, first_name 이름, job_id 업무코드, salary 급여, department_id 부서번호
FROM employees
WHERE 
    salary < (SELECT AVG(salary) FROM employees);

-- 사원번호가 162와 업무가 같고, 급여가 Clara보다 많은 사원
SELECT 
    employee_id 사원번호, 
    employees.first_name 이름, 
    jobs.job_title 담당업무명, 
    hire_date 입사일자, 
    salary 급여
FROM employees 
JOIN jobs
-- join 조건
ON jobs.job_id = employees.job_id
AND 
    employees.job_id = (SELECT job_id FROM employees WHERE employee_id = 162)
AND 
    salary > (SELECT salary FROM employees WHERE first_name = 'Clara');






