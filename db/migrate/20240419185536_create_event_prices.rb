class CreateEventPrices < ActiveRecord::Migration[7.1]
  def change
    create_table :event_prices do |t|
      t.integer :standard_price, null: false
      t.integer :extra_guest_price, null: false
      t.integer :extra_hour_price, null: false
      t.integer :day_type, null: false
      t.references :event, null: false, foreign_key: true

      t.timestamps
    end
  end
end
