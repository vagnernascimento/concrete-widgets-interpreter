class HTMLFormSelect < ConcreteWidget::WidgetBase
  def initialize(params)
    @content  = params[:content] || ""
    @css_class = params[:css_class] || ""
    @name = params[:name]
    @options = params[:options]
    @id = params[:id]
    @params  = params
  end

  def options
    @options
  end
  
  def options=(values)
    @options = values
  end
end