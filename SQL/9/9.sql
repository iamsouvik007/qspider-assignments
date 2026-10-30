-- QUESTIONS: (TWO TABLES)

-- 1. WAQTD NAME OF THE EMPLOYEE AND HIS MANAGER'S NAME IF EMPLOYEE IS WORKING AS CLERK

SELECT e.ename , m.ename 
FROM emp e
JOIN emp m
    ON e.mgr = m.empno
WHERE e.job = 'CLERK';



-- 2. WAQTD NAME OF THE EMPLOYEE AND MANAGER'S DESIGNATION IF MANAGER WORKS IN DEPT 10 OR 20

SELECT e.ename AS employee_name,
       m.job AS manager_designation
FROM emp e
JOIN emp m
    ON e.mgr = m.empno
WHERE m.deptno IN (10, 20);

-- 3. WAQTD NAME OF THE EMPLOYEE AND MANAGER'S SALARY IF EMPLOYEE AND MANAGER BOTH EARN MORE THAN 2300

SELECT e.ename AS employee_name,
       m.sal AS manager_salary
FROM emp e
JOIN emp m
    ON e.mgr = m.empno
WHERE e.sal > 2300
  AND m.sal > 2300;


-- 4. WAQTD EMPLOYEE NAME AND MANAGER'S HIREDATE IF EMPLOYEE WAS HIRED BEFORE 1982

SELECT e.ename AS employee_name,
       m.hiredate AS manager_hiredate
FROM emp e
JOIN emp m
    ON e.mgr = m.empno
WHERE e.hiredate < DATE '1982-01-01';

-- 5. WAQTD EMPLOYEE NAME AND MANAGER'S COMMISSION IF EMPLOYEE WORKS AS SALESMAN AND MANAGER WORKS IN DEPT 30

SELECT e.ename AS employee_name,
       m.comm AS manager_commission
FROM emp e
JOIN emp m
    ON e.mgr = m.empno
WHERE e.job = 'SALESMAN'
  AND m.deptno = 30;

-- 6. WAQTD EMPLOYEE NAME AND MANAGER NAME AND THEIR SALARIES IF EMPLOYEE EARNS MORE THAN MANAGER

SELECT e.ename AS employee_name,
       e.sal AS employee_salary,
       m.ename AS manager_name,
       m.sal AS manager_salary
FROM emp e
JOIN emp m
    ON e.mgr = m.empno
WHERE e.sal > m.sal;


-- 7. WAQTD EMPLOYEE NAME AND HIREDATE, MANAGER NAME AND HIREDATE IF MANAGER WAS HIRED BEFORE EMPLOYEE

SELECT e.ename AS employee_name,
       e.hiredate AS employee_hiredate,
       m.ename AS manager_name,
       m.hiredate AS manager_hiredate
FROM emp e
JOIN emp m
    ON e.mgr = m.empno
WHERE m.hiredate < e.hiredate;


-- 8. WAQTD EMPLOYEE NAME AND MANAGER NAME IF BOTH ARE WORKING IN THE SAME JOB

SELECT e.ename AS employee_name,
       m.ename AS manager_name
FROM emp e
JOIN emp m
    ON e.mgr = m.empno
WHERE e.job = m.job;

-- 9. WAQTD EMPLOYEE NAME AND MANAGER NAME IF MANAGER IS WORKING AS ACTUAL MANAGER

SELECT e.ename AS employee_name,
       m.ename AS manager_name
FROM emp e
JOIN emp m
    ON e.mgr = m.empno
WHERE m.job = 'MANAGER';


-- 10. WAQTD EMPLOYEE NAME AND MANAGER NAME ALONG WITH THEIR ANNUAL SALARIES IF EMPLOYEE WORKS IN DEPT 10 OR 20 AND MANAGER'S SALARY IS GREATER THAN EMPLOYEE'S SALARY

SELECT e.ename AS employee_name,
       m.ename AS manager_name,
       e.sal * 12 AS employee_annual_salary,
       m.sal * 12 AS manager_annual_salary
FROM emp e
JOIN emp m
    ON e.mgr = m.empno
WHERE e.deptno IN (10, 20)
  AND m.sal > e.sal;


-- 11. WAQTD EMPLOYEE'S NAME AND MANAGER'S DESIGNATION FOR ALL THE EMPLOYEES

SELECT e.ename AS employee_name,
       m.job AS manager_designation
FROM emp e
LEFT JOIN emp m
    ON e.mgr = m.empno;

-- 12. WAQTD EMPLOYEE'S NAME AND MANAGER'S SALARY FOR ALL THE EMPLOYEES IF MANAGER'S SALARY ENDS WITH 50


-- MULTIPLE TABLES

-- 1. WAQTD EMPLOYEE NAME AND MANAGER NAME OF ALL THE EMPLOYEES WHOSE SALARY IS MORE THAN 2000 AND THE MANAGER'S DESIGNATION IS ACTUAL MANAGER

SELECT e.ename AS employee_name,
       m.ename AS manager_name
FROM emp e
JOIN emp m
    ON e.mgr = m.empno
WHERE e.sal > 2000
  AND m.job = 'MANAGER';


-- 2. WAQTD MANAGER'S MANAGER'S NAME AND THE MANAGER'S LOCATION OF ALL THE EMPLOYEES IF THE MANAGER IS WORKING IN THE LOCATIONS NEW YORK OR DALLAS
SELECT mm.ename AS manager_manager_name,
       d.loc AS manager_location
FROM emp e
JOIN emp m
    ON e.mgr = m.empno
LEFT JOIN emp mm
    ON m.mgr = mm.empno
JOIN dept d
    ON m.deptno = d.deptno
WHERE d.loc IN ('NEW YORK', 'DALLAS');


-- 3. WAQTD EMPLOYEE NAME, THEIR DEPARTMENT NAME, MANAGER NAME AND THEIR LOCATION IF THE MANAGER'S MANAGER'S LOCATION IS NEW YORK, THE MANAGER WAS HIRED BETWEEN 1980 AND 1989, AND THE EMPLOYEE IS EARNING BETWEEN 2000 AND 5000
SELECT e.ename AS employee_name,
       de.dname AS employee_department,
       m.ename AS manager_name,
       dm.loc AS manager_location
FROM emp e
JOIN emp m
    ON e.mgr = m.empno
JOIN emp mm
    ON m.mgr = mm.empno
JOIN dept de
    ON e.deptno = de.deptno
JOIN dept dm
    ON m.deptno = dm.deptno
JOIN dept dmm
    ON mm.deptno = dmm.deptno
WHERE dmm.loc = 'NEW YORK'
  AND m.hiredate >= DATE '1980-01-01'
  AND m.hiredate < DATE '1990-01-01'
  AND e.sal BETWEEN 2000 AND 5000;


-- 4. WAQTD EMPLOYEE NAME, MANAGER NAME AND MANAGER'S SALARY IF THE EMPLOYEE'S LOCATION CONTAINS THE CHARACTER 'A' AND THE MANAGER WAS HIRED IN FEBRUARY

SELECT e.ename AS employee_name,
       m.ename AS manager_name,
       m.sal AS manager_salary
FROM emp e
JOIN emp m
    ON e.mgr = m.empno
JOIN dept d
    ON e.deptno = d.deptno
WHERE UPPER(d.loc) LIKE '%A%'
  AND EXTRACT(MONTH FROM m.hiredate) = 2;


