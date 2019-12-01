class Cat
  @@cats_count = 0

  def initialize(type)
    @type = type
    @age  = 0
    @@cats_count += 1
  end

  def self.cats_count
    @@cats_count
  end
end

=begin
  self when used with a method name inside of a class makes the method a class
  method.  Therefore, self refers to the Class rather than an instance of the
  class.  You would call the method as below.
=end

Cat.cats_count
