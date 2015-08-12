class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :song
  validates :user_id, uniqueness: { scope: :song_id,
    message: "Can only vote on this once" }
  validates :rating, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 1,
    less_than_or_equal_to: 5
  }
  validates  :content, presence: true
 
end