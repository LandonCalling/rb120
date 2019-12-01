class BeesWax
  attr_accessor :type

  def initialize(type)
    @type = type
  end

  def describe_type
    puts "I am a #{type} of Bees Wax"
  end
end

=begin
Changing the type getter and setter methods
to to attr_accessor :type will simplify the
class.
=end