class AddFieldsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :designation, :string
    add_column :users, :mobile_number, :string
    add_column :users, :email_id, :string 
    add_column :users, :reporting_manager_id, :bigint
    add_foreign_key :users, :users, column: :reporting_manager_id
    add_index :users, :email_id, unique: true
  end
end
