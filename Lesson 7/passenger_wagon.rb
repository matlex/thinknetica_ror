require_relative 'wagon'

class PassengerWagon < Wagon
  alias_method :total_seats, :total_capacity
  alias_method :reserved_seats, :reserved_capacity
  alias_method :reserve_seat!, :reserve_capacity!
  alias_method :free_seats, :free_capacity
end
