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

ActiveRecord::Schema.define(:version => 20110527124151) do

  create_table "budgets", :force => true do |t|
    t.string    "name"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "url"
  end

  create_table "cities", :force => true do |t|
    t.string  "name",       :limit => 30
    t.integer "population"
    t.integer "country_id"
    t.boolean "top"
    t.string  "url"
    t.integer "state_id"
    t.integer "similar"
  end

  create_table "countries", :force => true do |t|
    t.string  "short", :limit => 2
    t.string  "name",  :limit => 41
    t.integer "top"
    t.string  "url"
  end

  create_table "favorite_users", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "favorite_id"
  end

  create_table "favorites", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rails_admin_histories", :force => true do |t|
    t.string    "message"
    t.string    "username"
    t.integer   "item"
    t.string    "table"
    t.integer   "month"
    t.integer   "year"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_histories_on_item_and_table_and_month_and_year"

# Could not dump table "states" because of following StandardError
#   Unknown type '' for column 'url'

  create_table "us_cities", :id => false, :force => true do |t|
    t.string  "name",     :limit => nil
    t.string  "state",    :limit => nil
    t.integer "state_id"
  end

  create_table "us_state_abbr", :id => false, :force => true do |t|
    t.string "name", :limit => nil
    t.string "abbr", :limit => nil
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                                    :null => false
    t.string   "encrypted_password",     :limit => 128,                    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count"
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin"
    t.text     "describe"
    t.integer  "city_id"
    t.integer  "country_id"
    t.integer  "budget_id"
    t.boolean  "paid_atm",                              :default => false, :null => false
    t.string   "name"
    t.string   "contact_email"
    t.string   "contact_phone"
    t.string   "website"
    t.string   "company"
  end

  create_table "works", :force => true do |t|
    t.integer   "user_id"
    t.string    "image_content_type"
    t.integer   "image_file_size"
    t.timestamp "image_updated_at"
    t.string    "image_file_name"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "describe"
  end

end
