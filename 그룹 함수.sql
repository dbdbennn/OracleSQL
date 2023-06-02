SELECT department_id, first_name, salary, commission_pct, salary*(1+nvl(commission_pct, 0)) "금월급여" FROM employees WHERE department_id IN(30, 80);

SELECT department_id, first_name, MANAGER_ID, NVL2(MANAGER_ID, MANAGER_ID||'담당', '상위자') "담당매니저" FROM employees WHERE department_id IN(20,90);
SELECT department_id, first_name, MANAGER_ID, NVL2(MANAGER_ID, CONCAT(MANAGER_ID,'담당'), '상위자') "담당매니저" FROM employees WHERE department_id IN(20,90);

SELECT first_name, JOB_ID, NULLIF(JOB_ID, 'PU_CLERK') "결과" FROM employees WHERE department_id IN(30) ORDER BY FIRST_NAME;

SELECT first_name, COMMISSION_PCT, SALARY, COALESCE(COMMISSION_PCT, SALARY, 0.5) "결과" FROM employees;

SELECT first_name, SALARY, (salary*commission_pct)+6000 "비교값", GREATEST(SALARY, (salary*commission_pct)+6000) "결과" FROM employees WHERE SALARY IS NOT NULL AND COMMISSION_PCT IS NOT NULL;

SELECT first_name, SALARY, (salary*commission_pct)+6000 "비교값", LEAST(SALARY, (salary*commission_pct)+6000) "결과" FROM employees WHERE SALARY IS NOT NULL AND COMMISSION_PCT IS NOT NULL;

SELECT first_name, JOB_ID, SALARY, DECODE(JOB_ID, 'FI_ACCOUNT', SALARY*1.1, 'IT_PROG', SALARY*1.2, 'SA_REP', SALARY*1.3, 'PU_CLERK', SALARY*1.4, SALARY) "결과" FROM employees ORDER BY "결과";
SELECT first_name, JOB_ID, SALARY,
    CASE JOB_ID WHEN 'FI_ACCOUNT' THEN SALARY*1.1
        WHEN 'IT_PROG' THEN SALARY*1.2
        WHEN 'SA_REP' THEN SALARY*1.3
        WHEN 'PU_CLERK' THEN SALARY*1.4 
        ELSE SALARY
    END "결과"
FROM employees ORDER BY "결과";
--위아래 같은 결과가 나옴. 각각 DECODE/CASE, SALARY*1.1/SALARY+(SALARY*0.1)
SELECT first_name, JOB_ID, SALARY, SALARY*(1+DECODE(JOB_ID, 'FI_ACCOUNT', 0.1, 'IT_PROG', 0.2, 'SA_REP', 0.3, 'PU_CLERK', 0.4, SALARY)) "결과" FROM employees ORDER BY "결과";
SELECT first_name, JOB_ID, SALARY,
    SALARY*(1+CASE JOB_ID WHEN 'FI_ACCOUNT' THEN 0.1
        WHEN 'IT_PROG' THEN 0.2
        WHEN 'SA_REP' THEN 0.3
        WHEN 'PU_CLERK' THEN 0.4
        ELSE SALARY
    END) "결과"
FROM employees ORDER BY "결과";

--급여가 3000보다 작으면 'A', 3000이상 7500미만이면 'B', 7500이상이면 'C'로 표시
SELECT DEPARTMENT_ID, first_name, SALARY, DECODE(SIGN(salary-3000),-1, 'A', DECODE(SIGN(salary-7500), -1, 'B', 'C')) "GRADE" FROM employees WHERE DEPARTMENT_ID IN(30, 40, 90) ORDER BY DEPARTMENT_ID DESC;
SELECT DEPARTMENT_ID, first_name, SALARY, 
    CASE
        WHEN salary<3000 THEN 'A'
        WHEN salary<7500 THEN 'B'
        ELSE 'C'
    END"GRADE"
FROM employees WHERE DEPARTMENT_ID IN(30, 40, 90) ORDER BY DEPARTMENT_ID DESC;

----------------------------------

SELECT COUNT(*) FROM employees;

SELECT salary FROM employees;
SELECT AVG(salary) FROM employees;

SELECT MIN(first_name), MAX(first_name),  MIN(hire_date), MAX(hire_date) FROM employees;

SELECT AVG(salary) 평균, MAX(salary) 최고값, MIN(salary) 최저값, SUM(salary) 합계 FROM employees WHERE job_id = 'IT_PROG';
SELECT COUNT(*) CNT1, COUNT(salary) CNT2, AVG(salary) AVG1, AVG(NVL(salary, 0)) AVG2 FROM employees;

SELECT SUM(NVL(salary, 0)), NVL(SUM(salary),0) FROM employees;

SELECT COUNT(department_id), COUNT(DISTINCT department_id), COUNT(DISTINCT job_id) FROM employees;

SELECT AVG(salary), SUM(salary) / COUNT(*) FROM employees;

SELECT AVG(salary), SUM(salary) / COUNT(salary) FROM employees;

SELECT COUNT(department_id), COUNT(distinct department_id), SUM(department_id), SUM(distinct department_id) FROM employees;

SELECT DISTINCT department_id FROM employees ORDER BY department_id;
-- from->where->group by->having->select->order by

SELECT department_id, salary FROM employees ORDER BY department_id;

