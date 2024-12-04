class RenameSalesUserIdToUserIdInDailyStatuses < ActiveRecord::Migration[6.1]
  def change
    rename_column :daily_statuses, :sales_user_id, :user_id
  end
end
