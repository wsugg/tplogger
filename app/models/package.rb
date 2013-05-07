class Package < ActiveRecord::Base
  attr_accessible :destination_path, :inf_path, :source_path
end
