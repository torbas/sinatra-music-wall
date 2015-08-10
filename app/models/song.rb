class Song < ActiveRecord::Base
  validates :author, :title, presence: true

  def create_url
    url =~ /\Ahttps{0,1}:\/{2}/ ? url : "http://" << url
  end

end