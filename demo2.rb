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
                      :name => 'label_input1',
                      :node_content => {:concrete_widget => "HTMLLabel", :params => {:content => "Field1:"}},
                    
                    },
                    {
                      :name => 'input1',
                      :node_content => {:concrete_widget => "HTMLFormInput", :params => {:content => "Lorem Ypsum"}},
                    
                    },
                    {
                      :name => 'label_input2',
                      :node_content => {:concrete_widget => "HTMLLabel", :params => {:content => "Field2:"}},
                    
                    },
                    {
                      :name => 'select1',
                      :node_content => {:concrete_widget => "HTMLFormSelect", :params => {:options => [{:option => 'first', :value => 'First'},"second",{:option => 'Last', :value => 'Last', :selected => true}] }},
                    
                    },
                    {
                      :name => 'long_text',
                      :node_content => {:concrete_widget => "HTMLFormText", :params => {:content => "Lorem Ypsum"}},
                    
                    },
                    {
                      :name => 'checks',
                      :node_content => {:concrete_widget => "HTMLFormCheck", :params => {:options => ['Yes', 'No',{:label => 'Other', :value => 'O', :checked => true}], :label_side => 'left'}},
                    
                    },
                    {
                      :name => 'radios',
                      :node_content => {:concrete_widget => "HTMLFormRadio", :params => {:options => ['First', 'Second',{:label => 'Third', :value => 'T', :checked => true}], :label_side => 'right'}},
                    
                    },
                    {
                      :name => 'sendbnt',
                      :node_content => {:concrete_widget => "HTMLFormButton", :params => {:content => "Send"}},
                    
                    }
                  ]
                }
                
              ]
            },
            {
              :name => 'list1',
              :node_content => {:concrete_widget => "HTMLList", :params => {:css_class => 'xpto', :items => [{:value => 'First', :class => 'x', :url => 'http://www.firstlink.com'},'b','c']}},
            
            }
          ]  
        }
      
      ]
    } 
    
    extensions= [
      {:name => 'ext2', :extension => 'HTMLLineBreak', :nodes => ['input1', 'select1', 'long_text', 'checks']},
      {:name => 'ext1', :extension => 'JQueryCopyTo', :nodes => ['input1', 'select1'], :params => {:target => 'long_text'}},
    ]
    
    interface = ConcreteWidget::Interface.new(interface_schema)
   
    interface.add_extensions(extensions)
    
    File.open "demo-page2.html", "w" do |file|  
      file.write interface.render
    end  

    