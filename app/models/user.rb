class User < ApplicationRecord
  # Secure password handling
  has_secure_password

  # Associations
  has_one :sales_team, dependent: :destroy # Assuming one-to-one relationship with sales_team

  # Validations
  validates :username, presence: true, uniqueness: true, length: { maximum: 50 }
  validates :password, presence: true, length: { minimum: 6 }, if: :password_required?
  validates :role, presence: true, inclusion: { in: %w[admin sales user manager] } # Adjust roles as needed

  private

  def password_required?
    new_record? || !password.nil?
  end
end