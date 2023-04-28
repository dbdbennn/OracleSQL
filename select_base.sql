-- 단순 select
SELECT employee_id, first_name, salary, job_id, FIRST_NAME
FROM employees;

-- 산술 표현식
SELECT first_name, salary, salary+300
FROM employees;

SELECT first_name, salary, 2*salary+100
FROM employees;

SELECT first_name, salary, 2*(salary+100)
FROM employees;

SELECT employee_id, first_name, salary, COMMISSION_PCT, COMMISSION_PCT+300
FROM employees;

-- NVL
-- salary가 NULL이면 0으로 대체하라
SELECT employee_id, first_name, salary, NVL(salary,0)+300 from employees;

-- 컬럼 별칭
SELECT first_name as name, salary, salary*12 "Annual Salary"
FROM employees;

SELECT first_name 결과1, 'Abc' 결과2, salary 결과3, 500 결과4 FROM employees;

-- 연결 연산자
SELECT first_name||':'||employee_id||':'||job_id FROM employees;

SELECT first_name||' is a '||job_id as "Employees Details" FROM employees;

SELECT first_name||' : 1 Year Salary = '||salary*12 "Monthly" FROM employees;

-- DISTINCT : 중복 제거하여 출력
SELECT DISTINCT job_id FROM employees;

SELECT DISTINCT department_id, job_id FROM employees;

-- Pseudo Column
SELECT ROWID, ROWNUM, first_name, salary FROM employees;

-- 비교 연산자
SELECT employee_id, first_name, job_id, salary
FROM employees
WHERE job_id = 'FI_MGR';

SELECT employee_id, first_name, job_id, salary
FROM employees
WHERE salary >= 3000;

SELECT employee_id, salary, department_id
FROM employees
WHERE salary != 30;

SELECT first_name, job_id, salary, department_id
FROM employees
where salary between 13000 and 17000;

SELECT employee_id, first_name, job_id, salary, hire_date
FROM employees
WHERE employee_id IN (102, 101, 100);

SELECT first_name, salary, job_id FROM employees WHERE first_name LIKE '_a%';

SELECT first_name, salary, job_id FROM employees WHERE first_name LIKE '%A%';

-- 논리 연산자
SELECT employee_id, first_name, job_id, salary, department_id
FROM employees
WHERE salary >= 10000 AND job_id = 'FI_MGR';