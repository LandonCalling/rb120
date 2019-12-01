class Cat
  attr_accessor :type, :age

  def initialize(type)
    @type = type
    @age  = 0
  end

  def make_one_year_older
    self.age += 1
  end
end

=begin
The self in self.age of the make_one_year_older method refers to the instance
that calls the make_one_year_older method. So if we create an instance of Cat
as below, then when we call make_one_year_older on tabby, it will add one to
the instance variable @age for the tabby object.
=end

tabby = Cat.new('tabby')
tabby.make_one_year_older