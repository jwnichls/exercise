class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.integer :user_id
      t.string :name
      t.text :instructions
      t.string :survey_question_one
      t.string :survey_question_two
      t.string :survey_question_three

      t.timestamps
    end
  end
end
