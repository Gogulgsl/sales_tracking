class AddIsActiveToSchools < ActiveRecord::Migration[6.1]
  def change
    add_column :schools, :is_active, :boolean, default: true
  end
end
