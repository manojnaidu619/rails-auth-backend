class ApplicationController < ActionController::API

  def auth_user
    @token = request.headers['Authorization']
    logger.info @token
    if @token.nil?
      throw_unauthenticated_error
    else
      dtoken = JWT.decode @token,Rails.application.secrets.secret_key_base, true, {algorithm: 'HS256'}
      uid = dtoken[0]['user_id']
      current_user ||= User.find_by(id: uid)
      return !current_user.nil? ? (current_user) : (throw_unauthenticated_error)
    end
  end

  def generate_token(user)
    payload = {user_id: user.id, exp: (2.hours.from_now).to_i, email: user.email}
    return JWT.encode payload, Rails.application.secrets.secret_key_base, 'HS256'
  end

  def throw_unauthenticated_error
    render json: {
      error: "Missing Token/unregistered User",
      status: 401
    }
  end
end
