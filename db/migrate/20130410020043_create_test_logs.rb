class CreateTestLogs < ActiveRecord::Migration
  def change
    create_table :test_logs do |t|
      t.string :filename
      t.string :passfail

      t.timestamps
    end
  end
end
