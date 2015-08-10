class Song < ActiveRecord::Base
  validates :author, :title, presence: true

  def create_url
    url =~ /\Ahttp:\/\// ? url : "http://" << url
  end

end