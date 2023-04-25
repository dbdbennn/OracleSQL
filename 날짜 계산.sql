SELECT ROUND(4567.678) ���1, ROUND(4567.678, 0) ���2, ROUND(4567.678, 2) ���3, ROUND(4567.678, -2) ���4
FROM dual;

SELECT TRUNC(4567.678) ���1, TRUNC(4567.678, 0) ���2, TRUNC(4567.678, 2) ���3, TRUNC(4567.678, -2) ���4
FROM dual;

SELECT POWER(2, 10) ���1, CEIL(4.8) ���2, FLOOR(4.8) ���3
FROM dual;

SELECT department_id, salary, MOD(salary, 300)
FROM employees
WHERE department_id = 20;

SELECT employee_id, salary, SIGN(salary-2900)
FROM employees
WHERE department_id = 30;

SELECT value FROM nls_session_parameters 
WHERE parameter = 'NLS_TIMESTAMP_TZ_FORMAT';

SELECT SYSDATE FROM dual;

SELECT LOCALTIMESTAMP FROM dual;

SELECT SYSTIMESTAMP FROM dual;

SELECT first_name, hire_date, hire_date+3, hire_date+5/24
FROM employees
WHERE department_id = 30;

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';

-- ���� ��������
SELECT department_id, first_name, hire_date, 
TRUNC(sysdate-hire_date) ��ü�ϼ�,
TRUNC((sysdate-hire_date) / 30) ��, 
TRUNC(MOD((sysdate-hire_date) , 30) / 7) ��, 
TRUNC(MOD(MOD((sysdate-hire_date), 30), 7)) ��
FROM employees WHERE department_id = 30
ORDER BY sysdate-hire_date DESC;

-- ���� ��������
SELECT department_id, first_name, hire_date, 
TRUNC(sysdate-hire_date) ��ü�ϼ�, 
TRUNC((sysdate-hire_date)/365) ��,
TRUNC(MOD((sysdate-hire_date),365)/30) ��, 
TRUNC(MOD(MOD((sysdate-hire_date),365),30 ) / 7) ��, 
TRUNC(MOD(MOD(MOD((sysdate-hire_date),365),30),7)) ��
FROM employees WHERE department_id = 30
ORDER BY sysdate-hire_date DESC;

SELECT extract(day from sysdate) ����, extract(month from sysdate) ��, extract(year from sysdate) �⵵
FROM dual;

-- 'hh24' -> 24�ð���
SELECT systimestamp A, TO_CHAR(systimestamp, 'hh12') B, extract(hour from localtimestamp) C
FROM dual;

SELECT systimestamp,
TO_CHAR(systimestamp, 'hh24') ch,
extract(timezone_hour from systimestamp) etzh,
extract(hour from systimestamp) eh,
extract(hour from cast(systimestamp as timestamp)) ehc
FROM dual;

SELECT systimestamp,
extract(hour from systimestamp) h1,
extract(hour from systimestamp)
+ extract(timezone_hour from systimestamp) h2
FROM dual;

SELECT first_name, hire_date, extract(year from hire_date) "HIRE_YEAR",
extract(day from hire_date) "HIRE_DAY"
FROM employees;

SELECT first_name, hire_date, sysdate, months_between(sysdate, hire_date) M_BETWEEN,
TRUNC(months_between(sysdate, hire_date)) T_M_BETWEEN FROM employees 
WHERE department_id = 30
ORDER BY M_BETWEEN;

SELECT first_name, hire_date, add_months(hire_date, 5) "add_mon"
FROM employees
WHERE department_id IN (10,30)
ORDER BY hire_date DESC;

SELECT first_name, hire_date, next_day(hire_date, 2) "nd_Mon",
next_day(hire_date, 6) "nd_Fri"
FROM employees
WHERE department_id = 30
ORDER BY hire_date DESC;

SELECT department_id, employee_id, first_name, hire_date, 
last_day(hire_date)- hire_date + 1 hire_day
FROM employees
WHERE department_id = 30;

-- ����� ���� to_char���
SELECT to_char(sysdate, 'YY/MM/DD HH24:MI:SS') normal,
to_char(trunc(sysdate), 'YY/MM/DD HH24:MI:SS') trunc, -- ����
to_char(round(sysdate), 'YY/MM/DD HH24:MI:SS') round --�ݿø�
FROM dual;

SELECT hire_date, round(hire_date,'MONTH') h_m, round(hire_date, 'YEAR') h_y
FROM employees
WHERE department_id = 30;

SELECT hire_date, trunc(hire_date,'MONTH') h_m, trunc(hire_date, 'YEAR') h_y
FROM employees
WHERE department_id = 30;

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
COMMIT;
