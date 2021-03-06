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

ActiveRecord::Schema.define(version: 20150626141619) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "metadata", force: :cascade do |t|
    t.integer  "theme_id"
    t.string   "language"
    t.string   "title"
    t.string   "description"
    t.string   "keywords"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "metadata", ["theme_id"], name: "index_metadata_on_theme_id", using: :btree

  create_table "nodes", force: :cascade do |t|
    t.integer  "nodeID"
    t.text     "url_label"
    t.boolean  "hidden"
    t.string   "dg"
    t.hstore   "label_translations"
    t.hstore   "references"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "group"
  end

  create_table "themes", force: :cascade do |t|
    t.integer  "node_id"
    t.string   "contentID"
    t.text     "html_content"
    t.boolean  "more_about"
    t.boolean  "is_original"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.boolean  "check_dg"
    t.boolean  "check_com"
  end

  add_index "themes", ["node_id"], name: "index_themes_on_node_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "dg"
    t.string   "group"
    t.string   "encrypted_password",  default: "", null: false
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",       default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_foreign_key "metadata", "themes", on_delete: :cascade
  add_foreign_key "themes", "nodes", on_delete: :nullify
end
