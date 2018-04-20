class CreateRecommendations < ActiveRecord::Migration[5.1]
  def change
    create_table :recommendations do |t|
      t.references :user, foreign_key: true
      t.references :video, foreign_key: true
      t.decimal :importance

      t.timestamps
    end
  end
end
