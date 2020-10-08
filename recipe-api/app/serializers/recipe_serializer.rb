class RecipeSerializer < ActiveModel::Serializer
  attributes :name,
             :author_tip,
             :prep_time,
             :cook_time,
             :image,
             :rate,
             :difficulty,
             :people_quantity,
             :nb_comments

  belongs_to   :author
  has_many     :ingredients
  has_many     :tags
end