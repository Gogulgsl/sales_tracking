class Api::SchoolsController < ApplicationController
  before_action :set_school, only: [:show, :update, :destroy]

  # GET /api/schools
  def index
    schools = School.all
    render json: schools
  end

  # GET /api/schools/:id
  def show
    render json: @school
  end

  # POST /api/schools
  def create
    school = School.new(school_params)
    if school.save
      render json: school, status: :created
    else
      render json: school.errors, status: :unprocessable_entity
    end
  end

  # PUT /api/schools/:id
  def update
    if @school.update(school_params)
      render json: @school
    else
      render json: @school.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/schools/:id
  def destroy
    @school.destroy
    head :no_content
  end

  private

  def set_school
    @school = School.find(params[:id])
  end

  def school_params
    params.require(:school).permit(
      :name,
      :lead_source,
      :location,
      :city,
      :state,
      :pincode,
      :number_of_students,
      :avg_fees,
      :board,
      :website,
      :part_of_group_school,
      :institute_id
    )
  end
end
