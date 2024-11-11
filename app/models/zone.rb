class Zone < ApplicationRecord
  has_and_belongs_to_many :users, join_table: :users_zones
  has_many :cities

  validates :name, presence: true
end
