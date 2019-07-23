class ApplicationController < ActionController::API

  def auth_user
    @token = request.headers['Authorization']
    if @token.nil?
      render json: {
        error: "Missing Token",
        status: 401
      }
    else
      dtoken = JWT.decode @token,Rails.application.secrets.secret_key_base, true, {algorithm: 'HS256'}
      uid = dtoken[0]['user_id']
      return User.find_by(id: uid)
    end
  end

  def generate_token(user)
    payload = {user_id: user.id, exp: (2.hours.from_now).to_i, email: user.email}
    return JWT.encode payload, Rails.application.secrets.secret_key_base, 'HS256'
  end

end
