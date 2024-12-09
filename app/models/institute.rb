class Institute < ApplicationRecord
  has_many :schools, dependent: :destroy
  belongs_to :contact, optional: true
  validates :name_of_head_of_institution, :institute_email_id, presence: true
end
