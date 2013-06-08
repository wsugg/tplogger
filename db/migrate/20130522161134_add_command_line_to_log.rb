class AddCommandLineToLog < ActiveRecord::Migration
  def change
    add_column :logs, :cmdline, :string
  end
end
