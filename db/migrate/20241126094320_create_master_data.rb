class CreateMasterData < ActiveRecord::Migration[6.1]
  def change
    create_table :master_data do |t|
      t.string "name"
      t.string "lead_source"
      t.string "location"
      t.string "city"
      t.string "state"
      t.string "pincode"
      t.integer "number_of_students"
      t.decimal "avg_fees", precision: 10, scale: 2
      t.string "board"
      t.string "website"
      t.boolean "part_of_group_school"
      t.string "name_of_head_of_institution"
      t.string "institute_contact_no"
      t.string "institute_email_id"
      t.integer "number_of_schools_in_group"
      t.string "name_of_influencer_decision_maker"
      t.string "designation"
      t.bigint "createdby_user_id"
      t.bigint "updatedby_user_id"
      t.timestamps
    end
  end
end
