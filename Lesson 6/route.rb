require_relative 'station'
require_relative 'custom_errors'

class Route
  include InstanceCounter
  include CustomErrors

  attr_reader :stations, :title

  CORRECT_STATION_TYPE = Station

  def initialize(start_station, end_station)
    @stations = [start_station, end_station]
    validate!

    @title = "Route from #{@stations.first.name} to #{@stations.last.name}"
    register_instance
  end

  def valid?
    begin
      validate!
    rescue
      false
    end
  end

  def show_stations
    @stations.each_with_index { |station, index| puts "#{index + 1}: #{station.name}" }
  end

  def add_intermediate_station(new_station)
    @stations.insert(-2, new_station)
    puts "Station successfully added to: \"#{self.title}\""
  end

  def remove_intermediate_station(station)
    if not [@stations.first, @stations.last].include? station
      @stations.delete(station)
      puts "Station successfully removed from: \"#{self.title}\""
    else
      puts "Can't delete first or last stations."
    end
  end

  def count_stations
    @stations.size
  end

  def validate!
    raise ValidationError, "Start station should be a '#{ CORRECT_STATION_TYPE }' class" if !stations.first.is_a?(CORRECT_STATION_TYPE) || stations.first.nil?
    raise ValidationError, "End station should be a '#{ CORRECT_STATION_TYPE }' class" if !stations.last.is_a?(correct_station_type) || stations.last.nil?
    true
  end
end
