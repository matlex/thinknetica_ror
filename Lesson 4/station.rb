class Station
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
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

  def count_trains_by_type(type)
    @trains.select { |train| train.type == type }.size
  end
end
