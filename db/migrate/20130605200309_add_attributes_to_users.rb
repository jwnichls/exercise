class AddAttributesToUsers < ActiveRecord::Migration
  def change
	add_column :users, :email, :string
	add_column :users, :audience, :string
	add_column :users, :provider, :string
	add_column :users, :expires, :string

  end
end
