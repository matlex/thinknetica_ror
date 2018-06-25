require_relative 'train'
require_relative 'passenger_wagon'

class PassengerTrain < Train

  CORRECT_WAGON_TYPE = PassengerWagon

  private

  def correct_wagon_type
    CORRECT_WAGON_TYPE
  end
end
