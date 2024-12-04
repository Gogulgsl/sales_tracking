module Api
  class DailyStatusesController < ApplicationController
    before_action :authorize_request
    before_action :set_daily_status, only: [:show, :edit, :update, :destroy]

    # GET /daily_statuses
    def index
      @daily_statuses = DailyStatus.includes(:decision_maker_contact, :person_met_contact)

      render json: @daily_statuses.as_json(
        include: {
          decision_maker_contact: { only: [:id, :contact_name, :mobile, :decision_maker] },
          person_met_contact: { only: [:id, :contact_name, :mobile, :decision_maker] }
        }
      )
    end

    def show
    end

    # GET /daily_statuses/new
    def new
      @daily_status = DailyStatus.new
    end

    # POST /daily_statuses
    def create
      @daily_status = DailyStatus.new(daily_status_params)

      if @daily_status.save
        redirect_to @daily_status, notice: 'Daily status was successfully created.'
      else
        render :new
      end
    end

    # GET /daily_statuses/:id/edit
    def edit
    end

    # PATCH/PUT /daily_statuses/:id
    def update
      if @daily_status.update(daily_status_params)
        render json: @daily_status, status: :ok
      else
        render json: { error: 'Failed to update daily status', details: @daily_status.errors }, status: :unprocessable_entity
      end
    end

    # DELETE /daily_statuses/:id
    def destroy
      @daily_status.destroy
      redirect_to daily_statuses_url, notice: 'Daily status was successfully deleted.'
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_daily_status
      @daily_status = DailyStatus.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def daily_status_params
      params.require(:daily_status).permit(
        :user_id, :opportunity_id, :follow_up, :designation, :mail_id,
        :discussion_point, :next_steps, :stage, :decision_maker_contact_id,
        :person_met_contact_id, :school_id, :createdby_user_id, :updatedby_user_id
      )
    end
  end
end
