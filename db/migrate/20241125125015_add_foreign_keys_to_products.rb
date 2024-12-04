class AddForeignKeysToProducts < ActiveRecord::Migration[6.0]
  def change
    # Step 1: Add new foreign key columns
    add_column :products, :createdby_user_id, :bigint
    add_column :products, :updatedby_user_id, :bigint

    # Step 2: Add foreign key constraints
    add_foreign_key :products, :users, column: :createdby_user_id
    add_foreign_key :products, :users, column: :updatedby_user_id

    # Step 3: Add indexes for foreign key columns (optional but recommended for performance)
    add_index :products, :createdby_user_id
    add_index :products, :updatedby_user_id
  end
end
