class CreateSurveys < ActiveRecord::Migration
  def change
    #drop_table :surveyresponses
    create_table :surveys do |t|
      t.integer :user_id
      t.integer :ls1 					#likert scale 1
      t.integer :ls2 					#likert scale 2
      t.integer :ls3 					#likert scale 3
      t.integer :ils1 				#inverted likert scale 1
      t.boolean :sanitycheck1 #did the user pass a sanity check
      t.text		:url1 				#url contributed by a user
      t.text		:url2 				#url contributed by a user
      t.text		:tweet1 			#sample tweet user wrote
      t.text		:tweet2 			#sample tweet user wrote
      t.timestamps
    end
  end
end
