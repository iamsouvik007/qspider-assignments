CREATE DATABASE subquery_practice;


-- Create DEPT table
CREATE TABLE dept (
    deptno INTEGER PRIMARY KEY,
    dname  VARCHAR(14),
    loc    VARCHAR(13)
);

-- Create EMP table
CREATE TABLE emp (
    empno    INTEGER PRIMARY KEY,
    ename    VARCHAR(10) NOT NULL,
    job      VARCHAR(9),
    mgr      INTEGER,
    hiredate DATE,
    sal      NUMERIC(7,2),
    comm     NUMERIC(7,2),
    deptno   INTEGER REFERENCES dept(deptno)
);

-- Insert departments
INSERT INTO dept (deptno, dname, loc) VALUES
(10, 'ACCOUNTING', 'NEW YORK'),
(20, 'RESEARCH',  'DALLAS'),
(30, 'SALES',     'CHICAGO'),
(40, 'OPERATIONS','BOSTON');

-- Insert employees
INSERT INTO emp
(empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES
(7369, 'SMITH',  'CLERK',     7902, DATE '1980-12-17',  800, NULL, 20),
(7499, 'ALLEN',  'SALESMAN',  7698, DATE '1981-02-20', 1600,  300, 30),
(7521, 'WARD',   'SALESMAN',  7698, DATE '1981-02-22', 1250,  500, 30),
(7566, 'JONES',  'MANAGER',   7839, DATE '1981-04-02', 2975, NULL, 20),
(7654, 'MARTIN', 'SALESMAN',  7698, DATE '1981-09-28', 1250, 1400, 30),
(7698, 'BLAKE',  'MANAGER',   7839, DATE '1981-05-01', 2850, NULL, 30),
(7782, 'CLARK',  'MANAGER',   7839, DATE '1981-06-09', 2450, NULL, 10),
(7788, 'SCOTT',  'ANALYST',   7566, DATE '1987-04-19', 3000, NULL, 20),
(7839, 'KING',   'PRESIDENT', NULL, DATE '1981-11-17', 5000, NULL, 10),
(7844, 'TURNER', 'SALESMAN',  7698, DATE '1981-09-08', 1500,    0, 30),
(7876, 'ADAMS',  'CLERK',     7788, DATE '1987-05-23', 1100, NULL, 20),
(7900, 'JAMES',  'CLERK',     7698, DATE '1981-12-03',  950, NULL, 30),
(7902, 'FORD',   'ANALYST',   7566, DATE '1981-12-03', 3000, NULL, 20),
(7934, 'MILLER', 'CLERK',     7782, DATE '1982-01-23', 1300, NULL, 10);




-- 1. WAQTD NAME OF THE EMPLOYEES EARNING MORE THAN ADAMS

SELECT ename 
FROM emp 
WHERE sal > (SELECT sal 
			FROM emp 
			WHERE ename = 'ADAMS'
			);



-- 2. WAQTD NAME AND SALARY OF THE EMPLOYEES EARNING LESS THAN KING

SELECT ename, sal 
FROM emp 
WHERE sal < (
				SELECT sal 
				FROM emp 
				WHERE ename = 'KING'

);


-- 3. WAQTD NAME AND DEPTNO OF THE EMPLOYEES IF THEY ARE WORKING IN THE SAME DEPT AS JONES

SELECT ename, deptno 
FROM emp 
WHERE deptno = (
					SELECT deptno 
					FROM emp 
					WHERE ename = 'JONES'
);

-- 4. WAQTD NAME AND JOB OF ALL THE EMPLOYEES WORKING IN THE SAME DESIGNATION AS JAMES

SELECT ename, job 
FROM emp 
WHERE job = ( 
				SELECT job 
				FROM emp 
				WHERE ename = 'JAMES'

);


-- 5. WAQTD EMPNO AND ENAME ALONG WITH ANNUAL SALARY OF ALL THE EMPLOYEES IF THEIR ANNUAL SALARY IS GREATER THAN WARD'S ANNUAL SALARY

SELECT empno, ename, sal * 12 AS ANNUAL_SAL 
FROM emp 
WHERE sal * 12 > (
					SELECT sal * 12 
					FROM emp 
					WHERE ename = 'WARD'
);

-- 6. WAQTD NAME AND HIREDATE OF THE EMPLOYEES IF THEY ARE HIRED BEFORE SCOTT

SELECT ename, hiredate 
FROM emp 
WHERE hiredate < (
					SELECT hiredate 
					FROM emp 
					WHERE ename = 'SCOTT'

)

-- 7. WAQTD NAME AND HIREDATE OF THE EMPLOYEES IF THEY ARE HIRED AFTER THE PRESIDENT

SELECT ename, hiredate 
FROM emp 
WHERE hiredate > (
					SELECT hiredate 
					FROM emp 
					WHERE job = 'PRESIDENT'
);

-- 8. WAQTD NAME AND SAL OF THE EMPLOYEE IF THEY ARE EARNING SAL LESS THAN THE EMPLOYEE WHOSE EMPNO IS 7839

SELECT ename, sal 
FROM emp 
WHERE sal < (
				SELECT sal 
				FROM emp 
				WHERE empno = 7839
);


-- 9. WAQTD ALL THE DETAILS OF THE EMPLOYEES IF THE EMPLOYEES ARE HIRED BEFORE MILLER

SELECT * 
FROM emp 
WHERE hiredate < (
					SELECT hiredate 
					FROM emp 
					WHERE ename = 'MILLER'
);

-- 10. WAQTD ENAME AND EMPNO OF THE EMPLOYEES IF EMPLOYEES ARE EARNING MORE THAN ALLEN

SELECT ename, empno 
FROM emp 
WHERE sal > (
				SELECT sal 
				FROM emp 
				WHERE ename = 'ALLEN'
);


-- 11. WAQTD ENAME AND SALARY OF ALL THE EMPLOYEES WHO ARE EARNING MORE THAN MILLER BUT LESS THAN ALLEN

SELECT ename, sal 
FROM emp 
WHERE sal > (SELECT sal 
			FROM emp 
			WHERE ename = 'MILLER')
AND sal < ( 
			SELECT sal 
			FROM emp 
			WHERE ename = 'ALLEN'
);

-- 12. WAQTD ALL THE DETAILS OF THE EMPLOYEES WORKING IN DEPT 20 AND WORKING IN THE SAME DESIGNATION AS SMITH

SELECT * 
FROM emp 
WHERE deptno = 20 
AND job = (SELECT job 
			FROM emp 
			WHERE ename = 'SMITH');

-- 13. WAQTD ALL THE DETAILS OF THE EMPLOYEES WORKING AS MANAGER IN THE SAME DEPT AS TURNER

SELECT * 
FROM emp 
WHERE job = 'MANAGER'
AND deptno IN (SELECT deptno 
				FROM emp 
				WHERE ename = 'TURNER'
);

-- 14. WAQTD NAME AND HIREDATE OF THE EMPLOYEES HIRED AFTER 1980 AND BEFORE KING

SELECT ename, hiredate 
FROM emp 
WHERE hiredate >= DATE '1981-01-01'
AND hiredate < (
				SELECT hiredate 
				FROM emp 
				WHERE ename = 'KING'
);

-- 15. WAQTD NAME AND SAL ALONG WITH ANNUAL SAL FOR ALL EMPLOYEES WHOSE SAL IS LESS THAN BLAKE AND MORE THAN 3500

SELECT ename, sal, sal * 12 AS ANNUAL_SAL 
FROM emp 
WHERE sal < (
				SELECT sal 
				FROM emp 
				WHERE ename = 'BLAKE'
)
AND sal > 3500; 


-- 16. WAQTD ALL THE DETAILS OF EMPLOYEES WHO EARN MORE THAN SCOTT BUT LESS THAN KING

SELECT *
FROM emp
WHERE sal > (
    SELECT sal
    FROM emp
    WHERE ename = 'SCOTT'
)
AND sal < (
    SELECT sal
    FROM emp
    WHERE ename = 'KING'
);

-- 17. WAQTD NAME OF THE EMPLOYEES WHOSE NAME STARTS WITH 'A' AND WORK IN THE SAME DEPT AS BLAKE

SELECT ename
FROM emp
WHERE ename LIKE 'A%'
AND deptno = (
    SELECT deptno
    FROM emp
    WHERE ename = 'BLAKE'
);
-- 18. WAQTD NAME AND COMM IF EMPLOYEES EARN COMMISSION AND WORK IN THE SAME DESIGNATION AS SMITH

SELECT ename, comm 
FROM emp 
WHERE comm IS NOT NULL 
AND job IN (SELECT job 
			FROM emp 
			WHERE ename = 'SMITH'
);


-- 19. WAQTD DETAILS OF ALL THE EMPLOYEES WORKING AS CLERK IN THE SAME DEPT AS TURNER

SELECT * 
FROM emp 
WHERE job = 'CLERK'
AND deptno  IN ( 
				SELECT deptno 
				FROM emp 
				WHERE ename = 'TURNER'
);


-- 20. WAQTD ENAME, SAL AND DESIGNATION OF THE EMPLOYEES WHOSE ANNUAL SALARY IS MORE THAN SMITH AND LESS THAN KING

SELECT ename,
       sal,
       job
FROM emp
WHERE sal * 12 > (
				    SELECT sal * 12
				    FROM emp
				    WHERE ename = 'SMITH'
)
AND sal * 12 < (
				    SELECT sal * 12
				    FROM emp
				    WHERE ename = 'KING'
);



-- 21. WAQTD DNAME OF THE EMPLOYEES WHOSE NAME IS SMITH

SELECT dname 
FROM dept 
WHERE deptno = (
				SELECT deptno 
				FROM emp 
				WHERE ename = 'SMITH'
);


-- 22. WAQTD DNAME AND LOC OF THE EMPLOYEE WHOSE ENAME IS KING

SELECT dname, loc 
FROM dept 
WHERE deptno = ( 
				SELECT deptno 
				FROM emp 
				WHERE ename = 'KING'
);


-- 23. WAQTD LOC OF THE EMPLOYEE WHOSE EMPLOYEE NUMBER IS 7902

SELECT loc 
FROM dept 
WHERE deptno = (SELECT deptno 
				FROM emp 
				WHERE empno = 7902
						
);

-- 24. WAQTD DNAME AND LOC ALONG WITH DEPTNO OF THE EMPLOYEE WHOSE NAME ENDS WITH 'R'

SELECT dname, loc, deptno 
FROM dept 
WHERE deptno IN ( 
					SELECT deptno 
					FROM emp 
					WHERE ename LIKE '%R'
);

-- 25. WAQTD DNAME OF THE EMPLOYEE WHOSE DESIGNATION IS PRESIDENT

SELECT dname 
FROM dept 
WHERE deptno IN ( 
					SELECT deptno 
					FROM emp 
					WHERE job = 'PRESIDENT'
);

-- 26. WAQTD NAMES OF THE EMPLOYEES WORKING IN ACCOUNTING DEPARTMENT

SELECT ename  
FROM emp 
WHERE deptno IN ( 
					SELECT deptno 
					FROM dept
					WHERE dname = 'ACCOUNTING'
);

-- 27. WAQTD ENAME AND SALARIES OF THE EMPLOYEES WHO ARE WORKING IN THE LOCATION 'CHICAGO'

SELECT ename , sal 
FROM emp 
WHERE deptno IN ( 
					SELECT deptno 
					FROM dept 
					WHERE loc = 'CHICAGO'
);

-- 28. WAQTD DETAILS OF THE EMPLOYEES WORKING IN SALES

SELECT * 
FROM emp 
WHERE deptno IN ( 
					SELECT deptno 
					FROM dept 
					WHERE dname = 'SALES'
);


-- 29. WAQTD DETAILS OF THE EMPLOYEES ALONG WITH ANNUAL SALARY IF THEY ARE WORKING IN NEW YORK

SELECT emp.*, sal * 12 AS ANNUAL_SAL 
FROM emp 
WHERE deptno IN ( 
					SELECT deptno 
					FROM dept 
					WHERE loc = 'NEW YORK'
);

-- 30. WAQTD NAMES OF THE EMPLOYEES WORKING IN OPERATIONS DEPARTMENT

SELECT ename 
FROM emp 
WHERE deptno IN ( 
					SELECT deptno 
					FROM dept 
					WHERE dname = 'OPERATIONS'
);


-- 31. WAQTD NAMES OF THE EMPLOYEES EARNING MORE THAN SCOTT IN ACCOUNTING DEPARTMENT

SELECT ename 
FROM emp 
WHERE sal > ( 
				SELECT sal 
				FROM emp 
				WHERE ename = 'SCOTT'
)
AND deptno IN ( 
				SELECT deptno 
				FROM dept 
				WHERE dname = 'ACCOUNTING'
); 


-- 32. WAQTD DETAILS OF THE EMPLOYEES WORKING AS MANAGER IN THE LOCATION CHICAGO

SELECT * 
FROM emp 
WHERE deptno IN ( 
					SELECT deptno 
					FROM dept 
					WHERE loc = 'CHICAGO'
)
AND job = 'MANAGER';

-- 33. WAQTD NAME AND SAL OF THE EMPLOYEES EARNING MORE THAN KING IN THE ACCOUNTING DEPARTMENT

SELECT ename, sal 
FROM emp 
WHERE sal > (
				SELECT sal
				FROM emp 
				WHERE ename = 'KING'
)
AND deptno IN (
				SELECT deptno 
				FROM dept 
				WHERE dname = 'ACCOUNTING'
);


-- 34. WAQTD DETAILS OF THE EMPLOYEES WORKING AS SALESMAN IN THE SALES DEPARTMENT

SELECT * 
FROM emp 
WHERE job = 'SALESMAN'
AND deptno IN ( 
				SELECT deptno 
				FROM dept 
				WHERE dname = 'SALES'
);

-- 35. WAQTD NAME, SAL, JOB, HIREDATE OF THE EMPLOYEES WORKING IN OPERATIONS DEPARTMENT AND HIRED BEFORE KING

SELECT ename, sal , job, hiredate 
FROM emp 
WHERE hiredate < ( 
					SELECT hiredate 
					FROM emp 
					WHERE ename = 'KING'
)
AND deptno IN (  
				SELECT deptno 
				FROM dept 
				WHERE dname = 'OPERATIONS'
);

-- 36. DISPLAY ALL THE EMPLOYEES WHOSE DEPARTMENT NAMES END WITH 'S'

SELECT *
FROM emp
WHERE deptno IN (
    SELECT deptno
    FROM dept
    WHERE dname LIKE '%S'
);
-- 37. WAQTD DNAME OF THE EMPLOYEES WHOSE NAMES HAVE THE CHARACTER 'A' IN THEM

SELECT dname
FROM dept
WHERE deptno IN (
				    SELECT deptno
				    FROM emp
				    WHERE ename LIKE '%A%'
);

-- 38. WAQTD DNAME AND LOC OF THE EMPLOYEES WHOSE SALARY IS 800 RUPEES

SELECT dname, loc
FROM dept
WHERE deptno IN (
				    SELECT deptno
				    FROM emp
				    WHERE sal = 800
);

-- 39. WAQTD DNAME OF THE EMPLOYEES WHO EARN COMMISSION

SELECT dname 
FROM dept 
WHERE deptno IN ( 
				SELECT deptno 
				FROM emp 
				WHERE comm IS NOT NULL 
);


-- 40. WAQTD LOC OF THE EMPLOYEES IF THEY EARN COMMISSION IN DEPT 40

SELECT loc
FROM dept
WHERE deptno = 40
AND deptno IN (
		    SELECT deptno
		    FROM emp
		    WHERE comm IS NOT NULL
);


-- 41. WAQTD NAME OF THE EMPLOYEE EARNING MAXIMUM SALARY
SELECT ename 
FROM emp 
WHERE sal = ( 
				SELECT max (sal)
				FROM emp 
);


-- 42. WAQTD NAME OF THE EMPLOYEE EARNING MINIMUM SALARY

SELECT ename
FROM emp
WHERE sal = (
    SELECT MIN(sal)
    FROM emp
);


-- 43. WAQTD NAME AND HIREDATE OF THE EMPLOYEE HIRED BEFORE ALL THE EMPLOYEES (FIRST EMP)

SELECT ename, hiredate 
FROM emp 
WHERE hiredate = (
					SELECT MIN(hiredate)
					FROM emp 
); 

-- 44. WAQTD NAME AND HIREDATE OF THE EMPLOYEES HIRED AT THE LAST

SELECT ename, hiredate
FROM emp
WHERE hiredate = (
			    SELECT MAX(hiredate)
			    FROM emp
);

-- 45. WAQTD NAME, COMM OF THE EMPLOYEE WHO EARNS MINIMUM COMMISSION

SELECT ename, comm 
FROM emp 
WHERE comm = ( 
				SELECT MIN(comm)
				FROM emp 
);


-- 46. WAQTD NAME, SAL AND COMM OF THE EMPLOYEE EARNING MAXIMUM COMMISSION

SELECT ename, sal, comm
FROM emp
WHERE comm = (
		    SELECT MAX(comm)
		    FROM emp
);


-- 47. WAQTD DETAILS OF THE EMPLOYEE WHO HAS THE GREATEST EMPNO

SELECT * 
FROM emp 
WHERE empno = ( 
				SELECT MAX(empno)
				FROM emp 
);


-- 48. WAQTD DETAILS OF THE EMPLOYEES HAVING THE LEAST HIREDATE

SELECT * 
FROM emp 
WHERE hiredate = ( 
	SELECT MIN(hiredate)
	FROM emp 
);


-- 49. WAQTD DETAILS OF THE EMPLOYEES EARNING THE LEAST ANNUAL SALARY

SELECT * 
FROM emp 
WHERE sal * 12 = (
				SELECT MIN(sal * 12)
				FROM emp 
);


-- 50. WAQTD NAME, ANNUAL SALARY OF THE EMPLOYEES IF THEIR ANNUAL SALARY IS MORE THAN ALL THE SALESMEN

SELECT ename, sal * 12 AS annual_salary
FROM emp
WHERE sal * 12 > (
    SELECT MAX(sal * 12)
    FROM emp
    WHERE job = 'SALESMAN'
    
);





-- 61. WAQTD 2ND MINIMUM SALARY

SELECT MIN(sal) AS second_minimum_sal 
FROM emp 
WHERE sal > (
				SELECT MIN(sal)
				FROM emp 
);

-- 62. WAQTD 5TH MAXIMUM SALARY

SELECT MAX(sal) AS fifth_max_sal 
FROM emp 
WHERE sal < (
				SELECT MAX(sal)
				FROM emp 
				WHERE sal < (
								SELECT MAX(sal)
								FROM emp 
								WHERE sal < ( 
												SELECT MAX(sal)
												FROM emp 
												WHERE sal < (
																SELECT MAX(sal)
																FROM emp 
																
												)
								)
				)
				
);



-- 63. WAQTD NAME OF THE EMPLOYEE EARNING 3RD MAXIMUM SALARY

SELECT ename 
FROM emp 
WHERE sal = ( 
				SELECT MAX(sal)
				FROM emp 
				WHERE sal < ( 
								SELECT MAX(sal) 
								FROM emp 
								WHERE sal < ( 
												SELECT MAX(sal)
												FROM emp 
												
								)
				)
);


-- 64. WAQTD EMPNO OF THE EMPLOYEE EARNING 2ND MAXIMUM SALARY

SELECT empno
FROM emp
WHERE sal = (
	    SELECT MAX(sal)
	    FROM emp
	    WHERE sal < (
	        SELECT MAX(sal)
	        FROM emp
	    )
);



-- 65. WAQTD DEPARTMENT NAME OF AN EMPLOYEE GETTING 4TH MAXIMUM SALARY

SELECT dname 
FROM dept 
WHERE deptno IN ( 
					SELECT deptno 
					FROM emp 
					WHERE sal = (
									SELECT MAX(sal)
									FROM emp 
									WHERE sal < (
													SELECT MAX(sal) 
													FROM emp 
													WHERE sal < ( 
																	SELECT MAX(sal)
																	FROM emp
													)
									)
					)
);

-- 66. WAQTD DETAILS OF THE EMPLOYEE WHO WAS HIRED 2ND

SELECT  * 
FROM emp 
WHERE hiredate = ( 
					SELECT MIN(hiredate)
					FROM emp 
					WHERE hiredate > (
										SELECT MIN(hiredate)
										FROM emp
					)
);


-- 67. WAQTD NAME OF THE EMPLOYEE HIRED BEFORE THE LAST EMPLOYEE

SELECT ename
FROM emp
WHERE hiredate < (
    SELECT MAX(hiredate)
    FROM emp
);


-- 68. WAQTD LOC OF THE EMPLOYEE WHO WAS HIRED FIRST

SELECT loc 
FROM dept 
WHERE deptno IN ( 
	SELECT deptno 
	FROM emp 
	WHERE hiredate = ( 
		SELECT MIN(hiredate)
		FROM emp 
		
	)
);


-- 69. WAQTD DETAILS OF THE EMPLOYEE EARNING 7TH MINIMUM SALARY

SELECT *
FROM emp
WHERE sal = (
    SELECT DISTINCT sal
    FROM emp
    ORDER BY sal ASC
    OFFSET 6 LIMIT 1
);


-- 70. WAQTD DNAME OF THE EMPLOYEE GETTING 2ND MAXIMUM SALARY

SELECT dname
FROM dept
WHERE deptno IN (
			    SELECT deptno
			    FROM emp
			    WHERE sal = (
						        SELECT MAX(sal)
						        FROM emp
						        WHERE sal < (
									            SELECT MAX(sal)
									            FROM emp
						        )
    )
);

SELECT * FROM emp;

-- EMP-MGR

-- 71. WAQTD SMITH'S REPORTING MANAGER'S NAME
SELECT ename 
FROM emp 
WHERE empno = ( 
				SELECT mgr 
				FROM emp 
				WHERE ename = 'SMITH'
);

-- 72. WAQTD ADAMS' MANAGER'S MANAGER NAME

SELECT ename 
FROM emp 
WHERE empno = ( 
				SELECT mgr 
				FROM emp 
				WHERE empno = ( 
								SELECT mgr 
								FROM emp 
								WHERE ename = 'ADAMS'
				)
);


-- 73. WAQTD DNAME OF JONES' MANAGER

SELECT dname 
FROM dept 
WHERE deptno IN (
					SELECT deptno 
					FROM emp 
					WHERE empno IN (
									SELECT mgr 
									FROM emp 
									WHERE ename = 'JONES'
					)
);


-- 74. WAQTD MILLER'S MANAGER'S SALARY

SELECT sal
FROM emp
WHERE empno = (
			    SELECT mgr
			    FROM emp
			    WHERE ename = 'MILLER'
);

-- 75. WAQTD LOC OF SMITH'S MANAGER'S MANAGER

SELECT loc 
FROM dept
WHERE deptno IN (
				SELECT deptno 
				FROM emp 
				WHERE empno = (
								SELECT mgr 
								FROM emp 
								WHERE empno = (
												SELECT mgr 
												FROM emp 
												WHERE ename = 'SMITH'
								)
				)
);

SELECT * FROM emp;

-- 76. WAQTD NAME OF THE EMPLOYEES REPORTING TO BLAKE

SELECT ename
FROM emp
WHERE mgr = (
    SELECT empno
    FROM emp
    WHERE ename = 'BLAKE'
);


-- 77. WAQTD NUMBER OF EMPLOYEES REPORTING TO KING

SELECT count(*) AS employee_count 
FROM emp 
WHERE mgr = (
				SELECT empno 
				FROM emp 
				WHERE ename = 'KING'
);

-- 78. WAQTD DETAILS OF THE EMPLOYEES REPORTING TO JONES

SELECT * 
FROM emp 
WHERE mgr  = (
				SELECT empno 
				FROM emp 
				WHERE ename = 'JONES'
);


-- 79. WAQTD ENAMES OF THE EMPLOYEES REPORTING TO BLAKE'S MANAGER

SELECT ename 
FROM emp 
WHERE mgr = (
				SELECT mgr 
				FROM emp 
				WHERE ename = 'BLAKE'
);

-- 80. WAQTD NUMBER OF EMPLOYEES REPORTING TO FORD'S MANAGER

SELECT COUNT(*) AS employee_count
FROM emp
WHERE mgr = (
			    SELECT mgr
			    FROM emp
			    WHERE ename = 'FORD'
);



-- USING GROUP BY IN SUB-QUERY

-- 81. WAQTD DNAME IN WHICH THERE ARE AT LEAST 5 EMPLOYEES WORKING

SELECT dname 
FROM dept 
WHERE deptno IN (
					SELECT deptno 
					FROM emp 
					GROUP BY deptno 
					HAVING count(*) >= 5
);


-- 82. WAQTD LOC IN WHICH THERE ARE EXACTLY 3 EMPLOYEES WORKING

SELECT loc 
FROM dept 
WHERE deptno IN (
				SELECT deptno 
				FROM emp 
				GROUP BY deptno 
				HAVING count(*) = 3
);


-- 83. WAQTD DETAILS OF THE EMPLOYEES EARNING THE SAME SALARY

SELECT * 
FROM emp 
WHERE sal IN (
				SELECT sal 
				FROM emp 
				GROUP BY sal 
				HAVING count(*) > 1
)



-- 84. WAQTD SALARIES OF THE EMPLOYEES HAVING THE SAME NAMES

SELECT sal
FROM emp
WHERE ename IN (
			    SELECT ename
			    FROM emp
			    GROUP BY ename
			    HAVING COUNT(*) > 1
);


-- 85. WAQTD DETAILS OF THE EMPLOYEES GETTING THE SAME SALARY IN THE SAME DEPARTMENT

SELECT * 
FROM emp 
WHERE (deptno, sal) IN ( 
						SELECT deptno, sal 
						FROM emp 
						GROUP BY deptno, sal 
						HAVING count(*) > 1
); 


-- 86. WAQTD DETAILS OF THE EMPLOYEES HIRED ON THE SAME DAY IN THE SAME DEPARTMENT

SELECT *
FROM emp
WHERE (deptno, hiredate) IN (
							    SELECT deptno, hiredate
							    FROM emp
							    GROUP BY deptno, hiredate
							    HAVING COUNT(*) > 1
);


-- 87. WAQTD NAME AND SAL OF THE EMPLOYEES IF THEIR NAME IS REPEATED AT LEAST 4 TIMES IN THE EMPLOYEE TABLE

SELECT ename, sal
FROM emp
WHERE ename IN (
				    SELECT ename
				    FROM emp
				    GROUP BY ename
				    HAVING COUNT(*) >= 4
);

-- 88. WAQTD DETAILS OF THE EMPLOYEES HAVING THE SAME DESIGNATIONS IN THE SAME DEPARTMENT

SELECT *
FROM emp
WHERE (deptno, job) IN (
					    SELECT deptno, job
					    FROM emp
					    GROUP BY deptno, job
					    HAVING COUNT(*) > 1
);

-- 89. WAQTD DETAILS OF THE EMPLOYEES HAVING THE SAME NAMES IN THE SAME JOB

SELECT *
FROM emp
WHERE (ename, job) IN (
					    SELECT ename, job
					    FROM emp
					    GROUP BY ename, job
					    HAVING COUNT(*) > 1
);


-- 90. WAQTD DETAILS OF THE EMPLOYEE TO WHOM AT LEAST 3 EMPLOYEES REPORT

-- OR

-- 90. WAQTD DETAILS OF THE EMPLOYEE HAVING AT LEAST 3 REPORTINGS

SELECT *
FROM emp
WHERE empno IN (
				    SELECT mgr
				    FROM emp
				    WHERE mgr IS NOT NULL
				    GROUP BY mgr
				    HAVING COUNT(*) >= 3
);







































































































