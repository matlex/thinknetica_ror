require_relative 'manufacturer'

class Wagon
  attr_reader :total_capacity, :reserved_capacity

  include Manufacturer

  def initialize(total_capacity)
    @total_capacity = total_capacity
    @reserved_capacity = 0
  end

  def free_capacity
    @total_capacity - @reserved_capacity
  end

  def reserve_capacity!(amount)
    if amount <= free_capacity
      @reserved_capacity += amount
    end
  end

end
