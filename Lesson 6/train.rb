require_relative 'instance_counter'
require_relative 'custom_errors'

class Train
  include InstanceCounter
  include CustomErrors

  attr_reader :type, :number, :wagons, :current_speed

  POSSIBLE_TRAIN_TYPES = ['Passenger', 'Cargo']

  NUMBER_FORMAT_PATTERN = /^[a-z0-9]{3}-?[a-z0-9]{2}$/i

  @@trains = {}

  def initialize(number, type)
    @number = number
    @type = type
    @wagons = []
    @current_speed = 0
    @@trains[number] = self
    register_instance
    validate!
  end

  def self.find(number)
    @@trains.fetch(number, nil)
  end

  def valid?
    begin
      validate!
    rescue
      false
    end
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
    raise NotImplementedError
  end

  def correct_train_type
    raise NotImplementedError
  end

  def validate!
    raise ValidationError, "Number can't be nil" if number.nil?
    raise ValidationError, "Train number should be 6 symbols" unless number.length == 6
    raise ValidationError, "Train number has invalid format" if number !~ NUMBER_FORMAT_PATTERN
    raise ValidationError, "Wrong train type: \"#{@type}\"" unless POSSIBLE_TRAIN_TYPES.include?(correct_train_type)
    true
  end
end
