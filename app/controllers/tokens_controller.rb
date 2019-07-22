class TokensController < ApplicationController

  def create
    @user = User.find_by(email: params[:email])
      if @user and @user.authenticate(params[:password])
        render json: {
          jwt: encode_token({id: @user.id, email: @user.email})
        }
      else
        head :not_found, status: :bad_request
      end
  end

  private
   def encode_token(payload)
     exp = 86400
     payload[:exp] = exp.to_i
     JWT.encode(payload, Rails.application.secrets.secret_key_base)
   end
end
