class DailyStatus < ApplicationRecord
  belongs_to :sales_user, class_name: 'SalesTeam', foreign_key: 'sales_user_id'
  belongs_to :opportunity

  # Scope to fetch statuses for a given user
  # scope :for_user, ->(user) { joins(:sales_user).where(sales_users: { sales_user_id: user.id }) }
  validates :decision_maker, :follow_up, :persons_met, :designation, :mail_id, :mobile_number, :discussion_point, :next_steps, :stage, presence: true
end