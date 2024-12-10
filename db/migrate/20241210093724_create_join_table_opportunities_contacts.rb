class CreateJoinTableOpportunitiesContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :opportunities_contacts do |t|
      t.references :opportunity, null: false, foreign_key: true
      t.references :contact, null: false, foreign_key: true

      t.timestamps
    end
  end
end
