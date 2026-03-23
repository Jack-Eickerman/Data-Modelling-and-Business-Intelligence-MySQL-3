USE employees;

#1 - Find all information on all employees who were born in the 1965

SELECT first_name, last_name, birth_date
FROM employees
WHERE birth_date BETWEEN '1965-01-01' AND '1965-12-31';

#2 - Find the first name, last name, and employee number of the 8 employees that have been at the company the longest

SELECT first_name, last_name, employees.emp_no, from_date, to_date
FROM employees
JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
WHERE to_date = '9999-01-01'
ORDER BY from_date
LIMIT 8;

#3 - Find the first name, last name and salary of the employee with the highest salary (still at company)

SELECT first_name, last_name, salary
FROM employees
JOIN salaries ON employees.emp_no = salaries.emp_no
JOIN dept_emp ON salaries.emp_no = dept_emp.emp_no
WHERE dept_emp.to_date = '9999-01-01'
ORDER BY salary DESC
LIMIT 1;

#4 - Find the average salary per job title

SELECT title, AVG(salary) AS avg_salary
FROM salaries
JOIN titles ON salaries.emp_no = titles.emp_no
GROUP BY title 
ORDER BY AVG(salary) DESC; 

#5 - How many employees were hired by the company in the whole of the year 1985?

SELECT COUNT(employees.emp_no) AS number_hired
FROM employees
WHERE hire_date BETWEEN '1985-01-01' AND '1985-12-31';

#6 - Find the sum totals of salaries per department based on the manager salaries

SELECT dept_manager.dept_no, dept_name, SUM(salary) AS sum_total
FROM dept_manager
JOIN departments ON dept_manager.dept_no = departments.dept_no
JOIN salaries ON dept_manager.emp_no = salaries.emp_no
GROUP BY dept_name
ORDER BY sum_total DESC;

#7 - Find out the first names and last names of all employees who are managers by using a subquery in the WHERE clause of the outer query

SELECT employees.emp_no, first_name, last_name 
FROM employees
JOIN titles ON employees.emp_no = titles.emp_no
WHERE title = 
	(SELECT title
	 FROM titles
	 WHERE title = 'Manager'
     GROUP BY title);

#8 - Find the total number of employees (still at the company) who earn more than the average company salary using a subquery in the WHERE clause in the main outer query

SELECT COUNT(emp_no) AS num_staff
FROM salaries
WHERE to_date = '9999-01-01' AND salary >
	(SELECT AVG(salary)
	 FROM salaries
     WHERE to_date = '9999-01-01');
     
#9 - Redo question 3 but this time using a subquery in the WHERE clause of the main outer query
#  (Find the first name, last name and salary of the employee with the highest salary (still at company))     

SELECT first_name, last_name, salary
FROM employees
JOIN salaries ON employees.emp_no = salaries.emp_no
JOIN dept_emp ON salaries.emp_no = dept_emp.emp_no
WHERE salary = 
	(SELECT MAX(salary)
     FROM salaries
     WHERE to_date = '9999-01-01');
     
#10 - Find the first name, last name, and job titles of all employees with the same job title as Georgi Facello using a sub-query in the WHERE clause of the main outer query

SELECT first_name, last_name, title
FROM employees
JOIN titles ON employees.emp_no = titles.emp_no
WHERE title = 
	(SELECT title
	 FROM employees
	 JOIN titles ON employees.emp_no = titles.emp_no
	 WHERE first_name = 'Georgi' AND last_name = 'Facello'
	 GROUP BY title);





