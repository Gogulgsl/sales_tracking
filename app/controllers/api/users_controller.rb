# app/controllers/api/users_controller.rb
class Api::UsersController < ApplicationController
 before_action :authorize_admin, only: [:admin_dashboard]
 
  def index
    users = User.all
    render json: users
  end

  def show
    user = User.find(params[:id])
    render json: user
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: user, status: :created
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  def update
    user = User.find(params[:id])
    if user.update(user_params)
      render json: user
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    head :no_content
  end

  private

  def user_params
    params.require(:user).permit(
      :username, :password, :email_id, :mobile_number,
      :reporting_manager_id, :role
    )
  end

  def authorize_admin
    current_user = decode_token
    unless current_user&.admin?
      render json: { error: 'Forbidden: Admin access required' }, status: :forbidden
    end
  end

  def decode_token
    token = request.headers['Authorization']&.split(' ')&.last
    decoded = JWT.decode(token, Rails.application.secret_key_base, true, algorithm: 'HS256')[0]
    User.find(decoded['user_id'])
  rescue JWT::DecodeError
    nil
  end
end
