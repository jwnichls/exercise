class AddSurveyLinkAndVersionStringToUser < ActiveRecord::Migration
  def change
  	add_column :users, :survey_id, :int
  	add_column :users, :version_string, :string
  end
end
