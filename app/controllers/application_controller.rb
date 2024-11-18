class ApplicationController < ActionController::API
  require 'jwt'

  private

  # Encode the token with user details
  def encode_token(payload)
    JWT.encode(payload, Rails.application.secret_key_base, 'HS256')
  end

  # Decode the token from the Authorization header
  def decoded_token
    token = request.headers['Authorization']&.split(' ')&.last
    return nil unless token

    JWT.decode(token, Rails.application.secret_key_base, true, algorithm: 'HS256')[0]
  rescue JWT::DecodeError
    nil
  end

  # Fetch the current logged-in user based on the token
  def current_user
    return @current_user if @current_user

    decoded = decoded_token
    @current_user = User.find_by(id: decoded['user_id']) if decoded
  end

  # Ensure the user is authorized
  def authorize_request
    render json: { error: 'Unauthorized' }, status: :unauthorized unless current_user
  end
end
