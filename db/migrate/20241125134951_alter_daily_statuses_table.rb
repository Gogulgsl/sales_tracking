class AlterDailyStatusesTable < ActiveRecord::Migration[6.0]
  def change
    # Add new foreign key columns
    add_reference :daily_statuses, :decision_maker_contact, foreign_key: { to_table: :contacts }, type: :bigint
    add_reference :daily_statuses, :person_met_contact, foreign_key: { to_table: :contacts }, type: :bigint
    add_reference :daily_statuses, :school, foreign_key: true, type: :bigint
    add_reference :daily_statuses, :createdby_user, foreign_key: { to_table: :users }, type: :bigint
    add_reference :daily_statuses, :updatedby_user, foreign_key: { to_table: :users }, type: :bigint

    # Remove the unwanted foreign key
    remove_foreign_key :daily_statuses, column: :user_id

    # Add a new foreign key for user_id directly referencing users
    add_foreign_key :daily_statuses, :users, column: :user_id

    # Remove unnecessary columns
    remove_column :daily_statuses, :decision_maker, :string
    remove_column :daily_statuses, :persons_met, :string
    remove_column :daily_statuses, :mobile_number, :string
  end
end
