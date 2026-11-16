-- DBMS Assignment 1: DDL, Keys and Constraints

-- Q1. Create a simple countries table.
CREATE TABLE countries (
    country_id   INT,
    country_name VARCHAR(50),
    region_id    INT
);

-- Q2. Create the table only if it does not already exist.
CREATE TABLE IF NOT EXISTS countries (
    country_id   INT,
    country_name VARCHAR(50),
    region_id    INT
);

-- Q3. Create dup_countries with the same structure as countries, without rows.
CREATE TABLE dup_countries LIKE countries;

-- Q4. Copy both structure and data from countries into dup_countries.
-- Run this as the Q4 alternative to Q3 (the same table name is requested).
DROP TABLE IF EXISTS dup_countries;
CREATE TABLE dup_countries LIKE countries;
INSERT INTO dup_countries
SELECT * FROM countries;

-- Q5. Allow NULL values in the columns (explicit NULL declarations).
CREATE TABLE countries_nullable (
    country_id   INT NULL,
    country_name VARCHAR(50) NULL,
    region_id    INT NULL
);

-- Q6. Ensure max_salary never exceeds 25000.
CREATE TABLE jobs_q6 (
    job_id     VARCHAR(10),
    job_title  VARCHAR(35),
    min_salary DECIMAL(6,0),
    max_salary DECIMAL(6,0),
    CONSTRAINT chk_jobs_q6_max_salary CHECK (max_salary <= 25000)
);

-- Q7. Allow only Italy, India and China.
CREATE TABLE countries_q7 (
    country_id   INT,
    country_name VARCHAR(50),
    region_id    INT,
    CONSTRAINT chk_country_name CHECK (country_name IN ('Italy', 'India', 'China'))
);

-- Q8. Store end_date as a DATE.
-- MySQL DATE values use YYYY-MM-DD internally/input format.
-- To display as DD/MM/YYYY, use DATE_FORMAT(end_date, '%d/%m/%Y') in SELECT.
CREATE TABLE job_history_q8 (
    employee_id   INT,
    start_date    DATE,
    end_date      DATE,
    job_id        VARCHAR(10),
    department_id INT
);

-- Q9. Prevent duplicate country_id values.
CREATE TABLE countries_q9 (
    country_id   INT NOT NULL UNIQUE,
    country_name VARCHAR(50),
    region_id    INT
);

-- Q10. Set the requested default values.
CREATE TABLE jobs_q10 (
    job_id     INT,
    job_title  VARCHAR(35) NOT NULL DEFAULT '',
    min_salary DECIMAL(6,0) DEFAULT 8000,
    max_salary DECIMAL(6,0) DEFAULT NULL
);

-- Q11. Make country_id the primary key.
CREATE TABLE countries_q11 (
    country_id   INT PRIMARY KEY,
    country_name VARCHAR(50),
    region_id    INT
);

-- Q12. Make country_id unique and automatically incremented.
CREATE TABLE countries_q12 (
    country_id   INT NOT NULL AUTO_INCREMENT UNIQUE,
    country_name VARCHAR(50),
    region_id    INT
);

-- Q13. Enforce uniqueness of the country_id + region_id combination.
CREATE TABLE countries_q13 (
    country_id   INT,
    country_name VARCHAR(50),
    region_id    INT,
    CONSTRAINT uq_country_region UNIQUE (country_id, region_id)
);

-- Q14. employee_id must be unique; job_id must exist in jobs.
-- Assumes the referenced jobs.job_id has the same VARCHAR(10) type.
CREATE TABLE job_history_q14 (
    employee_id   INT NOT NULL UNIQUE,
    start_date    DATE,
    end_date      DATE,
    job_id        VARCHAR(10),
    department_id INT,
    CONSTRAINT fk_jh14_job FOREIGN KEY (job_id)
        REFERENCES jobs (job_id)
) ENGINE=InnoDB;

-- Q15. employee_id unique; (department_id, manager_id) must match
-- a unique/primary-key pair in departments.
-- The supplied departments structure shows these columns as a composite key.
CREATE TABLE employees_q15 (
    employee_id   INT NOT NULL UNIQUE,
    first_name    VARCHAR(20),
    last_name     VARCHAR(25),
    email         VARCHAR(100),
    phone_number  VARCHAR(20),
    hire_date     DATE,
    job_id        VARCHAR(10),
    salary        DECIMAL(8,2),
    commission    DECIMAL(4,2),
    manager_id    DECIMAL(6,0),
    department_id DECIMAL(4,0),
    CONSTRAINT fk_emp15_department_manager
        FOREIGN KEY (department_id, manager_id)
        REFERENCES departments (department_id, manager_id)
) ENGINE=InnoDB;

-- Q16. employee_id unique; department_id and job_id are foreign keys.
CREATE TABLE employees_q16 (
    employee_id   INT NOT NULL UNIQUE,
    first_name    VARCHAR(20),
    last_name     VARCHAR(25),
    email         VARCHAR(100),
    phone_number  VARCHAR(20),
    hire_date     DATE,
    job_id        VARCHAR(10),
    salary        DECIMAL(8,2),
    commission    DECIMAL(4,2),
    manager_id    INT,
    department_id DECIMAL(4,0),
    CONSTRAINT fk_emp16_department FOREIGN KEY (department_id)
        REFERENCES departments (department_id),
    CONSTRAINT fk_emp16_job FOREIGN KEY (job_id)
        REFERENCES jobs (job_id)
) ENGINE=InnoDB;

-- Q17. ON UPDATE CASCADE; ON DELETE RESTRICT.
-- Assumes jobs.job_id is INT, as in the question's supplied jobs example.
CREATE TABLE employees_q17 (
    employee_id INT NOT NULL UNIQUE,
    first_name  VARCHAR(20),
    last_name   VARCHAR(25),
    job_id      INT,
    salary      DECIMAL(8,2),
    CONSTRAINT fk_emp17_job FOREIGN KEY (job_id)
        REFERENCES jobs (job_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB;

-- Q18. ON DELETE CASCADE; ON UPDATE RESTRICT.
CREATE TABLE employees_q18 (
    employee_id INT NOT NULL UNIQUE,
    first_name  VARCHAR(20),
    last_name   VARCHAR(25),
    job_id      INT,
    salary      DECIMAL(8,2),
    CONSTRAINT fk_emp18_job FOREIGN KEY (job_id)
        REFERENCES jobs (job_id)
        ON DELETE CASCADE
        ON UPDATE RESTRICT
) ENGINE=InnoDB;

-- Q19. Set child job_id to NULL when the parent job is deleted or updated.
-- job_id must therefore permit NULL.
CREATE TABLE employees_q19 (
    employee_id INT NOT NULL UNIQUE,
    first_name  VARCHAR(20),
    last_name   VARCHAR(25),
    job_id      INT NULL,
    salary      DECIMAL(8,2),
    CONSTRAINT fk_emp19_job FOREIGN KEY (job_id)
        REFERENCES jobs (job_id)
        ON DELETE SET NULL
        ON UPDATE SET NULL
) ENGINE=InnoDB;

-- Q20. Explicitly reject parent deletes and updates when referenced.
CREATE TABLE employees_q20 (
    employee_id INT NOT NULL UNIQUE,
    first_name  VARCHAR(20),
    last_name   VARCHAR(25),
    job_id      INT,
    salary      DECIMAL(8,2),
    CONSTRAINT fk_emp20_job FOREIGN KEY (job_id)
        REFERENCES jobs (job_id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
) ENGINE=InnoDB;

