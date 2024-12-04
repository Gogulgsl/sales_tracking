class AlterSalesTeamsTable < ActiveRecord::Migration[6.1]
  def change
    # Step 1: Remove existing columns
    remove_column :sales_teams, :manager_id, :bigint

    # Step 3: Add new foreign key columns
    add_column :sales_teams, :createdby_user_id, :bigint                      
    add_column :sales_teams, :updatedby_user_id, :bigint                      
    add_column :sales_teams, :manager_user_id, :bigint                        

    # Step 4: Add foreign key constraints
    add_foreign_key :sales_teams, :users, column: :createdby_user_id          
    add_foreign_key :sales_teams, :users, column: :updatedby_user_id          
    add_foreign_key :sales_teams, :users, column: :manager_user_id            

    add_index :sales_teams, :createdby_user_id
    add_index :sales_teams, :updatedby_user_id
    add_index :sales_teams, :manager_user_id
  end
end
