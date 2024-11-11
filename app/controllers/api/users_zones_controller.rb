class Api::UsersZonesController < ApplicationController
  def index
    users_zones = UsersZone.all
    render json: users_zones
  end

   def create
    user = User.find(params[:user_id])
    zone = Zone.find(params[:zone_id])
    
    # Create the relationship (this assumes the has_and_belongs_to_many association is set up)
    if user.zones << zone
      render json: { status: :created, message: 'User added to zone successfully' }
    else
      render json: { status: :unprocessable_entity, error: 'Failed to add zone to city' }
    end
  rescue ActiveRecord::RecordNotFound => e
    render json: { status: :not_found, error: e.message }
  end

  def destroy
    users_zone = UsersZone.find_by(users_zone_params)
    users_zone&.destroy
    head :no_content
  end

  private

  def users_zone_params
    params.require(:users_zone).permit(:user_id, :zone_id)
  end
end
