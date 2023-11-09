USE employees;

/*
DROP PROCEDURE IF EXISTS select_employess;

DELIMITER $$
CREATE PROCEDURE select_employees()
BEGIN 
	SELECT * FROM employees
    LIMIT 1000;

END$$
DELIMITER ;

CALL employees.select_employees();

CALL select_employees;
*/

DELIMITER $$

CREATE PROCEDURE avg_salary()

BEGIN
	SELECT AVG(salary) FROM salaries;

END$$
DELIMITER ;

CALL avg_salary;
#CALL employees.avg_salary;
