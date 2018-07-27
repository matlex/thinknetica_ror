require_relative 'wagon'

class PassengerWagon < Wagon
  def reserve_capacity!
    super(1)
  end

  alias total_seats total_capacity
  alias reserved_seats reserved_capacity
  alias free_seats free_capacity
  alias reserve_seat! reserve_capacity!
end
