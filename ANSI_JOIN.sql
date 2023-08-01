-- NATURAL JOIN : �÷����� ���� ��� �����͸� ��
SELECT * FROM employees NATURAL JOIN departments;

-- ���� ���� ����� ���´�.
SELECT * 
FROM employees, departments 
WHERE employees.department_id = departments.department_id 
AND employees.manager_id = departments.manager_id;


-- JOIN USING : �ش��ϴ� �÷����� �̿��� �����͸� ��
SELECT * 
FROM employees 
JOIN departments USING (department_id);

-- ���� ���� ����� ���´�.
SELECT * 
FROM employees, departments 
WHERE employees.department_id = departments.department_id;


-- JOIN ON
SELECT * 
FROM employees JOIN departments ON
employees.department_id = departments.department_id;

-- ���� ���� ����� ���´�.
SELECT * 
FROM employees, departments 
WHERE employees.department_id = departments.department_id; 


-- RIGHT OUTER JOIN : ��ɾ� ���� �ִ� ���̺��� ������ ���� �¿� ���� ����.
SELECT * FROM employees RIGHT OUTER JOIN departments ON
-- ���ǽ��� ������ ��� ����.
employees.department_id = departments.department_id; 

-- ���� ���� ����� ���´�.
SELECT * 
FROM employees, departments 
WHERE employees.department_id(+) = departments.department_id;


-- LEFT OUTER JOIN
SELECT * FROM employees LEFT OUTER JOIN departments ON
employees.department_id = departments.department_id; 

-- ���� ���� ����� ���´�.
SELECT * 
FROM employees, departments 
WHERE employees.department_id = departments.department_id(+);


-- FULL OUTER JOIN
SELECT * FROM employees FULL OUTER JOIN departments ON
employees.department_id = departments.department_id; 

-- ���� ���� ����� ���´�.
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
SELECT first_name �����, department_id �μ���ȣ, department_name �μ��� 
FROM employees NATURAL JOIN departments 
ORDER BY first_name;
