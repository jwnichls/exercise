class SessionsController < ApplicationController

  def create
  	#raise request.env['omniauth.auth'].to_yaml

  	auth_hash = request.env['omniauth.auth']

  	if (authorization = Authorization.find_by_provider_and_uid(auth_hash['provider'], auth_hash["uid"])) 
      flash[:success] = "Welcome back #{authorization.user.name}!"
      session[:name] = authorization.user.name
      session[:uid] = authorization.user.id
      unless current_user
        flash[:warning] = "In order to participate you need to respond to a <a href='/posts/'>survey.</a>".html_safe
      end
    else
      user = User.create_with_omniauth(auth_hash, session[:turkerId])
      authorization = Authorization.create(:provider => auth_hash['provider'], :uid => auth_hash['uid'], :user => user)

      session[:name] = authorization.user.name
      session[:uid] = user.id
      flash[:success] = "Hi #{authorization.user.name}! Thanks for signing up."
    end

    if session[:campaign_id]
  	  redirect_to Campaign.find(session[:campaign_id])
	  else
	    redirect_to campaigns_path
    end
  end

  def failure
  	session[:uid] = "none"
  end

  def destroy
  	session[:uid] = nil;
  	session[:name] = nil;
    session[:turkerId] = nil;

    if session[:campaign_id]
  	  redirect_to Campaign.find(session[:campaign_id])
	  else
	    redirect_to campaigns_path
    end
  end
end
