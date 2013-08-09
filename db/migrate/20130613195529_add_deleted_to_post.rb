class AddDeletedToPost < ActiveRecord::Migration
  def change
  	add_column :posts, :deleted, :boolean, :null => false, :default => false
  end
end
