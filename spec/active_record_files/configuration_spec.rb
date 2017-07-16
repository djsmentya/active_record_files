require "spec_helper"

RSpec.describe ActiveRecordFiles::Core do

  it 'set root folder' do
    ActiveRecordFiles::Base.configurations = {root: '~/spec/dummy'}
    expect(ActiveRecordFiles::Base.configurations[:root]).to eq('~/spec/dummy')
  end

  it 'rise error if root folder not defined' do
    ActiveRecordFiles::Base.configurations = {}
    expect{ ActiveRecordFiles::Base.new }.to raise_error(ActiveRecordFiles::NoRootFolderError, "No root folder defined. Please define ActiveRecordFiles::Base.configurations = {root: Pathname.new('/custome/folder')}")
  end

end
