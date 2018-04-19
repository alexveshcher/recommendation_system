class CreateJoinTableVideosUsers < ActiveRecord::Migration[5.1]
  def change
    create_join_table :videos, :users do |t|
      t.boolean :like
      # t.index [:video_id, :user_id]
      # t.index [:user_id, :video_id]
    end
  end
end
