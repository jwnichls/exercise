# == Schema Information
#
# Table name: surveys
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  ls1          :integer
#  ls2          :integer
#  ls3          :integer
#  ils1         :integer
#  sanitycheck1 :boolean
#  url1         :text
#  url2         :text
#  tweet1       :text
#  tweet2       :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Survey < ActiveRecord::Base
	attr_accessible :user_id, :ls1, :ls2, :ls3, :ils1, :sanitycheck1, :url1, :url2, :tweet1, :tweet2

  def getValenceScore
  	#return Integer(ls1.to_s) + Integer(ls2.to_s) - Integer(ils1.to_s)
    return Integer(ls1.to_s)
  end

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
