require_relative 'train'
require_relative 'passenger_wagon'

class PassengerTrain < Train

  TRAIN_TYPE         = 'Passenger'
  CORRECT_WAGON_TYPE = PassengerWagon

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
