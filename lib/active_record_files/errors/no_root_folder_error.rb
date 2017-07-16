class ActiveRecordFiles::NoRootFolderError < StandardError
  def initialize(msg="No root folder defined. Please define ActiveRecordFiles::Base.configurations = {root: Pathname.new('/custome/folder')}")
    super
  end
end
