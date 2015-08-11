class Song < ActiveRecord::Base
  belongs_to :user
  validates :author, :title, presence: true
  validates :url, format: {with: /\Ahttps{0,1}:\/{2}/, message: "http or https url required"}, :allow_blank => true

end