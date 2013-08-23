class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :admin?, :current_user, :valence_pass?, :valence, :master_user  

  def restrict_to_admin
    head :unauthorized unless admin?
  end
  
  private

  def admin?
    if current_user
      return current_user.user_level == "admin"
    else
      return false
    end
  end

  def master_user
    # TODO: Determine by campaign
    return User.find_by_user_level("admin")
  end

  def current_user
    if session[:uid]
      User.find(session[:uid])
    else
      nil
    end
  end	

  def valence
    if current_user && current_user.has_survey_for_campaign?(@campaign)
      return current_user.valence(@campaign)
    else
      return nil
    end
  end

  def valence_pass?
    if(valence && valence > 1)
      return true
    else
      return false
    end
  end

end
