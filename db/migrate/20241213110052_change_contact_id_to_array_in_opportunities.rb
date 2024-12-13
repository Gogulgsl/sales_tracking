class ChangeContactIdToArrayInOpportunities < ActiveRecord::Migration[6.1]
  def change
    remove_column :opportunities, :contact_id, :bigint
    add_column :opportunities, :contact_ids, :integer, array: true, default: []
    add_index :opportunities, :contact_ids, using: 'gin'
  end
end
