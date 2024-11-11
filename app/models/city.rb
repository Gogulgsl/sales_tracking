class City < ApplicationRecord
  has_and_belongs_to_many :users, join_table: :cities_users
  belongs_to :zone, optional: true

  validates :name, presence: true
end
