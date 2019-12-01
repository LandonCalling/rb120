=begin
What is the default return value of to_s when invoked on an object?  Where
could you go to find out if you want to be sure?
=end

=begin
The default to_s method that is invoked on an object is found in the object
class.  Per the documentation, it returns a string representing the object it is
called on.  It prints the object's class and an encoding of the object id.
=end