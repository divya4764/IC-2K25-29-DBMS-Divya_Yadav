-- DBMS Assignment 5: MySQL Subqueries
-- Assumed database: the standard HR sample database.
-- Some questions refer to supporting HR tables (departments, locations,
-- countries, job_grades). Those tables must exist for the relevant query.

-- Q1. Employees earning more than the employee whose last name is Bull.
SELECT first_name, last_name, salary
FROM employees
WHERE salary > (
    SELECT salary
    FROM employees
    WHERE last_name = 'Bull'
);

-- Q2. Employees working in the IT department.
SELECT first_name, last_name
FROM employees
WHERE department_id IN (
    SELECT department_id
    FROM departments
    WHERE department_name = 'IT'
);

-- Q3. Employees who have a manager and work in a USA-based department.
SELECT first_name, last_name
FROM employees
WHERE manager_id IS NOT NULL
  AND department_id IN (
      SELECT d.department_id
      FROM departments AS d
      JOIN locations AS l ON l.location_id = d.location_id
      JOIN countries AS c ON c.country_id = l.country_id
      WHERE c.country_name = 'United States of America'
  );

-- Q4. Employees who are managers.
SELECT first_name, last_name
FROM employees
WHERE employee_id IN (
    SELECT DISTINCT manager_id
    FROM employees
    WHERE manager_id IS NOT NULL
);

-- Q5. Employees earning more than the overall average salary.
SELECT first_name, last_name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

-- Q6. Employees whose salary equals the minimum salary for their job.
-- The source says "job grade"; this version interprets the grouping as job_id.
SELECT e.first_name, e.last_name, e.salary
FROM employees AS e
WHERE e.salary = (
    SELECT MIN(e2.salary)
    FROM employees AS e2
    WHERE e2.job_id = e.job_id
);

-- Q7. Employees earning above the company average and working in IT.
SELECT first_name, last_name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees)
  AND department_id IN (
      SELECT department_id
      FROM departments
      WHERE department_name = 'IT'
  );

-- Q8. Employees earning more than Mr. Bell.
SELECT first_name, last_name, salary
FROM employees
WHERE salary > (
    SELECT salary
    FROM employees
    WHERE last_name = 'Bell'
);

-- Q9. Employees whose salary equals the minimum salary in at least one department.
SELECT first_name, last_name, salary
FROM employees
WHERE salary IN (
    SELECT MIN(salary)
    FROM employees
    GROUP BY department_id
);

-- Q10. Employees earning more than the overall average salary.
-- Interprets "average salary of all departments" as the overall employee average.
SELECT first_name, last_name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

-- Q11. Employees earning more than every Shipping Clerk; lowest to highest.
SELECT first_name, last_name, salary
FROM employees
WHERE salary > ALL (
    SELECT salary
    FROM employees
    WHERE job_id = 'SH_CLERK'
)
ORDER BY salary ASC;

-- Q12. Employees who are not supervisors (not listed as anyone's manager).
SELECT first_name, last_name
FROM employees
WHERE employee_id NOT IN (
    SELECT manager_id
    FROM employees
    WHERE manager_id IS NOT NULL
);

-- Q13. Employee ID, names and department names.
SELECT e.employee_id, e.first_name, e.last_name, d.department_name
FROM employees AS e
LEFT JOIN departments AS d
    ON d.department_id = e.department_id;

-- Q14. Employees whose salary is above the average salary of their own department.
SELECT e.employee_id, e.first_name, e.last_name, e.salary
FROM employees AS e
WHERE e.salary > (
    SELECT AVG(e2.salary)
    FROM employees AS e2
    WHERE e2.department_id = e.department_id
);

-- Q15. Even-numbered employee records.
-- Interprets "even numbered" as an even employee_id; SQL tables have no inherent row order.
SELECT *
FROM employees
WHERE MOD(employee_id, 2) = 0;

-- Q16. Fifth-highest distinct salary.
SELECT DISTINCT salary
FROM employees
ORDER BY salary DESC
LIMIT 1 OFFSET 4;

-- Q17. Fourth-lowest distinct salary.
SELECT DISTINCT salary
FROM employees
ORDER BY salary ASC
LIMIT 1 OFFSET 3;

-- Q18. Last 10 records by employee_id.
SELECT *
FROM employees
ORDER BY employee_id DESC
LIMIT 10;

-- Q19. Departments where no employee is working.
SELECT d.department_id, d.department_name
FROM departments AS d
WHERE NOT EXISTS (
    SELECT 1
    FROM employees AS e
    WHERE e.department_id = d.department_id
);

-- Q20. Three highest distinct salaries.
SELECT DISTINCT salary
FROM employees
ORDER BY salary DESC
LIMIT 3;

-- Q21. Three lowest distinct salaries.
SELECT DISTINCT salary
FROM employees
ORDER BY salary ASC
LIMIT 3;

-- Q22. Nth-highest distinct salary (MySQL 8.0+).
-- Change @n to the required position, e.g. 5 for fifth-highest.
SET @n = 3;

WITH ranked_salaries AS (
    SELECT salary,
           DENSE_RANK() OVER (ORDER BY salary DESC) AS salary_rank
    FROM employees
)
SELECT DISTINCT salary
FROM ranked_salaries
WHERE salary_rank = @n;
