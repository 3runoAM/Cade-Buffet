class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.references :buffet, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true
      t.date :event_date, null: false
      t.integer :total_guests, null: false
      t.string :address
      t.string :additional_info
      t.string :code, null: false
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
