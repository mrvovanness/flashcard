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

ActiveRecord::Schema.define(version: 20150428130920) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cards", force: :cascade do |t|
    t.text     "original_text"
    t.text     "translated_text"
    t.datetime "review_date"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "picture"
    t.integer  "deck_id"
    t.float    "e_factor",          default: 2.5
    t.integer  "interval",          default: 6
    t.integer  "number_of_reviews", default: 0
  end

  add_index "cards", ["deck_id"], name: "index_cards_on_deck_id", using: :btree

  create_table "decks", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
  end

  add_index "decks", ["user_id"], name: "index_decks_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "crypted_password"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "salt"
    t.integer  "current_deck_id"
    t.string   "locale",           default: "en"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end
