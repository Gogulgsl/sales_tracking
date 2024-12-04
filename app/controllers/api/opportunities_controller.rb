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

  def my_opportunities
    sales_team = SalesTeam.find_by(user_id: current_user.id) 

    if sales_team.present?
      opportunities = Opportunity.includes(:product, :school)
                                 .where(user_id: sales_team.user_id) 

      render json: opportunities.as_json(include: [:product, :school]), status: :ok
    else
      render json: { error: 'No opportunities found for the user' }, status: :not_found
    end
  end



  # POST /api/opportunities
  def create
    # Find the SalesTeam using the user_id from the opportunity parameters
    sales_team = SalesTeam.find_by(user_id: opportunity_params[:user_id])
    
    if sales_team.nil?
      render json: { error: 'Sales team must exist for the specified user' }, status: :unprocessable_entity
    else
      opportunity = Opportunity.new(opportunity_params)
      opportunity.sales_team = sales_team  # Associate the SalesTeam to the Opportunity

      if opportunity.save
        render json: opportunity.as_json(include: [:product, :school]), status: :created
      else
        render json: opportunity.errors, status: :unprocessable_entity
      end
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
    params.require(:opportunity).permit(:school_id, :product_id, :start_date, :contact_person, :user_id)
  end

  # Ensure the request has a valid Authorization header
  def authorize_user
    render json: { error: 'Unauthorized' }, status: :unauthorized unless request.headers['Authorization'].present?
  end
end
