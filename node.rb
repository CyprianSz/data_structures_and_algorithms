class Node
  attr_accessor :parent, :value, :children

  def initialize(value, parent = nil)
    @value = value
    @parent = parent
    @children = []
  end
end