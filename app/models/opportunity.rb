# app/models/opportunity.rb
class Opportunity < ApplicationRecord
  belongs_to :school
  belongs_to :product
  # belongs_to :sales_team

  validates :start_date, :contact_id, presence: true
  has_many :daily_statuses
end
