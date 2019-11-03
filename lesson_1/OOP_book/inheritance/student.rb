class Student
  attr_accessor :name, :grade

  def initialize(n, g)
    @name = n
    @grade = g
  end

  def better_grade_than?(student)
    self.grade > student.grade
  end

  protected

  def grade
    @grade
  end
end

joe = Student.new('Joe', 98)
bob = Student.new('Bob', 89)
puts 'Well done!' if joe.better_grade_than?(bob)

