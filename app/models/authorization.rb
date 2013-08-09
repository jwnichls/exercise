# == Schema Information
#
# Table name: authorizations
#
#  id         :integer          not null, primary key
#  provider   :string(255)
#  uid        :string(255)
#  user       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#

class Authorization < ActiveRecord::Base
  attr_accessible :provider, :uid, :user

  belongs_to :user
  validates :provider, :uid, :presence => true

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
