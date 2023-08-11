------------------------------ Single Row Subquery -----------------------------

-- employee_id�� 120�� ����� job_id�� ������ job_id�� ���� ������� first_name�� job_id ��ȸ
SELECT first_name, job_id 
FROM employees 
WHERE 
    job_id = (SELECT job_id FROM employees WHERE employee_id = 120);

-- 150������ �޿� ���� ��� ��ȸ
SELECT 
    first_name �̸�, salary �޿� 
FROM 
    employees 
WHERE 
    salary > (SELECT salary FROM employees WHERE employee_id = 150)
ORDER BY salary DESC;

-- �޿� ���� ���� �޴� ���
SELECT 
    first_name �̸�, department_id �μ���ȣ, salary �޿�, hire_date �Ի糯¥
FROM employees
WHERE 
    salary = (SELECT MAX(salary) FROM employees);
-- WHERE salary = MAX(salary);

-- ��� �޿����� ���� ���
SELECT 
    employee_id �����ȣ, first_name �̸�, job_id �����ڵ�, salary �޿�, department_id �μ���ȣ
FROM employees
WHERE 
    salary < (SELECT AVG(salary) FROM employees);

-- �����ȣ�� 162�� ������ ����, �޿��� Clara���� ���� ���
SELECT 
    employee_id �����ȣ, 
    employees.first_name �̸�, 
    jobs.job_title ��������, 
    hire_date �Ի�����, 
    salary �޿�
FROM employees 
JOIN jobs
-- join ����
ON jobs.job_id = employees.job_id
AND 
    employees.job_id = (SELECT job_id FROM employees WHERE employee_id = 162)
AND 
    salary > (SELECT salary FROM employees WHERE first_name = 'Clara');

-- GROUP BY
SELECT department_id, MIN(salary) 
FROM employees 
GROUP BY department_id
HAVING 
    MIN(salary) > (SELECT MIN(salary) FROM employees WHERE department_id = 80);
    
SELECT 
    first_name �����, 
    salary �޿�, 
    emp.job_id ������, 
    avg_sal ��ձ޿�,
    DECODE(SIGN(salary-avg_sal*1.1), 1, salary*0.05, 0) ������,
    salary- DECODE(SIGN(salary-avg_sal*1.1), 1, salary*0.05, 0) �Ǽ��ɾ�
FROM 
    employees emp, 
    (SELECT job_id, AVG(salary) avg_sal FROM employees GROUP BY job_id) avg_tbl
WHERE 
    emp.job_id = avg_tbl.job_id
AND salary > avg_sal;





















