class RecipesController < ApplicationController
before_action :authorize

  def index
    recipes = Recipe.all
    user = @current_user
    render json: @current_user.recipes
  end

  def create
    recipe = @current_user.recipes.create!(recipe_params)
    render json: recipe, status: :created
  end

  private
  def recipe_params
    params.permit(:title, :instructions, :minutes_to_complete)
  end
end
