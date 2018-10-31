require_relative 'Lesson 6/cargo_train'
require_relative 'Lesson 6/passenger_train'
require_relative 'Lesson 6/route'

t = CargoTrain.new('aa1-b2')
puts t.valid?



t2 = PassengerTrain.new('bb3-c4')
puts t2.valid?

r = Route.new('st', 'st')
puts r.valid?
