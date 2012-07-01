require  "concrete-widget/Interpreter.rb"
    
   interface_schema = { 
      :name => 'main_page', 
      :node_content => {:concrete_widget => "HTMLPage", :params => {:title => "My Demo page", :include_css=> ["css/screen.css"] }},
      :children => [
        { :name => 'header',
          :node_content => {:concrete_widget => "HTMLComposition", :params => {:css_class => "header", :content => "First line\n"}},
          :children => [
            { :name => "first_heading",
              :node_content => { :concrete_widget => "HTMLHeading", :params => {:number => 1, :content => "First heading", :css_class => "heading2"}}
            }
          ]
        },
        {
          :name => 'composition1',
          :node_content => {:concrete_widget => "HTMLComposition", :params => {:css_class => "box"}},
          :children => [
            { :name => "label_datepicker1",
              :node_content => { :concrete_widget => "HTMLLabel", :params => {:label_for => "date1", :css_class => "nada", :content => "Initial Date: "}}
            },
            { :name => "datepicker1",
              :node_content => { :concrete_widget => "JQueryDatePickerInput", :params => {:name => "date1", :id => "novo_id1", :content => "06/26/2012", :depends_on_ids => ["main_page"] }}
            },
            {
              :name => 'paragraph2',
              :node_content => {:concrete_widget => "HTMLParagraph", :params => {:content => "Something more here", :css_class => "parag1"}},
              :children => [
                {
                  :name => 'comp1',
                  :node_content => {:concrete_widget => "HTMLForm", :params => {:action => "http://www.google.com", :css_class => "box1"}},
                  :children => [
                    {
                      :name => 'comp2',
                      :node_content => {:concrete_widget => "HTMLComposition", :params => {:content => "Lorem Ypsum", :css_class => "box1"}},
                    
                    },
                    {
                      :name => 'label_input1',
                      :node_content => {:concrete_widget => "HTMLLabel", :params => {:content => "Field1:"}},
                    
                    },
                    {
                      :name => 'input1',
                      :node_content => {:concrete_widget => "HTMLFormInput", :params => {:content => "Lorem Ypsum"}},
                    
                    },
                    {
                      :node_content => {:concrete_widget => "HTMLLineBreak"},
                    },
                    {
                      :name => 'label_input2',
                      :node_content => {:concrete_widget => "HTMLLabel", :params => {:content => "Field2:"}},
                    
                    },
                    
                    {
                      :name => 'long_text',
                      :node_content => {:concrete_widget => "HTMLFormText", :params => {:id => "xpto", :content => "Lorem Ypsum"}},
                    
                    },
                     {
                      :name => 'line_break',
                      :node_content => {:concrete_widget => "HTMLLineBreak"},
                    
                    },
                    {
                      :name => 'select1',
                      :node_content => {:concrete_widget => "HTMLFormSelect", :params => {:options => [{:option => 'first', :value => 'First'},"second",{:option => 'Last', :value => 'Last', :selected => true}] }},
                    
                    },
                     {
                      :name => 'sendbnt',
                      :node_content => {:concrete_widget => "HTMLFormButton", :params => {:content => "Send"}},
                    
                    }
                  ]
                }
                
              ]
            }
          ]  
        }
      
      ]
    } 
    
    extensions= [
      {:name => 'ext1', :extension => 'JqueryCopyTo', :nodes => ['select1', 'label_input2'], :params => {:number => 2, :content => 'My new heading'}}
    ]
    
    interface = ConcreteWidget::Interface.new(interface_schema)
    
   
    interface.add_extensions(extensions)
     interface.direct_ref_node["label_input2"].content.extensions 
    #puts interface.direct_ref_node["first_heading"]
    
    File.open "demo-page.html", "w" do |file|  
      file.write interface.render
    end  

