class CreateLikes < ActiveRecord::Migration[5.1]
  def change
    create_table :likes do |t|
      t.references :message, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps

      t.index [:message_id, :user_id], unique: true
    end

    add_column :messages, :likes_count, :bigint, default: 0
  end
end
