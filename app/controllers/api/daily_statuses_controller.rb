module Api
  class DailyStatusesController < ApplicationController
    before_action :authorize_request
    # before_action :set_daily_status, only: [:show, :update, :destroy]

    def index
      @daily_statuses = DailyStatus.includes(:opportunity).all
      render json: @daily_statuses.as_json(include: :opportunity)
    end

    # GET /api/daily_statuses
    def my_daily_statuses
      @daily_statuses = DailyStatus
                        .joins("INNER JOIN sales_teams ON sales_teams.sales_user_id = daily_statuses.sales_user_id")
                        .where(sales_teams: { sales_user_id: current_user.id })
                        .includes(:opportunity)

      render json: @daily_statuses.as_json(include: :opportunity)
    end

    # GET /api/daily_statuses/:id
    def show
      render json: @daily_status
    end

    # POST /api/daily_statuses
    def create
      @daily_status = DailyStatus.new(daily_status_params.merge(sales_user_id: current_user.id))
      if @daily_status.save
        render json: @daily_status, status: :created
      else
        render json: @daily_status.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /api/daily_statuses/:id
    def update
      if @daily_status.update(daily_status_params)
        render json: @daily_status
      else
        render json: @daily_status.errors, status: :unprocessable_entity
      end
    end

    # DELETE /api/daily_statuses/:id
    def destroy
      @daily_status.destroy
      head :no_content
    end

    private

    # Fetch only statuses linked to the current user
    # def set_daily_status
    #   @daily_status = DailyStatus
    #                   .joins(:sales_user)
    #                   .where(sales_users: { sales_user_id: current_user.id })
    #                   .find_by(id: params[:id])

    #   render json: { error: 'Daily status not found' }, status: :not_found unless @daily_status
    # end

    def daily_status_params
      params.require(:daily_status).permit(
        :sales_user_id,
        :opportunity_id, 
        :decision_maker, 
        :follow_up, 
        :persons_met, 
        :designation, 
        :mail_id, 
        :mobile_number, 
        :discussion_point, 
        :next_steps, 
        :stage
      )
    end
  end
end
