class UsersController < ApplicationController
  def new
  end

  def show  	
  	@userlevel = current_user.user_level
  	@posts = current_user.posts.where(:deleted => 'false')
  end
end
