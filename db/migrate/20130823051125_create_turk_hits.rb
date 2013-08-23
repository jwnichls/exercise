class CreateTurkHits < ActiveRecord::Migration
  def change
    create_table :turk_hits do |t|
      t.string :hit_id
      t.string :hit_type_id

      t.timestamps
    end
  end
end
