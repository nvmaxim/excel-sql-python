# Вопрос:
# Дана строка. Нужно создать копию, где символы исходной строки с нечётными индексами (1,3,5,…) переставлены в обратном порядке, а символы с чётными индексами остаются на местах. Вывести результат. ввод 0123456789 должен быть такой результат 0927456381

s = "0123456789"

odd = ""
i = 0
for symb in s:
    if i % 2 == 1:
        odd += symb
    i += 1


sort = ""
k = 0
i = 0
len_odd = 0
for _ in odd:
    len_odd += 1


for symb in s:
    if i % 2 == 0:
        sort += symb
    else:
        need = len_odd - k - 1
        pick = ""
        j = 0
        for sy in odd:
            if j == need:
                pick = sy
                break
            j += 1
        sort += pick
        k += 1
    i += 1
print(odd)
print(sort)
