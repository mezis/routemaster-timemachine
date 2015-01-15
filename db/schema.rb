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

ActiveRecord::Schema.define(version: 20150115104425) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: :cascade do |t|
    t.string   "url"
    t.string   "type"
    t.string   "topic"
    t.decimal  "t"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "events", ["t"], name: "index_events_on_t", using: :btree
  add_index "events", ["topic"], name: "index_events_on_topic", using: :btree
  add_index "events", ["type"], name: "index_events_on_type", using: :btree
  add_index "events", ["url", "type", "topic", "t"], name: "index_events_on_url_and_type_and_topic_and_t", using: :btree
  add_index "events", ["url"], name: "index_events_on_url", using: :btree

end
