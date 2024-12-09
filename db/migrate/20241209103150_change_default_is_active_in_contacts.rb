class ChangeDefaultIsActiveInContacts < ActiveRecord::Migration[6.1]
  def change
    change_column_default :contacts, :is_active, true
  end
end
