class CreateContactsAndUpdateInstitutes < ActiveRecord::Migration[6.0]
  def change
    # Step 1: Create the contacts table
    create_table :contacts, force: :cascade do |t|
      t.string :contact_name
      t.string :mobile
      t.boolean :decision_maker, default: false
      t.bigint :school_id, null: false
      t.bigint :createdby_user_id
      t.bigint :updatedby_user_id
      t.timestamps
    end

    # Step 2: Add foreign key constraints for contacts table
    add_foreign_key :contacts, :schools, column: :school_id
    add_foreign_key :contacts, :users, column: :createdby_user_id
    add_foreign_key :contacts, :users, column: :updatedby_user_id

    # Step 3: Add index for foreign keys
    add_index :contacts, :school_id
    add_index :contacts, :createdby_user_id
    add_index :contacts, :updatedby_user_id

    # Step 4: Update institutes table (if required, e.g. adding reference to contacts)
    # Here, if we need to add a foreign key reference for contact_id in institutes:
    add_column :institutes, :contact_id, :bigint
    add_foreign_key :institutes, :contacts, column: :contact_id
    add_index :institutes, :contact_id
  end
end
