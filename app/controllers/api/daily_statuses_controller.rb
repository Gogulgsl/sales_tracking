# app/controllers/api/daily_statuses_controller.rb
module Api
  class DailyStatusesController < ApplicationController
    before_action :set_daily_status, only: [:show, :update, :destroy]

    # GET /api/daily_statuses
    def index
      @daily_statuses = DailyStatus.all
      render json: @daily_statuses
    end

    # GET /api/daily_statuses/:id
    def show
      render json: @daily_status
    end

    # POST /api/daily_statuses
    def create
      @daily_status = DailyStatus.new(daily_status_params)
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

    def set_daily_status
      @daily_status = DailyStatus.find(params[:id])
    end

    def daily_status_params
      params.require(:daily_status).permit(
        :sales_team_id, 
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
