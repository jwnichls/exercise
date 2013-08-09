class VotesController < ApplicationController
	#before_filter :require_user
  
  def new
    @post = Post.find(params[:post_id])
    #if current_user.able_to_vote?(@post)
      current_user.toggle_vote(@post, params[:vote_type])
      status = :ok
    #else
     # status = :error
    #end
    redirect_to '/posts'
  end

  def create
    #render json: { id: @post.id, like_count: @item.likes.count, liked: current_user.liked?(@item), status: status }
  end

end
