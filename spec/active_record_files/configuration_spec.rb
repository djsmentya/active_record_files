require "spec_helper"

RSpec.describe ActiveRecordFiles::Core do

  it 'set root folder' do
    ActiveRecordFiles::Base.configurations = {root: '~/spec/dummy'}
    expect(ActiveRecordFiles::Base.configurations[:root]).to eq('~/spec/dummy')
  end

end
