class CreateCities < ActiveRecord::Migration[6.1]
  def change
    create_table :zones do |t|
      t.string :name
      t.timestamps
    end

    create_table :cities do |t|
      t.string :name
      t.references :zone, foreign_key: true
      t.timestamps
    end
  end
end
