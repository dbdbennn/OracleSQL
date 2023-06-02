SELECT department_id, first_name, salary, commission_pct, salary*(1+nvl(commission_pct, 0)) "�ݿ��޿�" FROM employees WHERE department_id IN(30, 80);

SELECT department_id, first_name, MANAGER_ID, NVL2(MANAGER_ID, MANAGER_ID||'���', '������') "���Ŵ���" FROM employees WHERE department_id IN(20,90);
SELECT department_id, first_name, MANAGER_ID, NVL2(MANAGER_ID, CONCAT(MANAGER_ID,'���'), '������') "���Ŵ���" FROM employees WHERE department_id IN(20,90);

SELECT first_name, JOB_ID, NULLIF(JOB_ID, 'PU_CLERK') "���" FROM employees WHERE department_id IN(30) ORDER BY FIRST_NAME;

SELECT first_name, COMMISSION_PCT, SALARY, COALESCE(COMMISSION_PCT, SALARY, 0.5) "���" FROM employees;

SELECT first_name, SALARY, (salary*commission_pct)+6000 "�񱳰�", GREATEST(SALARY, (salary*commission_pct)+6000) "���" FROM employees WHERE SALARY IS NOT NULL AND COMMISSION_PCT IS NOT NULL;

SELECT first_name, SALARY, (salary*commission_pct)+6000 "�񱳰�", LEAST(SALARY, (salary*commission_pct)+6000) "���" FROM employees WHERE SALARY IS NOT NULL AND COMMISSION_PCT IS NOT NULL;

SELECT first_name, JOB_ID, SALARY, DECODE(JOB_ID, 'FI_ACCOUNT', SALARY*1.1, 'IT_PROG', SALARY*1.2, 'SA_REP', SALARY*1.3, 'PU_CLERK', SALARY*1.4, SALARY) "���" FROM employees ORDER BY "���";
SELECT first_name, JOB_ID, SALARY,
    CASE JOB_ID WHEN 'FI_ACCOUNT' THEN SALARY*1.1
        WHEN 'IT_PROG' THEN SALARY*1.2
        WHEN 'SA_REP' THEN SALARY*1.3
        WHEN 'PU_CLERK' THEN SALARY*1.4 
        ELSE SALARY
    END "���"
FROM employees ORDER BY "���";
--���Ʒ� ���� ����� ����. ���� DECODE/CASE, SALARY*1.1/SALARY+(SALARY*0.1)
SELECT first_name, JOB_ID, SALARY, SALARY*(1+DECODE(JOB_ID, 'FI_ACCOUNT', 0.1, 'IT_PROG', 0.2, 'SA_REP', 0.3, 'PU_CLERK', 0.4, SALARY)) "���" FROM employees ORDER BY "���";
SELECT first_name, JOB_ID, SALARY,
    SALARY*(1+CASE JOB_ID WHEN 'FI_ACCOUNT' THEN 0.1
        WHEN 'IT_PROG' THEN 0.2
        WHEN 'SA_REP' THEN 0.3
        WHEN 'PU_CLERK' THEN 0.4
        ELSE SALARY
    END) "���"
FROM employees ORDER BY "���";

--�޿��� 3000���� ������ 'A', 3000�̻� 7500�̸��̸� 'B', 7500�̻��̸� 'C'�� ǥ��
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

SELECT AVG(salary) ���, MAX(salary) �ְ�, MIN(salary) ������, SUM(salary) �հ� FROM employees WHERE job_id = 'IT_PROG';
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

-- �μ��� ��ȸ
SELECT department_id �μ���ȣ, count(*) �μ����ο���, AVG(salary) ��ձ޿�, MIN(salary) �����޿�, MAX(salary) �ְ�޿�, SUM(salary) �޿��հ�
FROM employees
GROUP BY department_id
ORDER BY department_id desc nulls last;

-- ������ ��ȸ
SELECT job_id ����,  count(*) �ο���, SUM(salary) �޿��հ�, AVG(salary) �޿����
FROM employees
GROUP BY job_id;

-- �μ�, ������ ��ȸ
SELECT department_id �μ���ȣ, job_id ����,  count(*) �ο���, SUM(salary) �޿��հ�, AVG(salary) �޿����
FROM employees
GROUP BY department_id, job_id
ORDER BY department_id, job_id;

SELECT job_id ����, department_id �μ���ȣ, count(*) �ο���, SUM(salary) �޿��հ�, AVG(salary) �޿����
FROM employees
GROUP BY department_id, job_id
ORDER BY department_id, job_id;

SELECT department_id �μ���ȣ, job_id ����,  count(*) �ο���, SUM(salary) �޿��հ�, AVG(salary) �޿����
FROM employees
GROUP BY job_id, department_id
ORDER BY department_id, job_id;

SELECT job_id ����, department_id �μ���ȣ,  count(*) �ο���, SUM(salary) �޿��հ�, AVG(salary) �޿����
FROM employees
GROUP BY job_id, department_id
ORDER BY department_id, job_id;

-- HAVING ��
SELECT department_id �μ���ȣ, count(*) �ο���, SUM(salary) �޿��հ� FROM employees
GROUP BY department_id
HAVING count(*) > 4;

SELECT department_id �μ���ȣ, AVG(salary) �޿����, SUM(salary) �޿��հ� FROM employees
GROUP BY department_id
HAVING MAX(salary) >= 9500;

-- having���� ��ġ�� group by ������ �� ���� ����
SELECT job_id, avg(salary), SUM(salary) FROM employees GROUP BY job_id having avg(salary) >= 3000;
SELECT job_id, avg(salary), SUM(salary) FROM employees HAVING AVG(salary) >= 3000 GROUP BY job_id;

-- �̸� �Ÿ��� WHERE���� ���� ���� ����
SELECT department_id, SUM(salary) FROM employees GROUP BY department_id HAVING SUM(salary) > 10000 AND department_id IN (20,30);
SELECT department_id, SUM(salary) FROM employees WHERE department_id IN (20,30) GROUP BY department_id HAVING SUM(salary) > 10000;

SELECT department_id, AVG(salary) FROM employees WHERE job_id='FI_MGR' GROUP BY department_id HAVING AVG(salary) > 3000;
-- �׷� ���� �� ���Ŀ� job_id�� ���� ������ ���� �߻�
SELECT department_id, AVG(salary) FROM employees GROUP BY department_id HAVING AVG(salary) > 3000 AND job_id='FI_MGR';

-- �μ� �޿� �հ� �� �ִ밪 ��ȸ
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

-- 0 return : ���� data�� ���
-- 1 return : ���� data�� �ƴ� ���
SELECT department_id, job_id, manager_id, SUM(salary), 
GROUPING(department_id), GROUPING(job_id), GROUPING(manager_id)
FROM employees GROUP BY ROLLUP(department_id, job_id, manager_id);

COMMIT;