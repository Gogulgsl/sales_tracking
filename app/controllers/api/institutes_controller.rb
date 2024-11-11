class Api::InstitutesController < ApplicationController
	before_action :set_institute, only: [:show, :update, :destroy]

	# GET /api/institutes
	def index
	  institutes = Institute.all
	  render json: institutes
	end

	# GET /api/institutes/:id
	def show
	  render json: @institute
	end

	# POST /api/institutes
	def create
	  institute = Institute.new(institute_params)
	  if institute.save
	    render json: institute, status: :created
	  else
	    render json: institute.errors, status: :unprocessable_entity
	  end
	end

	# PUT /api/institutes/:id
	def update
	  if @institute.update(institute_params)
	    render json: @institute
	  else
	    render json: @institute.errors, status: :unprocessable_entity
	  end
	end

	# DELETE /api/institutes/:id
	def destroy
	  @institute.destroy
	  head :no_content
	end

	private

	def set_institute
	  @institute = Institute.find(params[:id])
	end

	def institute_params
	  params.require(:institute).permit(
	    :name_of_head_of_institution,
	    :institute_contact_no,
	    :institute_email_id,
	    :number_of_schools_in_group,
	    :name_of_influencer_decision_maker,
	    :designation
	  )
	end
end
