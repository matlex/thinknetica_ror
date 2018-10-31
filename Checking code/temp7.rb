require_relative '../Lesson 9/accessors'
require_relative '../Lesson 9/validation'

require 'pry'

# Testing Accessors module
class TestAccessors
  include Accessors

  attr_accessor_with_history :a, :b, :c
  strong_attr_accessor :e, String
  strong_attr_accessor :d, Fixnum

end

def testing_accessors_module
  test = TestAccessors.new

  test.a = 5
  test.b = 12

  puts test.a, test.b, test.c
  puts '=' * 30
  puts test.a_history
  puts test.b_history
  puts test.c_history

  test.a = 33
  test.b = 35

  print test.a_history
  print test.b_history
  puts
  puts '=' * 30


  test.e = 'Hello'
  puts test.e

  # test.d = '123'
  test.d = 123
  puts test.d
end

# Testing Validations module
class TestValidations
  include Validation

  attr_accessor :a, :b, :c

  validate :a, :presence, :and_something
  validate :b, :format, /^[A-Z0-9]{3,}$/i
  validate :c, :type, String

end

def testing_validations_module
  t = TestValidations.new

  t.a = "some value"
  # t.a = nil
  t.b = "w1d"
  # t.b = "123"
  t.c = '123'
  # t.c = 123

  t.validate!
end


if __FILE__ == $0
  testing_accessors_module
  testing_validations_module
end
