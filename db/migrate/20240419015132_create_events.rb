class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.string :name, null: false
      t.string :description, null: false
      t.integer :min_guests, null: false
      t.integer :max_guests, null: false
      t.integer :standard_durarion, null: false
      t.string :menu, null: false
      t.boolean :offsite_event, null: false
      t.boolean :offers_alcohol, null: false
      t.boolean :offers_decoration, null: false
      t.boolean :offers_valet_parking, null: false
      t.references :buffet, null: false, foreign_key: true

      t.timestamps
    end
  end
end
