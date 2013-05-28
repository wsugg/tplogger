class AddBugNumToLog < ActiveRecord::Migration
  def change
    add_column :logs, :bugnum, :string
  end
end
