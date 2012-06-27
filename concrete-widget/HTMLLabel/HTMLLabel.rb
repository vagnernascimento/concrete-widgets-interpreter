class HTMLLabel < ConcreteWidget::WidgetBase
    def initialize(params)
        @content  = params[:content] || ""
        @css_class = params[:css_class] || ""
        @label_for = params[:label_for]
    end

end