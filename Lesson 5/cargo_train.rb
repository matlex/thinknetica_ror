require_relative 'train'
require_relative 'cargo_wagon'

class CargoTrain < Train
  private

  CORRECT_WAGON_TYPE = CargoWagon
  def correct_wagon_type
    CORRECT_WAGON_TYPE
  end
end
