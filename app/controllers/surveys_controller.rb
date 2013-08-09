class SurveysController < ApplicationController
	def new
		@sr = Survey.new
	end

	def create
    @sr = Survey.new params[:survey]
    respond_to do |format|  
	
			if @sr.save
				
				@user = User.find(session[:uid]).update_attributes(:survey_id => @sr.id)
				format.html { redirect_to('/posts') }  
				
				if @sr.getValenceScore > 2 
					#roll the dice to see which condition they're in. 1-20 goes to control group
					if rand(1..100) < 20
						 User.find(session[:uid]).update_attributes(:condition => "control")
						format.js { sleep 1; render :json => 1}
					else
						 User.find(session[:uid]).update_attributes(:condition => "participant")
						format.js { sleep 1; render :json => 2 }
					end
				else
					 User.find(session[:uid]).update_attributes(:condition => "lowvalence")
					format.js { sleep 1; render :json => 3 }
					end
			else
				format.html { redirect_to('/posts') }  
      	format.js { sleep 1; render :json => @sr.getValenceScore }
			end
		end

    
	end
end
