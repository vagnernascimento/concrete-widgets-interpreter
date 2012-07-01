# ConcreteWidget.rb -- Class required for all concrete widgets
# Author:: Vagner Nascimento (vagnernascimento@gmail.com)

module ConcreteWidget
  class WidgetBase
    
    #VERSION "0.1.1"
    
    def initialize(params)
      @content  = params[:content] || ""
      @css_class = params[:css_class] || ""
      @name = params[:name]
      @params  = params
      @id = params[:id]
      @extensions = []
    end
    
    def add_content(content, on_bottom = true)
      if on_bottom
          @content += content
      else
          @content = content + @content
      end
    end
    
    def <<(content)
      add_content(content)
    end
    
    def content=(content)
      @content = content
    end 
    
    def content
      @content
    end  
    
    def name
      @name
    end
    
    def name=(name)
      @name = name
    end
    
    def params
      @params
    end
    
    def id
      @id
    end
    
    def id=(id)
      @id = id
    end
    
    def css_class
      @css_class
    end
    
    def css_class=(css)
      @css_class = css
    end
    
    def extensions
      @extensions
    end
    
    def extensions=(ext)
      @extensions ||= []
      @extensions << ext
    end
    
    def add_extension(ext)
      @extensions ||= []
      @extensions << ext
    end
    
    def render_extensions()
      extensions_rendered = ""
      extensions.each{ |ext| 
        ext.parent = self
        extensions_rendered << "\n" + ext.render
      } unless extensions.nil?
      return extensions_rendered
    end
    
    def render(params={})
      require "tilt"
      path_mask = "#{File.dirname(__FILE__)}/#{self.class.to_s}/template.*"
      template_list = Dir.glob(path_mask)
      unless template_list.empty?
        template = Tilt.new(template_list.first)
        template.render(self, params ) << render_extensions
      else
        self.content << render_extensions
      end
    end
    
  end
  
  class Extension < WidgetBase
    def parent=(parent)
      @parent = parent
    end
    
    def parent
      @parent
    end
    
    def render(params={})
      require "tilt"
      path_mask = "#{File.dirname(__FILE__)}/../extensions/#{self.class.to_s}/template.*"
      template_list = Dir.glob(path_mask)
      unless template_list.empty?
        template = Tilt.new(template_list.first)
        template.render(self, params )
      else
        self.content
      end
    end
    
  end
end