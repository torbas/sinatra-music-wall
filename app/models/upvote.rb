class Upvote < ActiveRecord::Base
  belongs_to :user
  belongs_to :song
  validates :user_id, :song_id, presence: true
  validates :user_id, uniqueness: { scope: :song_id,
    message: "Can only vote on this once" }
  after_save :update_song_upvote

  def update_song_upvote
    song.upvote = Upvote.where("song_id = ?", song_id).size
    song.save
  end

end