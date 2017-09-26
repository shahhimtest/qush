class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :confirmation_token
      t.datetime :confirmed_at

      t.timestamps

      t.index :email, unique: true
    end
  end
end
