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
