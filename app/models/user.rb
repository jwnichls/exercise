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

class User < ActiveRecord::Base
  attr_accessible :email, :name, :user_id, :t_nickname, :t_location, :t_image
  attr_accessible :t_description, :t_access_token, :t_access_secret, :t_screen_name
  attr_accessible :t_followers_count, :t_listed_count, :t_statuses_count, :t_created_at
  attr_accessible :survey_id, :version_string, :user_level, :twitter_json, :condition

  has_many :authorizations
  has_many :posts, dependent: :destroy
  has_many :votes
  validates :name, :presence => true
  #has_one :survey_id
  
  def self.create_with_omniauth(auth_hash, turkerId)
    create! do |user|
      user.name               = auth_hash['info']['name']
      user.email              = auth_hash['info']['email']
      user.t_nickname         = auth_hash['info']['nickname']
      user.t_location         = auth_hash['info']['location']
      user.t_image            = auth_hash['info']['image']
      user.t_description      = auth_hash['info']['description']
      user.t_access_token     = auth_hash['credentials']['token']
      user.t_access_secret    = auth_hash['credentials']['secret']
      user.t_screen_name      = auth_hash['extra']['raw_info']['screen_name']
      user.t_followers_count  = auth_hash['extra']['raw_info']['followers_count']
      user.t_listed_count     = auth_hash['extra']['raw_info']['listed_count']
      user.t_statuses_count   = auth_hash['extra']['raw_info']['statuses_count']
      user.t_created_at       = auth_hash['extra']['raw_info']['created_at']
      user.version_string     = "pilot3.july.29.2013"
      user.twitter_json       = auth_hash.to_json
      if(User.count < 1)
        user.user_level       = "admin"
      else
        user.user_level        = "contributor"
      end
      user.turkerId           = turkerId
    end
  end

  def self.finished_survey(uid) 
    u = User.find(uid)
    if(u && u.survey_id) 
      return u
    else
      return nil
    end
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


  def self.valence(uid) 
    u = User.find(uid)
    if(u && u.survey_id)
      return Survey.find(u.survey_id).getValenceScore
    else
      return nil
    end
  end

  def add_provider(auth_hash)
  	unless authorizations.find_by_provider_and_uid(auth_hash['provider'], auth_hash['uid'])
  		Authorization.create :user => self, :provider => auth_hash['provider'], :uid => auth_hash['uid']
  	end
  end
	
  #def voted?(post_id)
  #  votes.exists?(post_id: post_id)
  #end

	def able_to_vote?(post)
    post.user == self
  end

  def toggle_vote(post, vote_type)
    #voted?(post) ? unvote(post, vote_type) : vote(post, vote_type)
    if votes.exists?(post_id: post.id, vote_type: vote_type)
      #user revoted the same way -- toggle off
      votes.where(post_id: post.id, vote_type: vote_type).first.destroy
    else #user voted a different way or a new vote
      if votes.exists?(post_id: post.id, vote_type: "up")
        #user voted a different way -- toggle off old then create new, but never toggle Tweet vote off
        votes.where(post_id: post.id, vote_type: "up").first.destroy
        votes << Vote.create(user_id: self.id, vote_type: vote_type, post_id: post.id)
      elsif votes.exists?(post_id: post.id, vote_type: "down")
        votes.where(post_id: post.id, vote_type: "down").first.destroy
        votes << Vote.create(user_id: self.id, vote_type: vote_type, post_id: post.id)
      else 
        #new vote
        votes << Vote.create(user_id: self.id, vote_type: vote_type, post_id: post.id)
      end
    end
    post.set_vote_count    
  end

  def tweet_vote(post_id)
    #voted?(post) ? unvote(post, vote_type) : vote(post, vote_type)
    if votes.exists?(post_id: post_id, vote_type: "up")
      #user tweeted something they'd upvoted, create another vote
      votes << Vote.create(user_id: self.id, vote_type: "rt", post_id: post_id)
      #votes.where(post_id: post.id, vote_type: vote_type).first.destroy
    elsif votes.exists?(post_id: post_id, vote_type: "down") 
      #user tweeted something they'd previously voted down, delete it and create 2 upvotes
        votes.where(post_id: post.id, vote_type: "down").first.destroy
        votes << Vote.create(user_id: self.id, vote_type: "rt", post_id: post_id)
        votes << Vote.create(user_id: self.id, vote_type: "up", post_id: post_id)
    else
        #new tweet-based upvote, create 2 upvotes
        votes << Vote.create(user_id: self.id, vote_type: "rt", post_id: post_id)
        votes << Vote.create(user_id: self.id, vote_type: "up", post_id: post_id)
    end
    Post.find(post_id).set_vote_count    
  end


  private
  #def unvote(post, vote_type)
  #  votes.where(post_id: post.id).first.destroy
  #  post.set_vote_count
  #end

  def vote(post, vote_type)
    votes << Vote.create(user_id: self.id, vote_type: 'up', post_id: post.id)
    post.set_vote_count
#    votes << Vote.new(post: post, user: self, vote_type: "up")
  end
end
