require_relative 'wagon'
require_relative 'cargo_train'
require_relative 'accessors'

class CargoWagon < Wagon
  include Accessors

  strong_attr_accessor :train, CargoTrain

  alias total_volume total_capacity
  alias reserved_volume reserved_capacity
  alias reserve_volume! reserve_capacity!
  alias free_volume free_capacity
end
