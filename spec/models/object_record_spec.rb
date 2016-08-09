require 'rails_helper'

describe ObjectRecord do
  let(:klass) { ObjectRecord }

  describe 'model validations' do
    it { should validate_presence_of(:object_id) }
    it { should validate_presence_of(:object_type) }
    it { should validate_presence_of(:timestamp) }
    it { should validate_presence_of(:object_changes) }
    it { should validate_uniqueness_of(:timestamp).scoped_to([:object_id, :object_type]) }
  end

  describe '.search' do
    let!(:first_record) { FactoryGirl.create(:first_record) }
    let!(:second_record) { FactoryGirl.create(:second_record) }
    let!(:last_record) { FactoryGirl.create(:last_record) }

    let(:object_id) { "1" }
    let(:object_type) { "ObjectA" }
    let(:timestamp) { 3.weeks.ago.to_i }

    context 'with timestamp option provided' do
      subject { klass.search(object_id, object_type, timestamp) }

      it 'returns the proper amount of records' do
        expect(subject.length).to eq 2
      end

      it 'returns the records in order of ascending timestamp' do
        expect(subject).to eq [first_record, second_record]
      end
    end

    context 'without timestamp option provided' do
      subject { klass.search(object_id, object_type) }

      it 'returns the proper amount of records' do
        expect(subject.length).to eq 3
      end

      it 'returns the records in order of ascending timestamp' do
        expect(subject).to eq [first_record, second_record, last_record]
      end
    end

  end
end
