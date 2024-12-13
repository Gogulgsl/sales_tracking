class ChangeManagerUserIdToNullableInSalesTeams < ActiveRecord::Migration[6.1]
  def change
    change_column_null :sales_teams, :manager_user_id, true
  end
end
