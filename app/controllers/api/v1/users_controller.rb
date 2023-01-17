class Api::V1::UsersController < ApplicationController 
  def create 
    user = User.new(user_params)
    if user.save
      render json: UserSerializer.new(user)
    else
      render json: ErrorSerializer(user.errors.full_messages), status: :bad_request
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :email)
    end
end