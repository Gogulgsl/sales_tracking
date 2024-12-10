class Opportunity < ApplicationRecord
  belongs_to :school
  belongs_to :product
  belongs_to :user, optional: true 
  has_many :opportunities_contacts
  has_many :contacts, through: :opportunities_contacts

  validates :start_date, presence: true
  validates :user, presence: true

  has_many :daily_statuses
end


