class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :author
      t.string :song_title
      t.string :url
      t.timestamp
    end
  end
end
