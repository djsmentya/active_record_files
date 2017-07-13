require "spec_helper"

class TestItem < ActiveRecordFiles::Base; end

RSpec.describe ActiveRecordFiles::Base do
  before do
    ActiveRecordFiles::Base.configurations = {
      root: Pathname.new('./spec/dummy')
    }
  end

  describe '#save' do
    it 'create new file' do
      TestItem.new.save
      expect(File.file?('./spec/dummy/test_items.json')).to be_truthy
    end
  end

  describe '.create' do
    it 'create new file' do
      TestItem.create
      expect(File.file?('./spec/dummy/test_items.json')).to be_truthy
    end
  end

end
