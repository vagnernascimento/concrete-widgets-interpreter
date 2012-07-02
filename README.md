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
          },
          {
            :name => 'label1',
            :node_content => {:concrete_widget => "HTMLLabel", :params => {:content => "Date:"}},
          
          },
          { :name => "datepicker1",
              :node_content => { 
                :concrete_widget => "JQueryDatePickerInput",
                :params => {:name => "date1", :id => "novo_id1", :content => "06/26/2012" }
              }
          },
          {
            :name => 'select1',
            :node_content => {
              :concrete_widget => "HTMLFormSelect",
              :params => {:options => [{:option => 'first', :value => 'First'},"second"] }
            },
          
          },
          {
            :name => 'label2',
            :node_content => {:concrete_widget => "HTMLLabel", :params => {:content => "Long text:"}},
          
          },
          {
            :name => 'long_text',
            :node_content => {:concrete_widget => "HTMLFormInput", :params => {:content => "Lorem Ypsum"}},
          }
        ]
      }]
    }
    
    extensions= [
      {:name => 'ext2', :extension => 'HTMLLineBreak', :nodes => ['select1']},
      { :name => 'ext1', :extension => 'JQueryCopyTo',
        :nodes => ['datepicker1', 'select1'],
        :params => {:to => 'long_text'}
      }
    ]
    
    interface = ConcreteWidget::Interface.new(interface_schema)
    interface.add_extensions(extensions)
    File.open "demo-page.html", "w" do |file|  
      file.write interface.render
    end 
