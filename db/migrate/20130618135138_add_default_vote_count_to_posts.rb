class AddDefaultVoteCountToPosts < ActiveRecord::Migration
  def change
  	remove_column :posts, :vote_count
  	add_column :posts, :vote_count, :integer, :null => false, :default => 0

  end
end
