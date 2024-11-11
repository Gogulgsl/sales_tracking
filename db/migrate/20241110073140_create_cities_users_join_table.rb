class CreateCitiesUsersJoinTable < ActiveRecord::Migration[6.1]
  def change
    create_table :cities_users, id: false do |t|
      t.references :user, null: false, foreign_key: true, index: true
      t.references :city, null: false, foreign_key: true, index: true

      # Optional combined index for faster lookups
      t.index [:user_id, :city_id], unique: true
    end
  end
end
