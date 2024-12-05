class Api::SchoolsController < ApplicationController
  before_action :set_school, only: [:show, :update, :destroy]

  # GET /api/schools
  def index
    schools = School.all
    render json: schools
  end

  # GET /api/schools/:id
  def show
    render json: @school
  end

  # POST /api/schools
  def create
    school = School.new(school_params)
    if school.save
      render json: school, status: :created
    else
      render json: school.errors, status: :unprocessable_entity
    end
  end

  # PUT /api/schools/:id
  def update
    if @school.update(school_params)
      render json: @school
    else
      render json: @school.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/schools/:id
  def destroy
    @school.destroy
    head :no_content
  end

  # POST /api/schools/upload
def upload
  # Ensure the file parameter is present
  if params[:file].nil?
    render json: { error: 'No file provided in the request.' }, status: :unprocessable_entity
    return
  end

  # Check if the file is of the correct content type
  unless params[:file].content_type.in?(["application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", "application/vnd.ms-excel"])
    render json: { error: "Invalid file type. Please upload an Excel file." }, status: :unprocessable_entity
    return
  end

  # Log details about the uploaded file for debugging
  Rails.logger.info "File uploaded: #{params[:file].inspect}"

  begin
    file = params[:file]
    
    # Log file details
    Rails.logger.info "Original filename: #{file.original_filename}"
    Rails.logger.info "Content type: #{file.content_type}"
    Rails.logger.info "Temp file path: #{file.tempfile.path}"

    # Process the file with Roo
    spreadsheet = Roo::Spreadsheet.open(file.tempfile.path)
    header = spreadsheet.row(1)

    # Iterate over rows to create school records
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      School.create!(
        name: row['name'],
        lead_source: row['lead_source'],
        location: row['location'],
        city: row['city'],
        state: row['state'],
        pincode: row['pincode'],
        number_of_students: row['number_of_students'],
        avg_fees: row['avg_fees'],
        board: row['board'],
        website: row['website'],
        part_of_group_school: row['part_of_group_school'],
        institute_id: row['institute_id']
      )
    end

    render json: { message: 'Schools uploaded successfully' }, status: :ok
  rescue StandardError => e
    # Catch any errors and log them
    Rails.logger.error "Error processing file: #{e.message}"
    render json: { error: "Error processing file: #{e.message}" }, status: :unprocessable_entity
  end
end





  private

  def set_school
    @school = School.find(params[:id])
  end

  def school_params
    params.require(:school).permit(
      :name,
      :lead_source,
      :location,
      :city,
      :state,
      :pincode,
      :number_of_students,
      :avg_fees,
      :board,
      :website,
      :part_of_group_school,
      :institute_id,
      :lalitude, 
      :longitude,
      :is_active
    )
  end
end
