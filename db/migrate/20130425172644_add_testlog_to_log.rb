class AddTestlogToLog < ActiveRecord::Migration
  def change
    add_column :logs, :testlog, :string
  end
end
