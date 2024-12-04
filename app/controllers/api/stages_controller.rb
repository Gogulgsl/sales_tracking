module Api
  class StagesController < ApplicationController
    before_action :set_stage, only: [:show, :edit, :update, :destroy]

    # GET /stages
    def index
      @stages = Stage.all
      render json: @stages
    end

    # GET /stages/:id
    def show
    end

    # GET /stages/new
    def new
      @stage = Stage.new
    end

    # POST /stages
    def create
      @stage = Stage.new(stage_params)
      if @stage.save
        redirect_to @stage, notice: 'Stage was successfully created.'
      else
        render :new, status: :unprocessable_entity
      end
    end

    # GET /stages/:id/edit
    def edit
    end

    # PATCH/PUT /stages/:id
    def update
      if @stage.update(stage_params)
        redirect_to @stage, notice: 'Stage was successfully updated.'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    # DELETE /stages/:id
    def destroy
      @stage.destroy
      redirect_to stages_url, notice: 'Stage was successfully destroyed.'
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_stage
      @stage = Stage.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def stage_params
      params.require(:stage).permit(:stage_code, :description)
    end
  end
end
