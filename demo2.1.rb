require  "concrete-widget/Interpreter.rb"

biggest_us_cities = ["New York", "Los Angeles", "Chicago", "Houston", "Philadelphia", "Phoenix", "San Antonio", "San Diego", "Dallas", "San Jose", "Jacksonville", "Indianapolis", "San Francisco", "Austin", "Columbus", "Fort Worth", "Charlotte", "Detroit", "El Paso", "Memphis", "Baltimore", "Boston", "Seattle", "Washington", "Nashville-Davidson", "Denver", "Louisville-Jefferson County", "Milwaukee", "Portland", "Las Vegas", "Oklahoma City", "Albuquerque", "Tucson", "Fresno", "Sacramento", "Long Beach", "Kansas City", "Mesa", "Virginia Beach", "Atlanta", "Colorado Springs", "Omaha", "Raleigh", "Miami", "Cleveland", "Tulsa", "Oakland", "Minneapolis", "Wichita", "Arlington"]

   interface_schema = { 
      :name => 'main_page', 
      :node_content => {:concrete_widget => "HTMLPage", :params => {:title => "My Demo page", :include_css=> ["css/default_interface.css"] }},
      :children => [
        { :name => 'header',
          :node_content => {:concrete_widget => "HTMLComposition", :params => {:css_class => "header"}},
          :children => [
            { :name => "first_heading",
              :node_content => { :concrete_widget => "HTMLHeading", :params => {:number => 1, :content => "Select your Sushi", :css_class => "heading2"}}
            }
          ]
        },
        {
          :name => 'comp1',
          :node_content => {:concrete_widget => "HTMLForm", :params => {:action => "http://www.google.com", :css_class => "box"}},
          :children => [
            {
              :name => 'label_select1',
              :node_content => {:concrete_widget => "HTMLLabel", :params => {:content => "The biggest US Cities:", :css_class => "column grid_3"}},
            },
            {
              :name => 'cities',
              :node_content => {:concrete_widget => "JQueryAjaxChainedSelect", 
              :params => {
                :options => biggest_us_cities, 
                :on_change => {
                  :request_json_url =>"http://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20local.search%20where%20query%3D%22sushi%22%20and%20location%3D%22{{value}}%22&format=json",
                  :data_type => "text json", 
                  :target => "restaurants", :clear_target => true, 
                  :json_results_node => "['query']['results']['Result']", :item_option => "['Title']", :item_value => "['MapUrl']" 
                }
              }
              },
            
            },
            {
              :name => 'label_input2',
              :node_content => {:concrete_widget => "HTMLLabel", :params => {:content => "Sushi restaurants:", :css_class => "column grid_3"}},
            
            },
            {
              :name => 'restaurants',
              :node_content => {:concrete_widget => "HTMLFormSelect", :params => {:options => ['Choose a sushi'] }},
            
            },
            {
              :name => 'label_mapURL',
              :node_content => {:concrete_widget => "HTMLLabel", :params => {:content => "Map URL:", :css_class => "column grid_3"}},
            
            },
            {
              :name => 'map_url',
              :node_content => {:concrete_widget => "HTMLSpan", :params => {}},
            
            },
          ]
        },
        {
          :name => 'ps',
          :node_content => {:concrete_widget => "HTMLSpan", :params => {:content => "* Data from http://developer.yahoo.com/yql/console"}}
        
        } 
      ]
    } 
    
    extensions= [
      {:name => 'ext2', :extension => 'HTMLLineBreak', :nodes => ['cities', 'restaurants']},
      {:name => 'ext1', :extension => 'JQueryCopyTo', :nodes => ['restaurants'], :params => {:target => 'map_url'}},
    ]
    
    interface = ConcreteWidget::Interface.new(interface_schema)
   
    interface.add_extensions(extensions)
    
    File.open "demo-page2.1.html", "w" do |file|  
      file.write interface.render
    end  

    