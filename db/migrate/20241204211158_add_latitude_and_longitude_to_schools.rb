class AddLatitudeAndLongitudeToSchools < ActiveRecord::Migration[6.1]
  def change
    add_column :schools, :latitude, :string
    add_column :schools, :longitude, :string
  end
end
