module Polymer
  module Generators
    class ComponentGenerator < ::Rails::Generators::NamedBase
      source_root File.expand_path('../templates', __FILE__)

      def create_component_dir
        empty_directory "app/assets/components/#{file_name}"
      end

      def copy_component_template
        template "component.html.erb", "app/assets/components/#{file_name}/#{file_name}.html.erb"
      end

    end
  end
end
