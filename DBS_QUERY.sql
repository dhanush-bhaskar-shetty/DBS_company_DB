-- SQLBook: Code

-- accessing all the rows to find total number of data elements in each table;
SELECT * FROM companies;
SELECT * FROM departments;
SELECT * FROM employees;
SELECT * FROM locations;
SELECT * FROM products;
SELECT * FROM servicerecords;
SELECT * FROM websites;

-- count total companys;
SELECT COUNT(company_id) FROM companies;

-- find all active employees names;
SELECT employee_id,first_name,last_name FROM employees WHERE  employees.status='active';

-- count total number of active employees;
SELECT COUNT(employee_id) FROM employees WHERE  employees.status='active';

-- listing departments with their location id;
SELECT department_name,main_location_id FROM departments;

-- find all website related to company_id=3;
SELECT website_id,url FROM websites WHERE company_id=3;

-- names of employees hired after 2020 and active;
SELECT first_name,last_name,status FROM employees WHERE  status='active' AND hire_date > '2020-01-01' ;

-- list each department with its company name;
SELECT  departments.department_id,departments.department_name,companies.company_name 
FROM departments
JOIN companies 
ON departments.company_id=companies.company_id;

-- find employees along with their departments  and company;
SELECT employees.first_name,employees.last_name,departments.department_name,companies.company_name 
FROM employees
JOIN departments 
ON employees.department_id=departments.department_id
JOIN companies
ON companies.company_id=departments.company_id;

-- find the average salary per  department;
SELECT departments.department_name,ROUND(AVG(employees.salary),2) as salary  
FROM employees
JOIN departments
ON employees.department_id=departments.department_id
GROUP BY employees.department_id;

-- list all products and their company ;
SELECT products.product_id,products.product_name,companies.company_name 
FROM products
JOIN companies 
ON products.company_id=companies.company_id;

-- number of employees as per status;
SELECT COUNT(employee_id)as count,status FROM employees
GROUP BY status ;

-- number of employees active and on leave;
SELECT COUNT(employee_id) ,status FROM employees
WHERE status  IN ('active','on leave')
GROUP BY status ;

-- find the highest paid employee in each department;
SELECT * FROM employees
WHERE salary IN (SELECT max(salary) as max_salary
				  FROM employees
				  GROUP BY department_id);
                  
-- find which department has lowest and highest payed employee along with his salary and his job role;
(SELECT departments.department_id,departments.department_name,employees.salary,employees.job_title 
FROM employees
JOIN departments
ON employees.department_id=departments.department_id
ORDER BY salary 
LIMIT 1)
UNION 
(SELECT departments.department_id,departments.department_name,employees.salary,employees.job_title 
FROM employees
JOIN departments
ON employees.department_id=departments.department_id
ORDER BY salary DESC
LIMIT 1);

-- find the job_role with highest pay
SELECT job_title FROM employees 
WHERE salary =( SELECT MAX(salary) 
                FROM employees);

-- list the services along with employee and product details;
SELECT * FROM servicerecords
JOIN employees
ON servicerecords.employee_id=employees.employee_id
JOIN products
ON servicerecords.product_id=products.product_id
ORDER BY service_id ASC;

-- find the number of employees in each company;
SELECT companies.company_name,COUNT(employee_id) 
FROM companies
JOIN departments 
ON companies.company_id=departments.company_id
JOIN employees
ON employees.department_id=departments.department_id
GROUP BY companies.company_name; 

-- which employee report to manager;
SELECT first_name,last_name,manager_id FROM employees
WHERE manager_id LIKE '%'
ORDER BY manager_id;
SELECT first_name, last_name
FROM Employees
WHERE manager_id IS NOT NULL;

-- employee unique job title;
SELECT job_title FROM employees
GROUP BY job_title
HAVING COUNT(*) = 1;

-- company with maximum departments;
SELECT companies.company_name,count(departments.department_name) as count 
FROM companies
join departments
ON companies.company_id=departments.company_id
GROUP BY departments.company_id
ORDER BY count DESC
LIMIT 1;
