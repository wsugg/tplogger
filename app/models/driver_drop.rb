class DriverDrop < ActiveRecord::Base
  attr_accessible :branch, :description

  validates :branch, :description, :presence => :true

  has_many :logs, :dependent => :destroy
  accepts_nested_attributes_for :logs, :allow_destroy => true
end
