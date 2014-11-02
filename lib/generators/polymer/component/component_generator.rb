module Polymer
  module Generators
    class ComponentGenerator < ::Rails::Generators::NamedBase
      source_root File.expand_path('../templates', __FILE__)

      def create_component_dir
        empty_directory "app/assets/components/#{name}"
      end

      def copy_component_template
        template "component.html.erb", "app/assets/components/#{name}/#{name}.html"
        template "component.js.coffee.erb", "app/assets/components/#{name}/#{name}.js.coffee"
        template "component.css.scss.erb", "app/assets/components/#{name}/#{name}.css.scss"
      end

    end
  end
end
