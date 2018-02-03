<<~doc
  Программа запрашивает у пользователя имя и рост и выводит идеальный вес по формуле <рост> - 110,
  после чего выводит результат пользователю на экран с обращением по имени. Если идеальный вес получается
  отрицательным, то выводится строка "Ваш вес уже оптимальный".
  Странное конечно условие, ну да ладно))
doc

print "What is you name?: "
name = gets.chomp.capitalize

print "What is your height?: "
height = gets.to_i

ideal_weight = height - 110

if ideal_weight >= 0
  puts "#{name}, your ideal weight is #{ideal_weight}"
else
  puts "Wow #{name}! Your weight is already ideal!"
end
