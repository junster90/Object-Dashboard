require 'rails_helper'

describe ObjectSnapshot do
  let(:klass) { ObjectSnapshot }

  describe 'stores correct attributes' do
    let(:id) { "1" }
    let(:type) { "ObjectA" }
    let(:timestamp) { "2016-08-09 11:16:17 +0800" }
    let(:properties) { {property1: "something", property2: "another thing"} }

    subject(:instance) { klass.new(id, type, timestamp, properties) }

    it 'for :object_id' do
      expect(instance.object_id).to eq id
    end

    it 'for :object_type' do
      expect(instance.object_type).to eq type
    end

    it 'for :timestamp' do
      expect(instance.timestamp).to eq timestamp
    end

    it 'for :properties' do
      expect(instance.properties).to eq properties
    end
  end
end
