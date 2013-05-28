class AddX64logpathToDriverDrops < ActiveRecord::Migration
  def change
    add_column :driver_drops, :x64logpath, :string
  end
end
