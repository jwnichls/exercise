class AddTweetJsonToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :tweet_json, :text
  end
end
