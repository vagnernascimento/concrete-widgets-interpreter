class JQueryFormAjax < ConcreteWidget::Extension
   def initialize(params)
      @name = params[:name]
      @id = params[:id]
      @params = params
      @parent = params[:parent]
      @data_type = params[:data_type] || "json"
      @depends_on_ids = params[:depends_on_ids]
    end
    
    def dependencies
      ["HTMLPage"]
    end
    
    def depends_on_ids
      @depends_on_ids
    end
    
    def run_dependencies(obj)
      obj.include_js(["js/jquery-1.7.2.min.js", "js/jquery.form.js"])
    end
end