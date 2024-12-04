class AddUserIdAsForeignKey < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :sales_teams, :users, column: :user_id
  end
end
