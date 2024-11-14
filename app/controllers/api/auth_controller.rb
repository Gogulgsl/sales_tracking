class Api::AuthController < ApplicationController
  require 'jwt'

  def login
    user = User.find_by(username: params[:username])
    if user&.authenticate(params[:password])
      token = encode_token({ user_id: user.id })
      render json: { token: token, message: 'Login successful' }, status: :ok
    else
      render json: { error: 'Invalid username or password' }, status: :unauthorized
    end
  end

  private

  # Encoding JWT token with user payload
  def encode_token(payload)
    JWT.encode(payload, Rails.application.secret_key_base, 'HS256')
  end

  # Exclude 'designation' from user_params but ensure it is passed explicitly
  def user_params
  params.require(:user).permit(:username, :password, :email_id, :mobile_number, :reporting_manager_id, city_ids: [], zone_ids: [])
  end
end

