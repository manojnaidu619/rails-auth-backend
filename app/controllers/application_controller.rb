class ApplicationController < ActionController::API

  def authenticate
    @token = request.headers['Authorization']
    @token.nil? ? (logger.info 'No value' ) : (logger.info @token)
  end

  def generate_token(user)
    payload = {user_id: user.id, exp: (2.hours.from_now).to_i, email: user.email}
    return JWT.encode payload, Rails.application.secrets.secret_key_base, 'HS256'
  end

  def current_user(token)
    @token = token
    dtoken = JWT.decode @token,Rails.application.secrets.secret_key_base, true, {algorithm: 'HS256'}
    uid = dtoken[0]['user_id']
    return User.find_by(id: uid)
  end
end
