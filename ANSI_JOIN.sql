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
FROM employees emp CROSS JOIN departments dept;

---------------------------------- GO TO DEEP ----------------------------------

-- NATURAL JOIN
SELECT * FROM jobs NATURAL JOIN job_history;

-- ex 1
SELECT first_name �����, department_id �μ���ȣ, department_name �μ��� 
FROM employees NATURAL JOIN departments 
ORDER BY first_name;

-- ex 2
SELECT department_id �μ���ȣ, department_name �μ��̸�, location_id �����ڵ�, city �ٹ�����
FROM departments NATURAL JOIN locations 
WHERE department_id IN (10, 30);

-- ex 4
SELECT first_name �����, salary �޿�, department_id �μ���ȣ, department_name �μ���, city �ٹ�����
FROM employees NATURAL JOIN locations NATURAL JOIN departments
ORDER BY 1;

-- ex 5
-- 1. create table
CREATE TABLE test_join(
    test varchar2(20),
    no number(2)
);

CREATE TABLE test_natural_join(
    job_id varchar2(10),
    job_title varchar(25) not null,
    test number(10)
);

SELECT * FROM TAB;

-- insert
INSERT INTO test_join values('1000', '20');
INSERT INTO test_natural_join values('10', 'TEST_JOB', 1000);

SELECT * FROM test_join NATURAL JOIN test_natural_join;

INSERT INTO test_join VALUES('ABC', 20);
DELETE FROM test_join WHERE test = 'ABC';

--------------------------------- JOIN ~ USING ---------------------------------

-- ex 1
SELECT first_name �����, department_id �μ���ȣ, department_name �μ���
FROM employees JOIN departments USING (department_id);

-- ex 2
SELECT 
    department_id �μ���ȣ,
    department_name �μ���,
    location_id �����ڵ�,
    city "���� ����"
FROM departments
    JOIN locations
    USING (location_id)
WHERE 
    department_id IN (20, 50, 80, 110)
ORDER BY department_id;

-- ex 3
SELECT
    employees.first_name �����,
    departments.department_name �μ���,
    locations.city �ٹ�����
FROM employees
    JOIN departments
        USING (department_id)
    JOIN locations
        USING (location_id);

---------------------------------- JOIN ~ ON -----------------------------------

-- ex 1
SELECT 
    e.first_name �����,
    e.salary �޿�,
    m.first_name �Ŵ�����,
    m.salary �Ŵ����޿�
FROM employees e
JOIN employees m
    ON e.manager_id = m.employee_id;

-- ex 2
SELECT 
    e.first_name �����, 
    d.department_name �μ���,
    l.city �ٹ�����
FROM employees e
JOIN departments d
    ON e.department_id = d.department_id
JOIN locations l
    ON d.location_id = l.location_id
WHERE first_name NOT LIKE '%A%'
AND first_name NOT LIKE '%a%'
ORDER BY 1;
    
---------------------------------- OUTER JOIN ----------------------------------

-- ex 1
SELECT 
    d.department_name �μ���,
    d.location_id d_�����ڵ�,
    l.location_id l_�����ڵ�,
    l.city ���ø�
FROM departments d
LEFT OUTER JOIN locations l
    ON l.location_id = d.location_id;
    
-- OR

SELECT 
    d.department_name �μ���,
    d.location_id d_�����ڵ�,
    l.location_id l_�����ڵ�,
    l.city ���ø�
FROM departments d, locations l
WHERE d.location_id = l.location_id(+);

-- ex 2 (���� ���̺� ����)

SELECT 
    d.department_name �μ���,
    d.location_id d_�����ڵ�,
    l.location_id l_�����ڵ�,
    l.city ���ø�
FROM departments d
RIGHT OUTER JOIN locations l
    ON l.location_id = d.location_id;

-- OR

SELECT 
    d.department_name �μ���,
    d.location_id d_�����ڵ�,
    l.location_id l_�����ڵ�,
    l.city ���ø�
FROM departments d, locations l
WHERE d.location_id(+) = l.location_id;

-- ex 3 (��� ���̺� ��ȸ)
SELECT 
    d.department_name �μ���,
    d.location_id d_�����ڵ�,
    l.location_id l_�����ڵ�,
    l.city ���ø�
FROM departments d
FULL OUTER JOIN locations l
    ON l.location_id = d.location_id;

-- OR

SELECT 
    d.department_name �μ���,
    d.location_id d_�����ڵ�,
    l.location_id l_�����ڵ�,
    l.city ���ø�
FROM departments d, locations l
WHERE d.location_id(+) = l.location_id
    UNION
SELECT 
    d.department_name �μ���,
    d.location_id d_�����ڵ�,
    l.location_id l_�����ڵ�,
    l.city ���ø�
FROM departments d, locations l
WHERE d.location_id = l.location_id(+);

-- ex 4
SELECT 
    e.first_name �̸�,
    e.salary �޿�,
    d.department_id �μ���ȣ,
    d.department_name �μ���
FROM departments d
LEFT OUTER JOIN employees e
    ON e.department_id = d.department_id
    -- WHERE�� ���� �Ǹ� ���� �޿��� null�� �ɷ���.
        AND salary > 3000;








