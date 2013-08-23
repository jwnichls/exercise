class FixLocationOfSurveyId < ActiveRecord::Migration
  def change
    add_column :surveys, :campaign_id, :integer
    
    remove_column :users, :survey_id
  end
end
