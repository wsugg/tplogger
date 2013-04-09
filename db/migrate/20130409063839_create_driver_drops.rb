class CreateDriverDrops < ActiveRecord::Migration
  def change
    create_table :driver_drops do |t|
      t.integer :branch
      t.string :description

      t.timestamps
    end
  end
end
