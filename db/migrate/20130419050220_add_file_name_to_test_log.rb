class AddFileNameToTestLog < ActiveRecord::Migration
def self.up
    add_column :test_logs, :log_file_name, :string # Original filename
    add_column :test_logs, :log_content_type, :string # Mime type
    add_column :test_logs, :log_file_size, :integer # File size in bytes
  end

  def self.down
    remove_column :test_logs, :log_file_name
    remove_column :test_logs, :log_content_type
    remove_column :test_logs, :log_file_size
  end
end
