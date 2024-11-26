class Api::MasterDataController < ApplicationController
  before_action :authorize_request, only: [:create, :update] 
  before_action :set_master_data, only: [:show, :update, :destroy]

  # GET /api/master_data
  def index
    master_data = MasterData.all
    render json: master_data
  end

  # GET /api/master_data/:id
  def show
    render json: @master_data
  end

  # POST /api/master_data
  def create
    master_data = MasterData.new(master_data_params)
    if master_data.save
      render json: master_data, status: :created
    else
      render json: master_data.errors, status: :unprocessable_entity
    end
  end

  # PUT /api/master_data/:id
  def update
    if @master_data.update(master_data_params)
      render json: @master_data
    else
      render json: @master_data.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/master_data/:id
  def destroy
    @master_data.destroy
    head :no_content
  end

  private

  def set_master_data
    @master_data = MasterData.find(params[:id])
  end

  def master_data_params
    params.require(:master_data).permit(
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
      :name_of_head_of_institution,
      :institute_contact_no,
      :institute_email_id,
      :number_of_schools_in_group,
      :name_of_influencer_decision_maker,
      :designation,
      :createdby_user_id,
      :updatedby_user_id
    )
  end
end
