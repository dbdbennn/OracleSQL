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
