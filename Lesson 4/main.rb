require_relative 'station'
require_relative 'passenger_train'
require_relative 'cargo_train'

class Main

  def initialize
    @stations = []
    @trains = []
    @routes = []
  end

  def run
    ask_action
  end

  private

  def ask_action
    loop do
      show_possible_actions
      choice = gets.chomp
      case choice
        when '1' then create_station
        when '2' then create_passenger_train
        when '3' then create_cargo_train
        when '4' then route_create
        when '5' then route_add_station
        when '6' then route_remove_station
        when '7' then route_set_to_train
        when '8' then add_train_wagon
        when '9' then remove_train_wagon
        when '10' then train_move_forward
        when '11' then train_move_backward
        when '12' then show_trains_in_station
        else
          show_possible_actions
      end
      puts '...'
    end
  end

  def show_possible_actions
    puts
    puts "Please choose one of actions listed below:"
    puts
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

  def create_station
    puts 'Enter a station title: '
    station_title = gets.chomp
    station = Station.new(station_title)
    @stations << station

    puts "Station #{station.name} created."
  end

  def create_passenger_train
    puts 'Enter a passenger train number: '
    number = gets.chomp
    train = PassengerTrain.new(number, 'Passenger')
    @trains << train
    puts "#{train.type} train No #{train.number} successfully created!"
  end

  def create_cargo_train
    puts 'Enter a cargo train number: '
    number = gets.chomp
    train = CargoTrain.new(number, 'Cargo')
    @trains << train
    puts "#{train.type} train No #{train.number} successfully created!"
  end
  # Создать маршрут
  def route_create

  end
  # Добавить станцию в маршрут
  def route_add_station

  end
  # Удалить станцию из маршрута
  def route_remove_station

  end
  # Назначить маршрут поезду
  def route_set_to_train

  end
  # Добавить вагон поезду
  def add_train_wagon

  end
  # Удалить вагон у поезда
  def remove_train_wagon

  end
  # Направить поезд к следующей станции
  def train_move_forward

  end
  # Направить поезд к предыдущей станции
  def train_move_backward

  end
  # Просматривать список станций и список поездов на станции
  def show_trains_in_station

  end
end

if __FILE__ == $0
  Main.new.run
end
