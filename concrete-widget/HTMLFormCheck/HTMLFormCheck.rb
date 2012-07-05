class HTMLFormCheck < ConcreteWidget::WidgetBase
  def initialize(params)
    @content  = params[:content] || ""
    @css_class = params[:css_class] || ""
    @name = params[:name]
    @options = params[:options]
    @id = params[:id]
    @label_side = params[:label_side] || "right"
    @params  = params
  end

end