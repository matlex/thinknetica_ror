# Гипотетическое приложение управления железнодорожными станциями, которое позволит управлять станциями,
# принимать и отправлять поезда, показывать информацию о них и т.д.

class Station
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def add(train)
    @trains << train
    # дополнительно назначает текущую станцию объекту train
    train.current_station = self
  end

  def remove(train)
    @trains.delete(train)
    # дополнительно убирает текущую станцию у объекта train
    train.current_station = nil
  end

  def all_trains_count
    @trains.size
  end

  def count_trains_by_type(type)
    @trains.select { |train| train.type == type }.size
  end
end

class Route
  attr_reader :stations

  def initialize(start_station, end_station)
    @stations = [start_station, end_station]
  end

  def show_stations
    @stations.each_with_index { |station, index| puts "#{index + 1}: #{station.name}" }
  end

  def add_intermediate_station(new_station)
    @stations.insert(-2, new_station)
  end

  def remove_intermediate_station(station)
    @stations.delete(station) unless [@stations.first, @stations.last].include? station
  end

  def count_stations
    @stations.size
  end
end

class Train
  attr_reader :type, :number, :wagons, :current_speed
  attr_accessor :current_station

  def initialize(number, type, wagons)
    @number = number
    @type = type
    @wagons = wagons
    @current_speed = 0
  end

  def speed_up(speed)
    @current_speed += speed
  end

  def speed_down(speed)
    @current_speed -= speed if (@current_speed - speed) >= 0
  end

  def stop
    @current_speed = 0
  end

  def add_wagon
    @wagons += 1 if @current_speed == 0
  end

  def remove_wagon
    @wagons -= 1 if @current_speed == 0 && @wagons > 0
  end

  def add_route(route)
    @route = route
    # Добавим в первую станцию маршрута наш поезд
    route.stations.first.add(self)
  end

  def next_station
    @route.stations[station_index(@current_station) + 1] if @route
  end

  def previous_station
    if @route && @current_station != @route.stations.first
      @route.stations[station_index(@current_station) - 1]
    end
  end

  def move_to_next_station
    found_next_station = next_station
    if found_next_station
      @current_station.remove(self)
      # @current_station проставится в методе add_train у станции
      found_next_station.add(self)
    end
  end

  def move_to_previous_station
    found_previous_station = previous_station
    if found_previous_station
      @current_station.remove(self)
      # @current_station проставится в методе add_train у станции
      found_previous_station.add(self)
    end
  end

  private

  def station_index(station)
    @route.stations.find_index(station)
  end
end

# Создаем станции
station1 = Station.new('Toronto')
station2 = Station.new('Quebec')
station3 = Station.new('Montreal')
puts

# Создадим маршрут от Toronto до Quebec
route1 = Route.new(station1, station2)
route1.show_stations
puts
route1.add_intermediate_station(station3)
route1.show_stations
puts

# Создадим пару поездов
train1 = Train.new('112233', 'Пассажирский', 10)
train2 = Train.new('55442', 'Грузовой', 30)
train3 = Train.new('H2323N', 'Грузовой', 45)

# Поиграемся со скоростью поезда и вагонами
puts train1.current_speed
train1.speed_up(5)
train1.speed_up(10)
puts train1.current_speed
train1.speed_down(8)
puts train1.current_speed
puts train1.wagons
train1.remove_wagon
train1.stop
train1.add_wagon
puts train1.wagons
puts train1.current_speed
train1.remove_wagon
puts train1.wagons
puts

# Пригоним поезд на станцию, но без назначения маршрута
station1.add(train3)
puts train3.current_station.name

# Поиграемся с маршрутом у поезда
puts train1.next_station
puts train1.previous_station

train1.add_route(route1)
puts train1.current_station.name

puts train1.next_station.name
puts train1.previous_station&.name

train1.move_to_next_station
puts train1.previous_station.name
puts train1.current_station.name

train1.move_to_next_station
puts train1.previous_station.name
puts train1.current_station.name

train1.move_to_next_station
puts train1.current_station.name

train1.move_to_previous_station
train1.move_to_previous_station
train1.move_to_previous_station
puts train1.current_station.name

station1.add(train2)
puts

station1.trains.each { |train| puts train.number }
puts station1.all_trains_count
puts
puts station1.count_trains_by_type('Пассажирский')
puts station1.count_trains_by_type('Грузовой')
puts
station1.remove(train2)
station1.trains.each { |train| puts train.number }
puts station1.all_trains_count
