DROP TABLE IF EXISTS task2.employees CASCADE;
DROP TABLE IF EXISTS task2.departments CASCADE;
DROP VIEW IF EXISTS task2.department_employees CASCADE;
DROP SCHEMA IF EXISTS task2 CASCADE;

CREATE SCHEMA task2;

CREATE TABLE task2.departments (
    department_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE task2.employees (
    employee_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    department_id INTEGER NOT NULL,
    CONSTRAINT fk_employee_department
        FOREIGN KEY (department_id) REFERENCES task2.departments (department_id)
        ON DELETE RESTRICT
);

INSERT INTO task2.departments (department_name) VALUES
    ('Разработка'),
    ('Финансы'),
    ('Реклама');

INSERT INTO task2.employees (full_name, department_id) VALUES
    ('Никита Соловьёв', 1),
    ('Татьяна Лебедева', 1),
    ('Ирина Козлова', 2),
    ('Артём Зайцев', 3);

SELECT e.employee_id, e.full_name AS employee_name, d.department_name
FROM task2.employees AS e
JOIN task2.departments AS d ON d.department_id = e.department_id
ORDER BY e.employee_id;

CREATE VIEW task2.department_employees AS
SELECT e.employee_id, e.full_name AS employee_name, d.department_name
FROM task2.employees AS e
JOIN task2.departments AS d ON d.department_id = e.department_id;

SELECT employee_id, employee_name, department_name
FROM task2.department_employees
ORDER BY employee_id;

SELECT e.full_name AS employee_name, d.department_name
FROM task2.employees AS e
JOIN task2.departments AS d ON d.department_id = e.department_id
WHERE d.department_name = 'Разработка'
ORDER BY e.employee_id;

UPDATE task2.employees
SET department_id = 3
WHERE employee_id = 2;

SELECT e.employee_id, e.full_name AS employee_name, d.department_name
FROM task2.employees AS e
JOIN task2.departments AS d ON d.department_id = e.department_id
ORDER BY e.employee_id;

SELECT employee_id, employee_name, department_name
FROM task2.department_employees
WHERE employee_id = 2;
