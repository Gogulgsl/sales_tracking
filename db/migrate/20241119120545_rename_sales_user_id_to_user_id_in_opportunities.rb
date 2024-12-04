class RenameSalesUserIdToUserIdInOpportunities < ActiveRecord::Migration[6.1]
  def change
    rename_column :opportunities, :sales_user_id, :user_id
  end
end
