class Campaign < ActiveRecord::Base
  attr_accessible :user_id, :name, :instructions, :survey_question_one, :survey_question_two, :survey_question_three
  belongs_to :user
end
