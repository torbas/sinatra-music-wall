class Song < ActiveRecord::Base
  validates :author, :title, presence: true
  validates :url, format: {with: /\Ahttps{0,1}:\/{2}/, message: "http or https url required"} 

end