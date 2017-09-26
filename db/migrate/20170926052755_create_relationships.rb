class CreateRelationships < ActiveRecord::Migration[5.1]
  def change
    create_table :relationships do |t|
      t.references :follower
      t.references :followed

      t.timestamps

      t.foreign_key :users, column: :follower_id
      t.foreign_key :users, column: :followed_id

      t.index [:follower_id, :followed_id], unique: true
    end
  end
end
