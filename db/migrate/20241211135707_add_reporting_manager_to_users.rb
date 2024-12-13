class AddReportingManagerToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :reporting_manager_id, :bigint
  end
end
