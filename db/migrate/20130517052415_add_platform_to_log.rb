class AddPlatformToLog < ActiveRecord::Migration
  def change
  	add_column :logs, :platform, :string
  end
end
