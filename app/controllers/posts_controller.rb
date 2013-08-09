class PostsController < ApplicationController
  
  def new
  	@post = Post.new
  end

  def create
  	
    if params[:commit] == 'Create and Tweet my post'
      if Tweet.create_and_post(params[:post][:body], current_user.id)
        flash[:success] = "You tweeted: " + params[:post][:body]
      else
        flash[:error] = "Error. Tweet not created"
      end
      redirect_to '/posts'  
    else
      if id = Post.post(params[:post][:body], current_user.id)
          flash[:success] = "Micropost created!"
          redirect_to '/posts'
      else
          flash[:error] = "Micropost not created!"
          redirect_to '/posts'
      end
    end 
  end

  def show
    @post = Post.find(params[:id])
  end

  def index
    @posts = Post.where(:deleted => 'false', :disabled => 'false').order('updated_at DESC')
    @survey = Survey.new
  end

  def unpost   
    post = Post.find(params[:id]);
    if post.update_attributes(:deleted => 'true')
      flash[:success] = "Post deleted."
    else
      flash[:error] = "Something went wrong. Post not deleted."
    end
    redirect_to '/posts'
  end


  def disable   
    post = Post.find(params[:id]);
    if post.update_attributes(:disabled => 'true')
      flash[:success] = "Post disabled."
    else
      flash[:error] = "Something went wrong. Post not deleted."
    end
    redirect_to '/posts'
  end
end
