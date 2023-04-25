SELECT employee_id, first_name, length(first_name), salary, length(salary)
FROM employees
WHERE department_id = 20;

SELECT first_name, instr(first_name, 'a') FROM employees;

SELECT first_name, SUBSTR(first_name,1,3), SUBSTR(first_name, 3), SUBSTR(first_name,-3,2)
FROM employees
WHERE department_id = 10;

SELECT parameter, value
FROM nls_database_parameters
WHERE parameter = 'NLS_CHARACTERSET';

SELECT '+'||SUBSTRB('I am here with you',5,3)||'+' 결과1,
'+'||SUBSTR('나 여기 있어',5,3)||'+' 결과2, 
'+'||SUBSTRB('나 여기 있어',5,3)||'+' 결과3 --한글 3byte처리
FROM dual;

SELECT 3*4 FROM dual;
DESCRIBE dual; 
-- DUMMY : CARCHAR2(1)
-- 일시적 산술
SELECT * FROM dual;
SELECT SYSDATE FROM dual;
SELECT SYSTIMESTAMP FROM dual;

SELECT first_name, LPAD(first_name, 15, '*'), salary, LPAD(salary,10,'*')
FROM employees
WHERE department_id = 10;

SELECT first_name, RPAD(first_name, 15, '*'), salary, RPAD(salary,10,'*')
FROM employees
WHERE department_id = 10;


SELECT first_name, job_id, LTRIM(job_id, 'A'), salary, LTRIM(salary,1)
FROM employees
WHERE department_id = 20;


SELECT first_name, job_id, RTRIM(job_id, 'T'), salary, RTRIM(salary,0)
FROM employees
WHERE department_id = 10;

SELECT first_name, REPLACE(job_id, 'CO', '*$') 변경결과
FROM employees
WHERE department_id=30;

SELECT first_name, TRANSLATE(first_name, 'Al', '*$') 변경결과2
FROM employees
WHERE department_id=30;

SELECT TRIM(LEADING 'A' FROM 'AABDCADD') 결과1,
TRIM('A' FROM 'AABDCADD') 결과2,
TRIM(TRAILING 'D' FROM 'AABDCADD') 결과3
FROM DUAL;

SELECT employee_id, first_name, TRANSLATE(first_name, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
'abcdefghijklmnopqrxtuvwxyz') u_lower
FROM employees
WHERE department_id = 10;








