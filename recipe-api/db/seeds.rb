# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Rails.application.eager_load!
ActiveRecord::Base.descendants.each {|d| d.reset_column_information }

require 'json'
require 'awesome_print'

file_path = Rails.root.to_s + "/db/seeds/recipes.json"
File.readlines(file_path).each do |line|
  data = JSON.parse(line)
  author = Author.find_or_create_by!(name: data['author'])
  recipe = Recipe.create({
    author_id:       author.id,
    name:            data['name'],
    author_tip:      data['author_tip'],
    prep_time:       data['prep_time'],
    cook_time:       data['cook_time'],
    image:           data['image'],
    rate:            data['rate'].to_i,
    difficulty:      data['difficulty'].to_i,
    people_quantity: data['people_quantity'].to_i,
    nb_comments:     data['nb_comments'].to_i
  })

  tags = data['tags'].map { |tag| Tag.find_or_create_by!(name: tag) }
  ingredients = data['ingredients'].map { |ingredient| Ingredient.find_or_create_by!(name: ingredient) }

  tags.each {|tag| RecipeTag.create({recipe: recipe, tag: tag})}
  ingredients.each {|ingredient| RecipeIngredient.create({recipe: recipe, ingredient: ingredient})}
end