class AddReferenceToTestLog < ActiveRecord::Migration
  def change
    add_column :test_logs, :driver_drop_id, :integer
  end
end
