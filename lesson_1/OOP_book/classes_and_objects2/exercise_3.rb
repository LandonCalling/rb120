class Person
  attr_reader :name
  def initialize(name)
    @name = name
  end
end

bob = Person.new('Steve')
bob.name = 'Bob'

=begin
The error occurs because on line 2 we have set up the name
instance variable with the attr_reader keyword.  If we want
to be able to change it, we have to set it up wiht the
attr_accessor keyword.  The attr_reader keyword only sets
up a getter method, while the attr_accessor keyword sets up
a getter and a setter method.
=end