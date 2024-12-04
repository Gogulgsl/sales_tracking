class AlterOpportunitiesTable < ActiveRecord::Migration[6.0]
  def change
    # Add new columns
    add_column :opportunities, :createdby_user_id, :bigint
    add_column :opportunities, :updatedby_user_id, :bigint
    add_column :opportunities, :last_stage, :string
    add_column :opportunities, :contact_id, :bigint

    # Remove the contact_person column
    remove_column :opportunities, :contact_person, :string
    remove_foreign_key :opportunities, column: :user_id

    # Add foreign key constraints for the new columns
    add_foreign_key :opportunities, :users, column: :createdby_user_id
    add_foreign_key :opportunities, :users, column: :updatedby_user_id
    add_foreign_key :opportunities, :contacts, column: :contact_id
    add_foreign_key :opportunities, :products, column: :product_id
    add_foreign_key :opportunities, :schools, column: :school_id
    add_foreign_key :opportunities, :users, column: :user_id
  end
end
