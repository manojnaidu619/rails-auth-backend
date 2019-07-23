class UsersController < ApplicationController

  before_action :authenticate

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: 200
    else
      render json: @user.errors
  end
end

private
  def user_params
    params.require(:user).permit(:email,:password)
  end
end
