# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  body       :text
#  user_id    :integer
#  deleted    :boolean          default(FALSE), not null
#  vote_count :integer          default(0), not null
#  tweet_body :text
#  disabled   :boolean          default(FALSE), not null
#

class Post < ActiveRecord::Base
	attr_accessible :body, :user_id, :deleted, :vote_count, :tweet_body, :disabled

	belongs_to :user

  has_many :tweets
	has_many :posts, dependent: :destroy
	has_many :votes
	after_touch :set_vote_count
  after_create :add_vote, :set_vote_count
	
	validates :body, presence: true

	validates :user_id, presence: true

  # attr_accessible :title, :body

  default_scope order: 'posts.updated_at DESC'

  def self.clean
    posts = Post.find(:all, :conditions => ["created_at < ?", 3.days.ago])
    posts.each  do |post|
      post.update_attributes(:disabled => true)
    end
  end

  def self.post(body,userid)

    @post = Post.new :tweet_body => bitlify(body), :user_id => userid, :body => body
    if @post.save

      return @post.id
    else 
     return -1
    end
  end


  def self.bitlify(content)
    client = Bitly.client
    urls = URI.extract(content)
    errorurl = ""
    urls.each do |url|
      begin
        u = client.shorten(url) #=> Bitly::Url
        if(u)
          content [url] = "<a href=\"" + u.short_url + "\">" + u.short_url + "</a>"
        end
      rescue
        url.delete(url)
      end
    end 
    return content
  end

  def add_vote
    votes << Vote.create(user_id: self.user_id, vote_type: 'up', post_id: self.id) unless vote_count.try(:>, 0)
  end

  def set_vote_count
  	c = Vote.where(post_id: self.id,  vote_type: 'up').count + Vote.where(post_id: self.id,  vote_type: 'rt').count  - Vote.where(post_id: self.id, vote_type: 'down').count
  	update_attributes(:vote_count => c)
    if c > 5
      logger.info("Tweeting content from master account")
      Tweet.retweet(self.id,User.find_by_user_level("admin").id)
      logger.info("Master account tweeted")
    end
  	#update_attributes(:vote_count => Vote.where(post_id: self.id,  vote_type: 'up').count)
  	#update_attributes(:vote_count => :vote_count - Vote.where(post_id: self.id, vote_type: 'down').count)
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

end
