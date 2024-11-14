class AddSalesTeamToOpportunities < ActiveRecord::Migration[6.1]
  def change
    add_column :opportunities, :sales_team_id, :bigint
    add_foreign_key :opportunities, :sales_teams
    add_index :opportunities, :sales_team_id
  end
end
