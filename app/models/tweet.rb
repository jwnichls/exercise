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

class Tweet < ActiveRecord::Base
  # attr_accessible :title, :body

  attr_accessible :post_id, :tweet_json, :tweet_type, :user_id, :tweet_id , :order => "created_at DESC"
  belongs_to :user
  belongs_to :post
  validates :post_id, :presence => true
  validates :user_id, :presence => true

  def self.twit(user_id)
    Twitter.configure do |config|
      config.consumer_key = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
    end
    return t = Twitter::Client.new(
      :oauth_token => User.find(user_id).t_access_token,
      :oauth_token_secret => User.find(user_id).t_access_secret
    )
  end	

  def self.follow(follower,followee)
    #Thread.new{
      if followee == nil
        twit(follower).follow(User.find(1).t_nickname)
      else
        twit(follower).follow(User.find(followee).t_nickname)
      end
    #}
  end

	def self.generateCSV
    csv_string = CSV.generate do |csv|
      csv << column_names
      all.each do |user|
        csv << user.attributes.values_at(*column_names)
      end
    end
    return csv_string
  end

  def self.tweet(post_id, user_id)
    #removes html links so that twitter will reinsert it properly when it detects links
    content = HTML::FullSanitizer.new.sanitize(Post.find(post_id).tweet_body)

    #Thread.new{
      begin
        
        tid = twit(user_id).update(content)

        @tweet = Tweet.create(:post_id => post_id, :user_id => user_id, :tweet_id => tid.id, :tweet_json => tid.to_json)
        if(@tweet.save)

          User.find(user_id).tweet_vote(post_id)
          return true
        else 
          return false
        end
      rescue
        #logger.debug("ERROR::::::" + $!.backtrace.inspect)
        return "Dupe"
      end
    #}
  end

  def self.retweet(post_id, user_id)
    #Thread.new{
    begin
      if tid = twit(user_id).retweet(Post.find(post_id).tweets.first.tweet_id) != []
        #fails if rt couldnt be made
        @tweet = Tweet.create(:post_id => post_id, :user_id => user_id, :tweet_id => Tweet.find_by_post_id(post_id), :tweet_json => tid.class.name)
        if(@tweet.save)        
          User.find(user_id).tweet_vote(post_id)
          return true
        else        
          return "Failed to save"
        end
      else        
        return false
      end
    rescue
      begin 
        if(!tid)
          return tweet(post_id, user_id)
        end
      rescue
        return false
      end
    end

    # => }
  end
  

  def self.create_and_post(body,user_id)
    
    return tweet(Post.post(body,user_id),user_id)
  end

end
