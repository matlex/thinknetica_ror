# Заполнить массив числами от 10 до 100 с шагом 5

# Решение 1
# Создаем интервал, далее используем метод step для указания шага итерации.
(10..100).step(5).each {|i| puts i}

puts
# Решение 2
# Почти то же, только при итерации заполняем целевой массив.
arr = []
(10..100).step(5).each {|i| arr << i}
puts arr
