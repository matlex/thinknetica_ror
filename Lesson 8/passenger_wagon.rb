require_relative 'wagon'

class PassengerWagon < Wagon
  def reserve_capacity!
    super(1)
  end

  alias_method :total_seats, :total_capacity
  alias_method :reserved_seats, :reserved_capacity
  alias_method :free_seats, :free_capacity
  alias_method :reserve_seat!, :reserve_capacity!
end
