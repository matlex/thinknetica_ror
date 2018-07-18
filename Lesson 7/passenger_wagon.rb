require_relative 'wagon'

class PassengerWagon < Wagon
  attr_reader :total_seats, :reserved_seats

  def initialize(total_seats)
    @total_seats = total_seats
    @reserved_seats = 0
  end

  def reserve_seat!
    if @reserved_seats < @total_seats
      @reserved_seats += 1
    end
  end

  def free_seats
    @total_seats - @reserved_seats
  end
end
