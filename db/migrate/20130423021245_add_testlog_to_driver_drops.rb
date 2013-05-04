class AddTestlogToDriverDrops < ActiveRecord::Migration
  def change
    add_column :driver_drops, :testlog, :string
  end
end
