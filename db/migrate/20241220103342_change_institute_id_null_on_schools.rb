class ChangeInstituteIdNullOnSchools < ActiveRecord::Migration[6.1]
  def change
    change_column_null :schools, :institute_id, true
  end
end
