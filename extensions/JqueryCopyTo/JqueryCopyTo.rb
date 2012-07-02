class JQueryCopyTo < ConcreteWidget::Extension
   def initialize(params)
      @name = params[:name]
      @id = params[:id]
      @params = params
      @parent = params[:parent]
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