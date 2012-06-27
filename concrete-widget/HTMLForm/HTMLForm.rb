class HTMLForm < ConcreteWidget::WidgetBase

 def initialize(params)
    @content  = params[:content] || ""
    @css_class = params[:css_class]
    @name = params[:name]
    @id = params[:id]
    @params = params
    @method = params[:method] || "post"
    @action = params[:action]
  end
end