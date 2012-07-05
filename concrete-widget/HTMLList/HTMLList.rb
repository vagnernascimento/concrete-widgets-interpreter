class HTMLList < ConcreteWidget::WidgetBase
  def initialize(params)
    @content  = params[:content] 
    @css_class = params[:css_class] 
    @name = params[:name] 
    @items = params[:items]
    @id = params[:id]
    @params  = params
  end

end