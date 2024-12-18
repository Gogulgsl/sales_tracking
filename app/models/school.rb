class School < ApplicationRecord
  belongs_to :institute

  belongs_to :created_by_user, class_name: 'User', optional: true
  belongs_to :updated_by_user, class_name: 'User', optional: true

  validates :name, :institute_id, presence: true
  has_many :contacts, dependent: :destroy
  has_many :daily_statuses
end
