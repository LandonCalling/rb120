class Cat
  @@cats_count = 0

  def initialize(type)
    @type = type
    @age = 0
    @@cats_count += 1
  end

  def self.cats_count
    @@cats_count
  end
end

=begin
The @@cats_count variable keeps track of how
many instances of the Cat class there are.
Every time a new object of type Cat are
instantiated, 1 is added to the @@cats_count
variable.  You would test that theory as 
shown below.
=end

mugi = Cat.new('tortie')
izzie = Cat.new('black and white')
quaddro = Cat.new('maine coon')

p Cat.cats_count # this should print out 3