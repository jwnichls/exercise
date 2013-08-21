class AddAndRemoveColumnsFromUsers < ActiveRecord::Migration
  def change
    add_column :users, :turkerId, :string
    add_column :users, :twitter_json, :text
    
    remove_column :users, :audience
    remove_column :users, :provider
    remove_column :users, :expires
  end
end
