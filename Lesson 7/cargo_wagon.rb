require_relative 'wagon'

class CargoWagon < Wagon
  def initialize(total_volume)
    @total_volume = total_volume
    @reserved_volume = 0
  end

  def reserve_volume(amount)
    if @reserved_volume < @total_volume
      @reserved_volume += amount
    end
  end

  def total_reserved_volume
    @reserved_volume
  end

  def total_free_volume
    @total_volume - @reserved_volume
  end
end
