-- DBMS Assignment 2: MySQL SELECT Queries.
-- Assumed database: the standard HR sample database.
-- Main table: employees. Columns follow the usual HR schema.

-- Q1. Display first and last names with the requested aliases.
SELECT first_name AS `First Name`,
       last_name  AS `Last Name`
FROM employees;

-- Q2. Display distinct department IDs.
SELECT DISTINCT department_id
FROM employees;

-- Q3. Display all employees ordered by first name descending.
SELECT *
FROM employees
ORDER BY first_name DESC;

-- Q4. Display names, salary and PF (15% of salary).
SELECT first_name, last_name, salary,
       salary * 0.15 AS PF
FROM employees;

-- Q5. Display employee ID, names and salary in ascending salary order.
SELECT employee_id, first_name, last_name, salary
FROM employees
ORDER BY salary ASC;

-- Q6. Total salary payable to all employees.
SELECT SUM(salary) AS total_salary
FROM employees;

-- Q7. Maximum and minimum salary.
SELECT MAX(salary) AS maximum_salary,
       MIN(salary) AS minimum_salary
FROM employees;

-- Q8. Average salary and number of employees.
SELECT AVG(salary) AS average_salary,
       COUNT(*) AS employee_count
FROM employees;

-- Q9. Number of employees in the company.
SELECT COUNT(*) AS total_employees
FROM employees;

-- Q10. Number of distinct jobs/designations in the employees table.
SELECT COUNT(DISTINCT job_id) AS number_of_jobs
FROM employees;

-- Q11. First names in uppercase.
SELECT UPPER(first_name) AS first_name_upper
FROM employees;

-- Q12. First three characters of each first name.
SELECT LEFT(first_name, 3) AS first_three_characters
FROM employees;

-- Q13. Calculate the arithmetic expression.
SELECT 171 * 214 + 625 AS result;

-- Q14. Display each employee's full name.
SELECT CONCAT(first_name, ' ', last_name) AS employee_name
FROM employees;

-- Q15. Remove leading and trailing spaces from first_name.
SELECT TRIM(first_name) AS trimmed_first_name
FROM employees;

-- Q16. Length of the combined employee name.
SELECT first_name, last_name,
       CHAR_LENGTH(CONCAT(first_name, ' ', last_name)) AS name_length
FROM employees;

-- Q17. Find first names containing at least one digit.
SELECT first_name
FROM employees
WHERE first_name REGEXP '[0-9]';

-- Q18. Select the first 10 rows.
-- Add ORDER BY employee_id for a repeatable result order.
SELECT *
FROM employees
ORDER BY employee_id
LIMIT 10;

-- Q19. Monthly salary when salary stores annual salary; round to 2 decimals.
SELECT employee_id, first_name, last_name,
       ROUND(salary / 12, 2) AS monthly_salary
FROM employees;
