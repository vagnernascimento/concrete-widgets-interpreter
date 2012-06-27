# interpreter.rb -- Module that composes and renders a interface through an interface schema.
# Author:: Vagner Nascimento (vagnernascimento@gmail.com)

module ConcreteWidget
  #VERSION '0.1.1'
  require "rubygems"
  require "concrete-widget/widget-base"

  class Interface
    
    def initialize(hash_tree)
      @tree = compose(hash_tree)
    end
    
    def tree
      @tree
    end
    
    # Returns a Ruby Tree version of the interface from a hash tree.
    def compose(hash_tree, counter = 0)
      begin
        counter+=1
        require "tree"
        name = hash_tree[:name] or hash_tree["name"]
        name =  counter.to_s if name.nil?
        node_content = hash_tree[:node_content] or hash_tree["node_content"]
        children = hash_tree[:children] or hash_tree["children"]
        node_content[:params] ||= {}
        node_content[:params][:name] ||= name
        node_content[:params][:id] ||= name
        content = widget_instance(node_content[:concrete_widget], node_content[:params])
        node = Tree::TreeNode.new(name, content)
        
        children.each do |child|
          node << compose(child, counter)
        end if children

        return node
      rescue LoadError => e
        warn "The Hash tree cannot be loaded"
      end
    end
    
    
    # Run a Depth-first search (DFS) L -> R to render a interface
    def render(tree=nil)
      tree = @tree if tree.nil?
      tree.children.each{|node|
        node.parent.content << render(node)
      } if tree.has_children?
      check_dependencies(tree)
      return tree.content.render if tree.content.respond_to?(:render)
    end
    
    private
    
    def widget_instance(name, params)
      require "concrete-widget/#{name}/#{name}"
      #load "concrete-widget/#{name}/#{name}.rb"
      klass = eval(name)
      klass.new(params) unless klass.nil?
    end
    
    # There are two categories of dependencies: explicit (where node Id is specified) and by type (searching the first node compatible).
    # Attention: Experimental mechanism
    def check_dependencies(tree)
        if tree.content.respond_to?(:dependencies)
          if tree.content.respond_to?(:depends_on_ids) and not tree.content.depends_on_ids.nil?
            # Node ID is directly specified
            condition = Proc.new{|node| node.name == tree.content.depends_on_ids.first}
          else 
            # When no node ID is directly specified, the first node found compatible will be selected
            condition = Proc.new{|node| node.content.class.to_s == tree.content.dependencies.first.to_s} 
          end
          tree.root.each{|node| 
            if condition.call(node)
              tree.content.run_dependencies(node.content)
              return
            end
          }
          
        end

    end
  end
end    