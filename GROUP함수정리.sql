-- 롤 업 에 관하여....
--------------------------------------------------------------------------------
-- ROLLUP
SELECT department_id, COUNT(*), SUM(salary) FROM employees GROUP BY department_id;
SELECT department_id, COUNT(*), SUM(salary) FROM employees GROUP BY ROLLUP(department_id);

-- ROLLUP -> UNION ALL
SELECT department_id, COUNT(*), SUM(salary) FROM employees GROUP BY department_id
    UNION ALL
SELECT NULL department_id, COUNT(*), SUM(salary) FROM employees ORDER BY department_id;

--------------------------------------------------------------------------------

-- ROLLUP
SELECT department_id, job_id, SUM(salary) FROM employees GROUP BY ROLLUP(department_id, job_id);

-- ROLLUP -> UNION ALL
SELECT department_id, job_id, SUM(salary) FROM employees GROUP BY (department_id, job_id)
    UNION ALL
SELECT department_id, NULL job_id, SUM(salary) FROM employees GROUP BY department_id
    UNION ALL
SELECT NULL department_id, NULL job_id, SUM(salary) FROM employees;

--------------------------------------------------------------------------------

-- ROLLUP
SELECT department_id, job_id, SUM(salary) FROM employees GROUP BY ROLLUP(job_id, department_id);

-- ROLLUP -> UNION ALL
SELECT department_id, job_id, SUM(salary) FROM employees GROUP BY (job_id, department_id)
    UNION ALL
SELECT NULL department_id, job_id, SUM(salary) FROM employees GROUP BY job_id
    UNION ALL
SELECT NULL department_id, NULL job_id, SUM(salary) FROM employees;

--------------------------------------------------------------------------------

-- ROLLUP
SELECT department_id, job_id, manager_id, SUM(salary)
FROM employees
GROUP BY ROLLUP(department_id, job_id, manager_id);

-- ROLLUP -> UNION ALL
SELECT department_id, job_id, manager_id, SUM(salary) FROM employees GROUP BY (department_id, job_id, manager_id)
    UNION ALL
SELECT department_id, job_id, NULL manager_id, SUM(salary) FROM employees GROUP BY (department_id, job_id)
    UNION ALL
SELECT department_id, NULL job_id, NULL manager_id, SUM(salary) FROM employees GROUP BY (department_id)
    UNION ALL
SELECT NULL department_id, NULL job_id, NULL manager_id, SUM(salary) FROM employees ORDER BY department_id;

--------------------------------------------------------------------------------
-- 큐브 에 관하여....

-- CUBE
SELECT department_id, job_id, SUM(salary) FROM employees
WHERE department_id IS NOT NULL
GROUP BY CUBE(department_id, job_id);

-- CUBE -> UNION ALL
SELECT department_id, job_id, SUM(salary) FROM employees
WHERE department_id IS NOT NULL
GROUP BY (department_id, job_id)
    UNION ALL
SELECT department_id, NULL job_id, SUM(salary) FROM employees
WHERE department_id IS NOT NULL
GROUP BY (department_id)
    UNION ALL
SELECT NULL department_id,  job_id, SUM(salary) FROM employees
WHERE department_id IS NOT NULL
GROUP BY (job_id)
    UNION ALL
SELECT NULL department_id,  NULL job_id, SUM(salary) FROM employees
WHERE department_id IS NOT NULL;

--------------------------------------------------------------------------------

-- CUBE
SELECT department_id, job_id, manager_id, SUM(salary) FROM employees
GROUP BY CUBE(department_id, job_id, manager_id);

-- UNION ALL (2의 3승)
SELECT department_id, job_id, manager_id, SUM(salary) FROM employees
GROUP BY (department_id, job_id, manager_id)
    UNION ALL
SELECT department_id, job_id, NULL manager_id, SUM(salary) FROM employees
GROUP BY (department_id, job_id)
    UNION ALL
SELECT NULL department_id, job_id,  manager_id, SUM(salary) FROM employees
GROUP BY (job_id, manager_id)
    UNION ALL
SELECT department_id, NULL job_id,  manager_id, SUM(salary) FROM employees
GROUP BY (department_id, manager_id)
    UNION ALL
SELECT department_id, NULL job_id, NULL manager_id, SUM(salary) FROM employees
GROUP BY (department_id)
    UNION ALL
SELECT NULL department_id,  job_id, NULL manager_id, SUM(salary) FROM employees
GROUP BY (job_id)
    UNION ALL
SELECT NULL department_id, NULL job_id, manager_id, SUM(salary) FROM employees
GROUP BY (manager_id)
    UNION ALL
SELECT NULL department_id, NULL job_id, NULL manager_id, SUM(salary) FROM employees
ORDER BY department_id ;

--------------------------------------------------------------------------------
-- 구루핑 섿 에 관하여....

-- 순서 상관 X 
-- 단순 합집합
-- 그냥 그룹을 합친거임
-- GROUPING SETS
SELECT department_id, job_id, SUM(salary) FROM employees
GROUP BY GROUPING SETS(department_id, job_id);

-- UNION ALL
SELECT department_id, NULL job_id, SUM(salary) FROM employees
GROUP BY department_id
UNION ALL
SELECT NULL department_id, job_id, SUM(salary) FROM employees
GROUP BY job_id;

--------------------------------------------------------------------------------

-- GROUPING SETS
SELECT department_id, job_id, manager_id, AVG(salary) 
FROM employees
GROUP BY GROUPING SETS((department_id, job_id, manager_id), department_id, job_id);

-- UNION ALL
SELECT department_id, job_id, manager_id, AVG(salary) 
FROM employees
GROUP BY (department_id, job_id, manager_id)
    UNION ALL
SELECT department_id, NULL job_id, NULL manager_id, AVG(salary) 
FROM employees
GROUP BY (department_id)
    UNION ALL
SELECT NULL department_id, job_id, NULL manager_id, AVG(salary) 
FROM employees
GROUP BY (job_id);

--------------------------------------------------------------------------------

SELECT department_id, job_id, manager_id, SUM(salary)
FROM employees
GROUP BY ROLLUP(department_id, (job_id, manager_id));

SELECT department_id, job_id, manager_id, SUM(salary) FROM employees
GROUP BY (department_id, job_id, manager_id)
    UNION ALL
SELECT department_id, null job_id, null manager_id, SUM(salary) FROM employees
GROUP BY (department_id)
    UNION ALL
SELECT null department_id, null job_id, null manager_id, SUM(salary) FROM employees
ORDER BY department_id;
