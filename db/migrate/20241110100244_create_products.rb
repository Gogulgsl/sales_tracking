class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :product_name
      t.text :description
      t.string :supplier
      t.string :unit
      t.decimal :price, precision: 10, scale: 2
      t.datetime :date
      t.json :available_days, default: []

      t.timestamps
    end
  end
end
