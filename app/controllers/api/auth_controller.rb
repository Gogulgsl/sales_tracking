# app/controllers/api/auth_controller.rb
class Api::AuthController < ApplicationController
  require 'jwt'

  def login
    user = User.find_by(username: params[:username])
    if user&.authenticate(params[:password])
      token = encode_token({ user_id: user.id })

      render json: { token: token, role: user.role, message: 'Login successful' }, status: :ok
    else
      render json: { error: 'Invalid username or password' }, status: :unauthorized
    end
  end
end
