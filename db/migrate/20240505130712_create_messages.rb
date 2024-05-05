class CreateMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :messages do |t|
      t.references :user, null: false, foreign_key: true
      t.references :order, null: false, foreign_key: true
      t.datetime :sent_at, null: false
      t.string :content, null: false

      t.timestamps
    end
  end
end