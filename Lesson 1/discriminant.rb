# Пользователь вводит 3 коэффициента a, b и с.
# Программа вычисляет дискриминант (D) и корни уравнения (x1 и x2, если они есть) и выводит значения
# дискриминанта и корней на экран. При этом возможны следующие варианты:
#   Если D > 0, то выводим дискриминант и 2 корня
#   Если D = 0, то выводим дискриминант и 1 корень (т.к. корни в этом случае равны)
#   Если D < 0, то выводим дискриминант и сообщение "Корней нет"

print 'Enter "a": '
a = gets.to_f
print 'Enter "b": '
b = gets.to_f
print 'Enter "c": '
c = gets.to_f

discriminant = b**2 - 4 * a * c

# Если D > 0, то выводим дискриминант и 2 корня
if discriminant > 0
  discriminant_square_root = Math.sqrt(discriminant)
  x1 = (-b + discriminant_square_root) / (2 * a)
  x2 = (-b - discriminant_square_root) / (2 * a)
  puts "D = #{discriminant_square_root}, х1 = #{x1}, х2 = #{x2}"
# Если D = 0, то выводим дискриминант и 1 корень
elsif discriminant == 0
  x = -b / (2 * a)
  puts "D = 0, х = #{x}"
# Если D < 0, то выводим дискриминант и сообщение "Корней нет"
else
  puts 'Корней нет.'
end
