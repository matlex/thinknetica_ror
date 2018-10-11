class Student

  def initialize(name, grade)
    @name = name
    @grade = grade
  end

  def better_grade_than?(another_student)
    grade > another_student.grade
  end

  protected

  def grade
    @grade
  end
end

matt = Student.new('Matt', 5)
bob = Student.new('Bob', 4)

puts "Well done!" if matt.better_grade_than?(bob)

numbers_array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

strings_array = numbers_array.map(&:to_s)

puts strings_array

def batman_ironman_proc
  victor = Proc.new { return "Batman will win!" }
  victor.call
  "Iron Man will win!"
end

puts batman_ironman_proc

def batman_ironman_lambda
  victor = lambda { return "Batman will win!" }
  victor.call
  "Iron Man will win!"
end

puts batman_ironman_lambda
