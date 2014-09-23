require "spec_helper"
require 'hpricot'
require 'polymer-rails/component'

describe Polymer::Rails::Component do
  let(:data){ '
      <link rel="stylesheet" href="1.css" />
      <link rel="stylesheet" href="2.css" shim-shadowdom />
      <script type="text/javascript" src="1.js"></script>
      <script type="text/javascript" src="2.js"></script>
      <link rel="import" href="1.html" />
      <link rel="import" href="2.html" />'
  }

  context '#replace_node' do
    context 'has shim-shadowdom attribute' do
      subject do
        doc = described_class.new data
        node = doc.stylesheets[1]
        doc.replace_node node, "style", "body { margin: 0px; }"
        doc
      end
      
      it 'replaces the stylesheet link with the inline styles and has the shim-shadowdom attr' do
        expect(subject.stringify).to include("<style shim-shadowdom>\nbody { margin: 0px; }\n</style>")
      end
    end
    
    context 'does not have the shim-shadowdom attribute' do
      subject do
        doc = described_class.new(data)
        nodes = doc.stylesheets
        nodes.each do |node|
          doc.replace_node node, "style", "body{color: red;}"
        end
        doc
      end
  
      it 'replaces stylesheet link with inline styles' do
        expect(subject.stringify).to include("<style>\nbody{color: red;}\n</style>")
        expect(subject.stringify).not_to include('<link rel="stylesheet"')
      end
    end
  end

  context '#imports' do
    subject{ described_class.new(data).imports }

    it 'returns array of nodes' do
      expect(subject.size).to eq 2
      expect(subject[0]).to be_kind_of(Hpricot::Node)
    end

    it 'returns nodes of html imports' do
      expect(subject[0].name).to eq('link')
      expect(subject[0].attributes['rel']).to eq('import')
    end

  end

  context '#javascripts' do
    subject{ described_class.new(data).javascripts }

    it 'returns array of nodes' do
      expect(subject.size).to eq 2
      expect(subject[0]).to be_kind_of(Hpricot::Node)
    end

    it 'returns nodes of html imports' do
      expect(subject[0].name).to eq('script')
      expect(subject[0].attributes['type']).to eq('text/javascript')
    end

  end

  context '#stylesheets' do
    subject{ described_class.new(data).stylesheets }

    it 'returns array of nodes' do
      expect(subject.size).to eq 2
      expect(subject[0]).to be_kind_of(Hpricot::Node)
    end

    it 'returns nodes of html imports' do
      expect(subject[0].name).to eq('link')
      expect(subject[0].attributes['rel']).to eq('stylesheet')
    end
  end

  context '#stringify' do
    subject{ described_class.new(data).stringify }

    it 'should return html string' do
      expect(subject).to eq(data)
    end
  end

end
