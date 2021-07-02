require_relative "skeleton/lib/00_tree_node.rb"

class KnightPathFinder

    def self.valid_moves(pos)
        row, col = pos
        moves = []

        moves << [row + 2, col + 1] if row + 2 < 8 && col + 1 < 8
        moves << [row + 2, col - 1] if row + 2 < 8 && col - 1 >= 0

        moves << [row + 1, col + 2] if row + 1 < 8 && col + 2 < 8
        moves << [row - 1, col + 2] if row - 1 >= 0 && col + 2 < 8

        moves << [row - 2, col + 1] if row - 2 >= 0 && col + 1 < 8
        moves << [row - 2, col - 1] if row - 2 >= 0 && col - 1 >= 0

        moves << [row + 1, col - 2] if row + 1 < 8 && col - 2 >= 0
        moves << [row - 1, col - 2] if row - 1 >= 0 && col - 2 >= 0

        moves
    end

    def initialize(pos)
        @root_node = PolyTreeNode.new(pos)
        @considered_positions = [pos]
        build_move_tree
    end

    def new_move_positions(pos)
        newpos = KnightPathFinder.valid_moves(pos).select { |move| !@considered_positions.include?(move) }
        @considered_positions += newpos
        newpos
    end

    def build_move_tree
        queue = [@root_node]
        until queue.empty?
            first = queue.shift
            possible_moves = new_move_positions(first.value)
            possible_moves.each do |move|
                child_node = PolyTreeNode.new(move)
                first.add_child(child_node)
                queue << child_node
            end
        end
    end

    def trace_path_back(node)
        moves = []
        current = node
        until current.parent.nil?
            moves << current.value
            current = current.parent
        end
        moves << current.value
        moves.reverse
    end

    def find_path(end_pos)
        end_node = @root_node.bfs(end_pos)
        trace_path_back(end_node)
    end

end

kpf = KnightPathFinder.new([0, 0])
p kpf.find_path([7, 6]) # => [[0, 0], [1, 2], [2, 4], [3, 6], [5, 5], [7, 6]]
p kpf.find_path([6, 2]) # => [[0, 0], [1, 2], [2, 0], [4, 1], [6, 2]]