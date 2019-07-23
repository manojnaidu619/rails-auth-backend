class TokensController < ApplicationController
  before_action :auth_user                        # auth_user is similar to current_user

  def create
    @user = User.find_by(email: params[:email])
      if @user and @user.authenticate(params[:password])
        @token = generate_token(@user)
        render json: {
          jwt: @token
        }
      else
        render json: {
          error: "Invalid username/password",
          status: 400
        }
      end
  end

  def testing
    random_integer = rand(1..100)
    render json: {
      integer: random_integer
    }
  end

end
