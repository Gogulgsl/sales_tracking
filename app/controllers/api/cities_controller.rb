class Api::CitiesController < ApplicationController
  def index
    cities = City.all
    render json: cities
  end

  def show
    city = City.find(params[:id])
    render json: city
  end

  def create
    city = City.new(city_params)
    if city.save
      render json: city, status: :created
    else
      render json: city.errors, status: :unprocessable_entity
    end
  end

  def update
    city = City.find(params[:id])
    if city.update(city_params)
      render json: city
    else
      render json: city.errors, status: :unprocessable_entity
    end
  end

  def destroy
    city = City.find(params[:id])
    city.destroy
    head :no_content
  end

  private

  def city_params
    params.require(:city).permit(:name, :zone_id)
  end
end
