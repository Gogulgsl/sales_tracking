class ChangeSalesTeamIdToUserId < ActiveRecord::Migration[6.1]
  def change
    rename_column :sales_teams, :sales_team_id, :user_id
  end
end
