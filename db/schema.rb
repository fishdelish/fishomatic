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

ActiveRecord::Schema.define(:version => 20110208111810) do

  create_table "authentications", :force => true do |t|
    t.integer  "user_id"
    t.string   "uid"
    t.string   "provider"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "external_fish_files", :force => true do |t|
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.string   "fish_file_file_name"
    t.string   "fish_file_content_type"
    t.integer  "fish_file_file_size"
    t.datetime "fish_file_updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
