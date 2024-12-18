# # app/controllers/api/users_controller.rb
# class Api::UsersController < ApplicationController
 
#   def index
#     users = User.all
#     render json: users
#   end

#   def show
#     user = User.find(params[:id])
#     render json: user
#   end

#   def create
#     user = User.new(user_params)
#     if user.save
#       # Create a SalesTeam entry if the user's role is relevant
#       SalesTeam.create(user_id: user.id, manager_id: user.id) 
#       render json: user, status: :created
#     else
#       render json: user.errors, status: :unprocessable_entity
#     end
#   end

#   def update
#     user = User.find(params[:id])
#     if user.update(user_params)
#       render json: user
#     else
#       render json: user.errors, status: :unprocessable_entity
#     end
#   end

#   def destroy
#     user = User.find(params[:id])
#     user.destroy
#     head :no_content
#   end

#   private

#   def user_params
#     params.require(:user).permit(
#       :username, :password, :role
#     )
#   end
# end



class Api::UsersController < ApplicationController
  def index
    users = User.includes(:manager_user).all

    users_data = users.map do |user|
      user_data = user.as_json

      if user.role == 'sales_executive' && user.manager_user
        # Include manager details in the user response
        user_data[:manager_user] = user.manager_user.as_json(only: [:id, :username, :role]) # You can choose which fields to show
      end

      user_data
    end

    render json: users_data
  end

  def show
    user = User.find(params[:id])
    render json: user
  end

 def create
    user = User.new(user_params)
    
    if user.save
      # Set manager_user_id to nil for admin users
      manager_user_id = user.role == 'admin' ? nil : user.reporting_manager_id
      
      # Create the SalesTeam with the correct manager_user_id
      sales_team = SalesTeam.create(
        user_id: user.id,
        manager_user_id: manager_user_id, # This will be nil for admin users
        createdby_user_id: current_user&.id
      )

      if sales_team.persisted?
        Rails.logger.debug "SalesTeam created successfully: #{sales_team.inspect}"
        render json: user, status: :created
      else
        Rails.logger.debug "SalesTeam creation failed: #{sales_team.errors.full_messages}"
        render json: sales_team.errors, status: :unprocessable_entity
      end
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  def reporting_managers
    admin_and_manager_users = User.where(role: ['admin', 'manager'])

    render json: admin_and_manager_users.as_json(only: [:id, :username, :role, :created_at, :updated_at])
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
    params.require(:user).permit(:username, :password, :role, :reporting_manager_id, :email_id, :mobile_number, :is_active)
  end
end