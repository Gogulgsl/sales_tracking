class AddIsActiveToContacts < ActiveRecord::Migration[6.1]
  def change
    add_column :contacts, :is_active, :boolean
  end
end
