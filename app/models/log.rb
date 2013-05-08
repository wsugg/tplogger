class Log < ActiveRecord::Base
  belongs_to :driver_drops
  attr_accessible :filename, :passfail, :id, :driver_drop_id, :testlog, :log, :name

  mount_uploader :testlog, TestlogUploader
  #mount_uploader :log, LogUploader
  before_create :default_name
  after_create :parse_log

  def default_name
    self.name ||= File.basename(testlog.filename, '.*').titleize if testlog
  end
end
