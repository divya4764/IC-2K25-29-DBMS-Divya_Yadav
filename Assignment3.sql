-- DBMS Assignment 3: Filtering and Operators.
-- Assumed database: the standard HR sample database.

-- Q1. Employees whose salary is outside the inclusive range 10000–15000.
SELECT first_name, last_name, salary
FROM employees
WHERE salary NOT BETWEEN 10000 AND 15000;

-- Q2. Employees in department 30 or 100, ordered by department ID ascending.
SELECT first_name, last_name, department_id
FROM employees
WHERE department_id IN (30, 100)
ORDER BY department_id ASC;

-- Q3. Salary outside 10000–15000 and department is 30 or 100.
SELECT first_name, last_name, salary
FROM employees
WHERE salary NOT BETWEEN 10000 AND 15000
  AND department_id IN (30, 100);

-- Q4. Employees hired during calendar year 1987.
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date >= '1987-01-01'
  AND hire_date <  '1988-01-01';

-- Q5. First names containing both letters b and c, case-insensitively.
SELECT first_name
FROM employees
WHERE LOWER(first_name) LIKE '%b%'
  AND LOWER(first_name) LIKE '%c%';

-- Q6. Programmers or Shipping Clerks, excluding the listed salaries.
SELECT last_name, job_id, salary
FROM employees
WHERE job_id IN ('IT_PROG', 'SH_CLERK')
  AND salary NOT IN (4500, 10000, 15000);

-- Q7. Last names having exactly six characters.
SELECT last_name
FROM employees
WHERE CHAR_LENGTH(last_name) = 6;

-- Q8. Last names with 'e' as the third character.
SELECT last_name
FROM employees
WHERE last_name LIKE '__e%';

-- Q9. Distinct jobs/designations available in employees.
SELECT DISTINCT job_id
FROM employees;

-- Q10. Names, salary and PF (15% of salary).
SELECT first_name, last_name, salary,
       salary * 0.15 AS PF
FROM employees;

-- Q11. Employees whose last names are in the given list.
SELECT *
FROM employees
WHERE UPPER(last_name) IN ('BLAKE', 'SCOTT', 'KING', 'FORD');
