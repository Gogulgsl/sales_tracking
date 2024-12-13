class RenameOpportunitiesContactsToContactsOpportunities < ActiveRecord::Migration[6.1]
  def change
    rename_table :opportunities_contacts, :contacts_opportunities
  end
end
