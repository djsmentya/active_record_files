module ActiveRecordFiles::Persistence
  attr_reader :id

  def new_record?
    !id
  end
end
