class School < ApplicationRecord
  belongs_to :institute

  validates :name, presence: true
  validates :lead_source, presence: true
  # Add other relevant validations as needed
end
