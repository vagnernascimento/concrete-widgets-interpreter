class HTMLPage < ConcreteWidget::WidgetBase
    
  def initialize(params)
    @title  = params[:title] || "Page"
    @content  = params[:content] || ""
    @include_js = params[:include_js] || []
    @include_css = params[:include_css] || []
  end
  
  def include_js(plus)
    @include_js += plus
    @include_js.uniq!
  end
  
  def js_libs
    @include_js
  end
  
  def include_css(plus)
    @include_css += plus
    @include_css.uniq!
  end
  
  def css_libs
    @include_css
  end
  
  def title
    @title
  end
  
end