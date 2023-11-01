-- Employees table
CREATE TABLE employees (
    emp_no INT PRIMARY KEY,
    emp_title_id VARCHAR NOT NULL,
    birth_date DATE NOT NULL,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    sex CHAR(1) NOT NULL,
    hire_date DATE NOT NULL
);

-- Departments table
CREATE TABLE departments (
    dept_no INT PRIMARY KEY,
    dept_name VARCHAR(255) NOT NULL
);

-- Department_Employees table (to establish many-to-many relationship between employees and departments)
CREATE TABLE dept_emp (
    emp_no INT,
    dept_no INT,
    PRIMARY KEY (emp_no, dept_no),
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
    FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

-- Department_Managers table
CREATE TABLE dept_manager (
    dept_no INT PRIMARY KEY,
    emp_no INT
);

-- Employees_Salaries table
CREATE TABLE salaries (
    emp_no INT,
    salary DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (emp_no)
);

-- Employees_Titles table
CREATE TABLE titles (
    title_id INT PRIMARY KEY,
    title VARCHAR(255) NOT NULL
);

-- List employee details including salary
SELECT e.emp_no, e.emp_title_id, e.last_name, e.first_name, e.sex, e.birth_date, e.hire_date
FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no;

-- List employees hired in 1986
SELECT first_name, last_name, hire_date
FROM employees
WHERE EXTRACT(YEAR FROM hire_date) = 1986;
-- List department managers and their department details
SELECT dept_manager.dept_no, departments.dept_name, dept_manager.emp_no, employees.last_name, employees.first_name
FROM dept_manager
JOIN departments ON dept_manager.dept_no = departments.dept_no
JOIN employees ON dept_manager.emp_no = employees.emp_no;

-- List employee department details
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees e
JOIN dept_emp de ON e.emp_no = de.emp_no
JOIN departments d ON de.dept_no = d.dept_no;

-- List employees with first name "Hercules" and last name starting with "B"
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

-- List employees in the Sales department
SELECT e.emp_no, e.last_name, e.first_name
FROM employees e
JOIN dept_emp de ON e.emp_no = de.emp_no
JOIN departments d ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Sales';

-- List employees in the Sales and Development departments
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees e
JOIN dept_emp departments ON e.emp_no = departments.emp_no
JOIN departments d ON departments.dept_no = d.dept_no
WHERE d.dept_name IN ('Sales', 'Development');

-- List the frequency counts of last names
SELECT last_name, COUNT(*) AS last_name_count
FROM employees
GROUP BY last_name
ORDER BY last_name_count DESC;

