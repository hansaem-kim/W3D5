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

end