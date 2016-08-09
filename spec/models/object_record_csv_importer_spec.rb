require 'rails_helper'

describe ObjectRecordCsvImporter do
  let(:klass) { ObjectRecordCsvImporter }

  describe '.initialize' do
    context 'with a valid csv file' do
      let(:file) { File.new("#{TEST_FILES_PATH}/correct_objects.csv") }

      context 'without existing duplicate record in database' do
        it 'does not raise any errors' do
          expect(klass.new(file)).to be_a(ObjectRecordCsvImporter)
        end
      end

      context 'with existing duplicate record in database' do
        before do
          FactoryGirl.create(:existing_record)
        end

        it 'raises an InvalidCsvRecordError' do
          expect{ klass.new(file) }.to raise_error Exceptions::InvalidCsvRecordError
        end
      end
    end

    context 'with an invalid csv file' do
      context 'with incorrect headers' do
        let(:file) { File.new("#{TEST_FILES_PATH}/wrong_headers.csv") }

        it 'raises an IncorrectCsvHeadersError' do
          expect{ klass.new(file) }.to raise_error Exceptions::IncorrectCsvHeadersError
        end
      end

      context 'with empty fields' do
        let(:file) { File.new("#{TEST_FILES_PATH}/blank_objects.csv") }

        it 'raises an InvalidCsvRecordError' do
          expect{ klass.new(file) }.to raise_error Exceptions::InvalidCsvRecordError
        end
      end

      context 'with duplicate rows' do
        let(:file) { File.new("#{TEST_FILES_PATH}/duplicate_objects.csv") }

        it 'raises a DuplicateRecordsError' do
          expect{ klass.new(file) }.to raise_error Exceptions::DuplicateRecordsError
        end
      end

      context 'with a gibberish file' do
        let(:file) { File.new("#{TEST_FILES_PATH}/gibberish.csv") }

        it 'raises an ArgumentError' do
          expect{ klass.new(file) }.to raise_error ArgumentError
        end
      end
    end
  end

  describe '#import' do
    let(:file) { File.new("#{TEST_FILES_PATH}/correct_objects.csv") }
    let(:instance) { klass.new(file) }

    before { instance.import }

    it 'creates the records in the db' do
      expect(ObjectRecord.count).to eq 4
    end
  end
end