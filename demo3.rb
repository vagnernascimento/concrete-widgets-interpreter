require  "concrete-widget/Interpreter.rb"
    
   interface_schema = { 
      :name => 'main_page', 
      :node_content => {:concrete_widget => "HTMLPage", :params => {:title => "My Demo page", :include_css=> ["css/screen.css"] }},
      :children => [
        { :name => nil,
          :node_content => {:concrete_widget => "HTMLComposition", :params => {:css_class => "header"}},
          :children => [
            { :name => "first_heading",
              :node_content => { :concrete_widget => "HTMLHeading", :params => {:number => 1, :content => "First heading", :css_class => "heading2"}}
            }
          ]
        },
        {
          :name => 'composition1',
          :node_content => {:concrete_widget => "HTMLComposition", 
          :params => {
            :repeatable => true,
            :values => [ {:name_field => {:content => 'Fulano'}, :age_field => {:content => '35'}},
                         {:name_field => {:content => 'Beltrano'}, :age_field => {:content => '53'}},
                         {:name_field => {:content => 'John'}, :age_field => {:content => '46'}}
                       ],
          :css_class => "box"}},
          :children => [
            { :name => "label1",
              :node_content => { :concrete_widget => "HTMLLabel", :params => {:label_for => "label1", :content => "Name: "}}
            },
            { :name => "name_field",
              :node_content => { :concrete_widget => "HTMLText"}
            },
            { :name => "label2",
              :node_content => { :concrete_widget => "HTMLLabel", :params => {:label_for => "label1", :content => "Age: "}}
            },
            { :name => "age_field",
              :node_content => { :concrete_widget => "HTMLText"}
            },
            { :node_content => {  :concrete_widget => "HTMLLineBreak"}
            },
            
          ]  
        }
      
      ]
    } 
    
    
    interface = ConcreteWidget::Interface.new(interface_schema)
   
   
    File.open "demo-page3.html", "w" do |file|  
      file.write interface.render
    end  

    