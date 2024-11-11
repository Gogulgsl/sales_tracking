class CreateInstitutes < ActiveRecord::Migration[6.1]
  def change
    create_table :institutes do |t|
      t.string :name_of_head_of_institution
      t.string :institute_contact_no
      t.string :institute_email_id
      t.integer :number_of_schools_in_group
      t.string :name_of_influencer_decision_maker
      t.string :designation

      t.timestamps
    end
  end
end
