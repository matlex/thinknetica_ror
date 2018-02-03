# Программа вычисляет площадь треугольника по формуле: 1/2*a*h где:
# (a) - основание
# (h) - высота

# Запрашиваем высоту треугольника у пользователя
print 'Input a height of triange: '
triangle_height = gets.to_f

# Запрашиваем основание треугольника у пользователя
print 'Input a base of triangle: '
triangle_base = gets.to_f

# Вычилсяем площадь треугольника и выводим результат пользователю
triangle_area = (0.5 * triangle_base * triangle_height)
puts("Triangle area is: #{triangle_area}")
