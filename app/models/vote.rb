# == Schema Information
#
# Table name: votes
#
#  id         :integer          not null, primary key
#  post_id    :integer
#  user_id    :integer
#  vote_type  :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Vote < ActiveRecord::Base
  attr_accessible :post_id, :vote_type, :user_id
  belongs_to :user
  belongs_to :post
  validates :post_id, :presence => true
  validates :user_id, :presence => true
	

	def self.generateCSV
    csv_string = CSV.generate do |csv|
      csv << column_names
      all.each do |user|
        csv << user.attributes.values_at(*column_names)
      end
    end
    return csv_string
  end

end
