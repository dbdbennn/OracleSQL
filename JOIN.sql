-- EQJOIN

SELECT employees.first_name, employees.department_id, departments.department_id, departments.department_name 
FROM employees, departments;

SELECT * FROM departments; -- 27��
SELECT * FROM employees; -- 111���� ������
--> 2997���� ���
-- īƼ�þ� �߻� ���� -> WHERE�� ����

SELECT employees.first_name, employees.department_id, departments.department_id, departments.department_name 
FROM employees, departments
WHERE employees.department_id = departments.department_id; -- �� ���̺��� ���� WHERE�� ���ǹ��� �ϳ�.

SELECT * FROM employees WHERE department_id IS NULL; -- ȸ���

-- �����ڵ尡 FI_MGR
SELECT employees.employee_id, employees.first_name, employees.salary, employees.department_id, departments.location_id
FROM employees, departments
WHERE job_id = 'FI_MGR' and employees.department_id = departments.department_id;

-- �����, �μ���, �޿�, �ٹ����ø� ��ȸ
SELECT employees.first_name, departments.department_name, employees.salary, locations.city
FROM employees, departments, locations
WHERE employees.department_id = departments.department_id and departments.location_id = locations.location_id;

-- Seatttle�� �ٹ��ϴ� ��� �� �޿� 5000 �̻��� ���
SELECT employees.first_name NAME, employees.salary SALARY, jobs.job_title JOB, employees.hire_date HIREDATE, employees.commission_pct BONUS,
departments.department_id DEPT, locations.city CITY
FROM employees, locations, departments, jobs
WHERE employees.salary >= 5000 
and locations.city = 'Seattle' 
and employees.department_id = departments.department_id 
and departments.location_id = locations.location_id
and jobs.job_id = employees.job_id
ORDER BY NAME;

-- �������� �ڿ� Manager�� �پ��ִ� ��� ��ȸ
SELECT departments.department_name, employees.first_name, jobs.job_title
FROM employees, departments, jobs
WHERE employees.department_id = departments.department_id 
and jobs.job_id = employees.job_id
and job_title LIKE '%Manager';

-- Michael�̶�� �̸��� ���� ����� ����.
SELECT employees.first_name, locations.city, locations.state_province 
FROM employees, locations, departments
WHERE employees.department_id = departments.department_id 
and departments.location_id = locations.location_id
and first_name = 'Michael';

-- �μ���� �μ��� �����ڵ� �� �� �μ��� CLERK �����ڵ�(_CLERK)�� ���� ����� �� ��ȸ
SELECT departments.department_name, employees.job_id, count(*) �ο���
FROM employees, departments
-- SELECT->FROM->WHERE->GROUP BY
WHERE employees.job_id LIKE '%CLERK'
and employees.department_id = departments.department_id
-- �μ���� �����ڵ忡 ���� GROUP BY��
GROUP BY (departments.department_name, employees.job_id)
ORDER BY departments.department_name;

-- ���̺� �� �� ���
SELECT departments.department_name, jobs.job_id, count(*) �ο���
FROM employees, departments, jobs
-- SELECT->FROM->WHERE->GROUP BY
WHERE employees.job_id LIKE '%CLERK'
and employees.department_id = departments.department_id
and employees.job_id = jobs.job_id
-- �μ���� �����ڵ忡 ���� GROUP BY��
GROUP BY (departments.department_name, jobs.job_id)
ORDER BY departments.department_name, jobs.job_id;

-- �� �μ��� ��� �޿� ��ȸ
SELECT departments.department_name, TRUNC(AVG(employees.salary)) ��ձ޿�
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
-- departments�� (+) => employees�� ������ ��.
-- employees�� (+) => departments�� ������ ��.
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

-- ��ġ��
SELECT employee_id, first_name, job_id, emp.department_id, dept.department_id, department_name
FROM employees emp, departments dept
WHERE emp.department_id = dept.department_id(+)
UNION
SELECT employee_id, first_name, job_id, emp.department_id, dept.department_id, department_name
FROM employees emp, departments dept
WHERE emp.department_id(+) = dept.department_id;

commit;














