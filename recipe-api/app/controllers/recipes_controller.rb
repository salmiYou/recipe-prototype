class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :update, :destroy]

  # GET /recipes
  def index
    @recipes = Recipe
    if params[:filter].present?
      @@_page_number = 1
      sane_value = ActiveRecord::Base.send(:sanitize_sql_like, params[:filter])
      @recipes = @recipes.left_joins([:tags, :ingredients])
                         .where('recipes.name iLIKE :search OR tags.name iLIKE :search OR ingredients.name iLIKE :search', search: "%#{sane_value}%")
                         .group('recipes.id')
    end
    @recipes = @recipes.order(rate: :desc).paginate(page: params[:page])

    render json: @recipes
  end

  # GET /recipes/1
  def show
    render json: @recipe
  end

  # POST /recipes
  def create
    @recipe = Recipe.new(recipe_params)

    if @recipe.save
      render json: @recipe, status: :created, location: @recipe
    else
      render json: @recipe.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /recipes/1
  def update
    if @recipe.update(recipe_params)
      render json: @recipe
    else
      render json: @recipe.errors, status: :unprocessable_entity
    end
  end

  # DELETE /recipes/1
  def destroy
    @recipe.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def recipe_params
      params.fetch(:recipe, {})
    end
end
