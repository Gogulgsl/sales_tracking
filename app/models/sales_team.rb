class SalesTeam < ApplicationRecord
  belongs_to :user, foreign_key: :sales_user_id
  belongs_to :manager, class_name: 'User', foreign_key: 'manager_id'
  validates :designation, presence: true
  has_many :daily_statuses
  has_many :daily_statuses, foreign_key: 'sales_user_id'
end
