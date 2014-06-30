module ActionView
  module Helpers
    module AssetTagHelper
      def html_import_tag(*sources)
        options = sources.extract_options!
        path_options = options.extract!('protocol').symbolize_keys
        sources.uniq.map do |source|
          tag_options = { rel: "import", href: html_path(source, path_options) }
          tag(:link, tag_options.merge!(options).stringify_keys)
        end.join("\n").html_safe
      end
    end
  end
end
