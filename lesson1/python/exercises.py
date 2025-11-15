import pandas as pd
import numpy as np
from main import df

# УПРАЖНЕНИЕ 1: "Анализ эффективности менеджеров"
result = (
    df[df["department"].isin(["А", "Б"])]  # Сито: оставляем только А и Б
    .groupby("department")  # Коробки: группируем по отделам
    .agg({"revenue": "mean"})  # Соковыжималка: выжимаем среднее
    .rename(columns={"revenue": "avg_revenue"})  # Новая этикетка: переименовываем
    .sort_values("avg_revenue", ascending=False)  # Ветер: раскладываем по убыванию
    .reset_index()[["department", "avg_revenue"]]
)  # Инструменты: берем только нужное
print(result)

#  УПРАЖНЕНИЕ 2: "Классификация клиентов"
# Весы + Новая деталь: взвешиваем и наклеиваем категории
df["category"] = np.where(
    df["revenue"] > 20000, "VIP", np.where(df["revenue"] >= 10000, "Standard", "Basic")
)

# Сито + Ветер: отбираем VIP и раскладываем по убыванию
result = df[df["category"] == "VIP"].sort_values("revenue", ascending=False)
print(result)

# УПРАЖНЕНИЕ 3: "Консолидация данных"
# Для упражнения 3 - разделяем на периоды обучение
sales_q1 = df[df["period"] == "Q1"][["manager", "revenue"]].reset_index(drop=True)
sales_q2 = df[df["period"] == "Q2"][["manager", "revenue"]].reset_index(drop=True)
# Две стопки бумаг: объединяем отчеты
combined_sales = pd.concat([sales_q1, sales_q2])

# Коробки + Соковыжималка + Ветер: группируем, суммируем, сортируем
result = (
    combined_sales.groupby("manager")  # Коробки: по менеджерам
    .agg(total_revenue=("revenue", "sum"))  # Соковыжималка: выжимаем сумму
    .sort_values("total_revenue", ascending=False)  # Ветер: раскладываем по убыванию
    .reset_index()
)
print(result)

# УПРАЖНЕНИЕ 4: "Очистка и трансформация"
# Сито + Ластик: фильтруем опыт ≥2 и отделы А/Б
result = df[(df["experience"] >= 2) & (df["department"].isin(["А", "Б"]))].copy()

# Новая деталь: добавляем колонку бонуса
result["bonus"] = result["revenue"] * 0.10

# Новая этикетка: переименовываем колонку
result = result.rename(columns={"revenue": "sales"})
print(result)

# УПРАЖНЕНИЕ 5: "Комплексный отчет"
# Коробки + Соковыжималка: группируем и агрегируем
dept_report = (
    df.groupby("department")
    .agg(
        managers_count=("manager", "count"),  # Соковыжималка: счет
        total_revenue=("revenue", "sum"),
    )  # Соковыжималка: сумма
    .reset_index()
)

# Новая деталь: добавляем вычисляемые колонки
dept_report["revenue_share"] = (
    dept_report["total_revenue"] / dept_report["total_revenue"].sum()
)
dept_report["avg_per_manager"] = (
    dept_report["total_revenue"] / dept_report["managers_count"]
)

# Весы: добавляем флаг эффективности
dept_report["high_performance"] = np.where(
    dept_report["avg_per_manager"] > 18000, "Да", "Нет"
)

# Ветер: сортируем по убыванию выручки
result = dept_report.sort_values("total_revenue", ascending=False)
print(result)
