class CampaignsController < ApplicationController
  before_action :set_campaign, only: [:show, :edit, :update, :destroy]

  # GET /campaigns
  def index
    unless restrict_to_admin
      @campaigns = Campaign.all
    end
  end

  # GET /campaigns/1
  def show
  	if(params[:turkerId])
  		session[:turkerId] = params[:turkerId]
  	end
  	
  	session[:campaign_id] = @campaign.id
  end

  # GET /campaigns/new
  def new
    unless restrict_to_admin
      @campaign = Campaign.new
    end
  end

  # GET /campaigns/1/edit
  def edit
    restrict_to_admin
  end

  # POST /campaigns
  def create
    unless restrict_to_admin
      @campaign = Campaign.new(campaign_params)

      if @campaign.save
        redirect_to @campaign, notice: 'Campaign was successfully created.'
      else
        render action: 'new'
      end
    end
  end

  # PATCH/PUT /campaigns/1
  def update
    unless restrict_to_admin
      if @campaign.update(campaign_params)
        redirect_to @campaign, notice: 'Campaign was successfully updated.'
      else
        render action: 'edit'
      end
    end
  end

  # DELETE /campaigns/1
  def destroy
    unless restrict_to_admin
      @campaign.destroy
      redirect_to campaigns_url, notice: 'Campaign was successfully destroyed.'
    end
  end
  
  def follow    
		if(params[:followee] == nil)
			Tweet.follow(current_user.id,nil)
			flash[:success] = "You followed: @" + @campaign.user.t_nickname
		else
			Tweet.follow(current_user.id,params[:followee])
			flash[:success] = "You followed: @" + User.find(params[:followee]).t_nickname
		end

		redirect_to campaign_posts_path(@campaign)
	end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_campaign
      @campaign = Campaign.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def campaign_params
      params.require(:campaign).permit(:user_id, :name, :instructions, :survey_question_one, :survey_question_two, :survey_question_three, :turk_question, :turk_properties)
    end
end
