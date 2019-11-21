class Animal
  def run
    'running!'
  end

  def jump
    'jumping!'
  end
end

class Dog < Animal
  def swim
    'swimming!'
  end

  def fetch
    'fetching!'
  end

  def speak
    'bark!'
  end
end

class Cat < Animal
  def speak
    'meow!'
  end
end

class Bulldog < Dog
  def swim
    "can't swim!"
  end
end

# pete = Animal.new
# kitty = Cat.new
# dave = Dog.new
# bud = Bulldog.new

# puts pete.run                # => "running!"
# puts pete.speak              # => NoMethodError

# puts kitty.run               # => "running!"
# puts kitty.speak             # => "meow!"
# puts kitty.fetch             # => NoMethodError

# puts dave.speak              # => "bark!"

# puts bud.run                 # => "running!"
# puts bud.swim                # => "can't swim!"

=begin
The lookup for Cat is as follows:
Cat > Animal > Object > Kernel > BasicObject

The lookup for Dog is as follows:
Dog > Animal > Object > Kernel > BasicObject

The lookup for Bulldog is as follows:
Bulldog > Dog > Animal > Object > Kernel > BasicObject

The method lookup is important because it tells the interpreter in what order
to look for methods.  Methods with the same names in the top of the heirarchy
will override methods in the lower part of the heirarchy.
=end

puts "---Cat Method Lookup---"
puts Cat.ancestors
puts "---Dog Method Lookup---"
puts Dog.ancestors
puts "---BullDog Method Lookup---"
puts Bulldog.ancestors
