@C:\Users\User\Desktop\학교수업\OracleDB\OracleSQL\20230331.sql;

SELECT department_id, employee_id, first_name, job_id, salary, 
to_char(salary, '999,999') "c_sal" -- 3자리마다 , 출력
FROM employees
WHERE department_id = 20;

SELECT department_id, employee_id, first_name, job_id, salary, 
to_char(salary, 'L999,999.99') "c_sal" -- 부동 지역 통화 기호
FROM employees
WHERE department_id = 20;

SELECT department_id, employee_id, first_name, job_id, salary, 
to_char(-1234, '999999MI') "c_sal" -- 빼기 기호 오른쪽에
FROM employees
WHERE department_id = 20;

SELECT department_id, employee_id, first_name, job_id, salary, 
to_char(1234, '99.999EEEE') "c_sal" -- 과학 표기
FROM employees
WHERE department_id = 20;

SELECT department_id, employee_id, first_name, job_id, salary, 
to_char(salary, '9999V999') "c_sal" -- 10씩 곱함
FROM employees
WHERE department_id = 20;

SELECT department_id, employee_id, first_name, job_id, salary, 
to_char(1234, 'B9999.99') "c_sal" -- 0아닌 공백 처리
FROM employees
WHERE department_id = 20;

-- 해당 년도에서 몇 번째 주인가?
SELECT to_char(sysdate, 'WW'), sysdate FROM dual;

SELECT first_name, hire_date, to_char(hire_date, 'YYYY"년" MM"월" DD"일"') hd_kor
FROM employees
WHERE department_id = 20
ORDER BY hire_date DESC;

SELECT employee_id, first_name, 
TO_CHAR(hire_date, 'YY/MM/DD(DAY) HH24:MI:SS') 입사일
FROM employees
WHERE job_id = 'PU_CLERK';

SELECT TO_CHAR(sysdate, 'HH24') FROM dual;

-- ADD_MONTHS(해당날짜, 더할 개월수)
-- TO_DATE(날짜변환가능데이터, 날짜형식)
SELECT TO_CHAR(ADD_MONTHS(TO_DATE('200306', 'YYYYMM'), 15), 'YYYY') FROM dual;

-- RR: 98일때, 현재 년도에서 1998이 가까운지, 2098이 가까운지 판단해 가까운 년도로 해석함.
-- YY: 무조건 현재 세기로 해석함.
SELECT TO_CHAR(TO_DATE('98', 'RR'),'YYYY') test1, 
TO_CHAR(TO_DATE('03', 'RR'),'YYYY') test2, 
TO_CHAR(TO_DATE('98', 'YY'),'YYYY') test3,
TO_CHAR(TO_DATE('03', 'YY'),'YYYY') test4
FROM dual;

SELECT first_name, hire_date, TO_DATE(NEXT_DAY(ADD_MONTHS(hire_date, 6), '일'),'YYYY/MM/DD') "NEXT_SUNDAY"
FROM employees
WHERE manager_id = 100;

SELECT '0001230' 결과1, to_number('0001230') 결과2
FROM dual;

SELECT to_timestamp('2003-6-25 12:32:00', 'YYYY-MM-DD HH:MI:SS') 결과
FROM dual;

SELECT to_timestamp('10-09-77 14:10:10.123000', 'DD-MM-RR HH24:MI:SS.FF') 결과
FROM dual;

-- 후의 시간 계산
SELECT sysdate, sysdate + to_dsinterval('03 11:47:23') 결과 FROM dual;

SELECT first_name, hire_date, hire_date + TO_YMINTERVAL('01-06') "결과 DATE" 
FROM employees;

-- null과 연산 -> 무조건 null
SELECT department_id, first_name, salary, commission_pct, 
salary*(1 + commission_pct) as "금월급여"
FROM employees
WHERE department_id IN (30,80);

-- null일경우 salary, null아닐 경우  salary*(1 + commission_pct)
SELECT department_id, first_name, salary, commission_pct, 
NVL2(salary, salary, salary*(1 + commission_pct)) as "금월급여"
FROM employees
WHERE department_id IN (30,80);

SELECT first_name, manager_id, NVL2(manager_id, manager_id || '담당', '상위자') as "담당매니저"
FROM employees
WHERE department_id IN (20,90);

ALTER SESSION SET NLS_TIMESTAMP_FORMAT = 'YYYY/MM/DD HH24:MI:SS.FF';

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
COMMIT;