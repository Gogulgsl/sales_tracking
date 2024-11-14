class Api::OpportunitiesController < ApplicationController
  before_action :set_opportunity, only: [:show, :update, :destroy, :assign_sales_team]

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

  # POST /api/opportunities/:id/assign_sales_team
  def assign_sales_team
    sales_team = SalesTeam.find(params[:sales_team_id])
    
    if @opportunity.update(sales_team: sales_team)
      render json: { message: "Opportunity assigned to sales team successfully", opportunity: @opportunity }, status: :ok
    else
      render json: @opportunity.errors, status: :unprocessable_entity
    end
  end

  private

  def set_opportunity
    @opportunity = Opportunity.find(params[:id])
  end

  def opportunity_params
    params.require(:opportunity).permit(:school_id, :product_id, :start_date, :contact_person, :sales_team_id)
  end
end
