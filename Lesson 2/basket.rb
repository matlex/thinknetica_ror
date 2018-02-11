# Сумма покупок. Пользователь вводит поочередно название товара, цену за единицу и кол-во купленного
# товара (может быть нецелым числом). Пользователь может ввести произвольное кол-во товаров до тех пор,
# пока не введет "стоп" в качестве названия товара. На основе введенных данных требуетеся:
# Заполнить и вывести на экран хеш, ключами которого являются названия товаров, а значением - вложенный
# хеш, содержащий цену за единицу товара и кол-во купленного товара. Также вывести итоговую сумму за
# каждый товар.
# Вычислить и вывести на экран итоговую сумму всех покупок в "корзине".

basket = {}
grand_total = 0

loop do
  print 'Enter an item title: '
  item_title = gets.chomp.downcase

  # Останавливаем дальнейший сбор информации если была команда 'stop'
  break if item_title == 'stop'

  print 'Enter an item quantity: '
  item_qty = gets.to_f

  print 'Enter an item price: '
  item_price = gets.to_f

  basket[item_title] = {
    price: item_price,
    qty: item_qty
  }
end

puts
puts "Current items in basket: \n#{basket}"
puts

# Выводим список товаров с итоговой стоимостью по каждой позиции и одновременно собираем итоговую сумму корзины
basket.each do |item_name, value|
  item_total = value[:price] * value[:qty]
  grand_total += item_total
  puts "#{item_name} --- total: #{item_total}"
end

puts "\nGrand Total: #{grand_total}"
