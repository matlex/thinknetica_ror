require_relative 'wagon'

class CargoWagon < Wagon
  attr_reader :total_volume, :reserved_volume

  def initialize(total_volume)
    @total_volume = total_volume
    @reserved_volume = 0
  end

  def reserve_volume!(amount)
    if amount <= free_volume
      @reserved_volume += amount
    end
  end

  def free_volume
    @total_volume - @reserved_volume
  end
end
