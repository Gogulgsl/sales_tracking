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

  def register
    # Debugging to check the parameters being passed
    Rails.logger.debug "Received Params: #{params.inspect}"

    user = User.new(user_params)

    if user.save
      create_sales_team_entry(user)
      render json: user, status: :created
    else
      render json: user.errors, status: :unprocessable_entity
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

 def create_sales_team_entry(user)
  designation = params[:user][:designation]  # Get designation directly from the params
  if designation.present?
    SalesTeam.create!(
      user_id: user.id,  # Use user's ID for user_id
      designation: designation,  # Insert designation into SalesTeam
      manager_id: user.reporting_manager_id
    )
  end
end


end
