require_relative 'station'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'route'

class Main

  def initialize
    @stations = []
    @trains = []
    @routes = []
    @wagons = []

    add_mocks
  end

  def run
    ask_action
  end

  private

  def add_mocks
    @stations << Station.new('Bishkek')
    @stations << Station.new('Almaty')

    @trains << PassengerTrain.new('AAA-01')
    @trains << CargoTrain.new('BBB-02')

    @wagons << PassengerWagon.new(30)
    @wagons << CargoWagon.new(500)
  end

  def ask_action
    loop do
      show_possible_actions
      begin
        choice = gets.chomp
        case choice
          when '0'  then show_possible_actions
          when '1'  then create_station
          when '2'  then create_passenger_train
          when '3'  then create_cargo_train
          when '4'  then route_create
          when '5'  then route_add_station
          when '6'  then route_remove_station
          when '7'  then route_set_to_train
          when '8'  then add_train_wagon
          when '9'  then remove_train_wagon
          when '10' then train_move_forward
          when '11' then train_move_backward
          when '12' then show_trains_in_station
          when '13' then create_wagon
          when '14' then print_all_wagons
          when '15' then show_train_wagons
          when '16' then reserve_seat_or_volume_in_wagon
          else
            break
        end
        puts '...'
      rescue => e
        puts "::ERROR:: #{e.message}"
      end
    end
  end

  def create_station
    puts 'Enter a station title: '
    station_title = gets.chomp
    station = Station.new(station_title)
    @stations << station

    puts "Station #{station.name} created." if station.valid?
  end

  def create_passenger_train
    puts 'Enter a passenger train number: '
    number = gets.chomp
    train = PassengerTrain.new(number)
    @trains << train

    puts "#{train.type} train No #{train.number} successfully created!" if train.valid?
  end

  def create_cargo_train
    puts 'Enter a cargo train number: '
    number = gets.chomp
    train = CargoTrain.new(number)
    @trains << train

    puts "#{train.type} train No #{train.number} successfully created!" if train.valid?
  end

  def create_wagon
    puts 'What type of wagon you want create? a: CargoWagon, b: PassengerWagon'
    wagon_type = gets.chomp
    case wagon_type
      when 'a'
        puts 'What is a volume of Cargo wagon should be?'
        volume = gets.chomp
        @wagons << CargoWagon.new(volume.to_i)
      when 'b'
        puts 'How many seats in Passenger wagon should be?'
        seats = gets.chomp
        @wagons << PassengerWagon.new(seats.to_i)
      else
        puts 'Choose right type of wagon'
        return
    end
    puts 'Wagon successfully created'
  end

  def route_create
    if @stations.empty? || @stations.size == 1
      puts 'You have no stations or just one, but the route needs two stations'
    else
      puts 'FIRST station:'
      station1 = select_station
      loop do
        puts 'SECOND station:'
        station2 = select_station
        if station2 != station1
          route = Route.new(station1, station2)
          @routes << route
          puts "#{route.title} successfully created!" if route.valid?
          break
        else
          puts "You can't set second station same as first."
        end
      end
    end
  end

  def route_add_station
    route = select_route
    if route
      station = select_station
      route.add_intermediate_station(station) if station
      puts "Station '#{station.name}' successfully added to route"
    end
  end

  def route_remove_station
    route = select_route
    if route
      station = select_station_from_route(route)
      route.remove_intermediate_station(station) if station
    end
  end

  def route_set_to_train
    route = select_route
    train = select_train
    if route && train
      train.add_route(route)
      puts "#{route.title} successfully added to train No #{train.number}"
    end
  end

  def add_train_wagon
    unless @wagons.any?
      puts 'Please create any wagon first'
      return
    end

    train = select_train
    if train
      wagon = select_wagon
      case train
        when CargoTrain
          puts 'Wrong wagon type!' unless wagon.class == CargoWagon
        when PassengerTrain
          puts 'Wrong wagon type!' unless wagon.class == PassengerWagon
      end
      train.add_wagon(wagon)
    end
  end

  def reserve_seat_or_volume_in_wagon
    wagon = select_wagon
    if wagon
      case wagon
        when CargoWagon
          puts 'How many volume to reserve?'
          volume = gets.chomp
          wagon.reserve_volume!(volume.to_i)
          puts 'Done!'
        when PassengerWagon
          wagon.reserve_seat!
          puts 'Done!'
      end
    end
  end

  def remove_train_wagon
    train = select_train
    if train
      train.remove_wagon
      puts "Wagon successfully removed from train No #{train.number}"
    end
  end

  def train_move_forward
    train = select_train
    if train
      train.move_to_next_station
      puts "Train No #{train.number} arrived to #{train.current_station} station"
    end
  end

  def train_move_backward
    train = select_train
    if train
      train.move_to_previous_station
      puts "Train No #{train.number} arrived to #{train.current_station} station"
    end
  end

  def show_trains_in_station
    station = select_station
    if station
      puts "List of trains on #{station.name} station:"
      station.iterate_trains { |train, index| puts "#{index}: #{train.number} -- #{train.type}, total wagons: #{train.wagons_count}" }
    end
  end

  def show_train_wagons
    train = select_train
    if train
      case train
        when PassengerTrain
          train.iterate_wagons { |wagon, index| print_passenger_wagon_info(wagon: wagon, index: index) }
        when CargoTrain
          train.iterate_wagons { |wagon, index| print_cargo_wagon_info(wagon: wagon, index: index) }
      end
    end
  end

