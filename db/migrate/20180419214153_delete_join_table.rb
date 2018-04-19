class DeleteJoinTable < ActiveRecord::Migration[5.1]
  def change
    drop_join_table :videos, :users
  end
end
