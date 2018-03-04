class Main

  def run
    ask_action
  end

  private

  def ask_action
    loop do
      print_actions
      choice = gets.chomp

      puts choice
    end
  end

  def print_actions
    puts 'Please choose one of actions listed below:'
    puts 'Enter 1 to create a station'
    puts 'Enter 2 to create a passenger train'
    puts 'Enter 3 to create a cargo train'
    puts 'Enter 4 to create a new route'
    puts 'Enter 5 to add station to the route'
    puts 'Enter 6 to remove station from the route'
    puts 'Enter 7 to set the route to train'
    puts 'Enter 8 to add wagon to train'
    puts 'Enter 9 to remove wagon from train'
    puts 'Enter 10 to move a train to the next station'
    puts 'Enter 11 to move a train to the previous station'
    puts 'Enter 12 to print out stations and trains lists'
    puts 'Enter anything else to exit'
  end

  # Создать станцию
  # Создать пассажирский поезд
  # Создать грузовой поезд
  # Создать маршрут
  # Добавить станцию в маршрут
  # Удалить станцию из маршрута
  # Назначить маршрут поезду
  # Добавить вагон поезду
  # Удалить вагон у поезда
  # Направить поезд к следующей станции
  # Направить поезд к предыдущей станции
  # Просматривать список станций и список поездов на станции
end

if __FILE__ == $0
  Main.new.run
end
