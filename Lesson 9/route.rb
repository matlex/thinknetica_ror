require_relative 'station'
require_relative 'custom_errors'
require_relative 'validation'

class Route
  include InstanceCounter
  include CustomErrors
  include Validation

  CORRECT_STATION_TYPE = Station

  attr_reader :stations, :title

  validate :start_station, :presence
  validate :start_station, :type, CORRECT_STATION_TYPE

  validate :end_station, :presence
  validate :end_station, :type, CORRECT_STATION_TYPE

  def initialize(start_station, end_station)
    @start_station = start_station
    @end_station = end_station
    @stations = [@start_station, @end_station]
    validate!

    @title = "Route from #{@stations.first.name} to #{@stations.last.name}"
    register_instance
  end

  def valid?
    validate!
  rescue ValidationError
    false
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
