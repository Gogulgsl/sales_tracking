class AddOpportunityNameInOpportunities < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :opportunities, :sales_teams, column: :user_id, primary_key: :user_id
    add_column :opportunities, :opportunity_name, :string
  end
end
