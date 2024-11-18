# app/controllers/api/opportunities_controller.rb
class Api::OpportunitiesController < ApplicationController
  before_action :authorize_user, except: [:index, :show]
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

  # GET /api/opportunities/my_opportunities
 def my_opportunities
    sales_team_ids = SalesTeam.where(user_id: current_user.id).pluck(:id)

    if sales_team_ids.present?
      opportunities = Opportunity.where(sales_team_id: sales_team_ids)
      render json: opportunities, status: :ok
    else
      render json: { error: 'No opportunities found for the user' }, status: :not_found
    end
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

  # Fetch opportunity by ID
  def set_opportunity
    @opportunity = Opportunity.find(params[:id])
  end

  # Permit opportunity parameters
  def opportunity_params
    params.require(:opportunity).permit(:school_id, :product_id, :start_date, :contact_person, :sales_team_id)
  end

  # Decode JWT token to extract user ID
  def decoded_token
    token = request.headers['Authorization']&.split(' ')&.last
    JWT.decode(token, Rails.application.secret_key_base, true, algorithm: 'HS256')[0]
  end

  # Ensure the request has a valid Authorization header
  def authorize_user
    render json: { error: 'Unauthorized' }, status: :unauthorized unless request.headers['Authorization'].present?
  end
end
