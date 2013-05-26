class AddCommandLineToLog < ActiveRecord::Migration
  def change
    add_column :logs, :cmdline, :String
  end
end
