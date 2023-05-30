-- n이 2인 경우 2의 n승 4종류
-- a: a, b 데이터
-- b: a 데이터
-- c: b 데이터
-- d: 전체
SELECT department_id, job_id, SUM(salary)
FROM employees
WHERE department_id IS NOT NULL
GROUP BY CUBE(department_id, job_id);

SELECT department_id, job_id, SUM(salary)
FROM employees
WHERE department_id IS NOT NULL
GROUP BY ROLLUP(department_id, job_id);

SELECT department_id, job_id, SUM(salary)
FROM employees
WHERE department_id IS NOT NULL
GROUP BY CUBE(job_id, department_id);

SELECT department_id, job_id, manager_id, SUM(salary) FROM employees
GROUP BY CUBE(department_id, job_id, manager_id);

-- 순서 상관 X
SELECT department_id, job_id, SUM(salary) FROM employees
GROUP BY GROUPING SETS(department_id, job_id);

-- 순서에 따라 결과 나옴
SELECT NULL department_id, job_id, SUM(salary) FROM employees
GROUP BY job_id
    UNION ALL
SELECT department_id, NULL job_id, SUM(salary) FROM employees
GROUP BY department_id;

SELECT department_id, job_id, manager_id, AVG(salary) 
FROM employees
GROUP BY GROUPING SETS((department_id, job_id, manager_id), department_id, job_id);

SELECT department_id, job_id, manager_id, AVG(salary) 
FROM employees
GROUP BY (department_id, job_id, manager_id)
    UNION ALL
SELECT department_id, NULL job_id, NULL manager_id, AVG(salary) 
FROM employees
GROUP BY department_id
    UNION ALL
SELECT NULL department_id,  job_id, NULL manager_id, AVG(salary) 
FROM employees
GROUP BY job_id;