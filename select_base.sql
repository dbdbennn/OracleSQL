-- �ܼ� select
SELECT employee_id, first_name, salary, job_id, FIRST_NAME
FROM employees;

-- ��� ǥ����
SELECT first_name, salary, salary+300
FROM employees;

SELECT first_name, salary, 2*salary+100
FROM employees;

SELECT first_name, salary, 2*(salary+100)
FROM employees;

SELECT employee_id, first_name, salary, COMMISSION_PCT, COMMISSION_PCT+300
FROM employees;

-- NVL
-- salary�� NULL�̸� 0���� ��ü�϶�
SELECT employee_id, first_name, salary, NVL(salary,0)+300 from employees;

-- �÷� ��Ī
SELECT first_name as name, salary, salary*12 "Annual Salary"
FROM employees;

SELECT first_name ���1, 'Abc' ���2, salary ���3, 500 ���4 FROM employees;

-- ���� ������
SELECT first_name||':'||employee_id||':'||job_id FROM employees;

SELECT first_name||' is a '||job_id as "Employees Details" FROM employees;

SELECT first_name||' : 1 Year Salary = '||salary*12 "Monthly" FROM employees;

-- DISTINCT : �ߺ� �����Ͽ� ���
SELECT DISTINCT job_id FROM employees;

SELECT DISTINCT department_id, job_id FROM employees;

-- Pseudo Column
SELECT ROWID, ROWNUM, first_name, salary FROM employees;

-- �� ������
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

-- �� ������
SELECT employee_id, first_name, job_id, salary, department_id
FROM employees
WHERE salary >= 10000 AND job_id = 'FI_MGR';