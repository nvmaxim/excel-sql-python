-- Универсальная таблица для всех упражнений
DROP VIEW IF EXISTS sales;

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

SELECT *
FROM sales;

-- УПРАЖНЕНИЕ 1: "Анализ эффективности менеджеров"
SELECT
    department,
    -- Инструменты: выбираем столбцы
    -- Соковыжималка: средняя выручка
    AVG(revenue) AS avg_revenue
FROM sales
WHERE department IN ('А', 'Б') -- Сито: только отделы А и Б
GROUP BY department -- Коробки: группируем по отделам
ORDER BY avg_revenue DESC;

-- Ветер: сортируем по убыванию
-- УПРАЖНЕНИЕ 2: "Классификация клиентов"
SELECT *
FROM (
    SELECT
        *,
        CASE
            -- Весы: классифицируем
            -- Новая деталь: создаем колонку
            WHEN revenue > 20000 THEN 'VIP'
            WHEN revenue >= 10000 THEN 'Standard'
            ELSE 'Basic'
        END AS category
    FROM sales
) AS classified
WHERE category = 'VIP' -- Сито: только VIP
ORDER BY revenue DESC;

-- Ветер: по убыванию выручки
