require "spec_helper"
require 'action_view'
require 'polymer-rails/helpers/asset_tag_helper'

class AssetTagHelperTest
end

describe Polymer::Rails::AssetTagHelper do

  before do
    @dummy_class = AssetTagHelperTest.new
    @dummy_class.extend(ActionView::Helpers::TagHelper)
    @dummy_class.extend(ActionView::Helpers::AssetTagHelper)
    @dummy_class.extend(Polymer::Rails::AssetTagHelper)
  end

  it 'generates html import tag' do
    expect(@dummy_class.html_import_tag('application')).to eq("<link rel=\"import\" href=\"/application.html\" />")
  end

end
