/*
  This section explains:
  1. Join employees table with itself
  2. use aliases to treat same tables as two separate tables
  3. Common Use cases
  	i)   comparing rows within same table
  	ii)  Finding relationships (employees & managers)
  	iii) Finding duplicates
  	iv)  Sequencing data
| emp_id  | emp_name  | manager_id  | salary |
| ------- | --------- | ----------- | ------ |
| 1       | Alice     | NULL        | 100000 |
| 2       | Bob       | 1           | 80000  |
| 3       | Carol     | 1           | 75000  |
| 4       | Dave      | 2           | 60000  |
| 5       | Eve       | 2           | 65000  |

*/

-- Create table
CREATE TABLE employees (
    emp_id INTEGER PRIMARY KEY,
    emp_name TEXT NOT NULL,
    manager_id INTEGER,
    salary REAL,
    FOREIGN KEY (manager_id) REFERENCES employees (emp_id)
);

-- Insert data
INSERT INTO employees (emp_id, emp_name, manager_id, salary) VALUES
(1, 'Alice', NULL, 100000),
(2, 'Bob', 1, 80000),
(3, 'Carol', 1, 75000),
(4, 'Dave', 2, 60000),
(5, 'Eve', 2, 65000);

-- View data
SELECT * FROM employees;

-- 1. basic self join - Find each employee's manager name
-- emp_id=2 - Bob's Manager is emp_id=1, that is Alice
-- Similarly, Carol's manager is Alice
-- Dave's manager is Bob
-- Eve's manager is Bob

SELECT emp_id,emp_name,manager_id FROM employees

-- need to find manager of each emp, we need all from left table (first table)
-- and only matched id from the right table (second table)

SELECT
	e.emp_name AS employee,
	m.emp_name AS manager
FROM employees e
LEFT JOIN employees m
ON e.manager_id=m.emp_id

-- Use e.manager_id = m.emp_id → to go upwards in hierarchy (employee → manager)
	-- to find manager of each employee
-- Use e.emp_id = m.manager_id → to go downwards in hierarchy (manager → direct reports)
	-- to find employees (direct reportees) under each manager

/*
[employees table as E]             [employees table as M]
+----+---------+------------+      +----+---------+------------+
| id | name    | manager_id |      | id | name    | manager_id |
+----+---------+------------+      +----+---------+------------+
|  1 | Alice   | NULL       |      |  1 | Alice   | NULL       |
|  2 | Bob     | 1          |      |  2 | Bob     | 1          |
|  3 | Carol   | 1          |      |  3 | Carol   | 1          |
|  4 | Dave    | 2          |      |  4 | Dave    | 2          |
|  5 | Eve     | 2          |      |  5 | Eve     | 2          |
+----+---------+------------+      +----+---------+------------+

Match: E.manager_id → M.id


E.emp_name | M.emp_name
-----------+-----------
Alice      | NULL
Bob        | Alice
Carol      | Alice
Dave       | Bob
Eve        | Bob

-- General Concept of Self Join
-- Duplicating the table
-- Joining "row to row"

        +-------------+
        | employees A |
        +-------------+
               ↓
         (join condition)
               ↑
        +-------------+
        | employees B |
        +-------------+
*/



