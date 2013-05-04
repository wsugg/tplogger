class ChangeColumnDriverDropsIdInLogTable < ActiveRecord::Migration
  def change
  	rename_column :logs, :driver_drops_id, :driver_drop_id
  end

  def down
  end
end
