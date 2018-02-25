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
    if train_obj.instance_of? Train
      @trains_on_station << {type: train_obj.type, number: train_obj.number, wagons: train_obj.wagons}
      puts "Поезд ##{train_obj.number} успешно прибыл на станцию #{name}."
    else
      puts "Добавлять на станцию можно только объект типа Train"
    end
  end

  def remove_train(train_number)
    @trains_on_station.delete_if { |train| train[:number] == train_number}
    puts "Поезд ##{train_number} успешно выбыл из станции #{name}."
  end

  def all_trains
    puts "Текущие поезда на станции: #{@trains_on_station}"
  end

  def all_trains_count
    puts "Всего поездов на станции: #{@trains_on_station.size}"
  end

  def all_trains_by_type(train_type)
    trains_by_type = @trains_on_station.select{ |train| train[:type] == train_type }.size
    puts "Количество поездов с типом \"#{train_type}\" на станции: #{trains_by_type}"
  end

  def to_s
    name
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
    puts "Маршрут от станции #{start_station} до станции #{end_station} успешно создан"
  end

  def get_all_stations
    puts 'Все станции на маршруте:'
    @stations.each_with_index { |station, index| puts "#{index + 1}: #{station}"}
  end

  def add_intermediate_station(new_station)
    @stations.insert(-2, new_station)
    puts "Новая станция \"#{new_station}\" добавлена."
  end

  def remove_intermediate_station(station_name)
    if [@stations.first, @stations.last].include? station_name
      puts "Нельзя удалять начальную/конечную станцию"
    elsif @stations.delete(station_name)
      puts "Станция успешно удалена"
    else
      puts "Не удалось удалить станцию с именем #{station_name}"
    end
  end

  def count_stations
    @stations.size
  end
end

class Train
  attr_reader :type, :number, :wagons

  def initialize(num, type, wagons)
    @number = num
    @type = type
    @wagons = wagons
    @route = nil
    @current_speed = 0
    @current_station = nil
    puts 'Поезд успешно создан'
    get_wagons
  end

  def speed_up
    @current_speed += 10
    puts "Поезд разогнался до #{@current_speed}"
  end

  def speed_down
    # Уменьшаем скорость на 10 только если текущая скорость кратна 10. Для того, чтобы не уйти в минус.
    @current_speed -= 10 if @current_speed % 10 == 0
    puts "Поезд притормозил до #{@current_speed}"
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
      puts 'Нельзя добавить вагон, когда поезд в движении или если вагонов нет!'
    end
  end

  def add_route(route_obj)
    @route = route_obj
    @current_station = 0
    puts 'Маршрут успешно добавлен поезду'
  end

  def current_station
    if @current_station
      puts "Текущая станция: #{get_station_from_route(@current_station)}"
    else
      puts 'Текущая станция: пока что поезду не назначено маршрутов'
    end
  end

  def next_station
    if @current_station
      next_station = get_station_from_route(@current_station + 1)
      if next_station
        puts "Следующая станция: #{next_station}"
      else
        puts 'Следующей станции нет, поезд в конце пути.'
      end
    else
      puts 'Следующая станция: пока что поезду не назначено маршрутов'
    end
  end

  def previous_station
    if @current_station && (@current_station != 0)
      prev_station = get_station_from_route(@current_station - 1)
      puts "Предыдущая станция: #{prev_station}"
    else
      puts 'Предыдущая станция: пока что поезду не назначено маршрутов либо он в самом начале пути'
    end
  end

  def move_to_next_station
    if @current_station + 1 < @route.count_stations
      @current_station += 1
      puts "Поезд успешно доехал до следующей станции: #{get_station_from_route(@current_station)}"
    else
      puts 'Дальше ехать нельзя. Это конечная станция.'
    end
  end

  def move_to_previous_station
    if @current_station != 0
      @current_station -= 1
      puts "Поезд успешно доехал до предыдущей станции: #{get_station_from_route(@current_station)}"
    else
      puts 'Назад ехать нельзя. Это начальная станция.'
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
route1 = Route.new(station1.name, station2.name)
route1.add_intermediate_station(station3.name)
route1.get_all_stations
route1.remove_intermediate_station('Montreal')
route1.remove_intermediate_station('FakeStation')
route1.add_intermediate_station(station3.name)
route1.get_all_stations
puts

# Создадим пару поездов
train1 = Train.new('112233', 'Пассажирский', 10)
train2 = Train.new('55442', 'Грузовой', 30)
puts

# Поиграемся со скоростью поезда и вагонами
train1.get_current_speed
train1.speed_up
train1.speed_up
train1.get_current_speed
train1.speed_down
train1.get_current_speed
train1.get_wagons
train1.remove_wagon
train1.stop
train1.add_wagon
train1.get_wagons
train1.get_current_speed
puts

# Поиграемся с маршрутом у поезда
train1.current_station
train1.add_route(route1)
train1.current_station
train1.next_station
train1.previous_station
train1.move_to_next_station
train1.move_to_next_station
train1.move_to_next_station
train1.next_station
train1.current_station
train1.move_to_previous_station
train1.move_to_previous_station
train1.previous_station
train1.move_to_previous_station
train1.current_station
exit

puts
station1.add_train(train1)
station1.add_train(train2)
puts
station1.all_trains
station1.all_trains_count
station1.all_trains_by_type('Пассажирский')
station1.all_trains_by_type('Грузовой')
puts
station1.remove_train('55442')
station1.all_trains
station1.all_trains_count
puts
