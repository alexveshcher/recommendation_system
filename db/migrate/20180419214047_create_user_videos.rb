class CreateUserVideos < ActiveRecord::Migration[5.1]
  def change
    create_table :user_videos do |t|
      t.boolean :like
      t.references :user
      t.references :video

      t.timestamps
    end
  end
end
