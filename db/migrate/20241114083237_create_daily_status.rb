class CreateDailyStatus < ActiveRecord::Migration[6.1]
  def change
    create_table :daily_statuses do |t|
      t.references :sales_team, null: false, foreign_key: true
      t.references :opportunity, null: false, foreign_key: true
      t.string :decision_maker
      t.text :follow_up
      t.string :persons_met
      t.string :designation
      t.string :mail_id
      t.string :mobile_number
      t.text :discussion_point
      t.text :next_steps
      t.string :stage

      t.timestamps
    end
  end
end
