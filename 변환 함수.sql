@C:\Users\User\Desktop\�б�����\OracleDB\OracleSQL\20230331.sql;

SELECT department_id, employee_id, first_name, job_id, salary, 
to_char(salary, '999,999') "c_sal" -- 3�ڸ����� , ���
FROM employees
WHERE department_id = 20;

SELECT department_id, employee_id, first_name, job_id, salary, 
to_char(salary, 'L999,999.99') "c_sal" -- �ε� ���� ��ȭ ��ȣ
FROM employees
WHERE department_id = 20;

SELECT department_id, employee_id, first_name, job_id, salary, 
to_char(-1234, '999999MI') "c_sal" -- ���� ��ȣ �����ʿ�
FROM employees
WHERE department_id = 20;

SELECT department_id, employee_id, first_name, job_id, salary, 
to_char(1234, '99.999EEEE') "c_sal" -- ���� ǥ��
FROM employees
WHERE department_id = 20;

SELECT department_id, employee_id, first_name, job_id, salary, 
to_char(salary, '9999V999') "c_sal" -- 10�� ����
FROM employees
WHERE department_id = 20;

SELECT department_id, employee_id, first_name, job_id, salary, 
to_char(1234, 'B9999.99') "c_sal" -- 0�ƴ� ���� ó��
FROM employees
WHERE department_id = 20;

-- �ش� �⵵���� �� ��° ���ΰ�?
SELECT to_char(sysdate, 'WW'), sysdate FROM dual;

SELECT first_name, hire_date, to_char(hire_date, 'YYYY"��" MM"��" DD"��"') hd_kor
FROM employees
WHERE department_id = 20
ORDER BY hire_date DESC;

SELECT employee_id, first_name, 
TO_CHAR(hire_date, 'YY/MM/DD(DAY) HH24:MI:SS') �Ի���
FROM employees
WHERE job_id = 'PU_CLERK';

SELECT TO_CHAR(sysdate, 'HH24') FROM dual;

-- ADD_MONTHS(�ش糯¥, ���� ������)
-- TO_DATE(��¥��ȯ���ɵ�����, ��¥����)
SELECT TO_CHAR(ADD_MONTHS(TO_DATE('200306', 'YYYYMM'), 15), 'YYYY') FROM dual;

-- RR: 98�϶�, ���� �⵵���� 1998�� �������, 2098�� ������� �Ǵ��� ����� �⵵�� �ؼ���.
-- YY: ������ ���� ����� �ؼ���.
SELECT TO_CHAR(TO_DATE('98', 'RR'),'YYYY') test1, 
TO_CHAR(TO_DATE('03', 'RR'),'YYYY') test2, 
TO_CHAR(TO_DATE('98', 'YY'),'YYYY') test3,
TO_CHAR(TO_DATE('03', 'YY'),'YYYY') test4
FROM dual;

SELECT first_name, hire_date, TO_DATE(NEXT_DAY(ADD_MONTHS(hire_date, 6), '��'),'YYYY/MM/DD') "NEXT_SUNDAY"
FROM employees
WHERE manager_id = 100;

SELECT '0001230' ���1, to_number('0001230') ���2
FROM dual;

SELECT to_timestamp('2003-6-25 12:32:00', 'YYYY-MM-DD HH:MI:SS') ���
FROM dual;

SELECT to_timestamp('10-09-77 14:10:10.123000', 'DD-MM-RR HH24:MI:SS.FF') ���
FROM dual;

-- ���� �ð� ���
SELECT sysdate, sysdate + to_dsinterval('03 11:47:23') ��� FROM dual;

SELECT first_name, hire_date, hire_date + TO_YMINTERVAL('01-06') "��� DATE" 
FROM employees;

-- null�� ���� -> ������ null
SELECT department_id, first_name, salary, commission_pct, 
salary*(1 + commission_pct) as "�ݿ��޿�"
FROM employees
WHERE department_id IN (30,80);

-- null�ϰ�� salary, null�ƴ� ���  salary*(1 + commission_pct)
SELECT department_id, first_name, salary, commission_pct, 
NVL2(salary, salary, salary*(1 + commission_pct)) as "�ݿ��޿�"
FROM employees
WHERE department_id IN (30,80);

SELECT first_name, manager_id, NVL2(manager_id, manager_id || '���', '������') as "���Ŵ���"
FROM employees
WHERE department_id IN (20,90);

ALTER SESSION SET NLS_TIMESTAMP_FORMAT = 'YYYY/MM/DD HH24:MI:SS.FF';

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
COMMIT;