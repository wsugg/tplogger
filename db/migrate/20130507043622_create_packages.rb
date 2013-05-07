class CreatePackages < ActiveRecord::Migration
  def change
    create_table :packages do |t|
      t.string :source_path
      t.string :inf_path
      t.string :destination_path

      t.timestamps
    end
  end
end
