class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :song
  validates :user_id, uniqueness: { scope: :song_id,
    message: "Can only vote on this once" }
  validates  :content, presence: true
 
end