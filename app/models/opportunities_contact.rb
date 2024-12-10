class OpportunitiesContact < ApplicationRecord
  belongs_to :opportunity
  belongs_to :contact
end
