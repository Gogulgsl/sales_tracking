class AddForeignKeysToSchools < ActiveRecord::Migration[6.0]
  def change
    # Step 1: Add new foreign key columns
    add_column :schools, :createdby_user_id, :bigint
    add_column :schools, :updatedby_user_id, :bigint

    # Step 2: Add foreign key constraints
    add_foreign_key :schools, :users, column: :createdby_user_id
    add_foreign_key :schools, :users, column: :updatedby_user_id
    add_foreign_key :schools, :institutes, column: :institute_id

    # Step 3: Add indexes for foreign key columns (optional but recommended for performance)
    add_index :schools, :createdby_user_id
    add_index :schools, :updatedby_user_id
  end
end
