require_relative 'instance_counter'
require_relative 'custom_errors'
require_relative 'accessors'
require_relative 'validation'

class Station
  include InstanceCounter
  include CustomErrors
  include Accessors
  include Validation

  STATION_NAME_FORMAT = /^[A-Z0-9]{3,}$/i

  attr_reader :trains
  attr_accessor_with_history :name

  validate :name, :presence, :and_something
  validate :name, :format, STATION_NAME_FORMAT

  @@all_stations = 0

  def self.all
    @@all_stations
  end

  def initialize(name)
    @name = name
    @trains = []
    @@all_stations += 1
    validate!
    register_instance
  end

  def valid?
    validate!
  rescue ValidationError
    false
  end

  def add(train)
    @trains << train
  end

  def remove(train)
    @trains.delete(train)
  end

  def all_trains_count
    @trains.size
  end

  def show_all_trains
    @trains.each.with_index(1) do |train, index|
      puts "#{index}: #{train.number} -- #{train.type}"
    end
  end

  def count_trains_by_type(type)
    @trains.select { |train| train.type == type }.size
  end

  def iterate_trains
    @trains.each.with_index(1) { |train, index| yield(train, index) }
  end

end
