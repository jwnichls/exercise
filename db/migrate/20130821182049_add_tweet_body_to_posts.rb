class AddTweetBodyToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :tweet_body, :text
  end
end
