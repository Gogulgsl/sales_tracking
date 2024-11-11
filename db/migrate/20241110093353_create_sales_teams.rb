class CreateSalesTeams < ActiveRecord::Migration[6.1]
  def change
    create_table :sales_teams do |t|
      t.bigint :sales_team_id, null: false
      t.string :designation, null: false
      t.bigint :manager_id, null: false

      t.timestamps
    end

    # Add foreign keys for sales_team_id and manager_id
    add_foreign_key :sales_teams, :users, column: :sales_team_id
    add_foreign_key :sales_teams, :users, column: :manager_id
  end
end
