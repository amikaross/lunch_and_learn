class Api::V1::FavoritesController < ApplicationController 
  def index 
    user = User.find_by(api_key: params[:api_key])
    if user.nil? 
      render json: ErrorSerializer.bad_request("Invalid API Key"), status: :bad_request
    else
      render json: FavoriteSerializer.new(user.favorites)
    end
  end

  def create
    user = User.find_by(api_key: params[:api_key])
    if user.nil?
      render json: ErrorSerializer.bad_request("Invalid API Key"), status: :bad_request
    else
      favorite = user.favorites.new(favorite_params)
      if favorite.save
        render json: FavoriteSerializer.success, status: :created
      else 
        render json: ErrorSerializer.bad_request(favorite.errors.full_messages), status: :bad_request
      end
    end
  end

  private
    
    def favorite_params
      params.require(:favorite).permit(:country, :recipe_link, :recipe_title)
    end
end