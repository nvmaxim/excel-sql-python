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
INSERT INTO sales_data VALUES
('Иван', 'А', 15000, 2, 'Q1'),
('Мария', 'Б', 22000, 5, 'Q1'),
('Петр', 'А', 17000, 3, 'Q1'),
('Анна', 'В', 12000, 1, 'Q1'),
('Сергей', 'Б', 25000, 4, 'Q1'),
('Иван', 'А', 18000, 2, 'Q2'),
('Мария', 'Б', 19000, 5, 'Q2'),
('Анна', 'В', 14000, 1, 'Q2'),
('Ольга', 'А', 16000, 2, 'Q2');

CREATE VIEW sales AS SELECT * FROM sales_data;

-- УПРАЖНЕНИЕ 1: "Анализ эффективности менеджеров"
SELECT
    department,
    AVG(revenue) AS avg_revenue
FROM sales
WHERE department IN ('А', 'Б')
GROUP BY department
ORDER BY avg_revenue DESC;

-- УПРАЖНЕНИЕ 2: "Классификация клиентов"
SELECT *
FROM (
    SELECT
        *,
        CASE
            WHEN revenue > 20000 THEN 'VIP'
            WHEN revenue >= 10000 THEN 'Standard'
            ELSE 'Basic'
        END AS category
    FROM sales
) AS classified
WHERE category = 'VIP'
ORDER BY revenue DESC;

-- УПРАЖНЕНИЕ 3: "Консолидация данных" 
CREATE VIEW sales_q1 AS
SELECT
    manager,
    revenue
FROM sales_data
WHERE period = 'Q1';

CREATE VIEW sales_q2 AS
SELECT
    manager,
    revenue
FROM sales_data
WHERE period = 'Q2';

-- Объединяем и агрегируем в одном запросе
SELECT
    manager,
    SUM(revenue) AS total_revenue
FROM (
    SELECT
        manager,
        revenue
    FROM sales_q1
    UNION ALL
    SELECT
        manager,
        revenue
    FROM sales_q2
) AS combined  -- ← ДОБАВЛЕН ПСЕВДОНИМ
GROUP BY manager
ORDER BY total_revenue DESC;

-- УПРАЖНЕНИЕ 4: "Очистка и трансформация"
SELECT
    manager,
    department,
    revenue AS sales,
    revenue * 0.10 AS bonus
FROM sales
WHERE
    experience >= 2
    AND department IN ('А', 'Б');

-- УПРАЖНЕНИЕ 5: "Комплексный отчет"
SELECT
    department,
    COUNT(manager) AS managers_count,
    SUM(revenue) AS total_revenue,
    SUM(revenue) * 1.0 / SUM(SUM(revenue)) OVER () AS revenue_share,
    SUM(revenue) * 1.0 / COUNT(manager) AS avg_per_manager,
    CASE
        WHEN SUM(revenue) * 1.0 / COUNT(manager) > 18000 THEN 'Да'
        ELSE 'Нет'
    END AS high_performance
FROM sales
GROUP BY department
ORDER BY total_revenue DESC;
