class Opportunity < ApplicationRecord
  belongs_to :school
  belongs_to :product
  belongs_to :user, optional: true 

  validates :start_date, :contact_id, presence: true
  validates :user, presence: true

  has_many :daily_statuses
end


