class CreateCitiesUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users_zones, id: false do |t|
      t.references :user, null: false, foreign_key: true
      t.references :zone, null: false, foreign_key: true

      t.index [:user_id, :zone_id], unique: true
    end
  end
end
