class CreateOpportunities < ActiveRecord::Migration[6.1]
  def change
    create_table :opportunities do |t|
      t.references :school, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.datetime :start_date, null: false
      t.string :contact_person

      t.timestamps
    end
  end
end
