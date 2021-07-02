class PolyTreeNode

    attr_reader :parent, :children, :value

    def initialize(value)
        @parent = nil
        @children = []
        @value = value
    end

    def parent=(node)
        @parent.children.delete(self) if !@parent.nil?
        @parent = node
        node.children << self if !node.nil?
    end

    def add_child(child_node)
        child_node.parent = self if !@children.include?(child_node)
    end

    def remove_child(child_node)
        raise "Not a child!" if child_node.parent.nil?
        child_node.parent = nil
    end

    def dfs(target_value)
        return self if self.value == target_value
        self.children.each do |child|
            search = child.dfs(target_value)
            return search if !search.nil?
        end
        nil
    end

    def bfs(target_value)
        queue = [self]

        while !queue.empty?
            return queue[0] if queue[0].value == target_value
            queue += queue.shift.children
        end
        nil
    end

end