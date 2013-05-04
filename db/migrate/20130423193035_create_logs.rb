class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.string :name
      t.string :passfail
      t.references :driver_drops

      t.timestamps
    end
    add_index :logs, :driver_drops_id
  end
end
