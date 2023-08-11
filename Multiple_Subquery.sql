SELECT emp.employee_id �����ȣ, emp.first_name �����, emp.salary �޿�, emp.department_id �μ���ȣ
FROM employees emp
JOIN (
    SELECT department_id, MAX(salary) max_sal
    FROM employees
    GROUP BY department_id
) max_tbl ON emp.salary = max_tbl.max_sal AND emp.department_id = max_tbl.department_id
ORDER BY emp.department_id;

-- ANY
SELECT first_name, salary, job_id
FROM employees
WHERE job_id NOT LIKE 'SA_%'
AND salary > ANY(SELECT salary FROM employees WHERE job_id LIKE 'SA_%')
ORDER BY salary;
-- OR
SELECT first_name, salary, job_id
FROM employees
WHERE job_id NOT LIKE 'SA_%'
AND salary > (SELECT MIN(salary) FROM employees WHERE job_id LIKE 'SA_%')
ORDER BY salary;

-- ALL
SELECT first_name, salary, job_id
FROM employees
WHERE job_id NOT LIKE 'SA_%'
AND salary > ALL(SELECT salary FROM employees WHERE job_id LIKE 'SA_%')
ORDER BY salary;
-- OR
SELECT first_name, salary, job_id
FROM employees
WHERE job_id NOT LIKE 'SA_%'
AND salary > (SELECT MAX(salary) FROM employees WHERE job_id LIKE 'SA_%')
ORDER BY salary;

CREATE TABLE TEMP_EMP AS (SELECT * FROM employees);

