class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :admin
  helper_method :current_user
  before_filter :current_user
  helper_method :valence_pass
  before_filter :valence_pass
  helper_method :valence
  before_filter :valence
  helper_method :master_user
  before_filter :master_user
  

  private

  def admin
    if current_user || session[:uid]
      return User.find(session[:uid]).user_level == "admin"
    else
      return false
    end
  end

  def master_user
    return User.find_by_user_level("admin")
  end

  def current_user
  	if session[:uid]
      return User.finished_survey(session[:uid])
  	else
  		#flash[:warning] = "Please login to continue."
		#session[:return_to] = request.request_uri
		#redirect_to '/static_pages/home'
		  return nil
    end
  end	

  def valence
    if session[:uid]
      if User.finished_survey(session[:uid])
        return User.valence(session[:uid])
      else
        return nil
      end
    else
      return nil
    end
  end

  def valence_pass
    if(valence && valence > 1)
      return true
    else
      return false
    end
  end



  
end
