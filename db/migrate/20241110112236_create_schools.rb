class CreateSchools < ActiveRecord::Migration[6.1]
  def change
    create_table :schools do |t|
      t.string :name
      t.string :lead_source
      t.string :location
      t.string :city
      t.string :state
      t.string :pincode
      t.integer :number_of_students
      t.decimal :avg_fees, precision: 10, scale: 2
      t.string :board
      t.string :website
      t.boolean :part_of_group_school
      t.references :institute, null: false, foreign_key: true

      t.timestamps
    end
  end
end
