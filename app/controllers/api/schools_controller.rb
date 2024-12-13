class Api::SchoolsController < ApplicationController
  before_action :set_school, only: %i[show update destroy contacts]
  before_action :authorize_user, except: [:index, :show, :my_opportunities, :active_schools]
  before_action -> { authorize_role('admin', 'sales_executive') }, only: [:index]


  # GET /api/schools
  def index
    if current_user.nil?
      return render json: { error: 'Unauthorized - No current user' }, status: :unauthorized
    end

    if current_user.role == 'admin'
      # Admin can see all schools
      schools = School.includes(:institute, :contacts).all
    elsif current_user.role == 'sales_executive'
      # Sales executive can only see active schools
      schools = School.includes(:institute, :contacts).where(is_active: true)
    else
      # Default case: If role is not recognized, return an empty list or raise an error
      schools = []
    end

    render json: schools, include: { institute: { only: [:name_of_head_of_institution, :institute_email_id, :designation] }, contacts: { only: [:contact_name, :mobile, :decision_maker] } }
  end



  def active_schools
    schools = School.where(is_active: true)
    render json: schools
  end

  # GET /api/schools/:id
  def show
    render json: @school
  end

  def create
  ActiveRecord::Base.transaction do
    # Create or find the associated Institute
    institute = find_or_create_institute(params[:school][:institute])

    # Create the School with the found or created Institute ID
    school = School.new(school_params.merge(institute_id: institute.id))

    if school.save
      # Iterate through the contacts and create each contact associated with the school
      contacts = []
      params[:school][:contacts].each do |contact_params|
        contact = find_or_create_contact(contact_params, school.id)
        contacts << contact
      end

      render json: { school: school, contacts: contacts }, status: :created
    else
      render json: { errors: school.errors.full_messages }, status: :unprocessable_entity
      raise ActiveRecord::Rollback
    end
  end
rescue ActiveRecord::RecordInvalid => e
  render json: { error: e.message }, status: :unprocessable_entity
rescue StandardError => e
  render json: { error: "An unexpected error occurred: #{e.message}" }, status: :internal_server_error
end


  # GET /api/schools/:id/contacts
  def contacts
    contacts = @school.contacts.select(:id, :contact_name, :mobile, :decision_maker)

    if contacts.any?
      render json: contacts, status: :ok
    else
      render json: { message: 'No contacts found for this school' }, status: :not_found
    end
  end

  # PUT /api/schools/:id
  def update
    if @school.update(school_params)
      render json: @school
    else
      render json: { errors: @school.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /api/schools/:id
  def destroy
    @school.destroy
    head :no_content
  end

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
    # Rails.logger.info "File uploaded: #{params[:file].inspect}"

    begin
      file = params[:file]
      
      # Log file details
      # Rails.logger.info "Original filename: #{file.original_filename}"
      # Rails.logger.info "Content type: #{file.content_type}"
      # Rails.logger.info "Temp file path: #{file.tempfile.path}"

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
      # Rails.logger.error "Error processing file: #{e.message}"
      render json: { error: "Error processing file: #{e.message}" }, status: :unprocessable_entity
    end
  end

  private

  # Helper to find or create an Institute
  def find_or_create_institute(institute_params)
    institute = Institute.find_by(institute_email_id: institute_params[:institute_email_id])
    unless institute
      institute = Institute.create!(
        name_of_head_of_institution: institute_params[:name_of_head_of_institution],
        institute_email_id: institute_params[:institute_email_id],
        number_of_schools_in_group: institute_params[:number_of_schools_in_group],
        designation: institute_params[:designation]
      )
    end
    institute
  end

  # Helper to find or create a Contact
  def find_or_create_contact(contact_params, school_id)
    contact = Contact.find_by(mobile: contact_params[:mobile])
    unless contact
      contact = Contact.create!(
        contact_name: contact_params[:contact_name],
        mobile: contact_params[:mobile],
        decision_maker: contact_params[:decision_maker],
        school_id: school_id
      )
    end
    contact
  end

  # Callback to set School object
  def set_school
    @school = School.find_by(id: params[:id])
    render json: { error: 'School not found' }, status: :not_found unless @school
  end

  # Strong parameters for School
  def school_params
    params.require(:school).permit(
      :name, :lead_source, :location, :city, :state, :pincode,
      :number_of_students, :avg_fees, :board, :website,
      :part_of_group_school, :latitude, :longitude, :is_active
    )
  end

  def current_user
    return @current_user if @current_user

    decoded = decoded_token
    if decoded
      @current_user = User.find_by(id: decoded['user_id'])
      Rails.logger.debug("Current User: #{@current_user.inspect}")
    end
    @current_user
  end


  def authorize_user
    render json: { error: 'Unauthorized' }, status: :unauthorized unless current_user
  end
end




