# == Schema Information
#
# Table name: users
#
#  id                :integer          not null, primary key
#  turkerId          :string(255)
#  name              :string(255)
#  email             :string(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  t_nickname        :string(255)
#  t_location        :string(255)
#  t_image           :string(255)
#  t_description     :string(255)
#  t_access_token    :string(255)
#  t_access_secret   :string(255)
#  t_screen_name     :string(255)
#  t_followers_count :integer
#  t_listed_count    :integer
#  t_statuses_count  :integer
#  t_created_at      :string(255)
#  survey_id         :integer
#  version_string    :string(255)
#  user_level        :string(255)      default("contributor")
#  twitter_json      :text
#  condition         :string(255)
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
