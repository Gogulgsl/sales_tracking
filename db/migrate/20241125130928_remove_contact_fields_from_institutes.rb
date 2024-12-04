class RemoveContactFieldsFromInstitutes < ActiveRecord::Migration[6.1]
  def change
    # Remove the contact_name and mobile columns from institutes table
    remove_column :institutes, :institute_contact_no
    remove_column :institutes, :name_of_influencer_decision_maker
  end
end
