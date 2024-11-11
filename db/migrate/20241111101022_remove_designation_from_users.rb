class RemoveDesignationFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :designation, :string
  end
end
