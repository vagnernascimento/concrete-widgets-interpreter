# interpreter.rb -- Module that composes and renders a interface through an interface schema.
# Author:: Vagner Nascimento (vagnernascimento@gmail.com)

module ConcreteWidget
  #VERSION '0.1.1'
  require "rubygems"
  require "concrete-widget/widget-base"

  class Interface
    
    def initialize(hash_tree)
      @direct_ref_node = Hash.new
      @tree = compose(hash_tree)
    end
    
    def tree
      @tree
    end
    
    def direct_ref_node
      @direct_ref_node
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
        node_content[:params][:extensions] = []
        content = widget_instance(node_content[:concrete_widget], node_content[:params])
        node = Tree::TreeNode.new(name, content)
        @direct_ref_node[name] = node
        children.each do |child|
          node << compose(child, counter)
        end if children

        return node
      rescue LoadError => e
        warn "The Hash tree cannot be loaded"
      end
    end
    
    
    def add_extensions(extensions)
      @extensions = extensions
      @extensions.each{ |ext|
        ext[:nodes].each{ |node|
          ext[:params][:index] = ext[:nodes].index(node)
          name = ext[:name] or ext[:params][:index]
          ext[:params][:name] ||= name
          ext[:params][:id] ||= name   
          instance = extension_instance(ext[:extension], ext[:params]) 
          instance = widget_instance(ext[:extension], ext[:params]) if instance.nil?
          direct_ref_node[node].content.add_extension( instance ) 
        }
      }
    end
    
    # Run a Depth-first search (DFS) L -> R to render a interface
    def render(tree=nil)
      tree = @tree if tree.nil?
      tree.children.each{|node|
        node.parent.content << render(node)
      } if tree.has_children?
      check_dependencies(tree)
      #return tree.content.render << render_extensions(tree) if tree.content.respond_to?(:render)
      return tree.content.render if tree.content.respond_to?(:render)
    end
    
    private
    
    def widget_instance(name, params)
      #load "concrete-widget/#{name}/#{name}.rb"
      require "concrete-widget/#{name}/#{name}"
      klass = eval(name)
      klass.new(params) unless klass.nil?
    end
    
    def extension_instance(name, params)
      begin
        #load "extensions/#{name}/#{name}.rb"
        require "extensions/#{name}/#{name}"
        klass = eval(name)
        klass.new(params) unless klass.nil?
      rescue LoadError => e
        return
      end
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