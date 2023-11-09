USE employees;

SELECT 
	AVG(salary) AS avg_salary
FROM
	salaries;

WITH cte AS(
	SELECT AVG(salary) AS avg_salary FROM salaries)
    SELECT
    SUM(CASE WHEN s.salary > c.avg_salary THEN 1 ELSE 0 END) AS no_f_salaries_above_avg,
    COUNT(s.salary) AS total_no_of_salary_contracts
    FROM
		salaries s
			JOIN
		employees e ON s.emp_no = e.emp_no AND gender = 'F'
			CROSS JOIN
		cte c;
        
WITH cte AS (
	SELECT AVG(salary) AS avg_salary FROM salaries)
    SELECT
		*
	FROM
		cte;   
        
WITH cte AS (
	SELECT AVG(salary) AS avg_salary FROM salaries)
    SELECT
    SUM(CASE WHEN s.salary > c.avg_salary THEN 1 ELSE 0 END) AS no_f_salaries_above_avg_w_sum,
    COUNT(CASE WHEN s.salary > c.avg_salary THEN s.salary ELSE NULL END) AS no_f_salaries_above_avg_w_count,
    COUNT(s.salary) AS total_no_of_salary_contracts
    FROM
		salaries s
			JOIN
		employees e ON s.emp_no = e.emp_no AND e.gender = 'F'
			CROSS JOIN
		cte c;
        
/*
Exercise #1:
Use a CTE (a Common Table Expression) and a SUM() function in the SELECT statement 
in a query to find out how many male employees have never signed a contract with 
a salary value higher than or equal to the all-time company salary average.
*/
WITH cte AS (
	SELECT AVG(salary) AS avg_salary FROM salaries)
	SELECT
	SUM(CASE WHEN s.salary < c.avg_salary THEN 1 ELSE 0 END) AS no_salaries_below_avg,
	COUNT(s.salary) AS no_of_salary_contracts
	FROM salaries s JOIN employees e ON s.emp_no = e.emp_no AND e.gender = 'M' JOIN cte c;

/*
Exercise #2:
Use a CTE (a Common Table Expression) and (at least one) COUNT() function in the SELECT 
statement of a query to find out how many male employees have never signed a contract with 
a salary value higher than or equal to the all-time company salary average.
*/
WITH cte AS (
	SELECT AVG(salary) AS avg_salary FROM salaries)
	SELECT
	COUNT(CASE WHEN s.salary < c.avg_salary THEN s.salary ELSE NULL END) AS no_salaries_below_avg_w_count,
	COUNT(s.salary) AS no_of_salary_contracts
	FROM salaries s JOIN employees e ON s.emp_no = e.emp_no AND e.gender = 'M' JOIN cte c;
    
/*
Exercise #3:
Use MySQL joins (and don’t use a Common Table Expression) in a query to find out how many male
employees have never signed a contract with a salary value higher than or equal to the 
all-time company salary average (i.e. to obtain the same result as in the previous exercise).
*/
SELECT
    SUM(CASE
        WHEN s.salary < a.avg_salary THEN 1
        ELSE 0
    END) AS no_salaries_below_avg,
    COUNT(s.salary) AS no_of_salary_contracts
FROM
    (SELECT
        AVG(salary) AS avg_salary
    FROM
        salaries s) a
        JOIN
    salaries s
        JOIN
    employees e ON e.emp_no = s.emp_no AND e.gender = 'M';
    
/*
Exercise #4:
Use a cross join in a query to find out how many male employees have never signed a contract
with a salary value higher than or equal to the all-time company salary average
 (i.e. to obtain the same result as in the previous exercise).
*/
WITH cte AS (
	SELECT AVG(salary) AS avg_salary FROM salaries)
	SELECT
	SUM(CASE WHEN s.salary < c.avg_salary THEN 1 ELSE 0 END) AS no_salaries_below_avg_w_sum,
# COUNT(CASE WHEN s.salary < c.avg_salary THEN s.salary ELSE NULL END) AS no_salaries_below_avg_w_count,
COUNT(s.salary) AS no_of_salary_contracts
FROM salaries s JOIN employees e ON s.emp_no = e.emp_no AND e.gender = 'M' CROSS JOIN cte c;
    