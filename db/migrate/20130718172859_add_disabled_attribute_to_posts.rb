class AddDisabledAttributeToPosts < ActiveRecord::Migration
  def change
  	  	add_column :posts, :disabled, :boolean, :null => false, :default => false
  end
end
