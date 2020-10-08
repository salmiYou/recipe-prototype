class IntDbSchema < ActiveRecord::Migration[5.0]
  def change
    enable_extension 'plpgsql'
    enable_extension 'uuid-ossp'

    create_table :recipes,  id: :uuid do |t|
      t.uuid     :author_id, null: false
      t.string   :name
      t.string   :author_tip
      t.string   :prep_time
      t.string   :cook_time
      t.string   :image
      t.integer  :rate
      t.integer  :difficulty
      t.integer  :people_quantity
      t.integer  :nb_comments
    end

    create_table :authors,  id: :uuid do |t|
      t.string   :name
    end

    create_table :tags,  id: :uuid do |t|
      t.string   :name
    end

    create_table :ingredients,  id: :uuid do |t|
      t.string   :name
    end

    create_table  :recipe_tags, id: :uuid do  |t|
      t.uuid      :recipe_id,   null: false
      t.uuid      :tag_id,      null: false
    end

    create_table  :recipe_ingredients, id: :uuid do  |t|
      t.uuid      :recipe_id,       null: false
      t.uuid      :ingredient_id,   null: false
    end

    add_foreign_key :recipes,             :authors
    add_foreign_key :recipe_tags,        :recipes
    add_foreign_key :recipe_tags,        :tags
    add_foreign_key :recipe_ingredients, :recipes
    add_foreign_key :recipe_ingredients, :ingredients

    add_index       :recipe_tags,   :recipe_id
    add_index       :recipe_tags,   :tag_id
    add_index       :recipe_tags,   [:recipe_id, :tag_id], unique: true, using: :btree,  name: :uniq_rt_rid_tid
    add_index       :recipe_tags,   [:tag_id, :recipe_id], unique: true, using: :btree,  name: :uniq_rt_tid_rid

    add_index       :recipe_ingredients,   :recipe_id
    add_index       :recipe_ingredients,   :ingredient_id
    add_index       :recipe_ingredients,   [:recipe_id, :ingredient_id], using: :btree,  name: :ri_rid_iid
    add_index       :recipe_ingredients,   [:ingredient_id, :recipe_id], using: :btree,  name: :ri_iid_rid
  end

  def down
    drop_table        :ingredients
    drop_table        :authors
    drop_table        :recipes
    drop_table        :tags
  end
end
