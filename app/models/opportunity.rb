# app/models/opportunity.rb
class Opportunity < ApplicationRecord
  belongs_to :school
  belongs_to :product

  validates :start_date, :contact_person, presence: true
end
