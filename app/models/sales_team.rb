class SalesTeam < ApplicationRecord
  belongs_to :user, foreign_key: 'user_id'
  belongs_to :manager, class_name: 'User', foreign_key: 'manager_id'
  validates :designation, presence: true
  has_many :daily_statuses
end
