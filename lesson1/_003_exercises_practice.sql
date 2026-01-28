-- Универсальная таблица для всех упражнений
DROP VIEW IF EXISTS sales;
DROP VIEW IF EXISTS sales_q1;
DROP VIEW IF EXISTS sales_q2;
DROP TABLE IF EXISTS sales_data;
CREATE TABLE sales_data (
    manager VARCHAR(50),
    department VARCHAR(1),
    revenue INT,
    experience INT,
    period VARCHAR(2)
);
-- Заполняем данными
INSERT INTO sales_data
VALUES ('Иван', 'А', 15000, 2, 'Q1'),
('Мария', 'Б', 22000, 5, 'Q1'),
('Петр', 'А', 17000, 3, 'Q1'),
('Анна', 'В', 12000, 1, 'Q1'),
('Сергей', 'Б', 25000, 4, 'Q1'),
('Иван', 'А', 18000, 2, 'Q2'),
('Мария', 'Б', 19000, 5, 'Q2'),
('Анна', 'В', 14000, 1, 'Q2'),
('Ольга', 'А', 16000, 2, 'Q2');
CREATE VIEW sales AS
SELECT *
FROM sales_data;

--Упражнение
-- УПРАЖНЕНИЕ 5: "Комплексный отчет" (SQL)
SELECT
    manager,
    department,
    revenue AS sales,
    revenue * 0.10 AS bonus
FROM sales_data
WHERE experience >= 2 AND department IN ('А', 'Б');
