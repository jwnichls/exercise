class PostsController < ApplicationController

  # TODO: Campaignify
  
  def new
    @campaign = Campaign.find(params[:campaign_id])
  	@post = Post.new
  	@post.campaign_id = @campaign.id
  	@post.user_id = current_user.id
  end

  def create
    @post = Post.new(params[:post])
    @post.tweet_body = Post.bitlify(@post.body)

    if @post.save
      if params[:commit] == 'Create and Tweet my post'
        if Tweet.create_and_post(params[:post][:body], current_user.id)
          flash[:success] = "Post created and tweeted"
        else
          flash[:error] = "Post created but tweet not sent"
        end
      else
        flash[:success] = "Post created"
      end
      
      redirect_to campaign_posts_path(@post.campaign)
    else
      flash[:error] = "Post could not saved"
      render action: new
    end    
  end

  def show
    @post = Post.find(params[:id])
  end

  def index
    @campaign = Campaign.find(params[:campaign_id])
    @posts = @campaign.posts.where(:deleted => 'false', :disabled => 'false').order('updated_at DESC')
    
    if current_user && !current_user.has_survey_for_campaign?(@campaign)
      @survey = Survey.new
      @survey.campaign = @campaign
      @survey.user = current_user
    end
  end

  def unpost   
    @campaign = Campaign.find(params[:campaign_id])
    
    post = Post.find(params[:id]);
    if post.update_attributes(:deleted => 'true')
      flash[:success] = "Post deleted."
    else
      flash[:error] = "Something went wrong. Post not deleted."
    end

    redirect_to campaign_posts_path(@campaign)
  end

  def disable   
    @campaign = Campaign.find(params[:campaign_id])
    
    post = Post.find(params[:id]);
    if post.update_attributes(:disabled => 'true')
      flash[:success] = "Post disabled."
    else
      flash[:error] = "Something went wrong. Post not deleted."
    end
    
    redirect_to campaign_posts_path(@campaign)
  end
  
  def tweet
    @campaign = Campaign.find(params[:campaign_id])
    @post = Post.find(params[:id])
    
		if Tweet.find_by_post_id(@post.id) #already has a tweet, try to retweet it
			if (str = Tweet.retweet(@post.id, current_user.id)) #try to retweet
				if str == "Dupe"
					flash[:warning] = "Unable to tweet, you've already tweeted this!"
				elsif str == "Failed to save"
					flash[:warning] = "You tweeted!"
				else
					flash[:success] = "You retweeted: " + @post.body
				end
			else
				flash[:error] = "Failed to retweet: " + @post.body
			end
		elsif Tweet.tweet(@post.id, current_user.id)
			flash[:success] = "You tweeted: " + @post.body
		else
			flash[:error] = "Error. Tweet not created"
		end

		redirect_to campaign_posts_path(@campaign)
	end
  
  def vote_up
    @campaign = Campaign.find(params[:campaign_id])
    
    vote(params[:id], "up")
    
    redirect_to campaign_posts_path(@campaign)
  end
  
  def vote_down
    @campaign = Campaign.find(params[:campaign_id])
    
    vote(params[:id], "down")
    
    redirect_to campaign_posts_path(@campaign)
  end
  
  private
  
  def vote(post_id, type)
    @post = Post.find(post_id)
    current_user.toggle_vote(@post, type)
  end
end
