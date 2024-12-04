class RemoveDesignationFromSalesTeams < ActiveRecord::Migration[6.1]
  def change
    remove_column :sales_teams, :designation, :string
  end
end
