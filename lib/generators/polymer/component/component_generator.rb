module Polymer
  module Generators
    class ComponentGenerator < ::Rails::Generators::NamedBase
      source_root File.expand_path('../templates', __FILE__)

      def create_component_dir
        empty_directory "app/assets/components/#{component_name}"
      end

      def copy_component_template
        template "component.html.erb", "app/assets/components/#{component_name}/#{component_name}.html"
        template "component.js.erb", "app/assets/components/#{component_name}/#{component_name}.js"
        template "component.css.erb", "app/assets/components/#{component_name}/#{component_name}.css"
      end

      private

      def component_name
        name.gsub('_', '-').downcase
      end
    end
  end
end
