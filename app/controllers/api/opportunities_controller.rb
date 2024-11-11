class Api::OpportunitiesController < ApplicationController
  before_action :set_opportunity, only: [:show, :update, :destroy]

  # GET /api/opportunities
  def index
    opportunities = Opportunity.all
    render json: opportunities
  end

  # GET /api/opportunities/:id
  def show
    render json: @opportunity
  end

  # POST /api/opportunities
  def create
    opportunity = Opportunity.new(opportunity_params)
    if opportunity.save
      render json: opportunity, status: :created
    else
      render json: opportunity.errors, status: :unprocessable_entity
    end
  end

  # PUT /api/opportunities/:id
  def update
    if @opportunity.update(opportunity_params)
      render json: @opportunity
    else
      render json: @opportunity.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/opportunities/:id
  def destroy
    @opportunity.destroy
    head :no_content
  end

  private

  def set_opportunity
    @opportunity = Opportunity.find(params[:id])
  end

  def opportunity_params
    params.require(:opportunity).permit(:school_id, :product_id, :start_date, :contact_person)
  end
end

