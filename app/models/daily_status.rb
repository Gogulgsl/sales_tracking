class DailyStatus < ApplicationRecord
  belongs_to :sales_team
  belongs_to :opportunity

  validates :decision_maker, :follow_up, :persons_met, :designation, :mail_id, :mobile_number, :discussion_point, :next_steps, :stage, presence: true
end