require "spec_helper"

class TestItem < ActiveRecordFiles::Base; end

class User < ActiveRecordFiles::Base
  attribute :name, String
  attribute :email, String
end

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

    it 'assign multiple attributes with params' do
      user = User.new name: 'John', email: 'john@example.com'
      expect(user.name).to eql 'John'
      expect(user.email).to eql 'john@example.com'
    end
  end

  describe '#save' do
    let(:table_representation) { [{}] }
    it 'write to file json object' do
      TestItem.new.save
      expect(File.read('./spec/dummy/test_items.json')).to eq table_representation.to_json
    end
  end

  describe 'attribute mapping' do
    it 'create accessors for attribute' do
      class TestSchemaMapping < ActiveRecordFiles::Base
        attribute :custom_attribute, String
      end
      expect(TestSchemaMapping.new).to respond_to(:custom_attribute)
      expect(TestSchemaMapping.new).to respond_to(:custom_attribute=)
    end
  end
end
