require_relative 'train'
require_relative 'cargo_wagon'

class CargoTrain < Train

  TRAIN_TYPE         = 'Cargo'
  CORRECT_WAGON_TYPE = CargoWagon

  def initialize(number)
    super(number, TRAIN_TYPE)
  end

  private

  def correct_train_type
    TRAIN_TYPE
  end

  def correct_wagon_type
    CORRECT_WAGON_TYPE
  end
end
