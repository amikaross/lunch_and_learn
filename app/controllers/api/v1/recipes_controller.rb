class Api::V1::RecipesController < ApplicationController
  def index 
    recipes = RecipesFacade.recipes_by_country(params[:country])
    render json: RecipeSerializer.new(recipes)
  end
end