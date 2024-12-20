class School < ApplicationRecord
  belongs_to :institute, optional: true
  validates :institute_id, presence: true, if: -> { part_of_group_school? }

  belongs_to :created_by_user, class_name: 'User', optional: true
  belongs_to :updated_by_user, class_name: 'User', optional: true

  validates :name, presence: true
  has_many :contacts, dependent: :destroy
  has_many :daily_statuses
  def part_of_group_school?
    part_of_group_school == true
  end
end
