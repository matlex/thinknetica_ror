class Station
  include InstanceCounter

  attr_reader :name, :trains

  @@all_stations = 0

  def self.all
    @@all_stations
  end

  def initialize(name)
    @name = name
    @trains = []
    @@all_stations += 1
    register_instance
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
end
