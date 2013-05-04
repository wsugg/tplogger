class RenameTableTestLogsToTestlog < ActiveRecord::Migration
  def change
  	rename_table :test_logs, :testlogs 
  end
end
