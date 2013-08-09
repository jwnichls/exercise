class StaticPagesController < ApplicationController
  def home
  	if(params[:turkerId])
  		session[:turkerId] = params[:turkerId]
  	end
  end

  def help
  end
end
