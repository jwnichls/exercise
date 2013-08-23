class SurveysController < ApplicationController
	def new
		@sr = Survey.new
	end

	def create
    @sr = Survey.new params[:survey]
    respond_to do |format|  
	
	    # TODO: Refactor?
	    # Maybe there should be a surveys controller for setting up the surveys and a survey entry controller for filling them out
	    # Furthermore, assignment into conditions should probably be handled somewhere else, perhaps in the users model
			if @sr.save
				
				format.html { redirect_to campaign_posts_path(@sr.campaign) }  
				
				if @sr.getValenceScore > 2 
					#roll the dice to see which condition they're in. 1-20 goes to control group
					if rand(1..100) < 20
						 current_user.update_attributes(:condition => "control")
						format.js { sleep 1; render :json => 1}
					else
						 current_user.update_attributes(:condition => "participant")
						format.js { sleep 1; render :json => 2 }
					end
				else
					 current_user.update_attributes(:condition => "lowvalence")
					format.js { sleep 1; render :json => 3 }
					end
			else
				format.html { redirect_to campaign_posts_path(@sr.campaign) }
      	format.js { sleep 1; render :json => @sr.getValenceScore }
			end
		end

    
	end
end
