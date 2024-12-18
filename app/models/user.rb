# class User < ApplicationRecord
#   # Secure password handling
#   has_secure_password

#   # Associations
#   has_one :sales_team, dependent: :destroy # Assuming one-to-one relationship with sales_team
#   has_many :opportunities, dependent: :nullify # This allows a user to have many opportunities
#   belongs_to :manager_user, class_name: "User", foreign_key: "manager_user_id", optional: true  # Manager association


#   # Validations
#   validates :username, presence: true, uniqueness: true, length: { maximum: 50 }
#   validates :password, presence: true, length: { minimum: 6 }, if: :password_required?
#   validates :role, presence: true, inclusion: { in: %w[admin sales_executive] } # Adjust roles as needed

#   private

#   def password_required?
#     new_record? || !password.nil?
#   end
# end


class User < ApplicationRecord
  # Secure password handling
  has_secure_password

  # Associations
  has_one :sales_team, dependent: :destroy
  has_many :opportunities, dependent: :nullify
  belongs_to :manager_user, class_name: 'User', foreign_key: 'reporting_manager_id', optional: true  # Correct association

  # Validations
  validates :username, presence: true, uniqueness: true, length: { maximum: 50 }
  validates :password, presence: true, length: { minimum: 6 }, if: :password_required?
  validates :role, presence: true, inclusion: { in: %w[admin sales_executive manager] }

  private

  def password_required?
    new_record? || !password.nil?
  end
end
