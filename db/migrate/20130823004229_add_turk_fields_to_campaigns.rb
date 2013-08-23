class AddTurkFieldsToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :turk_question, :text
    add_column :campaigns, :turk_properties, :text
  end
end
