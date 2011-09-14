# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100717124710) do

  create_table "accounts", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "accounts_users", :force => true do |t|
    t.integer "account_id"
    t.integer "user_id"
    t.boolean "admin",      :default => false
  end

  create_table "accounts_web_apps", :force => true do |t|
    t.integer "account_id"
    t.integer "web_app_id"
    t.date    "expires_on"
  end

  create_table "authentication_codes", :force => true do |t|
    t.integer  "account_id"
    t.string   "hash_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "users", :force => true do |t|
    t.string   "username",            :limit => 40
    t.string   "email",               :limit => 100
    t.string   "crypted_password",    :limit => 128, :default => "", :null => false
    t.string   "password_salt",       :limit => 128, :default => "", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "persistence_token",   :limit => 40
    t.boolean  "admin"
    t.string   "single_access_token"
    t.string   "perishable_token"
    t.integer  "roles_mask"
  end

  add_index "users", ["username"], :name => "index_users_on_login", :unique => true

  create_table "web_apps", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
