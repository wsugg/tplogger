class AddLogPathToDriverDrop < ActiveRecord::Migration
  def change
  	add_column :driver_drops, :logpath, :String
  end
end
