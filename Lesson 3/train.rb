# Гипотетическое приложение управления железнодорожными станциями, которое позволит управлять станциями,
# принимать и отправлять поезда, показывать информацию о них и т.д.

class Station
  attr_reader :name

  def initialize(name)
    @name = name
    @trains_on_station = []
    station_created_message
  end

  def add_train(train_obj)
    @trains_on_station << train_obj
    train_obj.current_station = self
    puts "Поезд ##{train_obj.number} успешно прибыл на станцию #{name}."
  end

  def remove_train(train_obj)
    @trains_on_station.delete(train_obj)
    train_obj.current_station = nil
      puts "Поезд ##{train_obj.number} успешно выбыл из станции #{name}."
  end

  def all_trains
    train_pretty_print = lambda do |train|
      puts "#{{number: train.number, type: train.type, wagons: train.wagons}}"
    end
    puts "Текущие поезда на станции: #{self.name}"
    @trains_on_station.each(&train_pretty_print)
  end

  def all_trains_count
    puts "Всего поездов на станции: #{@trains_on_station.size}"
  end

  def all_trains_by_type(train_type)
    trains_by_type = @trains_on_station.select{ |train| train.type == train_type }.size
    puts "Количество поездов с типом \"#{train_type}\" на станции: #{trains_by_type}"
  end

  private

  def station_created_message
    puts "Станция с названием #{name} успешно создана."
  end

end

class Route
  attr_reader :stations

  def initialize(start_station, end_station)
    @stations = [start_station, end_station]
    puts "Маршрут от станции #{start_station.name} до станции #{end_station.name} успешно создан"
  end

  def get_all_stations
    puts 'Все станции на маршруте:'
    @stations.each_with_index { |station, index| puts "#{index + 1}: #{station.name}"}
  end

  def add_intermediate_station(new_station)
    @stations.insert(-2, new_station)
    puts "Новая станция \"#{new_station.name}\" добавлена."
  end

  def remove_intermediate_station(station)
    if [@stations.first, @stations.last].include? station
      puts "Нельзя удалять начальную/конечную станцию"
    elsif @stations.delete(station)
      puts "Станция #{station.name} успешно удалена"
    else
      puts "Не удалось удалить станцию #{station.name}"
    end
  end

  def count_stations
    @stations.size
  end
end

class Train
  attr_reader :type, :number, :wagons
  attr_writer :current_station

  def initialize(num, type, wagons)
    @number = num
    @type = type
    @wagons = wagons
    @route
    @current_speed = 0
    @current_station
    @current_station_index
    puts 'Поезд успешно создан'
    get_wagons
  end

  def speed_up(speed)
    @current_speed += speed
    puts "Поезд разогнался до #{@current_speed} км/ч"
  end

  def speed_down(speed)
    @current_speed -= speed if (@current_speed - speed) >= 0
    puts "Поезд притормозил до #{@current_speed} км/ч"
  end

  def stop
    @current_speed = 0
    puts 'Поезд остановился'
  end

  def get_current_speed
    puts "Текущая скорость поезда #{@current_speed}"
  end

  def get_wagons
    puts "У поезда #{@wagons} вагонов"
  end

  def add_wagon
    if @current_speed == 0
      @wagons += 1
      puts 'Вагон успешно добавлен'
    else
      puts 'Нельзя добавить вагон когда поезд в движении!'
    end
  end

  def remove_wagon
    if @current_speed == 0 && @wagons > 0
      @wagons -= 1
      puts 'Вагон успешно отцеплен'
    else
      puts 'Нельзя отцепить вагон, когда поезд в движении или если вагонов нет!'
    end
  end

  def add_route(route_obj)
    @route = route_obj
    @current_station_index = 0
    puts 'Маршрут успешно добавлен поезду >>>'
    @current_station = get_current_station
    # Добавим в текущую станцию наш поезд
    @current_station.add_train(self)
  end

  def get_current_station
    if @current_station_index
      puts "Текущая станция: #{get_station_from_route(@current_station_index).name}"
      get_station_from_route(@current_station_index)
    # Если поезд на станции, но не имеет маршрута
    elsif @current_station
      puts "Текущая станция: #{@current_station.name}"
      @current_station
    else
      puts 'Текущая станция: пока что поезд находится в депо'
    end
  end

  def get_next_station
    if @current_station && @route
      next_station = get_station_from_route(@current_station_index + 1)
      if next_station
        puts "Следующая станция: #{next_station.name}"
        next_station
      else
        puts 'Следующей станции нет, поезд в конце пути.'
      end
    else
      puts 'Следующая станция: пока что поезду не назначено маршрутов'
    end
  end

  def get_previous_station
    if @current_station && @route
      if @current_station_index != 0
        prev_station = get_station_from_route(@current_station_index - 1)
        puts "Предыдущая станция: #{prev_station.name}"
        prev_station
      else
        puts 'Предыдущей станции нет, поезд в начале пути.'
      end
    else
      puts 'Предыдущая станция: пока что поезду не назначено маршрутов либо он в самом начале пути'
    end
  end

  def move_to_next_station
    next_station = get_next_station
    if next_station
      @current_station_index += 1
      @current_station.remove_train(self)
      # @current_station проставится в методе add_train у станции
      next_station.add_train(self)
    end
  end

  def move_to_previous_station
    previous_station = get_previous_station
    if previous_station
      @current_station_index -= 1
      @current_station.remove_train(self)
      # @current_station проставится в методе add_train у станции
      previous_station.add_train(self)
    end
  end

  private

  def get_station_from_route(station_index)
    @route.stations[station_index]
  end

end

# Создаем станции
station1 = Station.new('Toronto')
station2 = Station.new('Quebec')
station3 = Station.new('Montreal')
puts

# Создадим маршрут от Toronto до Quebec
route1 = Route.new(station1, station2)
route1.add_intermediate_station(station3)
route1.get_all_stations
route1.remove_intermediate_station(station3)
route1.add_intermediate_station(station3)
route1.get_all_stations
puts

# Создадим пару поездов
train1 = Train.new('112233', 'Пассажирский', 10)
train2 = Train.new('55442', 'Грузовой', 30)
train3 = Train.new('H2323N', 'Грузовой', 45)
puts

# Пригоним поезд на станцию, но без назначения маршрута
station1.add_train(train3)
train3.get_current_station
puts

# Поиграемся со скоростью поезда и вагонами
train1.get_current_speed
train1.speed_up(5)
train1.speed_up(10)
train1.get_current_speed
train1.speed_down(8)
train1.get_current_speed
train1.get_wagons
train1.remove_wagon
train1.stop
train1.add_wagon
train1.get_wagons
train1.get_current_speed
puts

# Поиграемся с маршрутом у поезда
train1.get_current_station
train1.get_previous_station
train1.get_next_station
puts

train1.add_route(route1)
puts

train1.get_next_station
train1.get_previous_station
puts

train1.move_to_next_station
train1.get_previous_station
puts

train1.move_to_next_station
train1.get_previous_station
puts

train1.move_to_next_station
train1.get_next_station
puts

train1.get_current_station
train1.move_to_previous_station
train1.move_to_previous_station
train1.get_previous_station
train1.move_to_previous_station
train1.get_current_station
puts

station1.add_train(train2)
puts

station1.all_trains
station1.all_trains_count
station1.all_trains_by_type('Пассажирский')
station1.all_trains_by_type('Грузовой')
puts
station1.remove_train(train2)
station1.all_trains
station1.all_trains_count
puts
