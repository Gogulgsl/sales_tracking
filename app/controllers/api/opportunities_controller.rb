class Api::OpportunitiesController < ApplicationController
  before_action :authorize_user, except: [:index, :show, :my_opportunities]
  before_action :set_opportunity, only: [:show, :update, :destroy, :assign_sales_team]

  # GET /api/opportunities
  def index
    opportunities = Opportunity.includes(:product, :school).all
    render json: opportunities.as_json(include: [:product, :school]), status: :ok
  end

  # GET /api/opportunities/:id
  def show
    render json: @opportunity.as_json(include: [:product, :school]), status: :ok
  end

  # GET /api/opportunities/my_opportunities
  def my_opportunities
    sales_team_ids = SalesTeam.where(user_id: current_user.id).pluck(:id)

    if sales_team_ids.present?
      opportunities = Opportunity.includes(:product, :school)
                                 .where(sales_team_id: sales_team_ids)
      render json: opportunities.as_json(include: [:product, :school]), status: :ok
    else
      render json: { error: 'No opportunities found for the user' }, status: :not_found
    end
  end

  # POST /api/opportunities
  def create
    opportunity = Opportunity.new(opportunity_params)
    if opportunity.save
      render json: opportunity.as_json(include: [:product, :school]), status: :created
    else
      render json: opportunity.errors, status: :unprocessable_entity
    end
  end

  # PUT /api/opportunities/:id
  def update
    if @opportunity.update(opportunity_params)
      render json: @opportunity.as_json(include: [:product, :school]), status: :ok
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

  # Fetch opportunity by ID
  def set_opportunity
    @opportunity = Opportunity.includes(:product, :school).find(params[:id])
  end

  # Permit opportunity parameters
  def opportunity_params
    params.require(:opportunity).permit(:school_id, :product_id, :start_date, :contact_person, :sales_team_id)
  end

  # Ensure the request has a valid Authorization header
  def authorize_user
    render json: { error: 'Unauthorized' }, status: :unauthorized unless request.headers['Authorization'].present?
  end
end
