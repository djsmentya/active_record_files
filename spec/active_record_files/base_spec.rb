require "spec_helper"

class TestItem < ActiveRecordFiles::Base; end

class User < ActiveRecordFiles::Base
  attribute :name, String
  attribute :email, String
end

class TestSchemaMapping < ActiveRecordFiles::Base
  attribute :custom_attribute, String
end

RSpec.describe ActiveRecordFiles::Base do
  before do
    ActiveRecordFiles::Base.configurations = {
      root: Pathname.new('./spec/dummy')
    }
  end

  describe '.create' do
    it 'create record with multiple params' do
      user = User.create name: 'John', email: 'john@example.com'
      expect(user.name).to eql 'John'
      expect(user.email).to eql 'john@example.com'
    end
  end

  describe '.find' do
    it 'return object of existen record' do
      user_id =  User.create(name: 'Luke').id
      expect(User.find(user_id).name).to eq('Luke')
    end
  end

  describe '.where' do
    before(:each) do
      User.create(name: 'Will', email: 'will@example.com')
      User.create(name: 'Luice')
      User.create(name: 'Will')
    end

    it 'return collection with matched attributes' do
      expect(User.where(name: 'Will').first.name).to eq 'Will'
    end
  end

  describe '#new' do
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

    it 'return self instance' do
      expect(TestItem.new.save).to be_a(TestItem)
    end

    let(:user_representation) { { name: 'John Doue', email: 'john@example.com' } }
    let(:user_table_representation) { [user_representation] }
    it 'serialize attributes to file' do
      User.new(user_representation).save
      expect(File.read('./spec/dummy/users.json')).to eq user_table_representation.to_json
    end

    it 'update existed attributes' do
      user = User.new(user_representation).save
      user.name = 'Frank'
      user.save

      expect(File.read('./spec/dummy/users.json')).to eq([{ name: 'Frank', email: 'john@example.com' }].to_json)
    end
  end

  describe 'attribute mapping' do
    it 'create accessors for attribute' do
      expect(TestSchemaMapping.new).to respond_to(:custom_attribute)
      expect(TestSchemaMapping.new).to respond_to(:custom_attribute=)
    end
  end
end
