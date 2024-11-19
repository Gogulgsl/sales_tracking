class UpdateSalesTeamAndOpportunitiesColumns < ActiveRecord::Migration[6.1]
  def change
    # Step 1: Rename the `user_id` column in `sales_teams` to `sales_user_id`
    rename_column :sales_teams, :user_id, :sales_user_id

    # Step 2: Rename the `sales_team_id` column in `opportunities` to `sales_user_id`
    rename_column :opportunities, :sales_team_id, :sales_user_id

    # Step 3: Update the foreign key in `opportunities` to reference the new column in `sales_teams`
    remove_foreign_key :opportunities, :sales_teams
    add_foreign_key :opportunities, :sales_teams, column: :sales_user_id
  end
end
