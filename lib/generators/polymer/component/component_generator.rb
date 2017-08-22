module Polymer
  module Generators
    class ComponentGenerator < ::Rails::Generators::NamedBase
      source_root File.expand_path('../templates', __FILE__)

      def create_component_dir
        empty_directory "app/assets/components/#{component_name}"
      end

      def copy_component_template
        template "component.html.erb", "app/assets/components/#{component_name}/#{component_base_name}.html"
        template "component.js.erb", "app/assets/components/#{component_name}/#{component_base_name}.js"
        template "component.css.erb", "app/assets/components/#{component_name}/#{component_base_name}.css"
      end

      private

      def component_name
        name.gsub('_', '-').downcase
      end

      def class_name
        name.split('_').map(&:capitalize).join('')
      end
      
      def component_base_name
        component_name.split('/')[-1]
      end
    end
  end
end
