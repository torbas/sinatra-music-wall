class AddUserIdToSongs < ActiveRecord::Migration
  def change
    add_column :songs, :user_id, :integer
    add_foreign_key :songs, :users
  end
end
