module Polymer
  module Generators
    class InstallGenerator < ::Rails::Generators::Base

      desc "Adds app/assets/components and vendor/assets/components directories and adds platform to js manifest"

      def create_app_dir
        empty_directory "app/assets/components"
      end

      def create_manifest
        create_file "app/assets/components/application.html.erb"
        append_to_file "app/assets/components/application.html.erb" do
          out = ""
          out << "//= require polymer/polymer"
          out << "\n"
        end
      end

      def create_vendor_dir
        empty_directory "vendor/assets/components"
        create_file "vendor/assets/components/.keep"
      end

      def inject_js
        insert_into_file "app/assets/javascripts/application.js", before: "//= require jquery\n" do
          out = ""
          out << "//= require polymer/platform"
          out << "\n"
        end
      end

    end
  end
end
