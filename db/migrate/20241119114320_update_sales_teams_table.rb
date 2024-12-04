class UpdateSalesTeamsTable < ActiveRecord::Migration[6.1]
  def change
    # Rename sales_user_id to user_id
    rename_column :sales_teams, :sales_user_id, :user_id

    # Make manager_id nullable
    change_column_null :sales_teams, :manager_id, true

    # Add unique index to user_id
    add_index :sales_teams, :user_id, unique: true

    # Add foreign keys
    add_foreign_key :sales_teams, :users, column: :user_id
    add_foreign_key :sales_teams, :users, column: :manager_id
  end
end
