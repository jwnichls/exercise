class Addconditiontousers < ActiveRecord::Migration
  def change
  	add_column :users, :condition, :string
  end
end
