-- DBMS Assignment 4: Aggregate Functions and GROUP BY
-- Assumed database: the standard HR sample database.

-- Q1. Number of distinct jobs available.
SELECT COUNT(DISTINCT job_id) AS number_of_jobs
FROM employees;

-- Q2. Total salaries payable.
SELECT SUM(salary) AS total_salary
FROM employees;

-- Q3. Minimum salary.
SELECT MIN(salary) AS minimum_salary
FROM employees;

-- Q4. Maximum salary among Programmers.
SELECT MAX(salary) AS maximum_programmer_salary
FROM employees
WHERE job_id = 'IT_PROG';

-- Q5. Average salary and employee count in department 90.
SELECT AVG(salary) AS average_salary,
       COUNT(*) AS employee_count
FROM employees
WHERE department_id = 90;

-- Q6. Highest, lowest, total and average salary.
SELECT MAX(salary) AS highest_salary,
       MIN(salary) AS lowest_salary,
       SUM(salary) AS total_salary,
       AVG(salary) AS average_salary
FROM employees;

-- Q7. Number of employees having each job.
SELECT job_id, COUNT(*) AS employee_count
FROM employees
GROUP BY job_id;

-- Q8. Difference between highest and lowest salaries.
SELECT MAX(salary) - MIN(salary) AS salary_difference
FROM employees;

-- Q9. Manager ID and lowest-paid employee salary under that manager.
SELECT manager_id, MIN(salary) AS lowest_employee_salary
FROM employees
WHERE manager_id IS NOT NULL
GROUP BY manager_id;

-- Q10. Department ID and total salary payable in each department.
SELECT department_id, SUM(salary) AS total_salary
FROM employees
GROUP BY department_id;

-- Q11. Average salary for each job, excluding Programmers.
SELECT job_id, AVG(salary) AS average_salary
FROM employees
WHERE job_id <> 'IT_PROG'
GROUP BY job_id;

-- Q12. Salary aggregates by job for department 90 only.
SELECT job_id,
       SUM(salary) AS total_salary,
       MAX(salary) AS maximum_salary,
       MIN(salary) AS minimum_salary,
       AVG(salary) AS average_salary
FROM employees
WHERE department_id = 90
GROUP BY job_id;

-- Q13. Job IDs whose maximum salary is at least 4000.
SELECT job_id, MAX(salary) AS maximum_salary
FROM employees
GROUP BY job_id
HAVING MAX(salary) >= 4000;

-- Q14. Average salary for departments employing more than 10 people.
SELECT department_id, AVG(salary) AS average_salary
FROM employees
GROUP BY department_id
HAVING COUNT(*) > 10;
