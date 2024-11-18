class Api::DashboardsController < ApplicationController
  before_action :authorize_request

  # GET /api/dashboard
  def index
    case current_user.role
    when 'sales_executive'
      # Filter opportunities and daily statuses for the specific user
      sales_team_ids = SalesTeam.where(user_id: current_user.id).pluck(:id)
      opportunities = Opportunity.where(sales_team_id: sales_team_ids)
      daily_statuses = DailyStatus.where(sales_team_id: sales_team_ids)

    when 'manager'
      # Managers see all opportunities and daily statuses for their team
      team_ids = SalesTeam.where(manager_id: current_user.id).pluck(:id)
      opportunities = Opportunity.where(sales_team_id: team_ids)
      daily_statuses = DailyStatus.where(sales_team_id: team_ids)

    when 'admin'
      # Admin sees all opportunities and daily statuses
      opportunities = Opportunity.all
      daily_statuses = DailyStatus.all

    else
      # Handle unexpected roles
      render json: { error: 'Unauthorized role' }, status: :forbidden and return
    end

    # Render the filtered data
    render json: {
      role: current_user.role,
      opportunities: opportunities,
      daily_statuses: daily_statuses
    }, status: :ok
  end

  private

  # Ensure the user is authorized
  def authorize_request
    render json: { error: 'Unauthorized' }, status: :unauthorized unless current_user
  end
end
