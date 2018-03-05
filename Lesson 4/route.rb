class Route
  attr_reader :stations, :title

  def initialize(start_station, end_station)
    @stations = [start_station, end_station]
    @title = "Route from #{@stations.first.name} to #{@stations.last.name}"
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
end
