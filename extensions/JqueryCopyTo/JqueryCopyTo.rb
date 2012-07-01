class JqueryCopyTo < ConcreteWidget::Extension
  def initialize(params)
    @index  = params[:index] || 0
    @content  = params[:content] || ""
    @name = params[:name]
    @params  = params
    @id = params[:id]
  end
  
  def number
      @number
  end
  
  
end