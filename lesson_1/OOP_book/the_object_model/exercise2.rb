# A module is a collection of behaviors that is usable by other classes via
# mixins
# We add modules to a class via use of the keyword include:
# i.e. include ModuleName

module ModuleName
end

class ClassName
  include ModuleName
end

variable = ClassName.new
