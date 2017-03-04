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

ActiveRecord::Schema.define(version: 20170303143116) do

  create_table "guestbooks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title"
    t.boolean  "archived"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.boolean  "is_default",                default: false
    t.text     "description", limit: 65535
  end

  create_table "messages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text     "content",      limit: 65535
    t.boolean  "approved"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.integer  "guestbook_id"
    t.integer  "votes"
    t.integer  "votes_cast",                 default: 0
    t.index ["guestbook_id"], name: "index_messages_on_guestbook_id", using: :btree
  end

end
