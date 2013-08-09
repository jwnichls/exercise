class TweetsController < ApplicationController
	def new

	end

	def follow
		if(params[:followee] == nil)
			Tweet.follow(current_user.id,nil)
			flash[:success] = "You followed: @" + User.find(1).t_nickname
		else
			Tweet.follow(current_user.id,params[:followee])
			flash[:success] = "You followed: @" + User.find(params[:followee]).t_nickname
		end
		redirect_to '/posts'
	end

	def tweet
		if(Tweet.find_by_post_id(params[:id])) #already has a tweet, try to retweet it
			if (str = Tweet.retweet(params[:id], current_user.id)) #try to retweet
				if str == "Dupe"
					flash[:warning] = "Unable to tweet, you've already tweeted this!"
				elsif str == "Failed to save"
					flash[:warning] = "You tweeted!"
				else
					flash[:success] = "You retweeted: " + Post.find(params[:id]).body
				end
			else
				flash[:error] = "Failed to retweet: " + Post.find(params[:id]).body
			end
		elsif Tweet.tweet(params[:id], current_user.id)
			flash[:success] = "You tweeted: " + Post.find(params[:id]).body
		else
			flash[:error] = "Error. Tweet not created"
		end
		redirect_to '/posts'
	end

#	def retweet
#		if(str = Tweet.retweet(params[:id], current_user.id))
#			if str == "Dupe"
#				flash[:warning] = "Unable to tweet, you've already tweeted this!"
#			else
#				flash[:success] = "You retweeted: " + Post.find(params[:id]).body
#			end
#		else
#			flash[:error] = "Error. Something broke!"
#		end
		#redirect_to '/posts'
#	end

end
