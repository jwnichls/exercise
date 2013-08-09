class AdminsController < ApplicationController

	def index

	end

	def export
		if(admin)
			if(params[:tablename] != 'All')
				csv = params[:tablename].constantize.generateCSV		
		  	filename = "#{params[:tablename]}-#{Time.now.to_s}.csv"    
	    	send_data(csv, :type => 'text/csv; charset=utf-8; header=present', :filename => filename)  
	    else 
				sql = "SELECT 
					  users.id as System_User_Id, 
					  users.name, 
					  users.email, 
					  users.t_nickname, 
					  users.t_description, 
					  users.t_screen_name, 
					  users.t_followers_count, 
					  users.t_listed_count, 
					  users.t_statuses_count, 
					  users.t_created_at, 
					  users.version_string, 
					  users.user_level, 
					  posts.body, 
					  posts.vote_count,
					  posts.deleted, 
					  posts.updated_at, 
					  posts.created_at, 
					  surveys.ls1, 
					  surveys.ls2, 
					  surveys.ils1,
					  surveys.ls1 + surveys.ls2 - surveys.ils1  as Survey_Aggregate
					FROM 
					  users, 
					  surveys, 
					  posts
					WHERE 
					  users.id = surveys.user_id AND
					  posts.user_id = users.id;"
				
				data = ActiveRecord::Base.connection.execute(sql)

	    	#data = User.all(:include => :posts)-

	    	csv_string = CSV.generate do |csv|
		      csv << data.fields
		      data.each_row do |row|
		        csv << row
	      	end
	      end
	 	  	filename = "#{params[:tablename]}-#{Time.now.to_s}.csv"    
	    	send_data(csv_string, :type => 'text/csv; charset=utf-8; header=present', :filename => filename)  
	    end
	 	end
	end
end
