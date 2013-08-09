class ChangePostBodyToText < ActiveRecord::Migration
  def up
  	    change_column :posts, :body, :text
  end

  def down
  	# This might cause trouble if you have strings longer
    # than 255 characters.
    change_column :posts, :body, :string
  end
end
