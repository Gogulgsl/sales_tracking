# app/models/user.rb
class User < ApplicationRecord
  has_secure_password
  has_one :sales_team, dependent: :destroy

  has_and_belongs_to_many :cities, join_table: :cities_users
  has_and_belongs_to_many :zones, join_table: :users_zones
  has_many :direct_reports, class_name: 'User', foreign_key: 'reporting_manager_id'
  belongs_to :reporting_manager, class_name: 'User', optional: true
  has_many :opportunities  

  validates :username, presence: true, uniqueness: true
  validates :mobile_number, presence: true, length: { minimum: 10 }
  validates :email_id, presence: true, uniqueness: true

  # Method to create SalesTeam entry
  def create_sales_team_entry(designation)
    SalesTeam.create!(user_id: self.id, designation: designation, manager_id: self.reporting_manager_id)
  end
end
