class User < ActiveRecord::Base
  has_many :songs
  validates :username, :email, :password, presence: true
  validates :username, :email, uniqueness: true

end