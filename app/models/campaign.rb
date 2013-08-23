class Campaign < ActiveRecord::Base
  attr_accessible :user_id, :name, :instructions, :survey_question_one, :survey_question_two, :survey_question_three, :turk_question, :turk_properties
  belongs_to :user
  has_many :posts
end
