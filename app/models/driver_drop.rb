class DriverDrop < ActiveRecord::Base
  attr_accessible :branch, :description, :logpath, :x64logpath

  validates :branch, :description, :presence => :true

  has_many :logs, :dependent => :destroy
  accepts_nested_attributes_for :logs, :allow_destroy => true
end
