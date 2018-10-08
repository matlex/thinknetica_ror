require_relative 'wagon'

class CargoWagon < Wagon
  alias total_volume total_capacity
  alias reserved_volume reserved_capacity
  alias reserve_volume! reserve_capacity!
  alias free_volume free_capacity
end
