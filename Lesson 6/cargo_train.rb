require_relative 'train'
require_relative 'cargo_wagon'

class CargoTrain < Train

  CORRECT_WAGON_TYPE = CargoWagon

  private

  def correct_wagon_type
    CORRECT_WAGON_TYPE
  end
end