SELECT job_id, AVG(salary) FROM employees 
GROUP BY job_id
ORDER BY 2;

-- 부서별 조회
SELECT department_id 부서번호, count(*) 부서별인원수, AVG(salary) 평균급여, MIN(salary) 최저급여, MAX(salary) 최고급여, SUM(salary) 급여합계
FROM employees
GROUP BY department_id
ORDER BY department_id desc nulls last;

-- 업무별 조회
SELECT job_id 업무,  count(*) 인원수, SUM(salary) 급여합계, AVG(salary) 급여평균
FROM employees
GROUP BY job_id;

-- 부서, 업무별 조회
SELECT department_id 부서번호, job_id 업무,  count(*) 인원수, SUM(salary) 급여합계, AVG(salary) 급여평균
FROM employees
GROUP BY department_id, job_id
ORDER BY department_id, job_id;

SELECT job_id 업무, department_id 부서번호, count(*) 인원수, SUM(salary) 급여합계, AVG(salary) 급여평균
FROM employees
GROUP BY department_id, job_id
ORDER BY department_id, job_id;

SELECT department_id 부서번호, job_id 업무,  count(*) 인원수, SUM(salary) 급여합계, AVG(salary) 급여평균
FROM employees
GROUP BY job_id, department_id
ORDER BY department_id, job_id;

SELECT job_id 업무, department_id 부서번호,  count(*) 인원수, SUM(salary) 급여합계, AVG(salary) 급여평균
FROM employees
GROUP BY job_id, department_id
ORDER BY department_id, job_id;

-- HAVING 절
SELECT department_id 부서번호, count(*) 인원수, SUM(salary) 급여합계 FROM employees
GROUP BY department_id
HAVING count(*) > 4;

SELECT department_id 부서번호, AVG(salary) 급여평균, SUM(salary) 급여합계 FROM employees
GROUP BY department_id
HAVING MAX(salary) >= 9500;

-- having절의 위치는 group by 다음에 쓸 것을 권장
SELECT job_id, avg(salary), SUM(salary) FROM employees GROUP BY job_id having avg(salary) >= 3000;
SELECT job_id, avg(salary), SUM(salary) FROM employees HAVING AVG(salary) >= 3000 GROUP BY job_id;

-- 미리 거를건 WHERE절에 쓰는 것이 좋음
SELECT department_id, SUM(salary) FROM employees GROUP BY department_id HAVING SUM(salary) > 10000 AND department_id IN (20,30);
SELECT department_id, SUM(salary) FROM employees WHERE department_id IN (20,30) GROUP BY department_id HAVING SUM(salary) > 10000;

SELECT department_id, AVG(salary) FROM employees WHERE job_id='FI_MGR' GROUP BY department_id HAVING AVG(salary) > 3000;
-- 그룹 짓고 난 이후에 job_id가 없기 때문에 오류 발생
SELECT department_id, AVG(salary) FROM employees GROUP BY department_id HAVING AVG(salary) > 3000 AND job_id='FI_MGR';

-- 부서 급여 합계 중 최대값 조회
SELECT MAX(SUM(salary)) FROM employees GROUP BY department_id;

SELECT department_id, COUNT(department_id) FROM employees GROUP BY department_id;

SELECT first_name, hire_date, MIN(hire_date) FROM employees WHERE department_id = 20 GROUP BY first_name, hire_date;

SELECT MIN(hire_date) FROM employees WHERE department_id=20;

SELECT MIN(hire_date) FROM employees;

-- LISTAGG
SELECT LISTAGG(first_name, '; ')
    WITHIN GROUP(ORDER BY first_name desc) "firstName",
    LISTAGG(hire_date, '; ')
    WITHIN GROUP(ORDER BY first_name desc) "hireDate",
    MIN(hire_date) "Earliest"
FROM employees
WHERE department_id=20;

SELECT LISTAGG(first_name, ' / ')
    WITHIN GROUP(ORDER BY first_name desc) "firstName",
    LISTAGG(hire_date, '; ')
    WITHIN GROUP(ORDER BY hire_date desc) "hireDate",
    MIN(hire_date) "Earliest"
FROM employees
WHERE department_id=20;

SELECT department_id Dpts, LISTAGG(first_name, ' / ')
    WITHIN GROUP(ORDER BY hire_date) Employees,
    LISTAGG(salary , ',')
    WITHIN GROUP(ORDER BY hire_date) Salarys
FROM employees
GROUP BY department_id;

SELECT department_id "Dept.", hire_date "Date", first_name Name, 
LISTAGG(first_name, ' / ')
WITHIN GROUP(ORDER BY hire_date, first_name)
OVER (PARTITION BY department_id) Emp_list
FROM employees
WHERE hire_date <= '2003-09-01'
ORDER BY "Dept.", "Date", Name;

SELECT department_id, SUM(salary), LISTAGG(first_name, ' / ')
WITHIN GROUP(ORDER BY salary) first_name
FROM employees
GROUP BY department_id;
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

-- 0 return : 실제 data인 경우
-- 1 return : 실제 data가 아닌 경우
SELECT department_id, job_id, manager_id, SUM(salary), 
GROUPING(department_id), GROUPING(job_id), GROUPING(manager_id)
FROM employees GROUP BY ROLLUP(department_id, job_id, manager_id);

COMMIT;