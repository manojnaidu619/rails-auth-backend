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
