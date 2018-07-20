require_relative 'wagon'

class CargoWagon < Wagon
  alias_method :total_volume, :total_capacity
  alias_method :reserved_volume, :reserved_capacity
  alias_method :reserve_volume!, :reserve_capacity!
  alias_method :free_volume, :free_capacity
end
