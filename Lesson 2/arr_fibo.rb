# Заполнить массив числами фибоначчи до 100

# Используем самый простой алгоритм с циклом while и параллельным присваиванием переменных
output_arr = []
num_a, num_b = 1, 1
to_num = 1000

while num_a < to_num
  print "#{num_a} "
  output_arr << num_a
  num_a, num_b = num_b, num_a + num_b
end
