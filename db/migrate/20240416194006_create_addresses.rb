class CreateAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :addresses do |t|
      t.string :street_name, null: false
      t.string :neighborhood, null: false
      t.string :house_or_lot_number, null: false
      t.string :state, null: false
      t.string :city, null: false
      t.string :zip, null: false

      t.timestamps
    end
  end
end
