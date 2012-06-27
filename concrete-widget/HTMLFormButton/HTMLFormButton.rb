class HTMLFormButton < ConcreteWidget::WidgetBase
 
 def initialize(params)
    @content  = params[:content] || ""
    @css_class = params[:css_class]
    @name = params[:name]
    @id = params[:id]
    @type = params[:type] || "submit"
    @params = params
  end
  
end