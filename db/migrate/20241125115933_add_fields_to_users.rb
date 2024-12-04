class AddFieldsToUsers < ActiveRecord::Migration[6.1]
   def change
    add_column :users, :createdby_user_id, :bigint
    add_column :users, :updatedby_user_id, :bigint
    
    add_index :users, :createdby_user_id
    add_index :users, :updatedby_user_id
  end
end
