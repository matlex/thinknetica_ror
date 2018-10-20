require_relative 'wagon'
require_relative 'accessors'
require_relative 'passenger_train'

class PassengerWagon < Wagon
  include Accessors

  strong_attr_accessor :train, PassengerTrain

  def reserve_capacity!
    super(1)
  end

  alias total_seats total_capacity
  alias reserved_seats reserved_capacity
  alias free_seats free_capacity
  alias reserve_seat! reserve_capacity!
end
