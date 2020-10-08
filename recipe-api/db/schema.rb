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

ActiveRecord::Schema.define(version: 20201006195100) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "authors", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string "name"
  end

  create_table "ingredients", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string "name"
  end

  create_table "recipe_ingredients", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid "recipe_id",     null: false
    t.uuid "ingredient_id", null: false
    t.index ["ingredient_id", "recipe_id"], name: "ri_iid_rid", using: :btree
    t.index ["ingredient_id"], name: "index_recipe_ingredients_on_ingredient_id", using: :btree
    t.index ["recipe_id", "ingredient_id"], name: "ri_rid_iid", using: :btree
    t.index ["recipe_id"], name: "index_recipe_ingredients_on_recipe_id", using: :btree
  end

  create_table "recipe_tags", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid "recipe_id", null: false
    t.uuid "tag_id",    null: false
    t.index ["recipe_id", "tag_id"], name: "uniq_rt_rid_tid", unique: true, using: :btree
    t.index ["recipe_id"], name: "index_recipe_tags_on_recipe_id", using: :btree
    t.index ["tag_id", "recipe_id"], name: "uniq_rt_tid_rid", unique: true, using: :btree
    t.index ["tag_id"], name: "index_recipe_tags_on_tag_id", using: :btree
  end

  create_table "recipes", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid    "author_id",       null: false
    t.string  "name"
    t.string  "author_tip"
    t.string  "prep_time"
    t.string  "cook_time"
    t.string  "image"
    t.integer "rate"
    t.integer "difficulty"
    t.integer "people_quantity"
    t.integer "nb_comments"
  end

  create_table "tags", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string "name"
  end

  add_foreign_key "recipe_ingredients", "ingredients"
  add_foreign_key "recipe_ingredients", "recipes"
  add_foreign_key "recipe_tags", "recipes"
  add_foreign_key "recipe_tags", "tags"
  add_foreign_key "recipes", "authors"
end