# Helpers
  def print_stations
    @stations.each.with_index(1) {|station, index| puts "#{index}: #{station.name}"}
  end

  def print_routes
    @routes.each.with_index(1) {|route, index| puts "#{index}: #{route.title}"}
  end

  def print_trains
    @trains.each.with_index(1) {|train, index| puts "#{index}: #{train.number}: #{train.type}"}
  end

  def print_all_wagons
    @wagons.each.with_index(1) do |wagon, index|
      if wagon.class == CargoWagon
        print_cargo_wagon_info(wagon: wagon, index: index)
      elsif wagon.class == PassengerWagon
        print_passenger_wagon_info(wagon: wagon, index: index)
      end
    end
  end

  def print_cargo_wagon_info(wagon:, index:)
    puts "#{index}: #{wagon.class.name}, total volume: #{wagon.total_volume}, reserved volume: #{wagon.reserved_volume}, free volume: #{wagon.free_volume}"
  end

  def print_passenger_wagon_info(wagon:, index:)
    puts "#{index}: #{wagon.class.name}, total seats: #{wagon.total_seats}, reserved seats: #{wagon.reserved_seats}, free seats: #{wagon.free_seats}"
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
    puts 'Enter 13 to create wagon'
    puts 'Enter 14 to print out wagons list'
    puts 'Enter 15 to show train wagons'
    puts 'Enter 16 to reserve seat or volume in train wagon'
    puts 'Enter 0 to show menu again'
    puts 'Enter anything else to exit'
  end

  def select_route
    puts 'Choose route:'
    print_routes
    user_choice = gets.to_i
    if user_choice <= @routes.size
      @routes[user_choice - 1]
    else
      puts 'Choose a correct number for route'
    end
  end

  def select_station
    if @stations.size > 0
      puts 'Choose station:'
      print_stations
      user_choice = gets.to_i
      if user_choice <= @stations.size
        @stations[user_choice - 1]
      else
        puts 'Choose a correct number for station'
      end
    else
      puts 'There is no any station!'
    end
  end

  def select_station_from_route(route)
    puts 'Choose station you want remove:'
    route.show_stations
    user_choice = gets.to_i
    if user_choice <= route.stations.size
      route.stations[user_choice - 1]
    else
      puts 'Choose a correct number for station'
    end
  end

  def select_train
    puts 'Choose one of trains:'
    print_trains
    user_choice = gets.to_i
    if user_choice <= @trains.size
      @trains[user_choice - 1]
    else
      puts 'Choose a correct number for train'
    end
  end

  def select_wagon
    puts 'Choose wagon:'
    print_all_wagons
    user_choice = gets.to_i
    if user_choice <= @wagons.size
      @wagons[user_choice - 1]
    else
      puts 'Choose a correct number for wagon'
    end
  end
end

if __FILE__ == $0
  Main.new.run
end
