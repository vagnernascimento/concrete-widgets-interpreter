class JQueryAjaxChainedSelect < ConcreteWidget::WidgetBase
  def initialize(params)
    @content  = params[:content] || ""
    @css_class = params[:css_class]
    @name = params[:name]
    @id = params[:id]
    @params = params
    @depends_on_ids = params[:depends_on_ids]
  end
    
  def options
    @options
  end
  
  def options=(values)
    @options = values
  end
    
  def dependencies
    ["HTMLPage"]
  end
  
  def depends_on_ids
    @depends_on_ids
  end
  
  def run_dependencies(obj)
    obj.include_js(["js/jquery-1.7.2.min.js"])
    
  end
   
end