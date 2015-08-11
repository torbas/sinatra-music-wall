class User < ActiveRecord::Base
  has_many :songs
  has_many :upvotes
  validates :username, :email, :password, presence: true
  validates :username, :email, uniqueness: true

end