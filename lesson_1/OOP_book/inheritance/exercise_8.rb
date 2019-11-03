bob = Person.new
bob.hi
# produces the error message
# NoMethodError: private method `hi' called for #<Person:0x007ff61dbb79f0>
# from (irb):8
# from /usr/local/rvm/rubies/ruby-2.0.0-rc2/bin/irb:16:in `<main>'

=begin
To fix this error I would move the hi method from the private section
of the class to the public section.
=end