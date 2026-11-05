DROP TABLE IF EXISTS task1.access_cards CASCADE;
DROP TABLE IF EXISTS task1.employees CASCADE;
DROP VIEW IF EXISTS task1.employee_access_cards CASCADE;
DROP SCHEMA IF EXISTS task1 CASCADE;

CREATE SCHEMA task1;

CREATE TABLE task1.employees (
    employee_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL
);

CREATE TABLE task1.access_cards (
    card_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    card_number VARCHAR(30) NOT NULL,
    employee_id INTEGER NOT NULL,
    CONSTRAINT uq_access_card_number UNIQUE (card_number),
    CONSTRAINT uq_access_card_employee UNIQUE (employee_id),
    CONSTRAINT fk_access_card_employee
        FOREIGN KEY (employee_id) REFERENCES task1.employees (employee_id)
        ON DELETE RESTRICT
);

INSERT INTO task1.employees (full_name) VALUES
    ('Сергей Волков'),
    ('Ольга Крылова'),
    ('Денис Медведев');

INSERT INTO task1.access_cards (card_number, employee_id) VALUES
    ('PASS-101', 1),
    ('PASS-102', 2);

SELECT e.full_name AS employee_name, ac.card_number
FROM task1.employees AS e
JOIN task1.access_cards AS ac ON ac.employee_id = e.employee_id
ORDER BY e.employee_id;

CREATE VIEW task1.employee_access_cards AS
SELECT e.full_name AS employee_name, ac.card_number
FROM task1.employees AS e
JOIN task1.access_cards AS ac ON ac.employee_id = e.employee_id;

SELECT employee_name, card_number
FROM task1.employee_access_cards
ORDER BY card_number;
