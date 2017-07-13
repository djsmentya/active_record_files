require "spec_helper"

class TestItem < ActiveRecordFiles::Base; end

RSpec.describe ActiveRecordFiles::Base do
  before do
    ActiveRecordFiles::Base.configurations = {
      root: Pathname.new('./spec/dummy')
    }
  end

  describe '#new' do
    it 'create new file' do
      TestItem.new
      expect(File.file?('./spec/dummy/test_items.json')).to be_truthy
    end
  end

  describe '#save' do
    let(:table_representation) {[{}]}
    it 'write to file json object' do
      TestItem.new.save
      expect(File.read('./spec/dummy/test_items.json')).to eq table_representation.to_json
    end
  end
end
