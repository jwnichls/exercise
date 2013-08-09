# == Schema Information
#
# Table name: surveys
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  ls1          :integer
#  ls2          :integer
#  ls3          :integer
#  ils1         :integer
#  sanitycheck1 :boolean
#  url1         :text
#  url2         :text
#  tweet1       :text
#  tweet2       :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'test_helper'

class SurveyTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
