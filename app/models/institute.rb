class Institute < ApplicationRecord
  has_many :schools, dependent: :destroy

  validates :name_of_head_of_institution, presence: true
  validates :institute_contact_no, presence: true
  # Add other relevant validations as needed
end
