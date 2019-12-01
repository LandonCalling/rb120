class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
  def hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end

hello = Hello.new
hello.hi
# This will print "Hello" to the screen

hello = Hello.new
hello.bye
# this will give a NoMethodError because the bye method
# is a part of the Goodbye class and not the Hello class

hello = Hello.new
hello.greet
# this will give an ArgumentError because you have to call
# greet with exactly one argument

hello = Hello.new
hello.greet("Goodbye")
# this will print "Goodbye" to the screen

Hello.hi
# this will give a NoMethodError because the Hello class
# doesn't contain a class method named hi
# you can fix this by adding a method self.hi that first
# creates a new Greeting instance, and then calls the greet
# method with the parameter "Hello"
