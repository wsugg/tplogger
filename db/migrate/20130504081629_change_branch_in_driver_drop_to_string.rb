class ChangeBranchInDriverDropToString < ActiveRecord::Migration
  def up
  	change_table :driver_drops do |t|
      t.change :branch, :string
    end
  end

  def down
  	change_table :driver_drops do |t|
      t.change :branch, :integer
    end
  end
end
