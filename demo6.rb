require  "concrete-widget/Interpreter.rb"
    
   interface_schema = { 
      :name => 'main_page', 
      :node_content => {:concrete_widget => "HTMLPage", :params => {:title => "SPARQL Viewer", :include_css=> ["css/default_interface.css"] }},
      :children => [
        { :name => 'header',
          :node_content => {:concrete_widget => "HTMLComposition", :params => {:css_class => "header"}},
          :children => [
            { :name => "main_heading",
              :node_content => { :concrete_widget => "HTMLHeading", :params => {:number => 1, 
              :content => "SPARQL Viewer", :css_class => "heading2"}}
            }
          ]
        },
        {
          :name => 'form_search',
          :node_content => {
            :concrete_widget => "HTMLForm",
            
            :params => {:css_class => "box center", :action => "http://dbpedia.org/sparql/", :method => "get"}
          },
          :children => [
            {
              :name => 'label_search',
              :node_content => {:concrete_widget => "HTMLLabel", 
              :params => {:content => "Search: "}},
              
            },
            {
              :name => 'query',
              :node_content => {:concrete_widget => "HTMLFormText", 
              :params => { :css_class => "search_box", 
              #:content => "SELECT ?film WHERE { ?film <http://purl.org/dc/terms/subject> <http://dbpedia.org/resource/Category:French_films> }"
              :content => "SELECT ?prop ?val WHERE { <http://dbpedia.org/resource/Dona_Flor_and_Her_Two_Husbands> ?prop ?val }"
              }},
              
            },
            {
              :name => 'format_label',
              :node_content => {:concrete_widget => "HTMLLabel", 
              :params => {:content => "Format: "}},
              
            },
            {
              :name => 'format',
              :node_content => {:concrete_widget => "HTMLFormSelect", 
              :params => {:name => 'format', :options => ["json"] }},
              
            },
            {
              :name => 'btn_send',
              :node_content => {:concrete_widget => "HTMLFormButton",
              :params => {:css_class => "input", :content => "Go"}},
              
            }
          ]
        },
        {
          :name => 'dbpedia_result',
          :node_content => {
            :concrete_widget => "JQueryTempoTemplateEngine", 
            :params => {
              #:json_source_url => "http://search.twitter.com/search.json?q=web interfaces&rpp=20&callback=?",
              :url_from_element_id => 'url_search_twitter',
              :node_json_result_element => "['results']['bindings']", :msg_error => "Sorry"
            }
          },
          :children => [
            {
              :name => 'attribute',
              :node_content => {:concrete_widget => "HTMLListItem", :params => {:css_class => "row"}},
              :children => [
                { :name => "columnA",
                  :node_content => { :concrete_widget => "HTMLComposition", :params => {:css_class => "column grid_4 user"} },
                  :children => [
                    { :name => "from_user",
                      :node_content => { :concrete_widget => "HTMLSpan", :params => {:css_class => 'xxx_{{_tempo.index}}',  :content => "{{prop.value}}"}}
                    },
                ]},
                { :name => "columnB",
                  :node_content => { :concrete_widget => "HTMLParagraph", :params => {:content => "{{text}}", :css_class => "column grid_8"} },
                  :children => [
                    { :name => "created_at",
                      :node_content => { :concrete_widget => "HTMLSpan", :params => {:content => ": {{val.value}}", :css_class => "time"}}
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
      {:name => 'ext2', :extension => 'JQueryFormAjax', :nodes => ['form_search'], :params => {:target => "dbpedia_result", :data_type => "json"}},
    ]
    
    interface = ConcreteWidget::Interface.new(interface_schema)
    interface.add_extensions(extensions)
   
    File.open "demo-page6.html", "w" do |file|  
      file.write interface.render
    end  

    