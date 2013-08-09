class AddTweetIdToTweet < ActiveRecord::Migration
  def change
  	add_column :tweets, :tweet_id, :bigint
  	add_column :tweets, :tweet_type, :string
  	add_column :tweets, :user_id, :integer
  	add_column :tweets, :post_id, :integer
  end
end
