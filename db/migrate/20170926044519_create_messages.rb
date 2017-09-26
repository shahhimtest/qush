class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.references :publisher
      t.text :content

      t.timestamps

      t.foreign_key :users, column: :publisher_id
    end
  end
end
