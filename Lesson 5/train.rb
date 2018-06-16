class Train
  attr_reader :type, :number, :wagons, :current_speed

  def initialize(number, type)
    @number = number
    @type = type
    @wagons = []
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

  def add_wagon(wagon)
    if @current_speed == 0 && correct_type?(wagon)
      @wagons << wagon
      puts "Wagon successfully added to train No #{self.number}"
    else
      puts 'Too high speed or incorrect wagon type'
    end
  end

  def remove_wagon
    if @current_speed == 0 && !@wagons.empty?
      @wagons.pop
    else
      puts 'Too high speed or nothing to remove'
    end
  end

  def current_station
    @route.stations[@current_station_index]
  end

  def add_route(route)
    @route = route
    @current_station_index = 0
    # Добавим в первую станцию маршрута наш поезд
    current_station.add(self)
  end

  def move_to_next_station
    if next_station
      current_station.remove(self)
      @current_station_index += 1
      current_station.add(self)
    end
  end

  def move_to_previous_station
    if previous_station
      current_station.remove(self)
      @current_station_index -= 1
      current_station.add(self)
    end
  end

  protected
  # Выносим методы т.к. они не будут вызываться клиентом, а используются только внутри текущего класса и его наследников
  def next_station
    @route.stations[@current_station_index + 1] if @route
  end

  def previous_station
    if @route && current_station != @route.stations.first
      @route.stations[@current_station_index - 1]
    end
  end

  def correct_type?(wagon)
    wagon.is_a?(correct_wagon_type)
  end

  def correct_wagon_type
    # Переопределяется в дочерних классах
  end

end
