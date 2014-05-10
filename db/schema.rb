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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140507210404) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "authentication_token"
    t.index ["authentication_token"], :name => "index_users_on_authentication_token"
    t.index ["email"], :name => "index_users_on_email", :unique => true
    t.index ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  end

  create_table "boards", force: true do |t|
    t.string   "name",                   null: false
    t.integer  "user_id",                null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "priority",   default: 1, null: false
    t.index ["priority"], :name => "index_boards_on_priority"
    t.index ["user_id"], :name => "fk__boards_user_id"
    t.index ["user_id"], :name => "index_boards_on_user_id"
    t.foreign_key ["user_id"], "users", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_boards_user_id"
  end

  create_table "lists", force: true do |t|
    t.string   "name",                   null: false
    t.integer  "board_id",               null: false
    t.integer  "priority",   default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["board_id"], :name => "fk__lists_board_id"
    t.index ["board_id"], :name => "index_lists_on_board_id"
    t.foreign_key ["board_id"], "boards", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_lists_board_id"
  end

end
