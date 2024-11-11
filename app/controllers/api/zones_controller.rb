class Api::ZonesController < ApplicationController
  def index
    zones = Zone.all
    render json: zones
  end

  def show
    zone = Zone.find(params[:id])
    render json: zone
  end

  def create
    zone = Zone.new(zone_params)
    if zone.save
      render json: zone, status: :created
    else
      render json: zone.errors, status: :unprocessable_entity
    end
  end

  def update
    zone = Zone.find(params[:id])
    if zone.update(zone_params)
      render json: zone
    else
      render json: zone.errors, status: :unprocessable_entity
    end
  end

  def destroy
    zone = Zone.find(params[:id])
    zone.destroy
    head :no_content
  end

  private

  def zone_params
    params.require(:zone).permit(:name)
  end
end
