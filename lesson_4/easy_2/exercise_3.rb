module Taste
  def flavor(flavor)
    puts flavor.to_s
  end
end

class Orange
  include Taste
end

class HotSauce
  include Taste
end

=begin
The lookup path for Orange is:
Orange
Taste
Object
Kernel
BasicObject
=end

=begin
The lookup path for HotSauce is:
HotSauce
Taste
Object
Kernel
BasicObject
=end
