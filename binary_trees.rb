#https://github.com/PiotrAleksander/Ruby/blob/master/goniec.rb
class Node
	attr_accessor :value, :parent, :left, :right

	def initialize(value, parent = nil)
		@value = value
		@left = nil
		@right = nil
	end
end

class BinaryTree
	def initialize(array = [])
		build_tree(array) unless array.empty?
	end

	def build_tree(array)
		@root = Node.new(array.first)

		array[1..-1].each do |value|
			set = false
			current_node = @root
			until set
				if value > current_node.value
					if current_node.right == nil
						current_node.right = Node.new(value, current_node)
						set = true
					else
						current_node = current_node.right
					end
				else
					if current_node.left == nil 
						current_node.left = Node.new(value, current_node)
						set = true
					else
						current_node = current_node.left
					end
				end
			end
		end
	end

	def breadth_first_search(value)
		queue = [@root]
		visited = [@root]
		return @root if @root.value == value

		until queue.empty?
			current_node = queue.shift
			if current_node.left != nil && !visited.include?(current_node.left)
				return current_node.left if current_node.left.value == value
				queue << current_node.left
				visited << current_node.left
			end
			if current_node.right != nil && !visited.include?(current_node.right)
				return current_node.right if current_node.right.value == value
				queue << current_node.right
				visited << current_node.right
			end
		end
	end

	def depth_first_search(value)
		stack = [@root]
		visited = [@root]

		until stack.empty?
			current_node = stack.last
			return current_node if current_node.value == value
			if current_node.left != nil && !visited.include?(current_node.left)
				return current_node.left if current_node.left.value == value
				stack << current_node.left
				visited << current_node.left
			elsif current_node.right != nil && !visited.include?(current_node.right)
				return current_node.right if current_node.right.value == value
				stack << current_node.right
				visited << current_node.right
			else
				stack.pop
			end
		end
	end

	def depth_first_search_recursion(value, current_node = @root)
		return current_node if current_node.value == value

		left_node = depth_first_search_recursion(value, current_node.left) if current_node.left != nil
		return left_node if left_node != nil
		right_node = depth_first_search_recursion(value, current_node.right) if current_node.right != nil
		return right_node if right_node != nil
	end
end