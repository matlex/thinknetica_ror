require_relative 'manufacturer'

class Wagon
  include Manufacturer

  attr_reader :total_capacity, :reserved_capacity

  def initialize(total_capacity)
    @total_capacity = total_capacity
    @reserved_capacity = 0
  end

  def free_capacity
    @total_capacity - @reserved_capacity
  end

  def reserve_capacity!(amount)
    @reserved_capacity += amount if amount <= free_capacity
  end
end
