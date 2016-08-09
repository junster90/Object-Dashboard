require 'rails_helper'

describe ObjectSnapshotsBuilder do
  let(:klass) { ObjectSnapshotsBuilder }

  describe '#build' do
    let(:object_id) { "1" }
    let(:object_type) { "ObjectA" }
    let(:timestamp) { Time.now.to_s }
    let(:first_record) { FactoryGirl.build(:first_record) }
    let(:last_record) { FactoryGirl.build(:last_record) }
    let(:instance) { klass.new({object_id: object_id, object_type: object_type, timestamp: timestamp}) }

    context 'with records found' do
      before do
        allow(ObjectRecord).to(receive(:search).and_return([first_record, last_record]))
      end

      let(:correct_merged_properties) do
        { property1: "2nd value", property2: "1st value", property3: "1st value" }
      end

      subject { instance.build }

      it 'returns an ObjectSnapshot instance' do
        expect(subject).to be_a(ObjectSnapshot)
      end

      it 'has an object_id' do
        expect(subject.object_id).to eq object_id
      end

      it 'has an object_type' do
        expect(subject.object_type).to eq object_type
      end

      it 'has a timestamp' do
        expect(subject.timestamp).to eq timestamp
      end

      it 'compiles the correct merged properties' do
        expect(subject.properties).to eq correct_merged_properties
      end
    end

    context 'with no records found' do
      before do
        allow(ObjectRecord).to(receive(:search).and_return(nil))
      end

      subject { instance.build }

      it 'returns nil' do
        expect(subject).to be_nil
      end
    end
  end
end