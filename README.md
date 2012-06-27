Introduction
------------
This concrete interface interpreter has being implemented as task for the master thesis of 
Vagner Nascimento on Informatics at PUC-Rio. 
The goal is render web interfaces from a hierarchical schema, currently specified in a Ruby Hash.

Dependencies
------------
    - Rubygems
      http://rubygems.org
    - Tilt
      gem install tilt
      https://github.com/rtomayko/tilt
    - RubyTree
      gem install rubytree
      http://rubytree.rubyforge.org/

Usage
-----
 
    require  "concrete-widget/Interpreter.rb"
    interface_schema = { 
    :name => 'root_node', 
    :node_content => {
      :concrete_widget => "HTMLPage", 
      :params => {:title => "My Demo page", :include_css=> ["css/screen.css"] }
    },
    :children => [
      { :name => 'element1',
        :node_content => {
          :concrete_widget => "HTMLComposition",
          :params => {:css_class => "header", :content => "First line"}
        },
        :children => [
          { :name => "first_heading",
            :node_content => { 
              :concrete_widget => "HTMLHeading",
              :params => {:number => 1, :content => "First heading"}
            }
          }
        ]
      }]
    }
    interface = ConcreteWidget::Interface.new(interface_schema)
    File.open "demo-page.html", "w" do |file|  
      file.write interface.render
    end 