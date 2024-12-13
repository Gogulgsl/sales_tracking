class ContactsOpportunity < ApplicationRecord
  belongs_to :opportunity
  belongs_to :contact
end
