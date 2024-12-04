class CreateStagesTable < ActiveRecord::Migration[6.1]
  def change
    create_table :stages do |t|
      t.string :stage_code
      t.text :description   

      t.timestamps          
    end
  end
end
