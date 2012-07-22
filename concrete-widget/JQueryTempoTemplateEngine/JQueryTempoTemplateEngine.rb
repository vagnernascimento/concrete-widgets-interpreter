class JQueryTempoTemplateEngine < ConcreteWidget::WidgetBase
    def initialize(params)
      @content  = params[:content] || ""
      @css_class = params[:css_class]
      @name = params[:name]
      @id = params[:id]
      @json_source_url = params[:json_source_url]
      @node_json_result_element = params[:node_json_result_element] || ""
      @msg_error = params[:msg_error] || "Sorry, but you sort of need JavaScript for this one!"
      @params = params
      @depends_on_ids = params[:depends_on_ids]
    end
    
    def js_handler
      "#{@id}_handler"
    end
    
    def dependencies
      ["HTMLPage"]
    end
    
    def depends_on_ids
      @depends_on_ids
    end
    
    def run_dependencies(obj)
      obj.include_js(["js/tempo.min.js", "js/jquery-1.7.2.min.js", "js/jquery-ui-1.8.21.custom.min.js"])
    end
   
end