require_relative 'train'

class PassengerTrain < Train
  TRAIN_TYPE         = 'Passenger'.freeze

  def initialize(number)
    super(number, TRAIN_TYPE)
  end

  private

  def correct_train_type
    TRAIN_TYPE
  end

end
