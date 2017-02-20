require_relative "node"

class KnightMoves
  def initialize(start_position, end_position)
    @start_position = start_position
    @end_position = end_position
    searching_final_position(start_position, end_position)
    print_path(@founded_node)
  end

  def searching_final_position(start_position, end_position)
    queue = [Node.new(@start_position)]
    @founded_node = nil

    until @founded_node != nil
      current_node = queue.shift
      create_children(current_node)
      if current_node.children.any? { |child| child.value == end_position }
        current_node.children.each { |child|
        if child.value == end_position
          @founded_node = child
          @founded_node
        end }
      else
        current_node.children.each { |child| queue << child }
      end
    end
  end

  def create_children(node)
    node.children = possible_moves(node.value).map { |move| Node.new(move, node) }
  end

  def possible_moves(position)
    moves = [[1,2],[2,1],[2,-1],[1,-2],[-1,-2],[-2,-1],[-2,1],[-1,2]]
    x, y = position[0], position[1]
    possible_moves = moves.map! { |move| 
      if (0..7).include?(move[0] + x) && (0..7).include?(move[1] + y)
        move[0] += x 
        move[1] += y
        move
      end
    }.compact
  end

  def print_path(node)
    path = []
    current_node = node
    until current_node.parent == nil
      path << current_node.value
      current_node = current_node.parent
    end
    path.push(@start_position).reverse!

    puts "\nYou made it in #{path.size - 1} moves! Here is your path:"
    path.each { |move| print "#{move}\n" }
  end
end