class Api::CitiesUsersController < ApplicationController
  def index
    cities_users = CitiesUser.all
    render json: cities_users
  end

  def create
    user = User.find(params[:user_id])
    city = City.find(params[:city_id])
    
    # Create the relationship (this assumes the has_and_belongs_to_many association is set up)
    if user.cities << city
      render json: { status: :created, message: 'User added to city successfully' }
    else
      render json: { status: :unprocessable_entity, error: 'Failed to add user to city' }
    end
  rescue ActiveRecord::RecordNotFound => e
    render json: { status: :not_found, error: e.message }
  end


  def destroy
    cities_user = CitiesUser.find_by(cities_user_params)
    cities_user&.destroy
    head :no_content
  end

  private

  def cities_user_params
    params.require(:cities_user).permit(:user_id, :city_id)
  end
end


