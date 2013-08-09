class UsersController < ApplicationController
  def new
  end

  def show
  	user = User.find(params[:id])
  	
  	@userlevel = User.find(params[:id]).user_level

  	@posts = user.posts.where(:deleted => 'false')

  	#user = User.find_by_id(params[:user_id])
    #posts = user.posts.where(:deleted => 'false').where(:user_id => user.id)#.paginate(page: params[:page])
    #@user.posts.paginate(page: params[:page])
  end
end
