# == Schema Information
#
# Table name: tweets
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  tweet_id   :integer
#  tweet_type :string(255)
#  user_id    :integer
#  post_id    :integer
#  tweet_json :text
#

require 'test_helper'

class TweetTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
