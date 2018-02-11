# Заданы три числа, которые обозначают число, месяц, год (запрашиваем у пользователя).
# Найти порядковый номер даты, начиная отсчет с начала года. Учесть, что год может быть високосным.

print 'Enter a day: '
day = gets.to_i

print 'Enter a month: '
month = gets.to_i

print 'Enter a year: '
year = gets.to_i

# Каждый элемент соответсвует кол-ву дней в каждом месяце года
days_in_months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

if day > days_in_months[month] || day == 0
  puts 'Enter correct day'
elsif
  month == 0 || month > days_in_months.size
  puts 'Enter correct month'
else
  # Определим високосный ли год, и если да, то в феврале будет 29 дней вместо 28
  # Используем алгоритм http://www.adm.yar.ru/arch_serv/2000/Microsoft/content/vis.htm
  days_in_months[1] = 29 if (year % 4 == 0 && year % 100 != 0) || year % 400 == 0

# Можно было бы использовать метод sum для массива, но раз уж изучаем итерации над массивами и блоки, то сделаем так:
  days_sum = 0
  days_in_months[0, month-1].each {|days_in_month| days_sum += days_in_month }
  date_index = days_sum + day

  puts date_index
end
