require "spec_helper"
require "polymer-rails/xml_adapters/base"
require "polymer-rails/component"

describe Polymer::Rails::Component do

  if RUBY_PLATFORM =~ /java/
    XML_ELEMENT = org.jsoup.nodes.Element
  else
    XML_ELEMENT = Nokogiri::XML::Element
  end

  let(:data){ '<link rel="stylesheet" href="1.css">
      <link rel="import" type="css" href="1.css">
      <script type="text/javascript" src="1.js"></script>
      <script type="text/javascript" src="2.js"></script>
      <link rel="import" href="1.html">
      <link rel="import" href="2.html">'
  }

  let(:img_tag){'<img src="[[link1]]" attr="[[attr1]]"></img>
      <img src="{{link2}}" attr="{{attr2}}"></img>'
  }

  context '#replace_node' do
    subject do
      doc = described_class.new(data)
      node = doc.stylesheets[0]
      doc.replace_node node, "style", "body{color: red;}"
      doc
    end

    it 'replaces stylesheet link with inline styles' do
      expect(subject.stringify).to include('<style>body{color: red;}</style>')
      expect(subject.stringify).not_to include('<link rel="stylesheet"')
    end
  end

  context '#html_imports' do
    subject{ described_class.new(data).html_imports }

    it 'returns array of nodes' do
      expect(subject.size).to eq 2
      expect(subject[0]).to be_kind_of(XML_ELEMENT)
    end

    it 'returns nodes of html imports' do
      expect(subject[0].name).to eq('link')
      expect(subject[0].attributes['rel'].value).to eq('import')
    end

  end

  context '#javascripts' do
    subject{ described_class.new(data).javascripts }

    it 'returns array of nodes' do
      expect(subject.size).to eq 2
      expect(subject[0]).to be_kind_of(XML_ELEMENT)
    end

    it 'returns nodes of html imports' do
      expect(subject[0].name).to eq('script')
      expect(subject[0].attributes['type'].value).to eq('text/javascript')
    end

  end

  context '#stylesheets' do
    subject{ described_class.new(data).stylesheets }

    it 'returns array of nodes' do
      expect(subject.size).to eq 2
      expect(subject[0]).to be_kind_of(XML_ELEMENT)
    end

    it 'returns nodes of html imports' do
      expect(subject[0].name).to eq('link')
      expect(subject[0].attributes['rel'].value).to eq('stylesheet')
    end
  end

  context '#stringify' do
    context 'regular html' do
      subject{ described_class.new(data).stringify }

      it 'should return html string' do
        expect(subject.squish).to eq(data.squish)
      end
    end

    context 'img tag with one-way and two-way binding' do
      subject{ described_class.new(img_tag).stringify }

      it 'should return html string' do
        expect(subject.squish).to eq(img_tag.squish)
      end
    end
  end

end
