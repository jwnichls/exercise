class AddTwitterInfoToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :t_nickname, :string
  	add_column :users, :t_location, :string
  	add_column :users, :t_image, :string
  	add_column :users, :t_description, :string
  	add_column :users, :t_access_token, :string
  	add_column :users, :t_access_secret, :string
  	add_column :users, :t_screen_name, :string
  	add_column :users, :t_followers_count, :integer
  	add_column :users, :t_listed_count, :integer
  	add_column :users, :t_statuses_count, :integer
  	add_column :users, :t_created_at, :string
  end
end
