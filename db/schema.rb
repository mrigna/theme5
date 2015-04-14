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

ActiveRecord::Schema.define(version: 20150413070505) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "metadata", force: :cascade do |t|
    t.string   "contentID"
    t.string   "language"
    t.string   "title"
    t.string   "description"
    t.string   "keywords"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "nodes", force: :cascade do |t|
    t.integer  "nodeID"
    t.text     "url_label"
    t.boolean  "hidden"
    t.string   "dg"
    t.hstore   "label_translations"
    t.hstore   "references"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "nodes", ["nodeID"], name: "index_nodes_on_nodeID", unique: true, using: :btree

  create_table "themes", force: :cascade do |t|
    t.integer  "nodeID"
    t.string   "contentID"
    t.text     "html_content"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "themes", ["contentID"], name: "index_themes_on_contentID", unique: true, using: :btree

  add_foreign_key "metadata", "themes", column: "contentID", primary_key: "contentID", on_delete: :cascade
  add_foreign_key "themes", "nodes", column: "nodeID", primary_key: "nodeID", on_delete: :nullify
end