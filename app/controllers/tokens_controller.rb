class TokensController < ApplicationController
  before_action :authenticate

  def create
    @user = User.find_by(email: params[:email])
      if @user and @user.authenticate(params[:password])
        @token = generate_token(@user)
        @user = current_user(@token)
        render json: {
          jwt: @token,
          email: @user.email
        }
      else
        render json: {
          error: "Invalid username/password",
          status: 400
        }
      end
  end

  def testing
  #  @token = access_token
    random_integer = rand(1..100)
    render json: {
      integer: random_integer
    }
  #  logger.info JWT.decode @token,Rails.application.secrets.secret_key_base, true, {algorithm: 'HS256'}

    #render json: {
    #  integer: random_integer,
    #  user: current_user.email
    #}
  end

end
