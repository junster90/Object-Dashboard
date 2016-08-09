require 'rails_helper'

describe StringToHashConverter do
  describe '.convert' do
    let(:hash_string) { "{property1: “value1\", property3: \"value2\"}" }

    subject { StringToHashConverter.convert(hash_string) }

    it 'returns a hash object' do
      expect(subject).to be_a(Hash)
    end

    it 'has the correct attributes' do
      expect(subject).to match({property1: "“value1\"", property3: "\"value2\""})
    end
  end
end