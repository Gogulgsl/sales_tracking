class Stage < ApplicationRecord
  # Validations
  validates :stage_code, presence: true, uniqueness: true
  validates :description, presence: true

  # Associations (if applicable)
  # Add associations if `Stage` is related to other models.
end
