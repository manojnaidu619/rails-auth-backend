class TokensController < ApplicationController

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

  private
   def generate_token(user)
     payload = {user_id: user.id}
     return JWT.encode payload, Rails.application.secrets.secret_key_base, 'HS256'
   end
   
end
