# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130522161134) do

  create_table "driver_drops", :force => true do |t|
    t.string   "branch"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "testlog"
  end

  create_table "logs", :force => true do |t|
    t.string   "name"
    t.string   "passfail"
    t.integer  "driver_drop_id"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.string   "testlog"
    t.string   "platform"
    t.string   "cmdline",        :limit => nil
  end

  add_index "logs", ["driver_drop_id"], :name => "index_logs_on_driver_drops_id"

  create_table "packages", :force => true do |t|
    t.string   "source_path"
    t.string   "inf_path"
    t.string   "destination_path"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "testlogs", :force => true do |t|
    t.string   "filename"
    t.string   "passfail"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "driver_drop_id"
    t.string   "log_file_name"
    t.string   "log_content_type"
    t.integer  "log_file_size"
  end

end
