require  "concrete-widget/Interpreter.rb"
    
   interface_schema = { 
      :name => 'main_page', 
      :node_content => {:concrete_widget => "HTMLPage", :params => {:title => "My Demo page", :include_css=> ["css/default_interface.css"] }},
      :children => [
        { :name => 'header',
          :node_content => {:concrete_widget => "HTMLComposition", :params => {:css_class => "header"}},
          :children => [
            { :name => "main_heading",
              :node_content => { :concrete_widget => "HTMLHeading", :params => {:number => 1, 
              :content => "Twitts about Anything", :css_class => "heading2"}}
            }
          ]
        },
        {
          :name => 'form_search',
          :node_content => {
            :concrete_widget => "HTMLForm",
            
            :params => {:css_class => "box center", :action => "http://search.twitter.com/search.json?&callback=?", :method => "get"}
          },
          :children => [
            {
              :name => 'label_search',
              :node_content => {:concrete_widget => "HTMLLabel", 
              :params => {:content => "Search: "}},
              
            },
            {
              :name => 'query',
              :node_content => {:concrete_widget => "HTMLFormInput", 
              :params => {:name => 'q', :css_class => "input", :content => "web interfaces"}},
              
            },
            {
              :name => 'items_per_page_label',
              :node_content => {:concrete_widget => "HTMLLabel", 
              :params => {:content => "Items per page: "}},
              
            },
            {
              :name => 'items_per_page',
              :node_content => {:concrete_widget => "HTMLFormSelect", 
              :params => {:name => 'rpp', :css_class => "input", :options => ["5", "10", "15", "20", "25", "30"] }},
              
            },
            {
              :name => 'btn_send',
              :node_content => {:concrete_widget => "HTMLFormButton",
              :params => {:css_class => "input", :content => "Go"}},
              
            }
          ]
        },
        {
          :name => 'tweets',
          :node_content => {
            :concrete_widget => "JQueryTempoTemplateEngine", 
            :params => {
              #:json_source_url => "http://search.twitter.com/search.json?q=web interfaces&rpp=20&callback=?",
              :url_from_element_id => 'url_search_twitter',
              :node_json_result_element => "['results']", :msg_error => "Sorry"
            }
          },
          :children => [
            {
              :name => 'twitt',
              :node_content => {:concrete_widget => "HTMLListItem", :params => {:css_class => "row"}},
              :children => [
                { :name => "columnA",
                  :node_content => { :concrete_widget => "HTMLComposition", :params => {:css_class => "column grid_4 user"} },
                  :children => [
                    { :name => "profile_image_url",
                      :node_content => { :concrete_widget => "HTMLImage", :params => {:content => "{{profile_image_url}}"}}
                    },
                    { :name => "from_user",
                      :node_content => { :concrete_widget => "HTMLHeading", :params => { :number => 3, :content => "{{from_user}}"}}
                    },
                ]},
                { :name => "columnB",
                  :node_content => { :concrete_widget => "HTMLParagraph", :params => {:content => "{{text}}", :css_class => "column grid_8"} },
                  :children => [
                    { :name => "created_at",
                      :node_content => { :concrete_widget => "HTMLSpan", :params => {:content => ",{{created_at | date '\\at HH:mm on EEEE' }}", :css_class => "time"}}
                    } 
                  ]
                },
                 
              ]
            }
            
          ]  
        },
        { :name => 'footer',
          :node_content => {:concrete_widget => "HTMLComposition", :params => {}},
          :children => [
            { :name => "footer_text",
              :node_content => { :concrete_widget => "HTMLParagraph", :params => {:css_class => "row",
              :content => "http://twigkit.github.com/tempo"}}
            }
          ]
        },  
      ]
    } 
    
    extensions= [
      {:name => 'ext2', :extension => 'JQueryFormAjax', :nodes => ['form_search'], :params => {:target => "tweets"}},
    ]
    
    interface = ConcreteWidget::Interface.new(interface_schema)
    interface.add_extensions(extensions)
   
    File.open "demo-page5.html", "w" do |file|  
      file.write interface.render
    end  

    