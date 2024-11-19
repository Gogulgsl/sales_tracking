class RenameSalesTeamIdToSalesUserIdInDailyStatuses < ActiveRecord::Migration[6.1]
 def change
    rename_column :daily_statuses, :sales_team_id, :sales_user_id
    add_foreign_key :daily_statuses, :sales_teams, column: :sales_user_id
  end
end
