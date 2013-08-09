class AddLevelToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :user_level, :string, :default => "contributor"
  end
end
