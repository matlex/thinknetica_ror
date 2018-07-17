require_relative 'wagon'

class PassengerWagon < Wagon
  def initialize(total_seats)
    @total_seats = total_seats
    @reserved_seats = 0
  end

  def reserve_seat!
    if @reserved_seats < @total_seats
      @reserved_seats += 1
    end
  end

  def total_reserved_seats
    @reserved_seats
  end

  def total_free_seats
    @total_seats - @reserved_seats
  end
end
