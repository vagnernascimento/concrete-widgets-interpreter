class JQueryDatePickerInput < ConcreteWidget::WidgetBase
    def initialize(params)
      @content  = params[:content] || ""
      @css_class = params[:css_class]
      @name = params[:name]
      @id = params[:id]
      @params = params
      @depends_on_ids = params[:depends_on_ids]
    end
    
    def dependencies
      ["HTMLPage"]
    end
    
    def depends_on_ids
      @depends_on_ids
    end
    
    def run_dependencies(obj)
      obj.include_js(["js/jquery-1.7.2.min.js", "js/jquery-ui-1.8.21.custom.min.js"])
      obj.include_css(["css/ui-lightness/jquery-ui-1.8.21.custom.css"])
    end
   
end