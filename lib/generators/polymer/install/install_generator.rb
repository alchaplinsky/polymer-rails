module Polymer
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)

      desc "Adds app/assets/components and vendor/assets/components directories and adds webcomponents to js manifest"

      def create_manifest
        template "application.html.erb", "app/assets/components/application.html.erb"
      end

      def inject_js
        insert_into_file "app/assets/javascripts/application.js", before: "//= require jquery\n" do
          out = ""
          out << "//= require webcomponentsjs/webcomponents-loader"
          out << "\n"
        end
      end

      def copy_bowerrc
        template "bowerrc.json", ".bowerrc"
      end

      def create_vendor_dir
        create_file "vendor/assets/components/.keep"
      end

    end
  end
end
